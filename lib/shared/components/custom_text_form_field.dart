import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/authCubit/auth_cubit.dart';
import 'package:safsofa/cubits/authCubit/auth_states.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key key,
    this.hintText,
    this.icon,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.validate,
    this.fillColor=Colors.white,
    this.hintColor= Colors.white54,
    this.textColor= Colors.white,
  }) : super(key: key);

  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String Function(String) validate;
 final Color fillColor;
 final Color hintColor;
 final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 50,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        validator: validate,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: TextStyle(color: textColor, fontFamily: 'Tajawal'),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: hintText,
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
    Key key,
    this.controller,
    this.hintText = 'password',
    this.validation,
    this.errorStyle,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final String Function(String) validation;
  final TextStyle errorStyle;

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
              obscureText: cubit.showPassword,
              validator: validation,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: hintText,
                errorStyle: errorStyle,
                hintStyle: TextStyle(color: Colors.white54, fontSize: 14),
                suffixIcon: IconButton(
                  icon: Icon(
                    cubit.passwordIcon,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    cubit.changePasswordVisibility();
                  },
                ),
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
