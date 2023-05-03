import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  const Label({
    this.text,
    this.fontColor,
  });

  final String? text;
  final Color? fontColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "${text}",
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 15, color: fontColor),
        )
      ],
    );
  }
}
