import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    this.title,
    this.icon,

  }) ;

  final String? title;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: AppBar(
        title: Text("${title}"),
        backgroundColor: Color(0xff393846),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color(0xff393846),
            statusBarIconBrightness: Brightness.light
        ) ,
        ///Color(),// Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
            color: kLightGoldColor, fontFamily: 'Tajawal', fontSize: 17),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(60),
            bottomLeft: Radius.circular(60),

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
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(70);
}
