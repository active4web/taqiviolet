import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    this.label,
    this.controller,
    this.isSecured = false,
    this.prefix,
    this.inputType = TextInputType.text,
    this.minLines = 1,
    required  this.validate,

  });

  final String? label;
  final controller;
  final bool isSecured;
  final Widget? prefix;
  final TextInputType inputType;
  final int minLines;
  final String? Function(String? val) validate;


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
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        obscureText: isSecured,
        keyboardType: inputType,
        minLines: minLines,
        maxLines: minLines != 1 ? null : 1,
        decoration: InputDecoration(

            contentPadding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 13.h),
            prefix: prefix,
            border: InputBorder.none,
            hintText: label,
            ),
        style: TextStyle(color: Colors.black),
          validator: (value){
            return  validate(value);
          }
      ),
    );
  }
}
