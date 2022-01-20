import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/shared/components/custom_app_bar_with_logo.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:safsofa/shared/constants.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithLogo(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Label(
              text: 'TermsAndConditions'.tr(),
            ),
            SizedBox(
              height: 10,
            ),
            Text(kLoremIpsum),
            SizedBox(
              height: 30,
            ),
            Label(
              text: 'TermsAndConditions'.tr(),
            ),
            SizedBox(
              height: 10,
            ),
            Text(kLoremIpsum),
            SizedBox(
              height: 30,
            ),
            Label(
              text: 'TermsAndConditions'.tr(),
            ),
            SizedBox(
              height: 10,
            ),
            Text(kLoremIpsum),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
