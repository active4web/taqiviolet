import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../models/phones_model.dart';
import '../network/local/cache_helper.dart';
import '../network/remote/dio_Mhelper.dart';
import '../shared/constants.dart';

part 'mobile_state.dart';

class MobileCubit extends Cubit<MobileState> {
  MobileCubit() : super(MobileInitial());
  static MobileCubit get(context) => BlocProvider.of(context);
  PhonesModel phonesModel;

  void getdataprofileCData() {
    emit(MobileLoadingState());

    Mhelper.getData(
      token: CacheHelper.getData("token"),
      url: phonesURL,
    ).then((value) {
      phonesModel = PhonesModel.fromJson(value.data);
      //  print(getdataprofileModel.toJson());
      // allOffer=offerModel.data;
      // print("${allOffer}");
      emit(MobileSuccessState());
    }).catchError((error) {
      emit(MobileErrorState());
      log(error.toString());
    });
  }
}
