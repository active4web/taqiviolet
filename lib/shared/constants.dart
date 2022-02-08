import 'package:flutter/material.dart';

const String kBaseURL = 'https://safsfurniture.com/';
String kToken = '';
String kLanguage = 'ar';

const Color kDarkGoldColor = Color(0xffBA8B31);
const Color kLightGoldColor = Color(0xffF3E184);
const Color kBGColor = Color(0xfff4f4f4);
const Gradient kBlackGradient =
    RadialGradient(colors: [Color(0xff4D4D4D), Colors.black], radius: 4);
const Gradient kGoldGradient =
    RadialGradient(colors: [kLightGoldColor, kDarkGoldColor], radius: 4);

const String kLoremIpsum =
    'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق';
BoxDecoration kBoxDecoration = BoxDecoration(
  border: Border.all(color: Colors.grey),
  borderRadius: BorderRadius.circular(10),
);
