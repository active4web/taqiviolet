import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  const Label({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        )
      ],
    );
  }
}
