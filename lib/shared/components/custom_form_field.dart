import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key key,
    this.label,
    this.controller,
    this.isSecured = false,
    this.prefix,
    this.inputType = TextInputType.text,
    this.minLines = 1,
  }) : super(key: key);

  final String label;
  final controller;
  final bool isSecured;
  final Widget prefix;
  final TextInputType inputType;
  final int minLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 50,
      //width: MediaQuery.of(context).size.width,
      // padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
          color: Color(0xffFAFAFA),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 0.5,
            )
          ]),
      child: TextFormField(
        controller: controller,
        obscureText: isSecured,
        keyboardType: inputType,
        minLines: minLines,
        maxLines: minLines != 1 ? null : 1,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            prefix: prefix,
            border: InputBorder.none,
            hintText: label,
            hintTextDirection: TextDirection.rtl),
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
