import 'package:flutter/material.dart';
import 'package:safsofa/cubits/taqi_work_cubit/cubit/taqi_work_cubit.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/components/custom_form_field.dart';
import 'package:safsofa/shared/defaults.dart';
import '../../cubits/taqi_work_cubit/cubit/taqi_work_state.dart';
import '../../shared/components/custom_label.dart';
import '../../shared/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class TaqiWorkScreen extends StatelessWidget {
  const TaqiWorkScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController commentController = TextEditingController();
    return BlocProvider(
      create: (context) => TaqiWorkCubit()..getTaqiWorkData(),
      child: Scaffold(
        appBar: CustomAppBar(title: "workingAtTaqiViolet".tr()),
        body: BlocConsumer<TaqiWorkCubit, TaqiWorkState>(
          listener: (context, state) {},
          builder: (context, state) {
            return state is TaqiWorkCubitSuccessState &&
                    TaqiWorkCubit.get(context).workModel != null
                ? Padding(
                    padding: const EdgeInsets.all(30),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemBuilder: (context, index) => Column(
                              children: [
                                if (TaqiWorkCubit.get(context)
                                    .workModel
                                    .data[index]
                                    .title
                                    .isNotEmpty)
                                  Row(
                                    children: [
                                      Text(
                                        TaqiWorkCubit.get(context)
                                            .workModel
                                            .data[index]
                                            .title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                            color: kDarkGoldColor),
                                      ),
                                    ],
                                  ),

                                Wrap(
                                  direction: Axis.horizontal,
                                  children: [
                                    Text(
                                      TaqiWorkCubit.get(context)
                                          .workModel
                                          .data[index]
                                          .contentApp,
                                      style: TextStyle(fontSize: 15, height: 2),
                                    ),
                                    if (index == 0)
                                      InkWell(
                                        onTap: () async {
                                          await launch(
                                              "https://taqiviolet.com/employment-Form");
                                        },
                                        child: Text(
                                          "press here".tr(),
                                          style: TextStyle(
                                            color: Colors.lightBlue,
                                            fontSize: 15,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    if (index == 1)
                                      InkWell(
                                        onTap: () async {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return BlocConsumer<
                                                    TaqiWorkCubit,
                                                    TaqiWorkState>(
                                                  listener: (context, state) {
                                                    if (state
                                                        is SendingSuccessState) {
                                                      if (state.status) {
                                                        Navigator.pop(context);
                                                        nameController.clear();
                                                        phoneController.clear();
                                                        emailController.clear();
                                                        commentController
                                                            .clear();
                                                      }
                                                    }
                                                  },
                                                  builder: (context, state) {
                                                    return AlertDialog(
                                                      content:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          // crossAxisAlignment:
                                                          //     CrossAxisAlignment
                                                          //         .start,
                                                          children: [
                                                            Label(
                                                                text: 'name'
                                                                    .tr()),
                                                            CustomFormField(
                                                              controller:
                                                                  nameController,
                                                              // label: "name".tr(),
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Label(
                                                                text: 'Email'
                                                                    .tr()),
                                                            CustomFormField(
                                                              controller:
                                                                  emailController,
                                                              inputType:
                                                                  TextInputType
                                                                      .emailAddress,

                                                              // label: "Email".tr(),
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Label(
                                                                text: 'Phone'
                                                                    .tr()),
                                                            CustomFormField(
                                                              controller:
                                                                  phoneController,
                                                              inputType:
                                                                  TextInputType
                                                                      .phone,
                                                              // label: "Phone".tr(),
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Label(
                                                                text: 'Comment'
                                                                    .tr()),
                                                            CustomFormField(
                                                              controller:
                                                                  commentController,
                                                              minLines: 7,
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            TaqiWorkCubit.get(
                                                                            context)
                                                                        .file ==
                                                                    null
                                                                ? TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      TaqiWorkCubit.get(
                                                                              context)
                                                                          .pickMediaFile();
                                                                    },
                                                                    child: Text(
                                                                      'chooseAFile'
                                                                          .tr(),
                                                                      style:
                                                                          TextStyle(
                                                                        color:
                                                                            kDarkGoldColor,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  )
                                                                : Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        2.5,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade300,
                                                                        shape: BoxShape
                                                                            .rectangle,
                                                                        border: Border.all(
                                                                            color: Colors
                                                                                .black),
                                                                        borderRadius:
                                                                            BorderRadius.circular(6)),
                                                                    child: Row(
                                                                      children: [
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            TaqiWorkCubit.get(context).removePickedFile();
                                                                          },
                                                                          child:
                                                                              Icon(
                                                                            Icons.close,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        Text(TaqiWorkCubit.get(context)
                                                                            .file
                                                                            .name)
                                                                      ],
                                                                    ),
                                                                  ),
                                                            SizedBox(
                                                              height: 30,
                                                            ),
                                                            state is SendingLoadingState
                                                                ? Center(
                                                                    child: CircularProgressIndicator(
                                                                        color:
                                                                            kDarkGoldColor),
                                                                  )
                                                                : CustomButton(
                                                                    onTap: () {
                                                                      if (nameController
                                                                              .text
                                                                              .isEmpty ||
                                                                          phoneController
                                                                              .text
                                                                              .isEmpty) {
                                                                        showToast(
                                                                            text:
                                                                                "fieldNameAndPhoneAreRequired".tr(),
                                                                            color: Colors.red);
                                                                      } else {
                                                                        TaqiWorkCubit.get(context).sendIdeaOfWork(
                                                                            name:
                                                                                nameController.text,
                                                                            email: emailController.text,
                                                                            phone: phoneController.text,
                                                                            comment: commentController.text);
                                                                      }
                                                                    },
                                                                    text: 'Send'
                                                                        .tr(),
                                                                    height: 50,
                                                                  ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              });
                                        },
                                        child: Text(
                                          "press here".tr(),
                                          style: TextStyle(
                                            color: Colors.lightBlue,
                                            fontSize: 15,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),

                                // if (index == cubit.aboutData.length - 1)
                                //   InkWell(
                                //     onTap: () async {
                                //       await launch(
                                //           "https://taqiviolet.com/employment-Form");
                                //     },
                                //     child: Text(
                                //       "press here".tr(),
                                //       style: TextStyle(
                                //         color: Colors.lightBlue,
                                //         fontSize: 15,
                                //         decoration: TextDecoration.underline,
                                //       ),
                                //     ),
                                //   ),
                              ],
                            ),
                            separatorBuilder: (context, index) => Column(
                              children: [
                                Divider(
                                  thickness: 1,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                            itemCount: TaqiWorkCubit.get(context)
                                .workModel
                                .data
                                .length,
                          ),
                        ],
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(color: kDarkGoldColor),
                  );
          },
        ),
      ),
    );
  }
}
