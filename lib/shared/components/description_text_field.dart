import 'package:flutter/material.dart';

class DescriptionTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String ?hintText;
  int maxLines ;
  Widget? suffixIcon;
  final String? Function(String?)? validator;
  DescriptionTextField(
      {this.controller, this.hintText, this.maxLines= 1, this.suffixIcon, this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey)),
      child: TextFormField(
        validator: validator,
        controller: controller,
        minLines: 4,
        maxLines: maxLines,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 13),
          isDense: true,
          suffixIcon: suffixIcon,
          // hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
