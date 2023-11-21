import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/constants.dart';

class CustomBottomWithoutBorder extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? background;
  final Function function;
  final String? text;
  final double? radius;
  final Color borderRadius;
  final Color? textColor;
  final bool textStyle;
  final double? fontSize;
  const CustomBottomWithoutBorder({
    super.key,
    required this.function,
    this.textColor,
    this.fontSize,
    required this.text,
    this.height,
    this.width = double.infinity,
    this.background = kCustomBlack,
    this.radius = 30,
    this.borderRadius = kCustomBlack,
    this.textStyle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: background,

        border: Border.all(
          color: borderRadius,
        ),
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          text.toString(),
          style:textStyle == false?  Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: textColor??Colors.white,
          fontSize: fontSize??12.sp):
          Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: textColor??kCustomBlack,
          fontSize: fontSize??12.sp),
        ),
      ),
    );
  }
}
