import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/shared/components/custom_app_bar_with_logo.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:safsofa/shared/constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithLogo(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Label(
                text: 'AboutUs'.tr(),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                kLoremIpsum,
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
