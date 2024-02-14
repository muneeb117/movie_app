import 'package:flutter/material.dart';
import 'package:movie_app/view/screens/cinema_booking/widgets/seat_button.dart';
import '../../../../models/seat_model.dart';

class SeatGridWidget extends StatefulWidget {
  final List<CinemaSeat> seats;
  final Function(CinemaSeat) onSeatTap;

  const SeatGridWidget({
    Key? key,
    required this.seats,
    required this.onSeatTap,
  }) : super(key: key);

  @override
  State<SeatGridWidget> createState() => _SeatGridWidgetState();
}

class _SeatGridWidgetState extends State<SeatGridWidget> {
  static const int rows = 10;
  static const int seatsPerRow = 7;
  static const double seatSpacing = 8.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0),
      child: Column(
        children: List.generate(rows, (rowIndex) {
          int displayRowNum = rows - rowIndex;
          return Row(
            children: [
              SizedBox(
                width: 18,
                child: Text('$displayRowNum',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(seatsPerRow, (seatIndex) {
                    int seatNumber =
                        (displayRowNum - 1) * seatsPerRow + seatIndex;
                    CinemaSeat seat = widget.seats[seatNumber];
                    if (seatIndex == 2 || seatIndex == 5) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SeatButton(
                            seat: seat,
                            onTap: () {
                              widget.onSeatTap(seat);
                              setState(() {});
                            },
                          ),
                          const SizedBox(width: seatSpacing * 2),
                        ],
                      );
                    } else {
                      return SeatButton(
                        seat: seat,
                        onTap: () {
                          widget.onSeatTap(seat);
                          setState(() {});
                        },
                      );
                    }
                  }),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
