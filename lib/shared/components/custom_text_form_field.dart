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
  }) : super(key: key);

  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 50,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        style: TextStyle(color: Colors.white, fontFamily: 'Tajawal'),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(34)),
          hintStyle: TextStyle(color: Colors.white54, fontSize: 14),
          filled: true,
          fillColor: Colors.white.withOpacity(0.4),
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
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;

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
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: hintText,
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
