import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/components/custom_form_field.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:safsofa/shared/components/custom_reset_password_profile.dart';
import 'package:safsofa/shared/components/custom_text_form_field.dart';
import 'package:safsofa/shared/constants.dart';
import 'dart:io';
import '../cubits/cubit/getdataprofile_cubit.dart';
import '../network/local/cache_helper.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    GetdataprofileCubit.get(context).getdataprofileCData();
    super.initState();
  }

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController resetPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool chooseName = false;
  bool chooseAddress = false;
  bool chooseResetPassword = false;
  bool chooseDeleteMyAccount = false;

  @override
  Widget build(BuildContext context) {
    GetdataprofileCubit cubit = GetdataprofileCubit.get(context);
    if (cubit.state is GetdataprofileInitial) {
      cubit.getdataprofileCData();
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'MyProfile'.tr(),
        icon: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, true);
            }),
      ),
      body: BlocConsumer<GetdataprofileCubit, GetdataprofileState>(
        listener: (context,state){
          if(state is ResetPasswordSuccessState){
            Navigator.pop(context);
          }
        },
          builder: (context, state) {
        if (state is GetdataprofileInitialSuccessState) {
          address.text = cubit.getDataProfileModel!.data!.address!=null ? cubit.getDataProfileModel!.data!.address!: "";
          name.text = cubit.getDataProfileModel!.data!.name!;
          cubit.getDataProfileModel?.data?.phone != null
              ? phone.text = cubit.getDataProfileModel!.data!.phone!
              : SizedBox();
          cubit.getDataProfileModel?.data?.email != null
              ? email.text = cubit.getDataProfileModel!.data!.email!
              : SizedBox();

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
         /*         Center(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: cubit.imageFile == null
                              ? Image(
                                  height: MediaQuery.of(context).size.width / 3,
                                  width: MediaQuery.of(context).size.width / 3,
                                  image: NetworkImage(
                                      "${'cubit.getDataProfileModel?.image'}"),
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      CupertinoIcons.profile_circled,
                                      color: kLightGoldColor,
                                      size: MediaQuery.of(context).size.width /
                                          3.5,
                                    );
                                  },
                                )
                              : Image(
                                  height: MediaQuery.of(context).size.width / 3,
                                  width: MediaQuery.of(context).size.width / 3,
                                  image: FileImage(
                                    File(cubit.imageFile!.path),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        IconButton(
                          onPressed: () => cubit.selectImage(),
                          icon: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(CupertinoIcons.camera_fill),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
*/
                  //ToDo : Email Or Phone
                  cubit.getDataProfileModel?.data?.email != null ?
                  Row(
                    children: [
                      Label(
                        text: "${'Email'.tr()}: ",
                      ),
                      Expanded(
                          child: Text(
                        "${cubit.getDataProfileModel!.data!.email}",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.black),
                      )),
                    ],
                  ):
                  Row(
                    children: [
                      Label(
                        text: "${'Phone'.tr()}: ",
                      ),
                      Expanded(
                          child: Text(
                            "${cubit.getDataProfileModel!.data!.phone}",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.black),
                          )),
                    ],
                  ),
               /*   SizedBox(
                    height: 20,
                  ),*/
         /*         Row(
                    children: [
                      Label(
                        text: "${'Address'.tr()}: ",
                      ),
                      Expanded(
                          child: Text(
                        "${cubit.getDataProfileModel!.data!.address}",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.black),
                      )),
                    ],
                  ),*/
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // CustomFormField(controller: name),
                  SizedBox(
                    height: 20,
                  ),
                  //TODO : Name
                  InkWell(
                          onTap: () {
                            chooseName == false
                                ? setState(() {
                                    chooseName = true;
                                  })
                                : setState(() {
                                    chooseName = false;
                                  });
                          },
                          child: Row(
                            children: [
                              Label(
                                text: 'FullName'.tr(),
                              ),
                              Spacer(),
                              chooseName != false
                                  ? Icon(
                                      Icons.expand_more,
                                    )
                                  : Icon(
                                      Icons.navigate_next,
                                    ),
                            ],
                          ),
                        ),
                          chooseName != false
                      ? Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            CustomFormField(
                                controller: name, validate: (va) {}),
                          ],
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 20,
                  ),
                  //TODO: Address
                  InkWell(
                    onTap: () {
                      chooseAddress == false
                          ? setState(() {
                        chooseAddress = true;
                      })
                          : setState(() {
                        chooseAddress = false;
                      });
                    },
                    child: Row(
                      children: [
                        Label(
                          text: 'Address'.tr(),
                        ),
                        Spacer(),
                        chooseAddress != false
                            ? Icon(
                          Icons.expand_more,
                        )
                            : Icon(
                          Icons.navigate_next,
                        ),
                      ],
                    ),
                  ),

                  chooseAddress != false
                      ? Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      CustomFormField(
                          controller: address, validate: (va) {}),
                    ],
                  )
                      : SizedBox(),
                  SizedBox(
                    height: 20,
                  ),

                  /*     cubit.getDataProfileModel?.data?.phone != null
                      ? InkWell(
                          onTap: () {
                            choosePhone == false
                                ? setState(() {
                                    choosePhone = true;
                                  })
                                : setState(() {
                                    choosePhone = false;
                                  });
                          },
                          child: Row(
                            children: [
                              Label(
                                text: 'Phone'.tr(),
                              ),
                              Spacer(),
                              choosePhone != false
                                  ? Icon(
                                      Icons.expand_more,
                                    )
                                  : Icon(
                                      Icons.navigate_next,
                                    ),
                            ],
                          ),
                        )
                      : SizedBox(),*/
            /*      cubit.getDataProfileModel?.data?.phone != null &&
                          choosePhone != false
                      ? Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            CustomFormField(
                                controller: phone, validate: (va) {}),
                          ],
                        )
                      : SizedBox(),*/
          /*        SizedBox(
                    height: 10,
                  ),*/
                  //TODO : RESET PASSWORD
                  InkWell(
                    onTap: () {
                      chooseResetPassword == false
                          ? setState(() {
                              chooseResetPassword = true;
                            })
                          : setState(() {
                              chooseResetPassword = false;
                            });
                    },
                    child: Row(
                      children: [
                        Label(
                          text: 'resetPassword'.tr(),
                        ),
                        Spacer(),
                        chooseResetPassword != false
                            ? Icon(
                                Icons.expand_more,
                              )
                            : Icon(
                                Icons.navigate_next,
                              ),
                      ],
                    ),
                  ),
                  chooseResetPassword != false
                      ? Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomResetPasswordProfile(
                                controller: oldPassword,
                                hintText: "oldPassword".tr(),
                                validation: (value) {
                                  if (value!.isEmpty) {
                                    return 'validateOldPassword'.tr();
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomResetPasswordProfile(
                                controller: resetPassword,
                                hintText: "newPassword".tr(),
                                validation: (value) {
                                  if (value!.isEmpty) {
                                    return 'thisFieldCanNotBeEmpty'.tr();
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomResetPasswordProfile(
                                controller: confirmPassword,
                                hintText: "confirmPassword".tr(),
                                validation: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "thisFieldCanNotBeEmpty".tr();
                                  } else if (value != resetPassword.text) {
                                    return "passwordDoesNotMatch".tr();
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              state is ResetPasswordLoadingState
                                  ? CircularProgressIndicator()
                                  :
                              CustomButton(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    print('object');
                                    cubit.resetPasswordData(
                                      oldPassword: oldPassword.text,
                                      newPassword: resetPassword.text,
                                    );
                                  }
                                  /*CacheHelper.getData('id');
                                  CacheHelper.getData('token');
                                  if (cubit.getDataProfileModel?.data?.email !=
                                      null) {
                                    cubit.postDataProfile(
                                      id: CacheHelper.getData('id'),
                                      name: name.text,
                                      address: address.text,
                                      email: email.text,
                                    );
                                  } else {
                                    cubit.postDataProfile(
                                        id: CacheHelper.getData('id'),
                                        name: name.text,
                                        address: address.text,
                                        phone: phone.text);
                                  }*/
                                },
                                height: 50,
                                text: 'Save'.tr(),
                              ),

                              //       CustomFormField(
                              //         controller: oldPassword,
                              //         label: "oldPassword".tr(),
                              //         validate: (value) {
                              //           if (value!.isEmpty) {
                              //             return 'validateOldPassword'.tr();
                              //           }
                              //           return null;
                              //         },
                              //       ),
                              //       SizedBox(
                              //         height: 10,
                              //       ),
                              //       CustomFormField(
                              //         controller: oldPassword,
                              //         label: "newPassword".tr(),
                              //         validate: (value) {
                              //           if (value!.isEmpty) {
                              //             return 'thisFieldCanNotBeEmpty'.tr();
                              //           }
                              //           return null;
                              //         },
                              //       ),
                              //       Container(
                              //         decoration: BoxDecoration(
                              //             color: Color(0xffFAFAFA),
                              //             borderRadius: BorderRadius.circular(30),
                              //             boxShadow: [
                              //               BoxShadow(
                              //                 color: Colors.grey,
                              //                 blurRadius: 0.5,
                              //               )
                              //             ]),
                              //         child: TextFormField(
                              //           controller: oldPassword,
                              //           cursorColor: Colors.white,
                              //           keyboardType: TextInputType.visiblePassword,
                              //           obscureText: false,
                              //           validator: (v) {},
                              //           autovalidateMode:
                              //               AutovalidateMode.onUserInteraction,
                              //           style: TextStyle(color: Colors.white),
                              //           decoration: InputDecoration(
                              //             hintText: 'hintText',
                              //             /*            errorStyle: errorStyle,*/
                              //             errorMaxLines: 2,
                              //             hintStyle: TextStyle(
                              //                 color: Colors.white54, fontSize: 14),
                              //             /* suffixIcon: suffixIcon != null
                              // ? IconButton(
                              // icon: Icon(
                              //   suffixIcon,
                              //   color: kLightGoldColor,
                              // ),
                              // onPressed: () {
                              //   suffixOnPressed!();
                              //
                              // })
                              // : null,*/
                              //             filled: true,
                              //             fillColor: Colors.white.withOpacity(0.4),
                              //             isDense: true,
                              //             focusedBorder: OutlineInputBorder(
                              //                 borderSide:
                              //                     BorderSide(color: Colors.white),
                              //                 borderRadius: BorderRadius.circular(30)),
                              //             enabledBorder: OutlineInputBorder(
                              //                 borderSide:
                              //                     BorderSide(color: Colors.white),
                              //                 borderRadius: BorderRadius.circular(30)),
                              //             border: OutlineInputBorder(
                              //                 borderSide: BorderSide.none,
                              //                 borderRadius: BorderRadius.circular(30)),
                              //           ),
                              //         ),
                              //       ),
                              //       SizedBox(
                              //         height: 10,
                              //       ),
                              //       CustomFormField(
                              //         controller: oldPassword,
                              //         label: "confirmPassword".tr(),
                              //         validate: (value) {
                              //           if (value!.isEmpty) {
                              //             return 'pleaseEnterYouPassword'.tr();
                              //           }
                              //           return null;
                              //         },
                              //       ),
                            ],
                          ),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 20,
                  ),
                  //TODO : DELETE MY ACCOUNT
                  InkWell(
                    onTap: () {
                      chooseDeleteMyAccount == false
                          ? setState(() {
                              chooseDeleteMyAccount = true;
                            })
                          : setState(() {
                              chooseDeleteMyAccount = false;
                            });
                    },
                    child: Row(
                      children: [
                        Label(
                          text: 'deleteAccount'.tr(),
                        ),
                        Spacer(),
                        chooseDeleteMyAccount != false
                            ? Icon(
                                Icons.expand_more,
                              )
                            : Icon(
                                Icons.navigate_next,
                              ),
                      ],
                    ),
                  ),
                  chooseDeleteMyAccount != false
                      ? Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            ///TODo : EDIT
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    AwesomeDialog(
                                        context: context ,
                                        animType: AnimType.scale,
                                        dialogType: DialogType.info,
                                        dialogBackgroundColor: Colors.white,
                                        dismissOnTouchOutside: false,
                                        dismissOnBackKeyPress: false,
                                        body: Text(
                                          'deleteAccount'.tr()),
                                        btnOkText: "areYouSure".tr(),
                                        btnOkOnPress: (){
                                          AppCubit.get(context)
                                              .deleteUserAccount(context: context);
                                        },
                                      btnCancelText: "cancel".tr(),
                                      btnCancelOnPress: (){}
                                    ).show();


                                  },
                                  child: Text("deleteAccount".tr(),
                                      style: TextStyle(color: Colors.black),
                                      textAlign: TextAlign.start),
                                ),
                              ],
                            ),
                            /*            CustomButton(
                    onTap: () {
                          AppCubit.get(context).deleteUserAccount(context: context);
                    },
                    height: 50,
                    text: "deleteAccount".tr(),
                  ),*/
                          ],
                        )
                      : SizedBox(),

                  SizedBox(
                    height: 60,
                  ),
                  state is postdataprofileLoadingState
                      ? CircularProgressIndicator()
                      : CustomButton(
                          onTap: () {
                            CacheHelper.getData('id');
                            CacheHelper.getData('token');
                            if (cubit.getDataProfileModel?.data?.email !=
                                null) {
                              cubit.postDataProfile(
                                id: CacheHelper.getData('id'),
                                name: name.text,
                                address: address.text,
                                email: email.text,
                              );
                            } else {
                              cubit.postDataProfile(
                                  id: CacheHelper.getData('id'),
                                  name: name.text,
                                  address: address.text,
                                  phone: phone.text);
                            }
                          },
                          height: 50,
                          text: 'Save'.tr(),
                        ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
