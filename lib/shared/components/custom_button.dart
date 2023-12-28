
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({

    this.text,
   required this.onTap,
    // this.gradient = kBlackGradient,
    this.gradient  ,
    this.height = 40,
    this.textColor = kLightGoldColor,   this.buttonColor=kCustomBlack,
  }) ;

  final String? text;
  final Gradient? gradient;
  final double? height;
  final Function? onTap;
  final Color textColor;
  final Color? buttonColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap!();
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: height?.h,
              decoration: BoxDecoration(
                color: buttonColor,
                  gradient: gradient, borderRadius: BorderRadius.circular(35.r)),
              child: Center(
                  child: Text(
                "${text}",
                style: TextStyle(color: textColor, fontWeight: FontWeight.w600,
                fontSize: 12.sp),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
