import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/network/local/cache_helper.dart';
import 'package:safsofa/screens/chat_screen.dart';
import 'package:safsofa/screens/new/personel_page/help/toast/toast.dart';
import 'package:safsofa/screens/new/personel_page/help/toast/toast_states.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/components/custom_form_field.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../../cubits/technicalSupporDetailstCubit/technical_suppor_detailst_cubit.dart';
import '../../cubits/technicalSupporDetailstCubit/technical_suppor_detailst_state.dart';
import '../../cubits/technicalSupportCubit/technical_support_cubit.dart';
import '../../cubits/technicalSupportCubit/technical_support_state.dart';

class TechnicalSupportScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController comment = TextEditingController();
    TechnicalSupportCubit cubit = TechnicalSupportCubit.get(context);
    cubit.getContactData();
    return BlocConsumer<TechnicalSupportCubit, TechnicalSupportState>(
      listener: (context, state){
        if(state is ContactUsSendingSuccessState){
          email.clear();
           name.clear();
          phone.clear();
        comment.clear();
        ToastConfig.showToast(msg: 'success', toastStates: ToastStates.success);
        }
      },
      builder: (context, state) {
        // TechnicalSupportCubit cubit = TechnicalSupportCubit.get(context);
        // state is TechnicalSupportInitial
        //     ? cubit.getContactData()
        //     : log("getdata");

        return Scaffold(
          appBar: CustomAppBar(
            title: 'TechnicalSupport'.tr(),
          ),
          body:  Form(
            key: cubit.formKey,
            child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'text1'
                                .tr(),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'text2'
                                .tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.red
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Label(text: 'name'.tr()),
                          SizedBox(
                            height: 10,
                          ),
                          CustomFormField(
                            controller: name,
                            label: "name".tr(),
                              validate: (va){
                                if(va!.trim().isEmpty){
                                  return 'The name is required';
                                }
                              }
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Label(text: 'Email'.tr()),
                          SizedBox(
                            height: 10,
                          ),
                          CustomFormField(
                            controller: email,
                            inputType: TextInputType.emailAddress,
                            label: "Email".tr(),
                              validate: (va){
                              if(va!.trim().isEmpty){
                                return 'The email is required';
                              }
                               else if(state is ContactUsSendingErrorState){
                                return state.error.toString();
                              }
                              }
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Label(text: 'Phone'.tr()),
                          SizedBox(
                            height: 10,
                          ),
                          CustomFormField(
                            controller: phone,
                            inputType: TextInputType.phone,
                            label: "Phone".tr(),
                              validate: (va){
                                if(va!.trim().isEmpty){
                                  return 'The phone is required';
                                }
                              }
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Label(text: 'Comment'.tr()),
                          SizedBox(
                            height: 10,
                          ),
                          CustomFormField(
                            controller: comment,
                            minLines: 5,
                            label: "Comment".tr(),
                              validate: (va){
                                if(va!.trim().isEmpty){
                                  return 'The Comment is required';
                                }
                              }
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ConditionalBuilder(
                            condition: state is ! ContactUsSendingLoadingState,
                            fallback: (context){
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          builder: (context){
                              return CustomButton(
                                onTap: () {
                                  // formKey.currentState!.validate();

                                    cubit.sendContactUs(
                                        email:   email.text,
                                        name:    name.text,
                                        phone:   phone.text,
                                        comment: comment.text);

                                },
                                text: 'Send'.tr(),
                                height: 50,
                              );
                          },
                          ),
                          SizedBox(
                            height: 20,
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
                                    await launch(
                                        'whatsapp://send?phone=+966${cubit.contactsData.data?.phone?.substring(5)}');
                                  },
                                  icon: Image.asset('assets/images/whatsapp.png'),
                                ),
                              ),
                              Expanded(
                                child: IconButton(
                                  onPressed: () async {
                                    await launch(
                                        'mailto:${cubit.contactsData.data?.mail}?subject=This is Subject Title&body=This is Body of Email');
                                  },
                                  icon: Image.asset('assets/images/gmail.png'),
                                ),
                              ),
                              // Expanded(
                              //   child: IconButton(
                              //     onPressed: () async {
                              //       await launch(
                              //           cubit.contactsData.data.twitterlink);
                              //     },
                              //     icon: Image.asset('assets/images/twitter.png'),
                              //   ),
                              // ),
                              // Expanded(
                              //   child: IconButton(
                              //     onPressed: () async {
                              //       await launch(
                              //           cubit.contactsData.data.instagramlink);
                              //     },
                              //     icon:
                              //         Image.asset('assets/images/instagram.png'),
                              //   ),
                              // ),
                              // Expanded(
                              //   child: IconButton(
                              //     onPressed: () async {
                              //       await launch(
                              //           cubit.contactsData.data.tiktoklink);
                              //     },
                              //     icon: Image.asset('assets/images/TikTok.png'),
                              //   ),
                              // ),
                              // Expanded(
                              //   child: IconButton(
                              //     onPressed: () async {
                              //       await launch(
                              //           cubit.contactsData.data.youtubelink);
                              //     },
                              //     icon: Image.asset('assets/images/youtube.png'),
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    )),
          ),
          floatingActionButton: state is! GetContactUsSuccessState
              ? SizedBox()
              : CacheHelper.getData('id') == null
                  ? SizedBox()
                  : FloatingActionButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            navigateTo(
                                                context,
                                                ChatScreen(
                                                  techSupportId: (cubit
                                                      .contactsData
                                                      .data
                                                      ?.technicalSupportId)!,
                                                  type: '2',
                                                ));
                                          },
                                          child: Wrap(
                                            direction: Axis.vertical,
                                            alignment: WrapAlignment.center,
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                                child: Image(
                                                  height: 40,
                                                  width: 40,
                                                  image: AssetImage(
                                                      'assets/images/technical-support-chat.png'),
                                                ),
                                              ),
                                              Text(
                                                "technicalSupport".tr(),
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            navigateTo(
                                                context,
                                                ChatScreen(
                                                  techSupportId: (cubit.contactsData.data?.salesId)!,
                                                  type: '1',
                                                ));
                                          },
                                          child: Wrap(
                                            direction: Axis.vertical,
                                            alignment: WrapAlignment.center,
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                                child: Image(
                                                  height: 40,
                                                  width: 40,
                                                  image: AssetImage(
                                                      'assets/images/sales_chat.png'),
                                                ),
                                              ),
                                              Text(
                                                "sales".tr(),
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            });
                        // navigateTo(
                        //     context,
                        //     ChatScreen(
                        //       techSupportId:
                        //       cubit.contactsData.data.technicalSupportId,
                        //     ));
                      },
                      child: Icon(
                        Icons.support_agent,
                        color: kDarkGoldColor,
                        size: 35,
                      ),
                      backgroundColor: Colors.black,
                    ),
        );
      },
    );
  }
}

