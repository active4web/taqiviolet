import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/components/custom_form_field.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:safsofa/shared/components/custom_text_form_field.dart';
import 'package:safsofa/shared/components/description_text_field.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'ContactUs'.tr(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Label(
                text: 'UserName'.tr(),
              ),
              SizedBox(
                height: 10,
              ),
              CustomFormField(),
              SizedBox(
                height: 10,
              ),
              DescriptionTextField(),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                height: 50,
                text: 'Send'.tr(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
