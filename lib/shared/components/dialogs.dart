import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Future<Future> displayLogoutDialog(
  BuildContext context,
  String title,
  String body,
) async {
  var currentLanguage = Localizations.localeOf(context);
  return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
            title: Text(
              title,
              style: TextStyle(
                fontFamily: "Cairo",
                fontSize: 13,
              ),
            ),
            content:
                Text(body, style: TextStyle(fontFamily: "Cairo", fontSize: 13)),
            actions: <Widget>[
              CupertinoButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                      currentLanguage.languageCode == 'ar' ? "الغاء" : "Cancel",
                      style: TextStyle(fontFamily: "Tajawal", fontSize: 13))),
              CupertinoButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    },
                  child: Text(
                      currentLanguage.languageCode == 'ar'
                          ? "اغلاق التطبيق"
                          : "Exit",
                      style: TextStyle(fontFamily: "Tajawal", fontSize: 13)))
            ]);
      });
}
