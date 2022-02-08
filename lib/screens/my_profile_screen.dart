import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/components/custom_form_field.dart';
import 'package:safsofa/shared/components/custom_label.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'MyProfile'.tr(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Label(
                text: 'FullName'.tr(),
              ),
              SizedBox(
                height: 10,
              ),
              CustomFormField(),
              SizedBox(
                height: 20,
              ),
              Label(
                text: 'Email'.tr(),
              ),
              SizedBox(
                height: 10,
              ),
              CustomFormField(),
              SizedBox(
                height: 20,
              ),
              Label(
                text: 'Phone'.tr(),
              ),
              SizedBox(
                height: 10,
              ),
              CustomFormField(),
              SizedBox(
                height: 20,
              ),
              Label(
                text: 'Address'.tr(),
              ),
              SizedBox(
                height: 10,
              ),
              CustomFormField(),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
              ),
              CustomButton(
                height: 50,
                text: 'Save'.tr(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
