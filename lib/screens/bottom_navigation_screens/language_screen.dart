import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:safsofa/network/local/cache_helper.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:safsofa/shared/constants.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}

class LanguageTile extends StatelessWidget {
  const LanguageTile({
    Key key,
    this.language,
    this.flag,
    this.localCode,
  }) : super(key: key);

  final String language;
  final String localCode;
  final ImageProvider flag;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(language),
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
          EasyLocalization.of(context).currentLocale.toString() == localCode
              ? Icon(
                  Icons.check_circle,
                  color: Colors.green,
                )
              : SizedBox(),
      onTap: () async {
        await EasyLocalization.of(context).setLocale(Locale(localCode));
        CacheHelper.setData(key: "language", value: localCode);
        kLanguage = CacheHelper.getData('language');
        log('$localCode');
      },
    );
  }
}
