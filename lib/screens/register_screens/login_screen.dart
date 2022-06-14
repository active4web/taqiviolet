import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/authCubit/auth_cubit.dart';
import 'package:safsofa/cubits/authCubit/auth_states.dart';
import 'package:safsofa/network/local/cache_helper.dart';
import 'package:safsofa/screens/home_layout.dart';
import 'package:safsofa/screens/register_screens/signup_screen.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/components/custom_text_form_field.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          CacheHelper.setData(
                  key: 'token', value: state.loginSuccessModel.data.token)
              .then((value) {
            kToken = CacheHelper.getData('token');
            AppCubit.get(context).getCache();
            navigateAndFinish(context, HomeLayout());
            showToast(text: state.loginSuccessModel.msg, color: Colors.green);
          });
        } else if (state is LoginErrorState) {
          showToast(text: state.errorMessage, color: Colors.red);
        }
      },
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return Scaffold(
          extendBody: true,
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background image.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.28,
                    ),
                    Text(
                      'Login'.tr(),
                      style: TextStyle(color: kLightGoldColor, fontSize: 32),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CustomTextFormField(
                      hintText: "phoneOrEmail".tr(),
                      controller: phoneController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomPasswordFormField(
                      hintText: 'Password'.tr(),
                      controller: passwordController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'ForgetPassword'.tr(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 30,
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
                              cubit.login(
                                  language: EasyLocalization.of(context)
                                      .currentLocale
                                      .toString(),
                                  phone: phoneController.text,
                                  password: passwordController.text);
                            },
                          ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    InkWell(
                      onTap: () {
                        navigateTo(context, SignupScreen());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'DoNotHaveAnAccount?'.tr(),
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          Text(
                            'SignUp'.tr(),
                            style:
                                TextStyle(color: kLightGoldColor, fontSize: 12),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
