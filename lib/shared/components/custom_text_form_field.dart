import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../constants.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final IconData? icon;
  final Widget? suffix;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validate;
  final Color fillColor;
  final Color hintColor;
  final Color borderColor;
  final Color textColor;
  final Color cursorColor;
  bool readOnly = false;
  final double? fontSize;
  bool check;
  final int? maxLines;
  void Function(String)? onChanged;
  void Function(String)? onFieldSubmitted;
   CustomTextFormField({
    this.hintText,
    this.icon,
     this.fontSize,
    this.controller,
    this.readOnly = false,
     this.borderColor=Colors.white,
    this.keyboardType = TextInputType.text,
    this.fillColor = Colors.white,
    this.hintColor = Colors.white54,
    this.textColor = Colors.white,
    this.cursorColor = Colors.white,
  required  this.validate, this.maxLines=1,
     this.onChanged,
     this.onFieldSubmitted,
     this.check=false, this.suffix
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 50,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.r)),
      child: TextFormField(
        onFieldSubmitted:onFieldSubmitted ,
        onChanged: onChanged,
        maxLines:maxLines ,
        readOnly: readOnly,
        keyboardType: keyboardType,
        controller: controller,

        validator: validate
        ,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        style: TextStyle(color: textColor, fontFamily: 'Tajawal',
            fontSize: fontSize??12.sp),

        cursorColor: cursorColor,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 13.h),
          hintText: hintText,
          suffixIcon: check?Icon(Icons.check_circle,color: Colors.green,):suffix,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.circular(34.r)),
          hintStyle: TextStyle(color: hintColor, fontSize: 14.sp),
          filled: true,
          fillColor: fillColor.withOpacity(0.4),
          isDense: true,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.circular(50.r)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.circular(50.r)),
        ),
      ),
    );
  }
}

class CustomPasswordFormField extends StatelessWidget {
  const CustomPasswordFormField({
    this.controller,
    this.hintText = 'password',
    this.validation,
    this.errorStyle,
    this.isPassword = false,
    this.suffixOnPressed,
    this.suffixIcon,

  });

  final TextEditingController? controller;
  final String? hintText;
  final Function? validation;
  final TextStyle? errorStyle;
  final IconData? suffixIcon;
  final bool isPassword;
  final Function? suffixOnPressed;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.white,
      keyboardType: TextInputType.visiblePassword,
      obscureText: isPassword,
      validator: (v){
        return validation!(v!);
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: TextStyle(color: Colors.white,fontSize: 12.sp),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
        hintText: hintText,
        errorStyle: errorStyle,
        errorMaxLines: 2,
        hintStyle: TextStyle(color: Colors.white54, fontSize: 14.sp),
        suffixIcon: suffixIcon != null
            ? IconButton(
            icon: Icon(
              suffixIcon,
              size: 20.w,
              color: kLightGoldColor,
            ),
            onPressed: () {
              suffixOnPressed!();

            })
            : SizedBox.shrink(),
        filled: true,
        fillColor: Colors.white.withOpacity(0.4),
        isDense: true,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(30.r)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(30.r)),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30.r)),
      ),
    );
  }
}
