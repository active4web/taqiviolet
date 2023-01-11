import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/appCubit/app_states.dart';
import 'package:safsofa/shared/components/custom_bottom_bar.dart';
import 'package:safsofa/shared/constants.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: InkWell(
            onTap: () {
              cubit.changeNavBar(2, context);
            },
            child: Container(
              padding: EdgeInsets.all(15),
              decoration:
                  BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Icon(
                    CupertinoIcons.bag,
                    size: 30,
                    color: Colors.black,
                  ),
                  if (cartCount != 0)
                    StreamBuilder<int>(
                        initialData: cartCount,
                        stream: cartCountControlller.stream,
                        builder: (context, snapShot) {
                          if (snapShot.data != 0) {
                            return Container(
                              width: 20,
                              height: 20,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: Text(
                                  snapShot.data.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        }),
                ],
              ),
            ),
          ),
          body: cubit.screens[cubit
              .selectedIndex] /*IndexedStack(
            children: cubit.screens,
            index: cubit.selectedIndex,
          )*/
          ,
          bottomNavigationBar: CustomBottomNavigationBar(),
        );
      },
    );
  }
}
