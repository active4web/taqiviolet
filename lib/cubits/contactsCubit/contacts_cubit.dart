import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../models/terms_and_conditions.dart';

import '../../network/remote/dio_Mhelper.dart';
import '../../shared/constants.dart';

part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  ContactsCubit() : super(ContactsInitial());
  static ContactsCubit get(context) => BlocProvider.of(context);
  TermsAndConditions termsAndConditions = TermsAndConditions();

  void getTermsAndConditions() async {
    emit(ContactsLoadingState());
    await Mhelper.getData(
        url: policyURL,
        query: {'lang': kLanguage, 'type': '2'}).then((value) async {
      log("0" * 50);
      log(value.data.toString());
      log("0" * 50);
      termsAndConditions = TermsAndConditions.fromJson(value.data);

      emit(ContactsStateSuccessState());
    }).catchError((err) {
      log("Error form dio:$err");
      emit(ContactsStateErrorState());
    });
  }
}
