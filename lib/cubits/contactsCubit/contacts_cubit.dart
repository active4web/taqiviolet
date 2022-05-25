import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/contacts_model.dart';
import '../../models/terms_and_conditions.dart';
import '../../network/local/cache_helper.dart';
import '../../network/remote/dio_Mhelper.dart';
import '../../shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  ContactsCubit() : super(ContactsInitial());
  static ContactsCubit get(context) => BlocProvider.of(context);
  TermsAndConditions termsAndConditions=TermsAndConditions();

  void getTermsAndConditions() async {
    emit(ContactsLoadingState());
    await Mhelper.getData(UrlPath: policyURL+(CacheHelper.getData("language")??"ar")).then((value) async {
      print("0"*50);
      print(value.data);
      print("0"*50);
      termsAndConditions = TermsAndConditions.fromJson(value.data);



      emit(ContactsStateSuccessState());
    }).catchError((err) {
      print("Error form dio:$err");
      emit(ContactsStateErrorState());
    });
  }
}
