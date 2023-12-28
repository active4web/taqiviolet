
import 'package:flutter_pw_validator/Resource/Strings.dart';
import 'package:easy_localization/easy_localization.dart';

  class Strings implements FlutterPwValidatorStrings  {
  @override
  final String atLeast = 'atLeast'.tr();
  @override
  final String uppercaseLetters = 'letter'.tr();
  @override
  final String numericCharacters = 'numericCharacter'.tr();
  @override
  final String specialCharacters = 'specialCharacter'.tr();



  @override
  // TODO: implement normalLetters
  String get normalLetters => uppercaseLetters;

  @override
  // TODO: implement lowercaseLetters
  String get lowercaseLetters =>atLeast ;
}

