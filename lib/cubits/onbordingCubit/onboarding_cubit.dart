import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/models/models.dart';

part 'onboarding_state.dart';

class OnboardngCubit extends Cubit<OnboardingState> {
  OnboardngCubit() : super(OnboardingInitial());
  static OnboardngCubit get(context)=>BlocProvider.of(context);
  emit(OnboardingInitial);
  int currentIndex=0;
  Future <void> changeIndex(int index)async{
    emit(ChangeIndex());
  }
  List<SliderModel> list = [
    SliderModel(
      Image: "assets/images/onboarding1.png",
      title: "Onboard1".tr(),
    ),
    SliderModel(
      Image: "assets/images/onboarding2.png",
      title: "Onboard2".tr(),
    ),
  ];

}