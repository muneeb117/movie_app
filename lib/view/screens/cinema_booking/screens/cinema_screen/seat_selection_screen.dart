import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../models/booking_model.dart';
import '../../../../../models/seat_model.dart';
import '../../../../../models/user_detail_model.dart';
import '../../../../../utils/colors_list.dart';
import '../../widgets/cinema_seat_widget.dart';
import 'booking_confirmation_screen.dart';
class SeatSelectionScreen extends StatefulWidget {
  final DateTime selectedDate;
  final String selectedHall;

  SeatSelectionScreen({Key? key, required this.selectedDate, required this.selectedHall})
      : super(key: key);

  @override
  _SeatSelectionScreenState createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {

  Future<UserDetail?> fetchUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userData.exists) {
        return UserDetail.fromMap(userData.data() as Map<String, dynamic>, user.uid);
      } else {
        Fluttertoast.showToast(msg: "User data not found.");
      }
    } else {
      Fluttertoast.showToast(msg: "No user is logged in.");
    }
    return null;
  }

  void bookSeats() async {
    UserDetail? userDetails = await fetchUserDetails();
    if (userDetails != null && selectedSeats.isNotEmpty) {
      Booking booking = Booking(
        userId: userDetails.userId,
        userName: userDetails.name,
        hallName: widget.selectedHall,
        date: widget.selectedDate,
        selectedSeats: selectedSeats.map((seat) => seat.id).toList(),
        totalPrice: getTotalPrice().toDouble(), email: userDetails.email,
      );

      await saveBookingToFirestore(booking);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookingConfirmationScreen(booking: booking),
        ),
      );
    } else {
      Fluttertoast.showToast(msg: "User details are not available or no seats selected.");
    }
  }
  List<CinemaSeat> seats = List.generate(
    70,
    (index) => CinemaSeat(
      id: 'seat_$index',
      row: String.fromCharCode(65 + (index ~/ 7)),
      number: index % 7 + 1,
      category: index < 7 ? SeatCategory.VIP : SeatCategory.Regular,
      status: SeatStatus.Available,
    ),
  );

  List<CinemaSeat> selectedSeats = [];

  int getTotalPrice() {
    int totalPrice = 0;
    for (var seat in selectedSeats) {
      totalPrice += seat.category == SeatCategory.VIP ? 150 : 50;
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 40,),
          Center(child: SvgPicture.asset("assets/icons/screen.svg")),

          SizedBox(height: 10,),


          Expanded(
            child: SeatGridWidget(
              seats: seats,
              onSeatTap: (seat) {
                setState(() {
                  if (seat.status == SeatStatus.Available) {
                    seat.status = SeatStatus.Selected;
                    selectedSeats.add(seat);
                  } else if (seat.status == SeatStatus.Selected) {
                    seat.status = SeatStatus.Available;
                    selectedSeats.remove(seat);
                  }
                });
              },
            ),
          ),
          // Display selected seats
          selectedSeats.isNotEmpty
              ? Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      color: AppColors.strokeColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                      'Selected Seats: ${selectedSeats.map((s) => '${s.row}${s.number}').join(', ')}'),
                )
              : Container(),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      children: [
                        _buildSeatLegend('VIP (\$150)', Colors.purple),
                        _buildSeatLegend('Regular (\$50)', Colors.blue),
                      ],
                    ),
                    Row(
                      children: [
                        _buildSeatLegend('Selected', Colors.brown),
                        _buildSeatLegend('Not available', Colors.grey),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),

      Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),

                decoration: BoxDecoration(
                  color: AppColors.strokeColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'Total Price \n ',
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,

                      ),

                    children: <TextSpan>[
                      TextSpan(
                        text: '\$${getTotalPrice().toString()}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              _buildProceedToPayButton(),
            ],
          ),

        ],
      ),
    );
  }

  Widget _buildProceedToPayButton() {
    return ElevatedButton(
      onPressed: selectedSeats.isNotEmpty ? () {
        bookSeats();
      } : null,
      child: Text('Book Seats ',style: TextStyle(color: Colors.white),),
      style: ElevatedButton.styleFrom(

        backgroundColor: fillColor,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 25),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildSeatLegend(String text, Color color) {
    return Container(
      margin: EdgeInsets.only(left: 10, bottom: 10),
      padding:  EdgeInsets.only(left: 10, bottom: 10,right: 10,top: 10),
      decoration: BoxDecoration(
        // color: AppColors.strokeColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
            ),
            child: Icon(
              Icons.event_seat,
              color: color,
            ),
          ),
          SizedBox(width: 8),
          Text(text,style: TextStyle(color: AppColors.primaryThreeElementText),),
        ],
      ),
    );
  }
}

Future<void> saveBookingToFirestore(Booking booking) async {
  await FirebaseFirestore.instance
      .collection('bookings')
      .add(booking.toFirestore())
      .then((docRef) => print("Booking added with ID: ${docRef.id}"))
      .catchError((error) => print("Failed to add booking: $error"));
}