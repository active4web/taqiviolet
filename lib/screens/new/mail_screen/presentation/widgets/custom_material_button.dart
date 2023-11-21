import 'package:flutter/material.dart';
import 'package:safsofa/shared/constants.dart';

class CustomMaterialButton extends StatelessWidget {
  final double? width;
  final Color? background;
  final Function function;
  final String? text;
  final double? radius;
  final Color borderRadius;
  final bool textStyle;
  const CustomMaterialButton({
    super.key,
    required this.function,
    required this.text,
    this.width = double.infinity,
    this.background = kPrimaryColor,
    this.radius = 30,
    this.borderRadius = kPrimaryColor,
    this.textStyle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(
          radius!,
        ),
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
              .copyWith(color:kPrimaryColor):
          Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: kPrimaryColor),
        ),
      ),
    );
  }
}
