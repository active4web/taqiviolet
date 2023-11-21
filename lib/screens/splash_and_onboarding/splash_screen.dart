import 'dart:async';

import 'package:flutter/material.dart%20';
import 'package:flutter/services.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/network/local/cache_helper.dart';
import 'package:safsofa/screens/home_layout.dart';
import 'package:safsofa/screens/splash_and_onboarding/onboarding.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds:3), _goNext);
  }

  _goNext() {
    print(kToken);
    if (CacheHelper.getData("onBoarding") == true && kToken == null ) {
      AppCubit.get(context).selectedIndex=3;
      navigateAndFinish(context, HomeLayout());

    }
       else if(CacheHelper.getData("onBoarding") == true && kToken != null) {
      navigateAndFinish(context, HomeLayout());
    } else {
      navigateAndFinish(context, OnboardingView());

      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnboardingView()));
    }
  }

  @override
  void initState() {
    _startDelay();
    AppCubit.get(context).fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor:Color(0xff393846),
            statusBarIconBrightness: Brightness.light
        ) ,
        toolbarHeight: 0.0,
        elevation: 0.0,
      ),

      backgroundColor: Color(0xff393846),
      body: Center(child: Image.asset('assets/images/logo.png',
      width: MediaQuery.of(context).size.width /1.3,
      )),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}