import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors_list.dart';


class ReusableButton extends StatelessWidget {
  const ReusableButton({
    super.key, required this.text, this.onPressed,
  });
  final String text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          width: double.infinity,
          height: 45.h,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius:5,
                color: AppColors.primary_bg.withOpacity(0.5),
                spreadRadius: 1,
                offset: Offset(0, 3),
              )
            ],
            color:AppColors.primary_bg,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.primarySecondaryBackground,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp
              ),
            ),
          )

      ),
    );
  }
}
