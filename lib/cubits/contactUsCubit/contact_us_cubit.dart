import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/subscribe_model.dart';
import '../../network/remote/dio_Mhelper.dart';
import '../../shared/constants.dart';
import 'contact_us_state.dart';

class ContactCubit extends Cubit<ContactUs> {
  ContactCubit() : super(ContactUsInitial());

  static ContactCubit get(context) => BlocProvider.of(context);


  Map<String, dynamic> query = {};
  var formKey = GlobalKey<FormState>();
  SubscribeModel? subscribeModel;
  void postContactUs() {
    emit(PostContactUsState());
    Mhelper.postData(url: datasupports, data: query).then((value) {
      subscribeModel == SubscribeModel.fromJson(value.data);
      log('*' * 10 + (subscribeModel!.msg!) + '*' * 10);
      emit(PostContactUsSuccessState());
    }).catchError((err) {
      log("ERR:$err");
      emit(PostContactUsErrorState());
    });
  }
}
