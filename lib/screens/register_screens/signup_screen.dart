// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/authCubit/auth_cubit.dart';
import 'package:safsofa/cubits/authCubit/auth_states.dart';
import 'package:safsofa/network/local/cache_helper.dart';
import 'package:safsofa/screens/register_screens/login_screen.dart';
import 'package:safsofa/screens/register_screens/select_language_screen.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/shared/components/custom_text_form_field.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import '../home_layout.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        if (state is SignupSuccessState) {
          CacheHelper.setData(key: 'token', value: cubit.MobToken)
              .then((value) {
            kToken = CacheHelper.getData('token');
            AppCubit.get(context).getCache();
            navigateAndFinish(context, HomeLayout());
            showToast(text: "تم التسجيل بنجاح", color: Colors.green);
          });
        } else if (state is SignupErrorState) {
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
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Text(
                      'SignUp'.tr(),
                      style: TextStyle(color: kLightGoldColor, fontSize: 32),
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
                            style: TextStyle(color: Colors.white, fontSize: 20),
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
                      controller: nameController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      hintText: 'Email'.tr(),
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      hintText: 'Phone'.tr(),
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      hintText: 'Address'.tr(),
                      controller: addressController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomPasswordFormField(
                      hintText: 'Password'.tr(),
                      controller: passwordController,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    state is SignupLoadingState
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
                              if (nameController.text == '' ||
                                  phoneController.text == '' ||
                                  addressController.text == '' ||
                                  emailController.text == '' ||
                                  !emailController.text.contains("@")) {
                                showToast(
                                    text: 'تأكد من ملئ البيانات بشكل كامل',
                                    color: Colors.red);
                              } else if (passwordController.text.length < 6) {
                                showToast(
                                    text: 'Password must be longer than 5',
                                    color: Colors.red);
                              } else {
                                print("""
                                ${addressController.text},
                                ${emailController.text},
                                ${nameController.text},
                                ${EasyLocalization.of(context).currentLocale.toString()},
                                    ${phoneController.text}
                                    ${cubit.MobToken}
                                """);
                                cubit.signUp(
                                  lang: EasyLocalization.of(context)
                                      .currentLocale
                                      .toString(),
                                  name: nameController.text,
                                  address: addressController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text,
                                );
                              }
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
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          Text(
                            'Login'.tr(),
                            style:
                                TextStyle(color: kLightGoldColor, fontSize: 12),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
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
