import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/utils/colors_list.dart';
import 'package:movie_app/view/screens/cinema_booking/screens/cinema_screen/seat_selection_screen.dart';
import 'package:movie_app/view/widgets/reusable_button.dart';

import '../../../../../models/booking_model.dart';

class MovieDateAndHallSelectionScreen extends StatefulWidget {
  final String movieName;
  final String releaseDate;

  MovieDateAndHallSelectionScreen({
    Key? key,
    required this.movieName,
    required this.releaseDate,
  }) : super(key: key);

  @override
  _MovieDateAndHallSelectionScreenState createState() =>
      _MovieDateAndHallSelectionScreenState();
}

class _MovieDateAndHallSelectionScreenState
    extends State<MovieDateAndHallSelectionScreen> {
  DateTime selectedDate = DateTime.now();
  String selectedHall = "Cinetech + Hall 1";

  List<DateTime> get nextSevenDays {
    return List.generate(
        7, (index) => DateTime.now().add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.movieName,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              'In Theaters ${DateFormat('MMMM dd, yyyy').format(DateTime.parse(widget.releaseDate))}',
              style: TextStyle(
                fontSize: 14,
                color: fillColor,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
            child: Text(
              "Date",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: nextSevenDays.length,
              itemBuilder: (context, index) {
                DateTime date = nextSevenDays[index];
                bool isSelected =
                    DateFormat('yyyy-MM-dd').format(selectedDate) ==
                        DateFormat('yyyy-MM-dd').format(date);
                return DateSelectionTile(
                  date: date,
                  isSelected: isSelected,
                  onSelect: () {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                );
              },
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(2, (index) {
                String hallName = 'Cinetech + Hall ${index + 1}';
                bool isSelected = selectedHall == hallName;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedHall = hallName;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? Colors.blue : Colors.grey,

                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/hall.svg',
                          width: 100,
                          height: 100,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          hallName,
                          style: TextStyle(
                              color: AppColors.primarySecondaryElementText),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: ReusableButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SeatSelectionScreen(
                      selectedDate: selectedDate,
                      selectedHall: selectedHall,
                    ),
                  ),
                );
              },
              text: 'Select Seats',
            ),
          ),
        ],
      ),
    );
  }
}

class DateSelectionTile extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final VoidCallback onSelect;

  const DateSelectionTile({
    Key? key,
    required this.date,
    required this.isSelected,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        width: 80,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //   color: fillColor.withOpacity(0.3),
          //   spreadRadius: 10,
          //   offset: Offset(0,1),
          // )],
          color: isSelected ? fillColor : Colors.grey[300],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            DateFormat('d MMM').format(date),
            style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 12),
          ),
        ),
      ),
    );
  }
}
