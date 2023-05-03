import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/appCubit/app_states.dart';
import 'package:safsofa/network/local/cache_helper.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
class LanguageScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppStates>(
      builder:(context,state)=>
    Scaffold(
        appBar: CustomAppBar(
          title: 'Language'.tr(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Label(
                text: 'ChooseYourLanguage'.tr(),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    LanguageTile(
                      language: 'عربي',
                      flag: AssetImage('assets/images/Arabia.png'),
                      localCode: 'ar',
                    ),
                    Divider(),
                    LanguageTile(
                      language: 'English',
                      flag: AssetImage('assets/images/English.png'),
                      localCode: 'en',
                    ),
                    Divider(),
                    LanguageTile(
                      language: 'Italy',
                      flag: AssetImage('assets/images/Italy.png'),
                      localCode: 'it',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageTile extends StatelessWidget {
  const LanguageTile({
    this.language,
    required this.flag,
    this.localCode,
  }) ;

  final String? language;
  final String? localCode;
  final ImageProvider flag;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(language!),
      leading: Container(
        width: 40,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: flag,
          ),
        ),
      ),
      trailing:
          EasyLocalization.of(context)?.currentLocale.toString() == localCode
              ? Icon(
                  Icons.check_circle,
                  color: Colors.green,
                )
              : SizedBox(),
      onTap: () async {
        await EasyLocalization.of(context)?.setLocale(Locale(localCode!));
        print('11111111111');
        CacheHelper.setData(key: "language", value: localCode);
        kLanguage = CacheHelper.getData('language');
        print('22222222222');

        if (kToken == null || kToken!.isEmpty) {
          print('3333333333333');

          CacheHelper.removeData('localCart');
          CacheHelper.removeData('cartCount');
          cartCount = 0;
          cartProducts = null;
        }
        print('444444444444444');
         Phoenix.rebirth(context);
        log('$localCode');
      },
    );
  }
}
