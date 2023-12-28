import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/authCubit/auth_cubit.dart';
import 'package:safsofa/cubits/authCubit/auth_states.dart';
import 'package:safsofa/network/local/cache_helper.dart';
import 'package:safsofa/screens/home_layout.dart';
import 'package:safsofa/screens/register_screens/forgot_password_screen.dart';
import 'package:safsofa/screens/register_screens/register_choice_screen.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/components/custom_text_form_field.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          CacheHelper.setData(
                  key: 'token', value: state.loginSuccessModel.data?.token)
              .then((value) {
            kToken = CacheHelper.getData('token');
            AppCubit.get(context).getCache();
            // showToast(text: state.loginSuccessModel.msg, color: Colors.green);
            navigateAndFinish(context, HomeLayout());
          });
        } else if (state is LoginErrorState) {

           showToast(text: state.errorMessage, color: Colors.red);
        }
      },
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return Scaffold(
           extendBody: true,
          // resizeToAvoidBottomInset: false,
           extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
           body: Form(
             key: _formKey,
             child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background image.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage('assets/images/logo.png'),
                        height:140.h,
                        width: 160.w,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 40,
                      ),
                      Text(
                        'Login'.tr(),
                        style: TextStyle(color: kLightGoldColor, fontSize: 24.sp),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CustomTextFormField(
                        hintText: "phoneOrEmail".tr(),
                        controller: phoneController,
                        validate: (value){
                          if (value!.isEmpty) {
                            return 'thisFieldCanNotBeEmpty'.tr();
                          } else {
                            return null;
                          }
                        },

                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomPasswordFormField(
                        hintText: 'Password'.tr(),
                        controller: passwordController,
                        isPassword: cubit.isPasswordLogin,
                        suffixIcon: cubit.suffixLogin,
                        suffixOnPressed: (){
                          cubit.isShowAndHideLoginPassWord();
                        },
                        validation: (value){
                          if (value!.isEmpty) {
                            return 'thisFieldCanNotBeEmpty'.tr();
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {
                                navigateTo(context, ForgotPasswordScreen());
                              },
                              child: Text(
                                'ForgetPassword'.tr(),
                                style:
                                    TextStyle(color: Colors.white, fontSize: 12.sp),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      state is LoginLoadingState
                          ? Center(
                              child: CircularProgressIndicator(
                                color: kLightGoldColor,
                              ),
                            )
                          : CustomButton(
                              text: 'Login'.tr(),
                              height: 50,
                              gradient: kGoldGradient,
                              textColor: Colors.black,
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if(_formKey.currentState!.validate()){
                                  cubit.login(
                                      language: EasyLocalization.of(context)
                                          ?.currentLocale
                                          .toString(),
                                      phone: phoneController.text,
                                      password: passwordController.text);
                                }
                              },
                            ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                      ),
                      Center(
                        child: Text(
                          'DoNotHaveAnAccount?'.tr(),
                          style: TextStyle(color: Colors.white, fontSize: 12.sp),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 60,
                      ),
                      CustomButton(
                        text: 'SignUp'.tr(),
                        height: 50,
                        gradient: kGoldGradient,
                        textColor: Colors.black,
                        onTap: () => navigateTo(context, RegisterChoiceScreen()),
                      ),
                      SizedBox(height:90.h),
                    ],
                  ),
                ),
              ),
          ),
           ),
        );
      },
    );
  }


}
