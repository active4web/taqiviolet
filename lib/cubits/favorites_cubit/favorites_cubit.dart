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
  FavoritesListsModel? favListModel;

  // void getFavListData() {
  //   emit(FavoritesListLoading());
  //   Mhelper.getData(
  //     url: 'api/favlist',
  //     token: kToken,
  //     query: {
  //       'lang': kLanguage,
  //     },
  //   ).then((value) {
  //     favListModel = FavoritesListsModel.fromJson(value.data);
  //     log(value.data.toString());
  //     emit(FavoritesListSuccess());
  //   }).catchError((error) {
  //     log('Error on loading fav list>>${error.toString()}');
  //     emit(FavoritesListError());
  //   });
  // }

  Future<dynamic> createNewFavList({
    required String listName,
    required BuildContext context,
  }) async {
    var data = await Mhelper.postData(
      url: 'api/addfavlist',
      data: {
        'name': listName,
      },
      token: kToken,
      query: {'lang': kLanguage},
    );
    return data;
  }

  FavoritesModel? allFavData;
  void getAllFavoritesData({bool withLoading = true}) {
    if (withLoading) {
      emit(LoadingFavoritesAllData());
    }

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

  void deleteFavList({required int listId, required int listIndex}) {
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
        allFavData?.data?.list?.removeAt(listIndex);
        emit(SuccessFavoritesAllData());
      } else {
        showToast(text: "somethingWentWrong".tr(), color: Colors.red);
      }
    });
  }

  // void addFavProductToFavList({@required int listId, @required int productId}) {
  //   Mhelper.postData(
  //       url: '/api/FavProduct',
  //       data: {
  //         'list_id': '$listId',
  //         'product_id': '$productId',
  //       },
  //       token: kToken,
  //       query: {
  //         'lang': kLanguage,
  //       }).then((value) {
  //     log(value.data.toString());
  //     if (value.data['status']) {
  //     } else {
  //       showToast(text: "somethingWentWrong".tr(), color: Colors.red);
  //     }
  //   });
  // }

  void removeProductFromFavorites(
      {required int prodId,
      required int listIndex,
      required int productIndex}) {
    log('inside is favorite of sub_cat_cubit');
    Mhelper.postData(
        url: 'api/FavProduct',
        data: {"product_id": prodId},
        token: kToken,
        query: {'lang': kLanguage}).then((value) {
      log(value.data.toString());
      if (value.data['status']) {
        allFavData?.data?.list![listIndex].listProducts?.removeAt(productIndex);
        emit(SuccessFavoritesAllData());
      }
    });
  }
}
