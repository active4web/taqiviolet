import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';

class CustomAppBar extends StatelessWidget implements  PreferredSizeWidget {
  const CustomAppBar({
    this.title,
    this.title2,
    this.icon,

  }) ;

  final String? title;
  final String? title2;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: AppBar(
        leading: icon,
        toolbarHeight: MediaQuery.of(context).size.height / 10,
        leadingWidth: 80,

        title: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            Text("${title}",maxLines: 2,),
            if(title2!=null)
            Text("${title2}",maxLines: 2,),
          ],
        ),
        backgroundColor: Color(0xff393846),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color(0xff393846),
            statusBarIconBrightness: Brightness.light
        ) ,
        ///Color(),// Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
            color: kLightGoldColor, fontFamily: 'Tajawal', fontSize: 17.sp),
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
              //fit: BoxFit.fill,
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

class CustomMainAppBar extends StatelessWidget implements  PreferredSizeWidget {


  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  const CustomMainAppBar({
    this.title,
    this.leading,
    this.actions

  }) ;


  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize:  Size.fromHeight(70.h),
      child: AppBar(
        leading: leading,
        toolbarHeight: MediaQuery.of(context).size.height / 10,
        leadingWidth: 80.w,
        title: Text("${title}",maxLines: 2,),
        backgroundColor: Color(0xff393846),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color(0xff393846),
            statusBarIconBrightness: Brightness.light
        ) ,
        ///Color(),// Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
            color: kLightGoldColor, fontFamily: 'Tajawal', fontSize: 17.sp),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(60),
            bottomLeft: Radius.circular(60),

          ),
        ),
        iconTheme: IconThemeData(color: kLightGoldColor),
        actions:actions,

      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(70.h);
}






