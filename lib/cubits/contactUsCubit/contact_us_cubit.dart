import 'package:flutter_bloc/flutter_bloc.dart';

import '../../network/remote/dio_Mhelper.dart';
import '../../shared/constants.dart';
import 'contact_us_state.dart';
class ContactCubit extends Cubit<ContactUs> {
  ContactCubit() : super(ContactUsInitial());

  static ContactCubit get(context) => BlocProvider.of(context);
  Map<String, dynamic> query={};

  void postContactUs() {
    emit(PostContactUsState());
    Mhelper.postData(
       url: datasupports,data: query
    ).then((value) {

      emit(PostContactUsSuccessState());
    }).catchError((err) {
      print("ERR:$err");
      emit(PostContactUsErrorState());
    });
  }
}