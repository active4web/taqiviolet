import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/screens/home_layout.dart';
import 'package:safsofa/screens/register_screens/signup_screen.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/components/custom_text_form_field.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

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
                  'Login'.tr(),
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
                  height: 10,
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'ForgetPassword'.tr(),
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                CustomButton(
                  text: 'Login'.tr(),
                  height: 50,
                  gradient: kGoldGradient,
                  textColor: Colors.black,
                  onTap: () {
                    navigateTo(context, HomeLayout());
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                InkWell(
                  onTap: () {
                    navigateTo(context, SignupScreen());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'DoNotHaveAnAccount?'.tr(),
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      Text(
                        'SignUp'.tr(),
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
