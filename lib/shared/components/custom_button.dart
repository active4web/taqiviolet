import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key key,
    this.text,
    this.onTap,
  }) : super(key: key);

  final String text;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  gradient: RadialGradient(
                      colors: [Color(0xff4D4D4D), Colors.black], radius: 4),
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                  child: Text(
                text,
                style: TextStyle(color: kLightGoldColor),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
