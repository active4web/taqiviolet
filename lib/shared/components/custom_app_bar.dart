import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.black,
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
            image: AssetImage('assets/images/logo.png'),
          ),
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(100);
}
