import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  Color border;
  TextEditingController controller;
  void Function(String) onChange;
  CustomSearchBar({@required this.border, this.controller, this.onChange});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Center(
        child: TextFormField(
          textAlign: TextAlign.start,
          controller: controller,
          onChanged: onChange,
          // textDirection: TextDirection.rtl,
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: border),
                  borderRadius: BorderRadius.circular(10)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: border),
                  borderRadius: BorderRadius.circular(10)),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10)),
              prefixIcon: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
              contentPadding: EdgeInsets.all(10)),
        ),
      ),
    );
  }
}
