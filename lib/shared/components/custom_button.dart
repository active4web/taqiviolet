
import 'package:flutter/material.dart';

import '../constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({

    this.text,
   required this.onTap,
    // this.gradient = kBlackGradient,
    this.gradient  ,
    this.height = 40,
    this.textColor = kLightGoldColor,   this.buttonColor,
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
              height: height,
              decoration: BoxDecoration(
                color: Color(0xff393846),
                  gradient: gradient, borderRadius: BorderRadius.circular(35)),
              child: Center(
                  child: Text(
                "${text}",
                style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
