import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/screens/bottom_navigation_screens/language_screen.dart';
import 'package:safsofa/screens/register_screens/signup_screen.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';

class SelectLanguageScreen extends StatelessWidget {
  const SelectLanguageScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: kLightGoldColor),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          children: [
            Label(
              text: 'ChooseYourLanguage'.tr(),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  LanguageTile(
                    language: 'عربي',
                    flag: AssetImage('assets/images/Arabia.png'),
                    localCode: 'ar',
                  ),
                  Divider(),
                  LanguageTile(
                    language: 'English',
                    flag: AssetImage('assets/images/English.png'),
                    localCode: 'en',
                  ),
                  Divider(),
                  LanguageTile(
                    language: 'Italy',
                    flag: AssetImage('assets/images/Italy.png'),
                    localCode: 'it',
                  ),
                ],
              ),
            ),
            CustomButton(
              height: 50,
              text: 'Next'.tr(),
              onTap: () {
                navigateTo(context, SignupScreen());
              },
            )
          ],
        ),
      ),
    );
  }
}
