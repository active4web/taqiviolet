import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../shared/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  bool? isProjectManger;
  bool? isWarehouseManger;
  double? appBarHeight;
  final Widget? title;
  bool? isActionBottomShow=true;
  final bool leadingImage;
  final bool? actionImage;
  final bool? hasLeading;
  final bool? isCeo;
  final bool? isClient;
  final bool? isRestoration;
  final bool? isEmployee;
  final bool? isHomeScreen;

  CustomAppBar({
    super.key,
    this.title,
     this.isActionBottomShow,
     this.isProjectManger,
    this.isHomeScreen,
    this.leadingImage = false,
      this.actionImage,
     this.hasLeading,
     this.isWarehouseManger,
     this.appBarHeight,
     this.isCeo,
    this.isClient,
    this.isRestoration,
    this.isEmployee
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(

      preferredSize:  Size.fromHeight(250.h),
      child: Container(
        //color: Colors.red,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 280.h,
            ),
            AppBar(
              leading: leadingImage == false
                  ?isHomeScreen==true? IconButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: kDarkGoldColor,
                  )): hasLeading==false?IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ):const SizedBox()
                  : Image.asset('assets/images/download.png'),
              title: title,
              toolbarHeight: 100.h,
              centerTitle: true,
              backgroundColor: kPrimaryColor,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: kPrimaryColor,
                  statusBarIconBrightness: Brightness.light),
              elevation: 0,
              titleTextStyle: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(color: kPrimaryColor),
              shape:  ContinuousRectangleBorder(

                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(60.r),
                  bottomLeft: Radius.circular(60.r),
                ),
              ),
              iconTheme: const IconThemeData(
                  color: kPrimaryColor),
              actions: [
               if(isActionBottomShow==true)
                 IconButton(
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    icon: const Icon(
                      Icons.menu,
                      color: kPrimaryColor,
                    )),
                if(actionImage==true)
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Image.asset(
                        'assets/images/download.png',height: 60.h,
                      width: 80.w,
                    ),
                  )
              ],
            ),


          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>  Size.fromHeight(appBarHeight??70.h);
}
