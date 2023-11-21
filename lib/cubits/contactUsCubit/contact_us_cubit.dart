import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/screens/new/personel_page/help/toast/toast.dart';
import 'package:safsofa/screens/new/personel_page/help/toast/toast_states.dart';

import '../../models/subscribe_model.dart';
import '../../network/remote/dio_Mhelper.dart';
import '../../shared/constants.dart';
import 'contact_us_state.dart';

class ContactCubit extends Cubit<ContactUs> {
  ContactCubit() : super(ContactUsInitial());

  static ContactCubit get(context) => BlocProvider.of(context);


  Map<String, dynamic> query = {};
  var formKey = GlobalKey<FormState>();
  // SubscribeModel? subscribeModel;
  void postContactUs({required String email})async {
    emit(PostContactUsState());
   final response=await Mhelper.postData(url: datasupports, data: {'email':email});
   if(response.data['status']){
     print(response.data);
     emit(PostContactUsSuccessState());
     ToastConfig.showToast(msg: response.data['message'], toastStates: ToastStates.success);

   }
   else {
     ToastConfig.showToast(msg: response.data['errors']["email"], toastStates: ToastStates.error);
      emit(PostContactUsErrorState());
    };
  }
}
