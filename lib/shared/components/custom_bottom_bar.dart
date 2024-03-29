import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/shared/constants.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: AppCubit(),
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30),),
          child: BottomAppBar(
            color: Color(0xff393846),
            shape: const CircularNotchedRectangle(),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              backgroundColor: Color(0xff393846)
                  .withAlpha(1),
              selectedItemColor: kDarkGoldColor,
              currentIndex: (cubit.selectedIndex!),
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
        );
      },
    );
  }
}
