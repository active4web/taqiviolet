import 'package:flutter/material.dart';
import 'package:safsofa/shared/router.dart';

const String kBaseURL = 'https://safsfurniture.com/';
const String MBaseUrl = "https://safsoofa.amlakyeg.com/";

String kToken = '';
String kLanguage = 'ar';
// /*****************All End Point***********************/
const String offersEndpoint = "/api/offers";
const String blogEndpoint = "/api/blogs";
const String homeMainCatEndPoint = "/api/categories?store_id=34&=";
const String homeMainBannerEndPoint = "/api/banners";
const String SubCatEndPoint = "/api/subCategory?category_id=";
const String productEndPoint = "/api/products?category_id=";
const String dataFromStores="/api/stores";
const String dataFromAllStores="/api/allStores/";
const String authRegister="api/register";
const String authLogin="/api/login";

// /*****************************************************/

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

const DefaultErrorMessage = 'خطأ في الانترنت!';

String getAsset(String imageName) => 'assets/images/$imageName.png';

String getLottie(String lottie) => 'assets/lottie/$lottie.json';

// void showInternetErrorMessage ()=> showSna(DefaultErrorMessage, color: Colors.red);

double get gridViewChildRatio => sizeFromWidth(1.0) / sizeFromHeight(1.5);

SliverGridDelegate get gridViewDelegate =>
    SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: gridViewChildRatio,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15);

String reformatTime(TimeOfDay value) {
  final reformatted = value.hour.toString().padLeft(2, '0') +
      ':' +
      value.minute.toString().padLeft(2, '0') +
      ':00';
  return reformatted;
}

String reformatDate(DateTime value) {
  if (value == null) return '';
  final reformatted = value.year.toString() +
      '-' +
      value.month.toString().padLeft(2, '0') +
      '-' +
      value.day.toString().padLeft(2, '0');
  return reformatted;
}

String get getCurrentTimeCustomized {
  final now = TimeOfDay.now();
  final time =
      '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:00';
  return time;
}

String get getTodayDateCustomized {
  final now = DateTime.now();
  final date =
      '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  return date;
}

String getOrderStatusTitle(String value) {
  if (value == '0')
    return "طلب قيد الانتظار";
  else if (value == '1')
    return "طلب قيد التنفيذ";
  else if (value == '2')
    return "طلب منتهي";
  else
    return "طلب ملغي";
}

const Color kPrimaryColor = Color(0xFF1492E6);
final Color kAccentColor = Color(0xFF1492E6).withOpacity(0.3);
// const Color kLightGreyColor = Color(0xFFB5B5B5);
const Color kGreyColor = Color(0xFFF2F2F2);
const Color kDarkGreyColor = Color(0xFF555555);
final Color kBackgroundColor = Colors.white;

ThemeData theme = ThemeData(
  platform: TargetPlatform.iOS,
  primaryColor: kPrimaryColor,
  // cursorColor: kPrimaryColor,
  canvasColor: kBackgroundColor,
  fontFamily: 'Tajawal',
  // appBarTheme: AppBarTheme(
  //   // titleTextStyle: TextStyle(color: k),
  //   // iconTheme: IconThemeData(color: Colors.white),
  // ),
  textButtonTheme: TextButtonThemeData(
    style:
        ButtonStyle(foregroundColor: MaterialStateProperty.all(kPrimaryColor)),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kAccentColor),
);

final containerDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.white,
    border: Border.all(color: Colors.black54, width: 0.2));

void closeKeyboard() =>
    FocusScope.of(MagicRouter.currentContext).requestFocus(FocusNode());

TextTheme get getTextTheme => Theme.of(MagicRouter.currentContext).textTheme;

double sizeFromHeight(double fraction, {bool removeAppBarSize = true}) {
  MediaQueryData mediaQuery = MediaQuery.of(MagicRouter.currentContext);
  fraction = (removeAppBarSize
          ? (mediaQuery.size.height -
              AppBar().preferredSize.height -
              mediaQuery.padding.top)
          : (mediaQuery.size.height)) /
      (fraction == 0 ? 1 : fraction);
  return fraction;
}

double sizeFromWidth(double fraction) {
  fraction = MediaQuery.of(MagicRouter.currentContext).size.width /
      (fraction == 0 ? 1 : fraction);
  return fraction;
}

class ColorManager {
  static Color lightGolden = HexaColor.fromHexa("#F3E184");
  static Color Golden = HexaColor.fromHexa("#BA8B31");
}

extension HexaColor on Color {
  static Color fromHexa(hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF" + hexColorString; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
