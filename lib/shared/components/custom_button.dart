import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key key,
    this.text,
    this.onTap,
    this.gradient = kBlackGradient,
    this.height = 40,
    this.textColor = kLightGoldColor,
  }) : super(key: key);

  final String text;
  final Gradient gradient;
  final double height;
  final Function onTap;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: height,
              decoration: BoxDecoration(
                  gradient: gradient, borderRadius: BorderRadius.circular(35)),
              child: Center(
                  child: Text(
                text,
                style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
