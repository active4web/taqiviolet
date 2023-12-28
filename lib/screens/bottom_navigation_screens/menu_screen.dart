import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/appCubit/app_states.dart';
import 'package:safsofa/cubits/authCubit/auth_cubit.dart';
import 'package:safsofa/cubits/authCubit/auth_states.dart';
import 'package:safsofa/screens/bottom_navigation_screens/language_screen.dart';
import 'package:safsofa/screens/display_inspiration_products.dart';
import 'package:safsofa/screens/home_layout.dart';
import 'package:safsofa/screens/menu_screens/about_screen.dart';
import 'package:safsofa/screens/menu_screens/common_question/common_question_screen.dart';
import 'package:safsofa/screens/menu_screens/contact_us_screen.dart';
import 'package:safsofa/screens/menu_screens/offers_screen.dart';
import 'package:safsofa/screens/menu_screens/policies_screens/policies_screen.dart';
import 'package:safsofa/screens/menu_screens/taqi_work_screen.dart';
import 'package:safsofa/screens/menu_screens/technical_support_screen.dart';
import 'package:safsofa/shared/components/dialogs.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';

import '../../network/local/cache_helper.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) => WillPopScope(
        onWillPop: () async {
          displayLogoutDialog(
              context, "closeApplication".tr(), "wantExit".tr());
          return true;
        },
        child: Scaffold(
            backgroundColor: Color(0xff393846),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
              child: Column(
                children: [
                  Container(
                    height: 160.h,
                    width: 200.w,
                    decoration: BoxDecoration(
                      color: Color(0xff393846),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/logo.png',),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  ContainersComponent()
                ],
              ),
            )),
      ),
    );
  }
}

class MenuTile extends StatelessWidget {
  const MenuTile({
    this.label,
    required this.image,
    this.onTap,
  });

  final String? label;
  final Function? onTap;
  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Container(
        padding: EdgeInsets.all(10),
        height:90.h,
        decoration: BoxDecoration(
            color: Color(0xff393846),
            border: Border.all(color: kLightGoldColor),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
              //  height: 120.h,
                //height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitHeight,
                  image: image,
                )),
              ),
            ),

            Expanded(
              flex: 2,
              child: Text(
                "${label}",
                textAlign: TextAlign.center,
                style: TextStyle(color: kLightGoldColor, fontSize: 13.sp),
              ),
            )
          ],
        ),
      ),
    );
  }
}



class ContainersComponent extends StatelessWidget {
  const ContainersComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: MenuTile(
                  label: "This is Taqi Violet".tr(),
                  image: AssetImage(
                      'assets/images/mainlogoheadericon.png'),
                  onTap: () {
                    navigateTo(context, AboutScreen());
                  },
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 4,
                child: MenuTile(
                  label: "workingAtTaqiViolet".tr(),
                  image: AssetImage('assets/images/crown.png'),
                  onTap: () {
                    navigateTo(context, TaqiWorkScreen());
                  },
                ),
              )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Expanded(
                child: MenuTile(
                  label: 'Offers'.tr(),
                  image: AssetImage('assets/images/offers.png'),
                  onTap: () {
                    navigateTo(context, OffersScreen());
                  },
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: MenuTile(
                  label: 'Language'.tr(),
                  image: AssetImage('assets/images/language.png'),
                  onTap: () {
                    navigateTo(context, LanguageScreen());
                  },
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: MenuTile(
                  label: 'Policies'.tr(),
                  image: AssetImage('assets/images/blog.png'),
                  onTap: () {
                    navigateTo(context, PoliciesScreen());
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Expanded(
                flex: 4,
                child: GestureDetector(
                  onTap: () {
                    navigateTo(
                        context,
                        DisplayInspirationProducts(
                          categoryName:
                          'Inspiration and creativity'.tr(),
                        ));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 2.w),
                    height:
                    MediaQuery.of(context).size.height * 0.13,
                    decoration: BoxDecoration(
                        color: Color(0xff393846),
                        border: Border.all(color: kLightGoldColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                        children: [
                          RotatedBox(
                              quarterTurns: 2,
                              child: Icon(
                                Icons.wb_incandescent_outlined,
                                color: kLightGoldColor,
                                size: 22.r,
                              )),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            'Inspiration and creativity'.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: kLightGoldColor,
                                fontSize: 13.sp
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 3,
                child: GestureDetector(
                  onTap: () {
                    navigateTo(context, CommonQuestionsScreen());
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 2.w),
                    height:
                    MediaQuery.of(context).size.height * 0.13,
                    decoration: BoxDecoration(
                        color: Color(0xff393846),
                        border: Border.all(color: kLightGoldColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.question_mark,
                              size: 22.r, color: kLightGoldColor),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "${"commonQuestions".tr()}",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: kLightGoldColor,
                                fontSize: 13.sp
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Expanded(
                child: MenuTile(
                  label: 'TechnicalSupport'.tr(),
                  image: AssetImage('assets/images/support.png'),
                  onTap: () {
                    navigateTo(context, TechnicalSupportScreen());
                  },
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: MenuTile(
                  label: 'newOffers'.tr(),
                  image: AssetImage('assets/images/phone.png'),
                  onTap: () {
                    navigateTo(context, ContactUsScreen());
                  },
                ),
              ),
              SizedBox(
                width: 10,
              ),
              kToken != null
                  ? Expanded(
                child: BlocBuilder<AuthCubit, AuthStates>(
                  builder: (context, state) {
                    return MenuTile(
                      label: 'LogOut'.tr(),
                      image: AssetImage(
                          'assets/images/log out.png'),
                      onTap: () {
                        AuthCubit.get(context).logOut();
                        AppCubit.get(context).selectedIndex = 0;
                        CacheHelper.removeData('type');
                        CacheHelper.removeData('userInfo');
                        CacheHelper.removeData('token');
                        CacheHelper.removeData('id');
                        kToken = null;
                        navigateAndFinish(
                            context, HomeLayout());
                      },
                    );
                  },
                ),
              )
                  : Expanded(
                child: MenuTile(
                  label: 'Login'.tr(),
                  image:
                  AssetImage('assets/images/log out.png'),
                  onTap: () {
                    // navigateTo(context, LoginScreen());
                    AppCubit.get(context).selectedIndex = 3;
                    navigateAndFinish(context, HomeLayout());
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 100.h,
          )
        ],
      ),
    );
  }
}

