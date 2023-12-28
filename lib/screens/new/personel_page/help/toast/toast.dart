import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/screens/new/personel_page/help/toast/toast_states.dart';

import '../../../../../shared/constants.dart';

class ToastConfig{

  static showToast({
    required String msg,
    required ToastStates toastStates,
  }) =>
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(toastStates),
        textColor: Colors.white,
        fontSize: 16.0,
      );
}


Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = kCustomBlack;
      break;
    case ToastStates.error:
      color =  Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }

  return color;
}
