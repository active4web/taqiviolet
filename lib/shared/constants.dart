import 'dart:async';

import 'package:flutter/material.dart';
import 'package:safsofa/shared/router.dart';

// const String kBaseURL = 'https://safsfurniture.com/';
//const String MBaseUrl = "https://safsoofa.amlakyeg.com/";
const String MBaseUrl = "https://taqiviolet.com/";
String kToken;
String kLanguage;
int cartCount = 0;

StreamController<int> cartCountControlller = StreamController.broadcast();
// /*****************All End Point***********************/
const String offersEndpoint = "/api/offers";
const String blogEndpoint = "/api/blogs";
const String homeMainCatEndPoint = "/api/categories?store_id=34&lang=ar";
const String homeMainBannerEndPoint = "/api/banners";
const String SubCatEndPoint = "/api/subCategory?";
const String productEndPoint = "/api/products";
const String dataFromStores = "/api/stores";
// const String dataFromstories = "/api/stories";
const String dataFromPrivacyPolicy = "/api/privacyPolicy";
const String privacyPolicyDetailsUrl = "/api/get_pages";
const String dataFromcontacts = "/api/contacts";
// const String dataFromabout="api/policy?type=2&lang=";
const String dataFromabout = "/api/pagesFooter";
// const String datasupports = "/api/supports";
const String datasupports = "/api/subscribe";
const String inspiration = '/api/inspiration';
const String dataFromAllStores = "/api/allStores/";
const String dataFromallSupports = "/api/allSupports";
const String dataFromalldetailsSupport = "/api/detailsSupport?message=";
const String authRegister = "api/register";
const String authLogin = "/api/login";
const String authLogOut = "/api/logout";
const String userProfile = "api/profile";
const String editProfile = "/api/editProfile";
const String getallnotifications = "/api/notifications?client_id=";
const String getonenotifications = "/api/DeleteNotification?id=";
const String dellallnotifications = "/api/DeleteAllNotification";
const String productDetails = "/api/productDetails?";
const String AddToCartURL = "/api/AddToCart";
const String myCartURL = "api/myCart";
const String sumItemCartURL = "/api/sumItemCart";
const String delItem = "/api/deleteItemCart?id=";
const String make_orderURL = "api/make_order";
const String promoCodeURL = "api/PromoCode";

const String waitingOrdersURL = "api/waiting_myOrders";
const String currentOrdersURL = "api/current_myOrders";
const String oldOrdersURL = "api/old_myOrders";
const String giftCardsURL = "api/giftCards";
const String phonesURL = "api/phones";
const String policyURL = "api/policy";
const String orderDetailsURL = "api/orderDetails";
const String mainListURL = "api/mainList";
const String createRosterURL = "api/createRoster";

const String deleteRosterURL = "api/deleteRoster";

const String roster_idURL = "api/rosterItem";
const String deleteRosterItemURL = "api/deleteRosterItem";
const String addToRosterItemURL = "api/addToRoster";

const String reOrderURL = "api/reOrder";
const String reOrderItemURL = "api/reOrderItem/";
const String offerProductsURL = "api/get_all_offers";
const String userProfileDataURL = 'api/UserProfile';
const String locationsURL = 'api/list_locations';
const String deleteAccountURL = 'api/delete_account';

// /*****************************************************/

const Color kDarkGoldColor = Color(0xffBA8B31);
const Color kLightGoldColor = Color(0xffF3E184);
const Color kBGColor = Color(0xfff4f4f4);
const Color kCustomBlack = Color(0xff393846);
const Gradient kBlackGradient =
    RadialGradient(colors: [Color(0xff4D4D4D), Colors.black], radius: 4);
const Gradient kGoldGradient =
    RadialGradient(colors: [kLightGoldColor, kDarkGoldColor], radius: 4);

// const String kLoremIpsum =
//     'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق';
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
