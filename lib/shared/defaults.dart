import 'dart:convert';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safsofa/shared/constants.dart';

import '../models/cart_models/cart_local_model/cart_local_model.dart';
import 'components/custom_button.dart';

void navigateTo(BuildContext context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}

void navigateReplacement(BuildContext context, Widget screen) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => screen));
}

void navigateAndFinish(BuildContext context, Widget screen) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => screen), (route) => false);
}

Uint8List decodeImage(String image) {
  Uint8List result;
  result = Base64Codec().decode(image);
  return result;
}

Future<void> showToast({
  required String text,
  required Color color,
  ToastGravity location = ToastGravity.BOTTOM,
}) {
  return Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: location,
      timeInSecForIosWeb: 5,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}

void showAlertDialogWithAction(
    {required BuildContext context,
    String? message,
    Color ?messageColor = kLightGoldColor,
    String? imagePath,
    String? buttonText,
    Function ?action}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Color(0xffF8F8F8),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "${message}",
              style: TextStyle(
                  fontSize: 20,
                  color: messageColor,
                  fontWeight: FontWeight.w500),
              // textDirection: TextDirection.rtl,
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.12,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath!),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            CustomButton(
              onTap: (){},
              text: buttonText,
            )
          ],
        ),
      ),
    ),
  );
}

Future<dynamic> showCustomBottomSheet({required BuildContext context, required Widget content}) {
  return showModalBottomSheet(
      context: context,
      builder: (context) => ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
            child: Container(
              padding: EdgeInsets.all(20),
              //height: MediaQuery.of(context).size.height*0.5,
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              //height: 350,
              child: content,
            ),
          ));
}

CartLocalModel? cartProducts;


// void ensureDeleteMessage({context, onTap, String text}) {
//   showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//             backgroundColor: Color(0xffF8F8F8),
//             title: Center(
//                 child: Text(
//               text,
//               textDirection: TextDirection.rtl,
//               style: TextStyle(
//                 color: kPrimaryColor,
//                 fontWeight: FontWeight.bold,
//               ),
//             )),
//             actionsAlignment: MainAxisAlignment.spaceEvenly,
//             actions: [
//               TextButton(
//                 child: Text(
//                   'تراجع',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(kPrimaryColor),
//                 ),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//               ),
//               TextButton(
//                 child: Text(
//                   'حذف',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(Colors.red),
//                 ),
//                 onPressed: onTap,
//               ),
//             ],
//           ));
// }

// void showLoadingDialogue(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       content: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SpinKitFadingCircle(
//               color: kPrimaryColor,
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }

/// Print Long String
void printLongString(String text) {
  final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern
      .allMatches(text)
      .forEach((RegExpMatch match) => print(match.group(0)));
}

String handleOrderStatusMessage({required String statusVal}) {
  switch (statusVal) {
    case '0':
      return "pending".tr();
    case '1':
      return "preparing".tr();
    case '2':
      return "delivering".tr();
    case '3':
      return "received".tr();
    case '4':
      return "cancelled".tr();
    case '5':
      return "rejected".tr();
    default:
      return 'Un Expected status';
  }
}
