import 'package:flutter/material.dart';

import '../constants.dart';

class CustomAppBarWithLogo extends StatelessWidget implements  PreferredSizeWidget {
  const CustomAppBarWithLogo({
    required Key key,
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
            bottomLeft: Radius.circular(100),

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
        backgroundColor:Color(0xff393846),// Colors.black,
        title: Container(
            decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/logo.png'),
          ),
        )),
        actions: [

        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(235);
}
