import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:safsofa/models/favorites_lists_model.dart';
import 'package:safsofa/models/subCat_home_Model.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';

import '../../models/ProductModel.dart';
import '../../models/search_results_model.dart';
import '../../network/local/cache_helper.dart';

part 'sub_cat_state.dart';

class SubCatCubit extends Cubit<SubCatState> {
  SubCatCubit() : super(SubCatInitial());

  static SubCatCubit get(context) => BlocProvider.of(context);

  /// Get Home Main Sub category List Data
  SubCatDataModel? subCatDataModel;
  List<SubCatData>? subCatDataList;

  Future<void> getSubCatData({required CatId}) async {
    log('in getSubCatData function');
    emit(HomeSubCatLoading());
    log("CatIdCatId  $CatId");
    await Mhelper.getData(
        url: SubCatEndPoint + CatId, query: {'lang': kLanguage}).then((value) {
      subCatDataModel = SubCatDataModel.fromJson(value.data);
      subCatDataList = subCatDataModel?.date;
      log('${subCatDataList![0].name}');
      emit(HomeSubCatSuccess());
    }).catchError((err) {
      emit(HomeSubCatError());
      log("///Home Err:${err.toString()}");
    });
  }

  ///End of SubCategories List Data

  /// Get  Product in  Sub category List Data
  ProductFromCatModel? productFromCatModel;
  List<DataProduct>? productFromCatList;
  List<DataProduct>? searchLocal = [];

  Future<void> getProductSubCatData({@required param, @required ProId}) async {
    emit(ProductLoading());
    await Mhelper.getData(
      url: productEndPoint,
      token: kToken,
      query: {"category_id": ProId, 'lang': kLanguage},
    ).then((value) {
      productFromCatModel = ProductFromCatModel.fromJson(value.data);
      productFromCatList = productFromCatModel?.data;
      emit(ProductSuccess());
      print("1"*100);
      print(value.data!);
    }).catchError((err) {
      emit(ProductError());
    });
  }

  void removeFavorite({required int prodId}) {
    log('inside is favorite of sub_cat_cubit');
    Mhelper.postData(
        url: 'api/FavProduct',
        data: {"product_id": prodId},
        token: kToken,
        query: {'lang': kLanguage}).then((value) {
      log(value.data.toString());
      if (value.data['status']) {
        for (int i = 0; i < productFromCatList!.length; i++) {
          if (productFromCatList![i].id == prodId) {
            if (productFromCatList![i].hasFavorites == 0) {
              productFromCatList![i].hasFavorites = 1;
              emit(RemoveFromFavoriteSuccess());
              break;
            } else {
              productFromCatList![i].hasFavorites = 0;
              emit(ProductSuccess());
              break;
            }
          }
        }

      }
    });
  }

  void localSearch(String? keyWord) {
    searchLocal?.clear();
    final productFromCatList = this.productFromCatList;
    if (productFromCatList != null) {
      productFromCatList.forEach((element) {
        if (keyWord!.contains(element.name as Pattern)) {
          searchLocal?.add(element);
        }
      });
    }
  }

  ///End of  Product in  Sub category List Data

  FavoritesListsModel? favListModel;

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
      emit(ProductSuccess());
    }).catchError((error) {
      log('Error on loading fav list>>${error.toString()}');
      emit(ProductError());
    });
  }

  void createNewFavList(
      {required String listName,
      required BuildContext context,
      int? productId,
      required int index}) {
    Mhelper.postData(
      url: 'api/addfavlist',
      data: {
        'name': listName,
        if (productId != null) 'prod_id': '$productId',
      },
      token: kToken,
      query: {'lang': kLanguage},
    ).then((value) {
      log('Crating new list data: ${value.data}');
      if (value.data['status']) {
        productFromCatList![index].hasFavorites = 1;
        emit(ProductSuccess());
        Navigator.of(context).pop();
      } else {
        showToast(text: value.data['msg'], color: Colors.red);
      }
    });
  }

  void addFavProductToFavList(
      {required int listId,
      required int productId,
      required BuildContext context,required index}) {
    Mhelper.postData(
        url: '/api/FavProduct',
        data: {
          'list_id': '$listId',
          'product_id': '$productId',
        },
        token: kToken,
        query: {
          'lang': kLanguage,
        }).then((value) {
      log(value.data.toString());
      if (value.data['status']) {
         productFromCatList![index].hasFavorites = 1;
        emit(AddToFavoriteSuccess());
        // getFavListData();
         Navigator.pop(context);
      } else {
        showToast(text: "somethingWentWrong".tr(), color: Colors.red);
      }
    });
  }

  SearchResultsModel? searchResults;
  void getSearchData(
      {required int categoryId,
        String? productName}) {
    emit(SearchLoadingState());
    Mhelper.postData(url: '/api/searchByPrice', data: {
      'category_id': categoryId,
      'productName': productName
    }, query: {
      'lang': kLanguage
    }).then((value) {

      productFromCatModel = ProductFromCatModel.fromJson(value.data);
      productFromCatList = productFromCatModel?.data;
      // log(value.data.toString());
      print(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      print("error ${error.toString()}");
      emit(SearchErrorState());
    });
  }
}
