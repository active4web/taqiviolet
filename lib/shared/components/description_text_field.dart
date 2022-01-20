import 'package:flutter/material.dart';

class DescriptionTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  int maxLines = 1;
  Widget suffixIcon;
  DescriptionTextField(
      {this.controller, this.hintText, this.maxLines, this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 0.5,
              )
            ]),
        child: TextFormField(
          textDirection: TextDirection.rtl,
          controller: controller,
          minLines: 3,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintTextDirection: TextDirection.rtl,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            hintText: hintText,
            isDense: true,
            suffixIcon: suffixIcon,
            // hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
