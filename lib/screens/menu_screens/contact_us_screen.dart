import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/components/custom_form_field.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:safsofa/shared/components/custom_text_form_field.dart';
import 'package:safsofa/shared/components/description_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/contactUsCubit/contact_us_cubit.dart';
import '../../cubits/contactUsCubit/contact_us_state.dart';
import '../../models/register_success_model.dart';
import '../../network/local/cache_helper.dart';

class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({Key key}) : super(key: key);
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {

    // RegisterSuccessModel user=   CacheHelper.getData(
    //       'userInfo'
    //  );
    return BlocBuilder<ContactCubit, ContactUs>(
      builder: (context, state) {
        ContactCubit cubit = ContactCubit.get(context);
        // state is AboutInitial ? cubit.getAbout():print("getdata");
        return Scaffold(
          appBar: CustomAppBar(
            title: 'ContactUs'.tr(),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                   CustomFormField(controller:name,inputType: TextInputType.text,label: "FullName".tr()),
                  SizedBox(
                    height: 10,
                  ),
                  CustomFormField(controller:phone,inputType: TextInputType.phone, label: "Phone".tr()),
                  SizedBox(
                    height: 10,
                  ),
                  DescriptionTextField(controller:message,hintText: "Comment".tr(), ),
                  SizedBox(
                    height: 20,
                  ),
                  state is PostContactUsState
                      ? CircularProgressIndicator()
                      : CustomButton(onTap: () {
                    cubit.query["name"] =name.text;
                    cubit.query["phone"] =phone.text;
                    cubit.query["message"] =message.text;
                    cubit.postContactUs();
                  },
                    height: 50,
                    text: 'Send'.tr(),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
