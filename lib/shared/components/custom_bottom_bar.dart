import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/shared/constants.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: AppCubit(),
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return SizedBox(
        height: 85.h,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r), topRight: Radius.circular(30.r),),
            child: BottomAppBar(
              color: Color(0xff393846),
              shape: const CircularNotchedRectangle(),
              child: BottomNavigationBar(
                iconSize: 18.w,
                type: BottomNavigationBarType.fixed,
                elevation: 0,
                backgroundColor: Color(0xff393846)
                    .withAlpha(1),
                selectedItemColor: kDarkGoldColor,
                currentIndex: (cubit.selectedIndex!),
                selectedLabelStyle: TextStyle(
                  fontSize: 10.sp
                ),
                unselectedLabelStyle: TextStyle(
                    fontSize: 10.sp
                ),
                unselectedItemColor: Colors.grey,
                onTap: (value) {
                  cubit.changeNavBar(value, context);
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.home), label: "Home".tr()),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.bookmark_add_outlined),
                      label: "myList".tr()),
                  BottomNavigationBarItem(icon: SizedBox(), label: ''),
                  BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.person), label: 'Account'.tr()),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu), label: 'More'.tr()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
