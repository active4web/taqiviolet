import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/inspirationCubit/inspiration_state.dart';
import 'package:safsofa/models/inspiration_model.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/shared/constants.dart';

class InspirationCubit extends Cubit<InspirationStates> {
  InspirationCubit() : super(InspirationInitialState());
  static InspirationCubit get(context) => BlocProvider.of(context);
  InspirationModel _inspirationModel;
  List<Data> inspirationData = [];

  void getInspirationData() async {
    emit(GetInspirationLoadingState());
    await Mhelper.getData(url: inspiration, query: {'lang': kLanguage})
        .then((value) async {
      _inspirationModel = InspirationModel.fromJson(value.data);
      inspirationData = _inspirationModel.data;
      log(inspirationData[0].urlLink.toString());
      emit(GetInspirationSuccessState());
    }).catchError((error) {
      log('=' * 10 + 'error in inspiration' + '=' * 10);
      log('*' * 10 + error.toString() + '*' * 10);
      emit(GetInspirationErrorState());
    });
  }

  void updateFavorite({@required int prodId}) {
    log('inside is favorite of sub_cat_cubit');
    Mhelper.postData(
        url: 'api/FavProduct',
        data: {"product_id": prodId},
        token: kToken,
        query: {'lang': kLanguage}).then((value) {
      log(value.data.toString());
      if (value.data['status']) {
        for (int i = 0; i < inspirationData.length; i++) {
          if (inspirationData[i].urlLink == prodId) {
            if (inspirationData[i].hasFavorites == 0) {
              inspirationData[i].hasFavorites = 1;
              emit(GetInspirationSuccessState());
              break;
            } else {
              inspirationData[i].hasFavorites = 0;
              emit(GetInspirationSuccessState());
              break;
            }
          }
        }
      }
    });
  }
  // void searchInspirationData({String searchQuery}) {
  //   inspirationData.forEach((element) {
  //     if (element.iD == int.parse(searchQuery)) {
  //       inspirationSearchResult.add(element);
  //       print(element.image);
  //     }
  //   });
  //   emit(SearchInspirationSuccessState());
  // }
}
