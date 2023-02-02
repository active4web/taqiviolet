// ignore_for_file: must_be_immutable
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/authCubit/auth_cubit.dart';
import 'package:safsofa/cubits/authCubit/auth_states.dart';
import 'package:safsofa/screens/register_screens/login_screen.dart';
import 'package:safsofa/screens/register_screens/select_language_screen.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/components/custom_text_form_field.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';

import '../../cubits/appCubit/app_cubit.dart';
import '../../network/local/cache_helper.dart';
import '../home_layout.dart';

class EmailRegisterScreen extends StatelessWidget {
  EmailRegisterScreen({Key key}) : super(key: key);

  TextEditingController regENameController = TextEditingController();
  TextEditingController regEEmailController = TextEditingController();
  TextEditingController regEAddressController = TextEditingController();
  TextEditingController regEPasswordContoller = TextEditingController();
  TextEditingController confirmRegEPasswordController = TextEditingController();

  bool passwordValidate = false;
  var formRegKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);
          if (state is EmailSignupSuccessState) {
            CacheHelper.setData(
                    key: 'token', value: state.signUpModel.data.token)
                .then((value) {
              kToken = CacheHelper.getData('token');
              AppCubit.get(context).getCache();
              navigateAndFinish(context, HomeLayout());
              // showToast(text: state.signUpModel.msg, color: Colors.green);
            });
          } else if (state is EmailSignupErrorState) {
            showToast(text: state.errorMessage, color: Colors.red);
          }
          return Scaffold(
            extendBody: true,
            resizeToAvoidBottomInset: true,
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background image.png'),
                    fit: BoxFit.cover),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Form(
                    key: formRegKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Text(
                          'SignUp'.tr(),
                          style:
                              TextStyle(color: kLightGoldColor, fontSize: 32),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Language'.tr(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              LanguageChip(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        CustomTextFormField(
                          hintText: 'FullName'.tr(),
                          controller: regENameController,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'thisFieldCanNotBeEmpty'.tr();
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          hintText: 'Email'.tr(),
                          keyboardType: TextInputType.emailAddress,
                          controller: regEEmailController,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'thisFieldCanNotBeEmpty'.tr();
                            } else if (!RegExp(
                                    r"^((([a-zA-Z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-zA-Z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-zA-Z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-zA-Z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-zA-Z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-zA-Z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-zA-Z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-zA-Z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-zA-Z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$")
                                .hasMatch(value)) {
                              return 'pleaseEnterValidEmail'.tr();
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          hintText: 'Address'.tr(),
                          controller: regEAddressController,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'thisFieldCanNotBeEmpty'.tr();
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomPasswordFormField(
                          hintText: 'Password'.tr(),
                          controller: regEPasswordContoller,
                          validation: (String pass) {
                            if (pass.isEmpty) {
                              return 'thisFieldCanNotBeEmpty'.tr();
                            } else {
                              bool result = cubit.validatePassword(pass);
                              if (result) {
                                return null;
                              } else {
                                return "passwordInvalidMessage".tr();
                              }
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: LinearProgressIndicator(
                            value: cubit.password_strength,
                            backgroundColor: Colors.grey[300],
                            minHeight: 5,
                            color: cubit.password_strength <= 1 / 4
                                ? Colors.red
                                : cubit.password_strength == 2 / 4
                                    ? Colors.yellow
                                    : cubit.password_strength == 3 / 4
                                        ? Colors.blue
                                        : Colors.green,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // FlutterPwValidator(
                        //   controller: regEPasswordContoller,
                        //   minLength: 6,
                        //   uppercaseCharCount: 1,
                        //   numericCharCount: 1,
                        //   specialCharCount: 1,
                        //   width: MediaQuery.of(context).size.width / 1.2,
                        //   height: MediaQuery.of(context).size.height / 6,
                        //   onSuccess: () {
                        //     passwordValidate = true;
                        //   },
                        //   onFail: () {
                        //     passwordValidate = false;
                        //   },
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomPasswordFormField(
                          hintText: "confirmPassword".tr(),
                          controller: confirmRegEPasswordController,
                          validation: (String value) {
                            if (value == null || value.isEmpty) {
                              return "thisFieldCanNotBeEmpty".tr();
                            } else if (value != regEPasswordContoller.text) {
                              return "passwordDoesNotMatch".tr();
                            } else {
                              return null;
                            }
                          },
                        ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: ListTile(
                        //         contentPadding: EdgeInsets.zero,
                        //         horizontalTitleGap: 0,
                        //         leading: Icon(Icons.check,
                        //             color: AuthCubit.get(context).consistOf6
                        //                 ? Colors.green
                        //                 : null),
                        //         title: Text(
                        //           '6 charcters',
                        //           style: TextStyle(
                        //               color: AuthCubit.get(context).consistOf6
                        //                   ? Colors.green
                        //                   : null),
                        //         ),
                        //       ),
                        //     ),
                        //     Expanded(
                        //       child: ListTile(
                        //         contentPadding: EdgeInsets.zero,
                        //         horizontalTitleGap: 0,
                        //         leading: Icon(Icons.check,
                        //             color: AuthCubit.get(context).consistOf6
                        //                 ? Colors.green
                        //                 : null),
                        //         title: Text(
                        //           'Capital letters',
                        //           style: TextStyle(
                        //               color: AuthCubit.get(context).consistOf6
                        //                   ? Colors.green
                        //                   : null),
                        //         ),
                        //       ),
                        //     ),
                        //     Expanded(
                        //       child: ListTile(
                        //         contentPadding: EdgeInsets.zero,
                        //         horizontalTitleGap: 0,
                        //         leading: Icon(Icons.check,
                        //             color: AuthCubit.get(context).consistOf6
                        //                 ? Colors.green
                        //                 : null),
                        //         title: Text(
                        //           'Small letters',
                        //           style: TextStyle(
                        //               color: AuthCubit.get(context).consistOf6
                        //                   ? Colors.green
                        //                   : null),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: ListTile(
                        //         contentPadding: EdgeInsets.zero,
                        //         horizontalTitleGap: 0,
                        //         leading: Icon(Icons.check,
                        //             color: AuthCubit.get(context).consistOf6
                        //                 ? Colors.green
                        //                 : null),
                        //         title: Text(
                        //           'Special Characters',
                        //           style: TextStyle(
                        //               color: AuthCubit.get(context).consistOf6
                        //                   ? Colors.green
                        //                   : null),
                        //         ),
                        //       ),
                        //     ),
                        //     Expanded(
                        //       child: ListTile(
                        //         contentPadding: EdgeInsets.zero,
                        //         horizontalTitleGap: 0,
                        //         leading: Icon(Icons.check,
                        //             color: AuthCubit.get(context).consistOf6
                        //                 ? Colors.green
                        //                 : null),
                        //         title: Text(
                        //           'Numbers',
                        //           style: TextStyle(
                        //               color: AuthCubit.get(context).consistOf6
                        //                   ? Colors.green
                        //                   : null),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: CustomPasswordFormField(
                        //         hintText: 'Password'.tr(),
                        //         controller: regEPasswordContoller,
                        //         validation: (String val) =>
                        //             AuthCubit.get(context).checkPassword(val),
                        //         // errorStyle: TextStyle(
                        //         //     color: AuthCubit.get(context).strength >= 3 / 4
                        //         //         ? Colors.green
                        //         //         : null),
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: 20,
                        //     ),
                        //     Expanded(
                        //       child: Wrap(
                        //         children: [
                        //           ListTile(
                        //             contentPadding: EdgeInsets.zero,
                        //             horizontalTitleGap: 0,
                        //             leading: Icon(Icons.check,
                        //                 color: AuthCubit.get(context).consistOf6
                        //                     ? Colors.green
                        //                     : null),
                        //             title: Text(
                        //               '6 charcters',
                        //               style: TextStyle(
                        //                   color: AuthCubit.get(context).consistOf6
                        //                       ? Colors.green
                        //                       : null),
                        //             ),
                        //           ),
                        //           ListTile(
                        //             contentPadding: EdgeInsets.zero,
                        //             horizontalTitleGap: 0,
                        //             leading: Icon(Icons.check,
                        //                 color: AuthCubit.get(context).consistOf6
                        //                     ? Colors.green
                        //                     : null),
                        //             title: Text(
                        //               'Capital letters',
                        //               style: TextStyle(
                        //                   color: AuthCubit.get(context).consistOf6
                        //                       ? Colors.green
                        //                       : null),
                        //             ),
                        //           ),
                        //           ListTile(
                        //             contentPadding: EdgeInsets.zero,
                        //             horizontalTitleGap: 0,
                        //             leading: Icon(Icons.check,
                        //                 color: AuthCubit.get(context).consistOf6
                        //                     ? Colors.green
                        //                     : null),
                        //             title: Text(
                        //               'Small letters',
                        //               style: TextStyle(
                        //                   color: AuthCubit.get(context).consistOf6
                        //                       ? Colors.green
                        //                       : null),
                        //             ),
                        //           ),
                        //           ListTile(
                        //             contentPadding: EdgeInsets.zero,
                        //             horizontalTitleGap: 0,
                        //             leading: Icon(Icons.check,
                        //                 color: AuthCubit.get(context).consistOf6
                        //                     ? Colors.green
                        //                     : null),
                        //             title: Text(
                        //               'Special Characters',
                        //               style: TextStyle(
                        //                   color: AuthCubit.get(context).consistOf6
                        //                       ? Colors.green
                        //                       : null),
                        //             ),
                        //           ),
                        //           ListTile(
                        //             contentPadding: EdgeInsets.zero,
                        //             horizontalTitleGap: 0,
                        //             leading: Icon(Icons.check,
                        //                 color: AuthCubit.get(context).consistOf6
                        //                     ? Colors.green
                        //                     : null),
                        //             title: Text(
                        //               'Numbers',
                        //               style: TextStyle(
                        //                   color: AuthCubit.get(context).consistOf6
                        //                       ? Colors.green
                        //                       : null),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     )
                        //   ],
                        // ),
                        // The strength indicator bar
                        // LinearProgressIndicator(
                        //   value: AuthCubit.get(context).strength,
                        //   backgroundColor: Colors.grey[300],
                        //   color: AuthCubit.get(context).strength <= 1 / 4
                        //       ? Colors.red
                        //       : AuthCubit.get(context).strength == 2 / 4
                        //           ? Colors.yellow
                        //           : AuthCubit.get(context).strength == 3 / 4
                        //               ? Colors.blue
                        //               : Colors.green,
                        //   minHeight: 4,
                        // ),
                        SizedBox(
                          height: 30,
                        ),
                        state is EmailSignupLoadingState
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: kLightGoldColor,
                                ),
                              )
                            : CustomButton(
                                text: 'SignUp'.tr(),
                                height: 50,
                                gradient: kGoldGradient,
                                textColor: Colors.black,
                                onTap: () {
                                  if (formRegKey.currentState.validate() &&
                                      passwordValidate) {
                                    log("""
                                        ${regEAddressController.text},
                                        ${regEEmailController.text},
                                        ${regENameController.text},
                                        ${EasyLocalization.of(context).currentLocale.toString()},
                                            
                                            ${cubit.MobToken}
                                        """);
                                    cubit.registerWithEmail(
                                      lang: EasyLocalization.of(context)
                                          .currentLocale
                                          .toString(),
                                      name: regENameController.text,
                                      address: regEAddressController.text,
                                      email: regEEmailController.text,
                                      password: regEPasswordContoller.text,
                                      key: '2',
                                    );
                                  }
                                  // if (regENameController.text == '' ||
                                  //     phoneController.text == '' ||
                                  //     regEAddressController.text == '' ||
                                  //     regEEmailController.text == '' ||
                                  //     !regEEmailController.text.contains("@")) {
                                  //   showToast(
                                  //       text: 'تأكد من ملئ البيانات بشكل كامل',
                                  //       color: Colors.red);
                                  // } else if (regEPasswordContoller.text.length < 6) {
                                  //   showToast(
                                  //       text: 'Password must be longer than 5',
                                  //       color: Colors.red);
                                  // } else {
                                  //
                                  // }
                                },
                              ),
                        SizedBox(height: 30),
                        InkWell(
                          onTap: () {
                            navigateTo(context, LoginScreen());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'HaveAnAccount?'.tr(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                              Text(
                                'Login'.tr(),
                                style: TextStyle(
                                    color: kLightGoldColor, fontSize: 12),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class LanguageChip extends StatelessWidget {
  const LanguageChip({
    Key key,
    this.localCode,
    this.flag,
  }) : super(key: key);

  final String localCode;
  final ImageProvider flag;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(context, SelectLanguageScreen());
      },
      child: Container(
        width: 40,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(5),
          // border: Border.all(color: Colors.white, width: 1),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: EasyLocalization.of(context).currentLocale.toString() == "ar"
                ? AssetImage('assets/images/Arabia.png')
                : EasyLocalization.of(context).currentLocale.toString() == "en"
                    ? AssetImage('assets/images/English.png')
                    : EasyLocalization.of(context).currentLocale.toString() ==
                            "it"
                        ? AssetImage('assets/images/Italy.png')
                        : SizedBox(),
          ),
        ),
      ),
    );
  }
}
