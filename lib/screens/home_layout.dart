import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/app_cubit.dart';
import 'package:safsofa/cubits/app_states.dart';
import 'package:safsofa/shared/components/custom_bottom_bar.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          extendBody: true,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: InkWell(
            onTap: () {
              cubit.changeNavBar(2);
            },
            child: Container(
              padding: EdgeInsets.all(15),
              decoration:
                  BoxDecoration(color: Colors.black, shape: BoxShape.circle),
              child: Icon(
                CupertinoIcons.bag,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          body: IndexedStack(
            children: cubit.screens,
            index: cubit.selectedIndex,
          ),
          bottomNavigationBar: CustomBottomNavigationBar(),
        );
      },
    );
  }
}
