import 'package:flutter/material.dart';
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
  _SeatGridWidgetState createState() => _SeatGridWidgetState();
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
              // Row number
              SizedBox(
                width: 18,
                child: Text('$displayRowNum',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(seatsPerRow, (seatIndex) {
                    int seatNumber = (displayRowNum - 1) * seatsPerRow + seatIndex;
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
                          SizedBox(width: seatSpacing * 2),
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

class SeatButton extends StatelessWidget {
  final CinemaSeat seat;
  final VoidCallback onTap;

  const SeatButton({
    Key? key,
    required this.seat,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData iconData = Icons.event_seat;
    Color color = _getSeatColor(seat);

    return IconButton(
      icon: Icon(iconData),
      color: color,
      onPressed: seat.status != SeatStatus.Booked ? onTap : null,
      iconSize: 24,
    );
  }

  Color _getSeatColor(CinemaSeat seat) {
    if (seat.status == SeatStatus.Booked) {
      return Colors.grey;
    } else if (seat.status == SeatStatus.Selected) {
      return Colors.brown;
    } else if (seat.category == SeatCategory.VIP) {
      return Colors.purple;
    } else {
      return Colors.blue;
    }
  }
}
