import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/shared/constants.dart';

class CustomDropDown<T> extends StatelessWidget {
  final T value;

  final String hintText;
  final Color hintColor;
  final Color fillColor;
  final Color textColor;
  final List<DropdownMenuItem<T>> items;
  final void Function(T) onChanged;

  final String Function(T) validate;
  CustomDropDown({
    Key key,
    @required this.hintText,
    @required this.items,
    @required this.onChanged,
    @required this.value,
    this.validate,
    this.fillColor = Colors.white,
    this.hintColor = Colors.white54,
    this.textColor = Colors.white,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      style: TextStyle(color: textColor, fontFamily: 'Tajawal'),

      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(34), //34
        ),
        // hintStyle: TextStyle(color: hintColor, fontSize: 14),
        filled: true,
        fillColor: fillColor.withOpacity(0.4),
        // isDense: true,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(50)), //50
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(50)), //50
      ),
      hint: Text(
        hintText,
        style: TextStyle(
          fontSize: 14,
          color: hintColor,
        ),
      ),
      icon: const Icon(
        Icons.expand_more,
        color: Color(0xffB4AFAF),
      ),
      iconSize: 28,
      buttonHeight: 50,
      // buttonWidth: 120,
      // buttonPadding: const EdgeInsets.symmetric(horizontal: 2),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      validator: validate,
      onChanged: onChanged,
      items: items,
    );
  }
}
