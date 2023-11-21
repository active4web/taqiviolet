import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safsofa/screens/register_screens/email_register_screen.dart';
import 'package:safsofa/screens/register_screens/phone_register_screen.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/defaults.dart';

import '../../shared/constants.dart';
import 'package:easy_localization/easy_localization.dart';

class RegisterChoiceScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,

      body: SafeArea(
        child: Stack(
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/images/logo.png'),
                      height: MediaQuery.of(context).size.width / 2,
                      width: MediaQuery.of(context).size.width / 2,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                    CustomButton(
                      text: "registerUsingMobileNumber".tr(),
                      height: 50,
                      gradient: kGoldGradient,
                      textColor: Colors.black,
                      onTap: () => navigateTo(context, PhoneRegisterScreen()),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    CustomButton(
                      text: "registerUsingEmail".tr(),
                      height: 50,
                      gradient: kGoldGradient,
                      textColor: Colors.black,
                      onTap: () => navigateTo(context, EmailRegisterScreen()),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back,color: kLightGoldColor,))
          ],
        ),
      ),
    );
  }
}
