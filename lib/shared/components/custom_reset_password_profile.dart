import 'package:flutter/material.dart%20';
import 'package:safsofa/shared/constants.dart';

class CustomResetPasswordProfile extends StatelessWidget {
   CustomResetPasswordProfile({
     this.controller,
     this.hintText ,
     this.validation,
     // this.isPassword = true,
     this.suffixOnPressed,
     this.suffixIcon,


   }) ;
  final TextEditingController? controller;
  final String? hintText;
  final Function? validation;
  final IconData? suffixIcon;
  // final bool isPassword;
  final Function? suffixOnPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
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
        // cursorColor: Colors.white,
        keyboardType: TextInputType.visiblePassword,
        // obscureText: isPassword,
        validator: (v){
          return validation!(v!);
        },
        autovalidateMode:
        AutovalidateMode.onUserInteraction,
        // style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            border: InputBorder.none,
            hintText: hintText,
            suffixIcon: suffixIcon != null
                ? IconButton(
                icon: Icon(
                  suffixIcon,
                  color: kLightGoldColor,
                ),
                onPressed: () {
                  suffixOnPressed!();
                })
                : null,
            hintTextDirection: TextDirection.rtl),

      ),
    );
  }
}
