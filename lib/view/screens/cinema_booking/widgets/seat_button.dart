
import 'package:flutter/material.dart';

import '../../../../models/seat_model.dart';

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
