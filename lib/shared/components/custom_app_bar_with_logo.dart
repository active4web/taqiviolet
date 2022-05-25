import 'package:flutter/material.dart';

import '../constants.dart';

class CustomAppBarWithLogo extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBarWithLogo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.25),
      child: AppBar(
        iconTheme: IconThemeData(color: kLightGoldColor),
        elevation: 0,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(100),
          ),
        ),
        flexibleSpace: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/logo.png'),
            )),
          ),
        ),
        backgroundColor:HexaColor.fromHexa("#2d2d37"),// Colors.black,
        title: Container(
            decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/logo.png'),
          ),
        )),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(235);
}
