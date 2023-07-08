import 'package:flutter/material.dart%20';
import 'package:easy_localization/src/public_ext.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String text;

  const CustomTextFormField(
      {Key? key,
      required this.controller,
       required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'thisFieldCanNotBeEmpty'.tr();
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
          label: Text(text, style: TextStyle(color: Colors.grey)),
          border:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
    );
  }
}
