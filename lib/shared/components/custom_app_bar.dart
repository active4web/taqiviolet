import 'dart:ui';

import 'package:flutter/material.dart';

import '../constants.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    Key key,
    this.title,
    this.icon,
  }) : super(key: key);

  final String title;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: HexaColor.fromHexa("#2d2d37"),

      ///Color(),// Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
          color: kLightGoldColor, fontFamily: 'Tajawal', fontSize: 17),
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(60),
        ),
      ),
      iconTheme: IconThemeData(color: kLightGoldColor),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Image(
            image: AssetImage('assets/images/logoheader.png'),
          ),
        )
      ],
      leading: icon,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(70);
}
