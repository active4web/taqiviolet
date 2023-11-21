import 'package:flutter/material.dart';
import 'package:safsofa/shared/constants.dart';

class CustomYellowContainer extends StatelessWidget {
  final Widget widget;
  final Color? containerColor;
  const CustomYellowContainer({Key? key,
  required this.widget,
    this.containerColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: containerColor??Colors.grey,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: kCustomBlack,
          )
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          8,
        ),
        child: Center(
          child: widget,
        ),
      ),
    );
  }
}
