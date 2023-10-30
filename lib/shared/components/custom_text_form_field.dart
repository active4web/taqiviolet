import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/authCubit/auth_cubit.dart';
import 'package:safsofa/cubits/authCubit/auth_states.dart';

import '../constants.dart';

class CustomTextFormField extends StatelessWidget {
   CustomTextFormField({
    this.hintText,
    this.icon,
    this.controller,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.fillColor = Colors.white,
    this.hintColor = Colors.white54,
    this.textColor = Colors.white,
    this.cursorColor = Colors.white,
  required  this.validate, this.maxLines=1,
     this.onChanged,
     this.onFieldSubmitted,
     this.check=false
  });

  final String? hintText;
  final IconData? icon;
  final TextEditingController? controller;
  final TextInputType keyboardType;
 final String? Function(String?)? validate;
  final Color fillColor;
  final Color hintColor;
  final Color textColor;
  final Color cursorColor;
    bool readOnly = false;
    bool check;
    final int? maxLines;
void Function(String)? onChanged;
   void Function(String)? onFieldSubmitted;
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 50,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      child: TextFormField(
        onFieldSubmitted:onFieldSubmitted ,
        onChanged: onChanged,
        maxLines:maxLines ,
        readOnly: readOnly,
        keyboardType: keyboardType,
        controller: controller,
        validator: validate
        ,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: TextStyle(color: textColor, fontFamily: 'Tajawal'),
        cursorColor: cursorColor,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: check?Icon(Icons.check_circle,color: Colors.green,):SizedBox.shrink(),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(34)),
          hintStyle: TextStyle(color: hintColor, fontSize: 14),
          filled: true,
          fillColor: fillColor.withOpacity(0.4),
          isDense: true,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(50)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(50)),
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
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);
          return Container(
            //height: 50,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            child: TextFormField(
              controller: controller,
              cursorColor: Colors.white,
              keyboardType: TextInputType.visiblePassword,
              obscureText: isPassword,
              validator: (v){
                return validation!(v!);
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: hintText,
                errorStyle: errorStyle,
                errorMaxLines: 2,
                hintStyle: TextStyle(color: Colors.white54, fontSize: 14),
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
                filled: true,
                fillColor: Colors.white.withOpacity(0.4),
                isDense: true,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(30)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(30)),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30)),
              ),
            ),
          );
        },
      ),
    );
  }
}
