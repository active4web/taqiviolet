import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class MainInfractionFormModel extends Equatable{
  final String arabicTitle;
  final String englishTitle;
  final TextEditingController controller;

  const MainInfractionFormModel({
    required this.arabicTitle,
    required this.englishTitle,
    required this.controller});

  @override
  // TODO: implement props
  List<Object?> get props => [
    arabicTitle,englishTitle,controller
  ];

}