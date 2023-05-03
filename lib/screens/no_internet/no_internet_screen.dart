import 'package:flutter/material.dart%20';
import 'package:flutter/services.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/appCubit/app_states.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {

        return Scaffold(
          backgroundColor: Color(0xff393846),
          appBar:AppBar(
            backgroundColor: Color(0xff393846),
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Color(0xff393846),
                statusBarIconBrightness: Brightness.light
            ) ,
            elevation: 0,
            toolbarHeight: 0.0,
          ) ,
          body: Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SvgPicture.asset('assets/images/disconnect_Internet.svg',
                  //   height: 300.h,
                  //
                  // ),
                  Icon(Icons.wifi_off_outlined,
                    size: MediaQuery.of(context).size.height /4,
                    color: kLightGoldColor,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  // const Text(
                  //   'الأنترنت غير متصل',
                  //   style: TextStyle(
                  //     color: MyColors.primaryColor,
                  //     fontSize: 22,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'noInternet'.tr(),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                ],
              ),
            ),
          ),
    );


}
);}}
