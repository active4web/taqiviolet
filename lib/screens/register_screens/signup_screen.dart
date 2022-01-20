import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/screens/register_screens/login_screen.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/components/custom_text_form_field.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import '../home_layout.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background image.png'),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.28,
                ),
                Text(
                  'SignUp'.tr(),
                  style: TextStyle(color: kLightGoldColor, fontSize: 32),
                ),
                SizedBox(
                  height: 30,
                ),
                CustomTextFormField(
                  hintText: 'UserName'.tr(),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomPasswordFormField(
                  hintText: 'Password'.tr(),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    LanguageCircle(
                      flag: AssetImage('assets/images/Arabia.png'),
                      localCode: 'ar',
                    ),
                    LanguageCircle(
                      flag: AssetImage('assets/images/English.png'),
                      localCode: 'en',
                    ),
                    LanguageCircle(
                      flag: AssetImage('assets/images/Italy.png'),
                      localCode: 'it',
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                CustomButton(
                  text: 'SignUp'.tr(),
                  height: 50,
                  gradient: kGoldGradient,
                  textColor: Colors.black,
                  onTap: () {
                    navigateTo(context, LoginScreen());
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
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
                        style: TextStyle(color: kLightGoldColor, fontSize: 12),
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
  }
}

class LanguageCircle extends StatelessWidget {
  const LanguageCircle({
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
        EasyLocalization.of(context).setLocale(Locale(localCode));
        print(EasyLocalization.of(context).currentLocale);
        Phoenix.rebirth(context);
      },
      child: Container(
        width: 40,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.grey,
          border:
              EasyLocalization.of(context).currentLocale.toString() == localCode
                  ? Border.all(color: kLightGoldColor, width: 1.5)
                  : Border.all(color: Colors.transparent),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: flag,
          ),
        ),
      ),
    );
  }
}
