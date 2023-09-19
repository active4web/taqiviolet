import 'package:flutter/material.dart';
import 'package:safsofa/shared/constants.dart';

class CustomTranslateCheckBox extends StatelessWidget {
  final bool check;
  final ValueChanged<bool?>  function;
  const CustomTranslateCheckBox({
    Key? key,
    required this.function,
    required this.check}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 6,
        height: 60,
        //color: Colors.red,
        child: Transform.translate(
          offset: Offset(0,-20),
          child: Checkbox(
            // activeColor: Colors.green,
            value: check,
            onChanged: function,
            checkColor: kDarkGoldColor,

          ),
        ));
  }
}