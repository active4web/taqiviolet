import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              fontWeight: FontWeight.bold, fontSize: 16.sp, color: fontColor),
        )
      ],
    );
  }
}
