import 'package:flutter/material.dart';

import '../constants.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Center(
        child: TextFormField(
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
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
