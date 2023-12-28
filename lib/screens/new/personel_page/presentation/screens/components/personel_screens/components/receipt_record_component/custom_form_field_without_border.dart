import 'package:flutter/material.dart';
class MainCustomFormFieldWithoutBorder extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String? value) validator;
  final TextInputType keyBoardType;
  final IconData? suffixIcon;
  final VoidCallback? onTap;
  bool isReadOnly;
  bool? isCenter;
  double? fontSize;
   MainCustomFormFieldWithoutBorder({Key? key,
  required this.controller,
  required this.validator,
    this.isCenter,
     this.isReadOnly=false,
    this.onTap,
    this.suffixIcon,
     this.fontSize,
  required this.keyBoardType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: isReadOnly,
      decoration:  InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        suffixIcon: Icon(suffixIcon)
      ),
      style:fontSize!=null? TextStyle(
        fontSize: fontSize
      ):null,
      onTap: onTap,
      textAlign: isCenter!=null?TextAlign.center:TextAlign.start,
      keyboardType: keyBoardType,

      controller: controller,
      validator:validator,

    );
  }
}
