import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:safsofa/shared/constants.dart';

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

Future<bool> showToast({
  @required String text,
  @required Color color,
}) {
  return Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}

// void showAlertDialogWithAction(
//     {BuildContext context,
//     String message,
//     Color messageColor = kLightGoldColor,
//     String imagePath,
//     String buttonText,
//     Function action}) {
//   showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       backgroundColor: Color(0xffF8F8F8),
//       contentPadding: EdgeInsets.all(40),
//       content: Container(
//         height: MediaQuery.of(context).size.height * 0.5,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Image(image: AssetImage(imagePath)),
//             SizedBox(
//               height: 20,
//             ),
//             Text(
//               message,
//               style: TextStyle(fontSize: 18, color: messageColor),
//               textDirection: TextDirection.rtl,
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             CustomButton(
//               onTab: action,
//               label: buttonText,
//             )
//           ],
//         ),
//       ),
//     ),
//   );
// }

Future<dynamic> showCustomBottomSheet({BuildContext context, Widget content}) {
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

// void logOut(context) {
//   CacheHelper.removeData('token');
//   CacheHelper.removeData('userType')
//       .then((value) => navigateAndFinish(context, LoginScreen()));
//   CacheHelper.clearCache();
// }

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
