import 'dart:async';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:safsofa/cubits/forgot_password/forgot_password_cubit.dart';
import 'package:safsofa/screens/home_layout.dart';
import 'package:safsofa/screens/new/personel_page/help/custom_circular_progress/custom_circular_progress.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';
import '../../shared/components/custom_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/components/custom_text_form_field.dart';
class ForgotPasswordScreen extends StatelessWidget {
   const ForgotPasswordScreen({super.key});


   @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:CustomAppBar(
          title: 'ForgetPassword'.tr(),
        ),
        body: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
    listener: (context, state) {
      if(state is CheckCodeSuccessState){
        showModalBottomSheet(isScrollControlled: true,backgroundColor:kCustomBlack,context: context, builder: (context)=>
            BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
              listener: (context, state) {
                if(state is ChangePasswordSuccessState){
                  navigateAndFinish(context, HomeLayout());
                }
              },
              builder: (context, state) {
                return Padding(
                  padding:  EdgeInsets.only(top:8.0.h,right: 10.w,left: 10,bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Wrap(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.h,),
                          Text('changePassword'.tr(),style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),),
                          SizedBox(height: 20.h,),
                          CustomPasswordFormField(
                            controller: ForgotPasswordCubit.get(context).passwordController,
                            hintText: 'newPassword'.tr(),
                            isPassword: ForgotPasswordCubit.get(context).isPassword,
                            suffixIcon: ForgotPasswordCubit.get(context).isPassword?Icons.visibility_off_outlined: Icons.visibility_outlined,
                            suffixOnPressed: (){
                              ForgotPasswordCubit.get(context).changeShowPassState();
                            },
                            validation: (value){
                              if(value.toString().isEmpty){
                                return 'thisFieldCanNotBeEmpty'.tr();
                              }else if(value.toString().length<6){
                                return "atLeast6Char".tr();
                              }
                            },
                          ),
                          SizedBox(height: 10.h,),
                          CustomPasswordFormField(
                            hintText: "confirmPassword".tr(),
                            controller: ForgotPasswordCubit.get(context).confirmPasswordController,
                            isPassword: ForgotPasswordCubit.get(context).isPassword,
                            validation: (String value) {
                              if (value.trim().isEmpty) {
                                return "thisFieldCanNotBeEmpty".tr();
                              } else if (value !=
                                  ForgotPasswordCubit.get(context).passwordController.text) {
                                return "passwordDoesNotMatch".tr();
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 20.h,),
                        state is ChangePasswordLoadingState? CustomCircularProgress() :CustomButton(onTap: (){
                            ForgotPasswordCubit.get(context).changePassword();
                          },text: "Confirm".tr(),buttonColor: kDarkGoldColor,
                            textColor: kCustomBlack,height: 45,
                          ),
                          SizedBox(height: 70.h,)
                        ],
                      ),
                    ],
                  ),
                );
              },
            )
        );
      }
    },
    builder: (context, state) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
              // padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h,),
                Text("sendVerifyCodeVia".tr(),style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 10.h,),
               Row(
                 children: [
                   InkWell(
                     onTap: ()async{
                       await launch(
                           'whatsapp://send?phone=+966570033133');

                     },
                     child: Row(
                       children: [
                         Image.asset('assets/images/whatsapp.png',height: 30.h,),
                         SizedBox(width: 10.w,),
                         Text("whatsapp".tr(),style: TextStyle(
                             fontSize: 16.sp
                         ),),
                       ],
                     ),
                   ),
                   SizedBox(width: 10.h,),
                   InkWell(
                     onTap: (){
                       ForgotPasswordCubit.get(context).changeSelect();
                     },
                     child: Row(
                       children: [
                         Image.asset('assets/images/gmail.png',height: 30.h,),
                         SizedBox(width: 10.w,),
                         Text("Email".tr(),style: TextStyle(
                             fontSize: 16.sp
                         ),),
                       ],
                     ),
                   ),
                 ],
               ),
                if(ForgotPasswordCubit.get(context).email)
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h,),
                      CustomTextFormField(controller: ForgotPasswordCubit.get(context).emailController,keyboardType: TextInputType.emailAddress, validate: (value ) {  },
                      hintText: "${'Email'.tr()}",
                        hintColor: kCustomBlack,
                        borderColor: kCustomBlack,
                        cursorColor: kCustomBlack,
                        textColor: kCustomBlack,
                        fontSize: 16.sp,
                      ),
                      if(state is SendVerifyCodeErrorState)
                        Text(state.error,style: TextStyle(
                          color: Colors.red,
                            fontSize: 11.sp
                        ),),
                      if(state is SendVerifyCodeSuccessState)
                        Text('${'codeSent'.tr()}: ${ForgotPasswordCubit.get(context).emailController.text}',style: TextStyle(
                            color: Colors.green,
                          fontSize: 11.sp
                        ),),
                      SizedBox(height: 10.h,),
                     state is SendVerifyCodeLoadingState? CustomCircularProgress(
                       color: kCustomBlack,
                     ):CustomButton(onTap: (){
                        ForgotPasswordCubit.get(context).forgotPassword();
                      },text: "Send".tr(),),
                    ],
                  ),
                ),
                SizedBox(height: 5,),
                Divider(thickness: 2,),
                SizedBox(height: 20.h,),
                PinCodeTextField(
                  autoDisposeControllers: false,
                  keyboardType: TextInputType.phone,
                  length: 6,
                  cursorColor: Colors.white,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    inactiveFillColor: Colors.white,
                    inactiveColor: kCustomBlack,
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50.h,
                    fieldWidth: 40.w,
                    activeFillColor: Colors.white,
                    selectedFillColor: kCustomBlack
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  errorAnimationController: ForgotPasswordCubit.get(context).errorAnimationController,
                  controller: ForgotPasswordCubit.get(context).textEditingController,
                  onCompleted: (v) {
                    ForgotPasswordCubit.get(context).checkCode();
                  },
                  onChanged: (value) {
                    print(value);

                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  }, appContext: context,
                ),
               //  SizedBox(height: 10.h,),
               // state is CheckCodeLoadingState? CustomCircularProgress(color: kCustomBlack,):CustomButton(onTap: (){
               //    ForgotPasswordCubit.get(context).checkCode();
               //  },text: "تحقق",)
              ],
            ),
        ),
      );
    },
),
      );
  }
}
