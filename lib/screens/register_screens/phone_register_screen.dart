// ignore_for_file: must_be_immutable
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:safsofa/cubits/authCubit/auth_cubit.dart';
import 'package:safsofa/cubits/authCubit/auth_states.dart';
import 'package:safsofa/screens/register_screens/login_screen.dart';
import 'package:safsofa/screens/register_screens/select_language_screen.dart';
import 'package:safsofa/screens/register_screens/strings.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/components/custom_text_form_field.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';

import '../../cubits/appCubit/app_cubit.dart';
import '../../network/local/cache_helper.dart';
import '../home_layout.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

class PhoneRegisterScreen extends StatefulWidget {

  @override
  State<PhoneRegisterScreen> createState() => _PhoneRegisterScreenState();
}

class _PhoneRegisterScreenState extends State<PhoneRegisterScreen> {
  TextEditingController regPhNameController = TextEditingController();

  TextEditingController regPhPhoneContoller = TextEditingController();

  TextEditingController regPhAddressController = TextEditingController();

  TextEditingController regPhPasswordController = TextEditingController();

  TextEditingController confirmRegPhPasswordController = TextEditingController();

  // bool passwordValidate = false;

  var formRegPhone = GlobalKey<FormState>();

  String countryCode = '';
  bool success = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        if (state is PhoneSignupSuccessState) {
          CacheHelper.setData(key: 'token', value: state.signUpModel.data?.token).then((value) {
            kToken = CacheHelper.getData('token');
            AppCubit.get(context).getCache();
            navigateAndFinish(context, HomeLayout());
            // showToast(text: state.signUpModel.msg, color: Colors.green);
          });
        } else if (state is PhoneSignupErrorState) {
          showToast(text: state.errorMessage, color: Colors.red);
        }
        return Scaffold(
          extendBody: true,
          resizeToAvoidBottomInset: true,
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          body: Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              Container(
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
                      key: formRegPhone,
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
                            controller: regPhNameController,
                            validate: ( value) {
                              if (value!.isEmpty) {
                                return 'thisFieldCanNotBeEmpty'.tr();
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // CustomTextFormField(
                          //   hintText: 'Phone'.tr(),
                          //   keyboardType: TextInputType.phone,
                          //   controller: regPhPhoneContoller,
                          //   validate: (String value) {
                          //     if (value.isEmpty) {
                          //       return 'thisFieldCanNotBeEmpty'.tr();
                          //     } else {
                          //       return null;
                          //     }
                          //   },
                          // ),
                          IntlPhoneField(
                            showDropdownIcon: false,
                            controller: regPhPhoneContoller,
                            textAlign: TextAlign.end,
                            keyboardType: TextInputType.phone,
                            disableLengthCheck: false,
                            flagsButtonPadding: EdgeInsets.symmetric(
                                vertical: 10.r,
                                horizontal:
                                    8.r),
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Tajawal'),
                            dropdownDecoration: BoxDecoration(
                              color: const Color(0xffE8E8E8),
                              borderRadius: kLanguage != 'ar'
                                  ? BorderRadius.only(
                                      topLeft: Radius.circular(34),
                                      bottomLeft: Radius.circular(34),
                                    )
                                  : BorderRadius.only(
                                      topRight: Radius.circular(34),
                                      bottomRight: Radius.circular(34),
                                    ),
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.4),
                                hintText: '56xxxxxxx',
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(34)),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(34)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(34))),
                            onChanged: (phone) {
                              countryCode = phone.countryCode;
                              log('${phone.completeNumber}');
                            },
                            onSaved: (phone) {
                              regPhPhoneContoller.text = phone!.completeNumber;
                            },
                            invalidNumberMessage:
                                "pleaseEnterAValidMobileNumber".tr(),
                            initialCountryCode: 'SA',
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                            hintText: 'Address'.tr(),
                            controller: regPhAddressController,
                            validate: ( value) {
                              return null;
                              // if (value!.isEmpty) {
                              //   return 'thisFieldCanNotBeEmpty'.tr();
                              // } else {
                              //   return null;
                              // }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomPasswordFormField(
                            hintText: 'Password'.tr(),
                            controller: regPhPasswordController,
                            isPassword: cubit.isPasswordPhoneRegisterPassword,
                            suffixIcon: cubit.suffixPhoneRegisterPassword,
                            suffixOnPressed: (){
                              cubit.isShowAndHidePhoneRegisterPassword();
                            },
                            validation: (String pass) {
                              if (pass.isEmpty) {
                                return 'thisFieldCanNotBeEmpty'.tr();
                              } else {
                                // bool result = cubit.validatePassword(pass);
                                // if (result) {
                                //   return null;
                                // } else {
                                //   return "passwordInvalidMessage".tr();
                                // }
                              }
                            },
                          ),
                          Padding(
                            padding:  EdgeInsets.all(12),
                            child: FlutterPwValidator(
                               strings:Strings(),
                              controller:regPhPasswordController,
                              minLength: 8,
                              uppercaseCharCount: 0,
                              numericCharCount: 1,
                              specialCharCount: 1,
                              normalCharCount: 2,
                              width: 400,
                              height: 150,
                              onSuccess: () {
                                setState(() {
                                  success = true;
                                }
                                );
                                print("MATCHED");
                              },
                              onFail: () {
                                setState(() {
                                  success = false;
                                });
                                print("NOT MATCHED");
                              },
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(12.0),
                          //   child: LinearProgressIndicator(
                          //     value: cubit.password_strength,
                          //     backgroundColor: Colors.grey[300],
                          //     minHeight: 5,
                          //     color: cubit.password_strength <= 1 / 4
                          //         ? Colors.red
                          //         : cubit.password_strength == 2 / 4
                          //             ? Colors.yellow
                          //             : cubit.password_strength == 3 / 4
                          //                 ? Colors.blue
                          //                 : Colors.green,
                          //   ),
                          // ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomPasswordFormField(
                            hintText: "confirmPassword".tr(),
                            controller: confirmRegPhPasswordController,
                            isPassword: cubit.isPasswordPhoneRegisterConfirmPassword,
                            suffixIcon: cubit.suffixPhoneRegisterConfirmPassword,
                            suffixOnPressed: (){
                              cubit.isShowAndHidePhoneRegisterConfirmPassword();
                            },
                            validation: (String value) {
                              if (value == null || value.isEmpty) {
                                return "thisFieldCanNotBeEmpty".tr();
                              } else if (value != regPhPasswordController.text) {
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
                          //         controller: regPhPasswordController,
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
                          state is PhoneSignupLoadingState
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
                                    print("phone${regPhPhoneContoller.text}");
                                    if (formRegPhone.currentState!.validate() ) {
                                      cubit.registerWithPhone(
                                        lang: EasyLocalization.of(context)
                                            ?.currentLocale
                                            .toString(),
                                        name: regPhNameController.text,
                                        address: regPhAddressController.text,
                                        phone: regPhPhoneContoller.text,
                                        password: regPhPasswordController.text,
                                        key: '1',
                                      );
                                    }
                                    // if (regPhNameController.text == '' ||
                                    //     regPhPhoneContoller.text == '' ||
                                    //     regPhAddressController.text == '' ||
                                    //     emailController.text == '' ||
                                    //     !emailController.text.contains("@")) {
                                    //   showToast(
                                    //       text: 'تأكد من ملئ البيانات بشكل كامل',
                                    //       color: Colors.red);
                                    // } else if (regPhPasswordController.text.length < 6) {
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
                              navigateAndFinish(context, HomeLayout());
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
              IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back,color: kLightGoldColor,))

            ],
          ),
        );
      },
    );
  }
}

class LanguageChip extends StatelessWidget {
  final String? localCode;
  final ImageProvider? flag;
  const LanguageChip({
    this.localCode,
     this.flag,
  });
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
            image:
            EasyLocalization.of(context)?.currentLocale.toString() == "ar" ?
            AssetImage('assets/images/Arabia.png') :

              EasyLocalization.of(context)?.currentLocale.toString() == "en"
                    ? AssetImage('assets/images/English.png') :
                    // EasyLocalization.of(context)?.currentLocale.toString() ==
                    //     "it" ?
                    AssetImage('assets/images/Italy.png'),
                          // : SizedBox() ,
          ),
        ),
      ),
    );
  }
}