class RequestCard extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TechnicalSupportDetailsCubit,
        TechnicalSupportDetailstState>(
      builder: (context, state) {
        TechnicalSupportDetailsCubit cubit =
            TechnicalSupportDetailsCubit.get(context);

        return Scaffold(
          appBar: CustomAppBar(
            title: 'TechnicalSupport'.tr(),
          ),
          body: state is! GetTechnicalSupportdetailstSuccessState
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 1)
                      ]),
                  child: ListView.builder(
                      itemCount: cubit.detailsSupportDetailsData!.length,
                      itemBuilder: (context, pos) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${cubit.detailsSupportDetailsData![pos].name}",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "${cubit.detailsSupportDetailsData![0].phone}",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "${cubit.detailsSupportDetailsData![pos].message}",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${cubit.detailsSupportDetailsData![pos].updatedAt}",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                                Text(
                                  "${cubit.detailsSupportDetailsData![pos].createdAt}",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    cubit.detailsSupportDetailsData![pos]
                                            .notes ??
                                        "",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                Icon(
                                  Icons.remove_red_eye,
                                  color: cubit.detailsSupportDetailsData![pos]
                                              .status ==
                                          0
                                      ? Colors.grey
                                      : Colors.green,
                                ),
                              ],
                            )
                          ],
                        );
                      })),
        );
      },
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 1)]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'مشكله في الطلب الخاص بي',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '27-11-2020',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                '3:30 AM',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'تم الحل',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
