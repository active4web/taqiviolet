import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/cubits/favorites_cubit/favorites_state.dart';
import 'package:safsofa/models/favorites_lists_model.dart';
import 'package:safsofa/models/favorites_model.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/shared/defaults.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());
  static FavoritesCubit get(context) => BlocProvider.of(context);
  FavoritesListsModel favListModel;

  void getFavListData() {
    emit(FavoritesListLoading());
    Mhelper.getData(
      url: 'api/favlist',
      token: kToken,
      query: {
        'lang': kLanguage,
      },
    ).then((value) {
      favListModel = FavoritesListsModel.fromJson(value.data);
      log(value.data.toString());
      emit(FavoritesListSuccess());
    }).catchError((error) {
      log('Error on loading fav list>>${error.toString()}');
      emit(FavoritesListError());
    });
  }

  void createNewFavList(
      {@required String listName, @required BuildContext context}) {
    Mhelper.postData(
      url: 'api/addfavlist',
      data: {
        'name': listName,
      },
      token: kToken,
      query: {'lang': kLanguage},
    ).then((value) {
      log('Crating new list data: ${value.data}');
      if (value.data['status']) {
        showToast(text: "listCreatedSuccessfully".tr(), color: Colors.green);
        Navigator.of(context).pop();
      } else {
        showToast(text: value.data['msg'], color: Colors.red);
      }
    });
  }

  FavoritesModel allFavData;
  void getAllFavoritesData() {
    emit(LoadingFavoritesAllData());
    Mhelper.getData(url: 'api/MyFav', token: kToken, query: {
      'lang': kLanguage,
    }).then((value) {
      allFavData = FavoritesModel.fromJson(value.data);
      log('All Fav is: ${value.data}');
      emit(SuccessFavoritesAllData());
    }).catchError((error) {
      log('Error in getting all fav data: ${error.toString()}');
      emit(ErrorFavoritesAllData());
    });
  }

  void deleteFavList({@required int listId, @required int listIndex}) {
    Mhelper.postData(
        url: 'api/deletefavlist',
        data: {
          'id': '$listId',
        },
        token: kToken,
        query: {
          'lang': kLanguage,
        }).then((value) {
      if (value.data['status']) {
        allFavData.data.list.removeAt(listIndex);
        emit(SuccessFavoritesAllData());
      } else {
        showToast(text: "somethingWentWrong".tr(), color: Colors.red);
      }
    });
  }
}
