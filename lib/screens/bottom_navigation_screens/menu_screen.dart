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
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Color(0xff393846),
                statusBarIconBrightness: Brightness.light),
            toolbarHeight: 0.0,
            elevation: 0.0,
          ),
          body: BlocProvider(
            create: (context) => AuthCubit(),
            child: BlocConsumer<AuthCubit, AuthStates>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 30.w,vertical: 20.h),
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.6,
                          decoration: BoxDecoration(
                            color: Color(0xff393846),
                            image: DecorationImage(
                              image: AssetImage('assets/images/logo.png'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
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
                              flex: 5,
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
                          height: 10,
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
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
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
                                  padding: EdgeInsets.all(10),
                                  height:
                                      MediaQuery.of(context).size.height * 0.13,
                                  decoration: BoxDecoration(
                                      color: Color(0xff393846),
                                      border:
                                          Border.all(color: kLightGoldColor),
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
                                              size: 30,
                                            )),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Inspiration and creativity'.tr(),
                                          textAlign: TextAlign.center,
                                          style:
                                              TextStyle(color: kLightGoldColor),
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
                              child: GestureDetector(
                                onTap: () {
                                  navigateTo(context, CommonQuestionsScreen());
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  height:
                                      MediaQuery.of(context).size.height * 0.13,
                                  decoration: BoxDecoration(
                                      color: Color(0xff393846),
                                      border:
                                          Border.all(color: kLightGoldColor),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(Icons.question_mark,
                                            color: kLightGoldColor),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${"commonQuestions".tr()}",
                                          textAlign: TextAlign.center,
                                          style:
                                              TextStyle(color: kLightGoldColor),
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
                          height: 10,
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
                                    child: MenuTile(
                                      label: 'LogOut'.tr(),
                                      image: AssetImage(
                                          'assets/images/log out.png'),
                                      onTap: () {
                                        AuthCubit.get(context)
                                            .logOut(context: context);
                                        print("Bishotoken $kToken");
                                        AppCubit.get(context).selectedIndex = 0;
                                        navigateAndFinish(
                                            context, HomeLayout());
                                      },
                                    ),
                                  )
                                : Expanded(
                                    child: MenuTile(
                                      label: 'Login'.tr(),
                                      image: AssetImage(
                                          'assets/images/log out.png'),
                                      onTap: () {
                                        // navigateTo(context, LoginScreen());
                                        AppCubit.get(context).selectedIndex = 3;
                                        navigateAndFinish(
                                            context, HomeLayout());
                                      },
                                    ),
                                  ),
                          ],
                        ),

                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
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
        height: MediaQuery.of(context).size.height * 0.13,
        decoration: BoxDecoration(
            color: Color(0xff393846),
            border: Border.all(color: kLightGoldColor),
            borderRadius: BorderRadius.circular(10)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.04,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: image,
                )),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "${label}",
                textAlign: TextAlign.center,
                style: TextStyle(color: kLightGoldColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
