import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/appCubit/app_states.dart';
import 'package:safsofa/shared/components/custom_bottom_bar.dart';
import 'package:safsofa/shared/constants.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout>with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) =>
            Scaffold(
              resizeToAvoidBottomInset: false,
              extendBody: true,
              floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
              floatingActionButton: InkWell(
                onTap: () {
                  cubit.changeNavBar(2, context);
                },
                child: Container(
                  padding: EdgeInsets.all(15.r),
                  decoration:
                  BoxDecoration(color: Color(0xff393846), shape: BoxShape.circle),
                  child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Icon(
                        CupertinoIcons.bag,
                        size: 30.r,
                        color: cubit.selectedIndex == 2 ? kDarkGoldColor :Colors.grey,
                      ),
                      if (cartCount != 0)
                        StreamBuilder<int>(
                            initialData: cartCount,
                            stream: cartCountControlller.stream,
                            builder: (context, snapShot) {
                              if (snapShot.data != 0) {
                                return Container(
                                  width: 20.w,
                                  height: 20.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                  child: Padding(
                                    padding:  EdgeInsets.all(3.r),
                                    child: Text(
                                      snapShot.data.toString(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15.sp),
                                    ),
                                  ),
                                );
                              } else {
                                return SizedBox();
                              }
                            },
                        ),
                    ],
                  ),
                ),
              ),
              body: cubit.screens[cubit.selectedIndex!]
              /*IndexedStack(
            children: cubit.screens,
            index: cubit.selectedIndex,
          )*/
              ,
              bottomNavigationBar:  CustomBottomNavigationBar(),
            )
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true
  ;}