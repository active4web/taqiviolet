import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';
import 'custom_search_bar.dart';

class CustomAppBarWithSearch extends StatelessWidget implements  PreferredSizeWidget {
  CustomAppBarWithSearch(
      {
      this.title,
      this.colorAB = Colors.white,
      this.withFilter = false,
      this.colorIcon = Colors.white,
       this.controller,
        this.function,
       this.onChange, this.onSaved, this.iconSearchOnTap})
       ;

  final String? title;
  final void Function()? iconSearchOnTap;
  Color? colorAB;
  final bool withFilter;
  final Function? function;
  Color colorIcon;
  TextEditingController? controller;
  void Function(String)? onChange;
  final void Function(String?)? onSaved;
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(160.h),
      child: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff393846), //
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color(0xff393846),
            statusBarIconBrightness: Brightness.light
        ) ,
// colorAB,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(60.r)),
        ),
        title: Text(
          "${title}",
          style: TextStyle(
              fontSize: 14.sp, fontWeight: FontWeight.normal, color: colorIcon),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: colorIcon, // Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.w),
            child: Image(
              height: 65.h,
              image: AssetImage('assets/images/logoheader.png'),
            ),
          )
        ],
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(65.h),
          child: Padding(
            padding:  EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
            child: Row(
              children: [
                withFilter
                    ? InkWell(
                  onTap: (){
                    function!();
                  },
                      child: Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                              color: colorIcon, //Colors.grey,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Icon(CupertinoIcons.line_horizontal_3_decrease,
                              color: Colors.black // Colors.white,
                              ),
                        ),
                    )
                    : SizedBox(),
                SizedBox(
                  width: withFilter ? 10 : 0,
                ),
                Expanded(
                    child: CustomSearchBar(

                  border: colorIcon,
                  controller: controller,
                  onChange: onChange,
                      onSaved:onSaved ,
                      iconSearchOnTap: iconSearchOnTap,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(90.h);
}
