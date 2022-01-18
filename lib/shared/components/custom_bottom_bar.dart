import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/app_States.dart';
import 'package:safsofa/cubits/app_cubit.dart';
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
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              backgroundColor: Theme.of(context).primaryColor.withAlpha(0),
              selectedItemColor: kDarkGoldColor,
              currentIndex: cubit.selectedIndex,
              unselectedItemColor: Colors.grey,
              onTap: (value) {
                cubit.changeNavBar(value);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.home), label: ''),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.chat_bubble_2), label: ''),
                BottomNavigationBarItem(icon: SizedBox(), label: ''),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.person), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: ''),
              ],
            ),
          ),
        );
      },
    );
  }
}
