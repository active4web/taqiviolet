import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/cubit/getdataprofile_cubit.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/components/custom_form_field.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../cubits/contactUsCubit/contact_us_cubit.dart';
import '../../cubits/contactUsCubit/contact_us_state.dart';

import '../../cubits/technicalSupportCubit/technical_support_cubit.dart';

class ContactUsScreen extends StatelessWidget {
  TextEditingController email = TextEditingController();
  // TextEditingController phone = TextEditingController();
  // TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // RegisterSuccessModel user=   CacheHelper.getData(
    //       'userInfo'
    //  );
    TechnicalSupportCubit technicalSupportDetailsCubit =
        TechnicalSupportCubit.get(context);
    technicalSupportDetailsCubit.getContactData();
    return BlocConsumer<ContactCubit, ContactUs>(
      listener: (context,state){
        if(state is PostContactUsSuccessState){
          email.clear();

        }
      },
      builder: (context, state) {
        ContactCubit cubit = ContactCubit.get(context);
        // state is AboutInitial ? cubit.getAbout():log("getdata");

        return Scaffold(
          appBar: CustomAppBar(
            title: 'newOffers'.tr(),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  Text(
                    "Get the latest exclusive offers from Tagy Violet via email"
                        .tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  // Container(
                  //   //height: 50,
                  //   //width: MediaQuery.of(context).size.width,
                  //   // padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  //   decoration: BoxDecoration(
                  //       color: Color(0xffFAFAFA),
                  //       borderRadius: BorderRadius.circular(30),
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.grey,
                  //           blurRadius: 0.5,
                  //         )
                  //       ]),
                  //   child: Form(
                  //     key: cubit.formKey,
                  //     child: TextFormField(
                  //       controller: email,
                  //       keyboardType: TextInputType.emailAddress,
                  //       autovalidateMode: AutovalidateMode.onUserInteraction,
                  //       validator: (value) {
                  //         if (value.isEmpty) {
                  //           return "Email should not be empty".tr();
                  //         } else if ((RegExp(
                  //                     r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  //                 .hasMatch(value)) ==
                  //             false) {
                  //           return 'Please! enter valid e-mail'.tr();
                  //         } else {
                  //           return null;
                  //         }
                  //       },
                  //       decoration: InputDecoration(
                  //           contentPadding:
                  //               EdgeInsets.symmetric(horizontal: 20),
                  //           border: InputBorder.none,
                  //           hintText: "Email".tr(),
                  //           hintTextDirection: TextDirection.rtl),
                  //       style: TextStyle(color: Colors.black),
                  //     ),
                  //   ),
                  // ),
                  CustomFormField(
                    controller: email,
                    inputType: TextInputType.emailAddress,
                    label: "Email".tr(),
                      validate: (va){}
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // CustomFormField(
                  //     controller: phone,
                  //     inputType: TextInputType.phone,
                  //     label: "Phone".tr()),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // DescriptionTextField(
                  //   controller: message,
                  //   hintText: "Comment".tr(),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  state is PostContactUsState
                      ? CircularProgressIndicator()
                      : CustomButton(
                          onTap: () {
                            // cubit.query["name"] = name.text;
                            // cubit.query["phone"] = phone.text;
                            // cubit.query["message"] = message.text;
                            cubit.postContactUs(email: email.text);

                            // if (cubit.formKey.currentState.validate()) {
                            //
                            //   // if (cubit.subscribeModel.msg
                            //   //         .allMatches('success') !=
                            //   //     null) {
                            //   //   email.clear();
                            //   // }
                            // }
                          },
                          height: 50,
                          text: 'subscribe'.tr(),
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Expanded(
                      //   child: IconButton(
                      //     onPressed: () async {
                      //       await launch(
                      //           'tel:+966${cubit.contactsData.data.phone.substring(5)}');
                      //     },
                      //     icon:
                      //         Image.asset('assets/images/phoneicon.png'),
                      //   ),
                      // ),

                      Expanded(
                        child: IconButton(
                          onPressed: () async {
                            await launch("${technicalSupportDetailsCubit.contactsData.data?.twitterLink}");
                          },
                          icon: Image.asset('assets/images/twitter.png'),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () async {
                            await launch("${technicalSupportDetailsCubit.contactsData.data?.instagramLink}");
                          },
                          icon: Image.asset('assets/images/instagram.png'),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () async {
                            await launch("${technicalSupportDetailsCubit.contactsData.data?.tiktokLink}");
                          },
                          icon: Image.asset('assets/images/TikTok.png'),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () async {
                            await launch("${technicalSupportDetailsCubit.contactsData.data?.youtubeLink}");
                          },
                          icon: Image.asset('assets/images/youtube.png'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
