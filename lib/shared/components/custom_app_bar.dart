import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';

class CustomAppBar extends StatelessWidget implements  PreferredSizeWidget {
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
        leading: icon,
        toolbarHeight: MediaQuery.of(context).size.height / 10,
        leadingWidth: 100,
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
              image: AssetImage('assets/images/CjNXMk2j7aZvFbC5k5LbDOoBhYylZTRxrSx4jSVU.png',
              ),
              height: 70,
              width: 70,
            ),
          )
        ],

      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(70);
}
