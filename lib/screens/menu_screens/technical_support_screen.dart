import 'package:easy_localization/src/public_ext.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/components/custom_form_field.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../cubits/technicalSupporDetailstCubit/technical_suppor_detailst_cubit.dart';
import '../../cubits/technicalSupporDetailstCubit/technical_suppor_detailst_state.dart';
import '../../cubits/technicalSupportCubit/technical_support_cubit.dart';
import '../../cubits/technicalSupportCubit/technical_support_state.dart';

class TechnicalSupportScreen extends StatelessWidget {
  const TechnicalSupportScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController comment = TextEditingController();
    TechnicalSupportCubit cubit = TechnicalSupportCubit.get(context);
    cubit.getContactData();
    return BlocBuilder<TechnicalSupportCubit, TechnicalSupportState>(
      builder: (context, state) {
        // TechnicalSupportCubit cubit = TechnicalSupportCubit.get(context);
        // state is TechnicalSupportInitial
        //     ? cubit.getContactData()
        //     : log("getdata");

        return Scaffold(
          appBar: CustomAppBar(
            title: 'TechnicalSupport'.tr(),
          ),
          body: state is! GetContactUsSuccessState
              ? Center(
                  child: CircularProgressIndicator(
                    color: kDarkGoldColor,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          'At Taqi Violet, we believe that our success depends on the satisfaction of our customers. Therefore, the customer service staff is happy to assist you and answer all your inquiries about our products through social media programs or through'
                              .tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
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
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          onTap: () {
                            cubit.sendContactUs(
                                email: email.text,
                                name: name.text,
                                phone: phone.text,
                                comment: comment.text);
                          },
                          text: 'Send'.tr(),
                          height: 50,
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
                                      'whatsapp://send?phone=+966${cubit.contactsData.data.phone.substring(5)}');
                                },
                                icon: Image.asset('assets/images/whatsapp.png'),
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                onPressed: () async {
                                  await launch(
                                      'mailto:${cubit.contactsData.data.mail}?subject=This is Subject Title&body=This is Body of Email');
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
                  )
                  // Column(
                  //   children: [
                  //     Label(text: 'RequestHelp'.tr()),
                  //     SizedBox(
                  //       height: 30,
                  //     ),
                  //     CustomButton(onTap: (){
                  //       navigateTo(context, ContactUsScreen());
                  //     },
                  //       height: 50,
                  //       text: 'CreateRequest'.tr(),
                  //     ),
                  //     SizedBox(
                  //       height: 30,
                  //     ),
                  //   Expanded(
                  //     child: ListView.builder(itemCount:cubit.AllSupportsListOfData.length ,itemBuilder: (context,pos){
                  //       return InkWell(onTap: (){
                  //         log('${cubit.AllSupportsListOfData[pos].id}');
                  //         TechnicalSupportDetailsCubit.get(context).id= cubit.AllSupportsListOfData[pos].id;
                  //         TechnicalSupportDetailsCubit.get(context).getTechnicalSupport() ;
                  //         log('${TechnicalSupportDetailsCubit.get(context).id}');
                  //         navigateTo(context, RequestCard());
                  //       },
                  //         child: Container(
                  //           padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                  //           decoration: BoxDecoration(
                  //               color: Colors.white,
                  //               borderRadius: BorderRadius.circular(20),
                  //               boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 1)]),
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Row(
                  //                 children: [
                  //                   Text(
                  //                     cubit.AllSupportsListOfData[pos].name,
                  //                     style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  //                   )
                  //                 ],
                  //               ),
                  //               SizedBox(
                  //                 height: 20,
                  //               ),
                  //               Row(
                  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                 children: [
                  //                   Text(
                  //                     cubit.AllSupportsListOfData[pos].createdAt,
                  //                     style: TextStyle(
                  //                       fontSize: 17,
                  //                     ),
                  //                   ),
                  //                   Text(
                  //                     cubit.AllSupportsListOfData[pos].updatedAt,
                  //                     style: TextStyle(
                  //                       fontSize: 17,
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //               SizedBox(
                  //                 height: 20,
                  //               ),
                  //               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                 children: [
                  //                   Container(
                  //                     padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  //                     decoration: BoxDecoration(
                  //                       color: Colors.green,
                  //                       borderRadius: BorderRadius.circular(20),
                  //                     ),
                  //                     child: Text(cubit.AllSupportsListOfData[pos].notes??""
                  //                    ,
                  //                       style: TextStyle(
                  //                           fontWeight: FontWeight.bold, color: Colors.white),
                  //                     ),
                  //                   ),
                  //                Icon(Icons.remove_red_eye,color: cubit.AllSupportsListOfData[pos].status==0?Colors.grey:Colors.green,) ],
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //       );
                  //     }),
                  //   )
                  //
                  //     ,
                  //     SizedBox(
                  //       height: 20,
                  //     ),
                  //   ],
                  // ),
                  ),
        );
      },
    );
  }
}

class RequestCard extends StatelessWidget {
  const RequestCard({
    Key key,
  }) : super(key: key);

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
                      itemCount: cubit.detailsSupportDetailsData.length,
                      itemBuilder: (context, pos) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  cubit.detailsSupportDetailsData[pos].name,
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
                              cubit.detailsSupportDetailsData[0].phone,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              cubit.detailsSupportDetailsData[pos].message,
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
                                  cubit
                                      .detailsSupportDetailsData[pos].updatedAt,
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                                Text(
                                  cubit
                                      .detailsSupportDetailsData[pos].createdAt,
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
                                    cubit.detailsSupportDetailsData[pos]
                                            .notes ??
                                        "",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                Icon(
                                  Icons.remove_red_eye,
                                  color: cubit.detailsSupportDetailsData[pos]
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
