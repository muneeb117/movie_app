
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../utils/colors_list.dart';

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
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(

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
