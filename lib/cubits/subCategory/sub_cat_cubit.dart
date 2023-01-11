import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:safsofa/models/subCat_home_Model.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/shared/constants.dart';

import '../../models/ProductModel.dart';

part 'sub_cat_state.dart';

class SubCatCubit extends Cubit<SubCatState> {
  SubCatCubit() : super(SubCatInitial());

  static SubCatCubit get(context) => BlocProvider.of(context);

  /// Get Home Main Sub category List Data
  SubCatDataModel subCatDataModel;
  List<SubCatData> subCatDataList;

  Future<void> getSubCatData({@required CatId}) async {
    log('in getSubCatData function');
    emit(HomeSubCatLoading());
    log("CatIdCatId  $CatId");
    await Mhelper.getData(
        url: SubCatEndPoint + CatId, query: {'lang': kLanguage}).then((value) {
      subCatDataModel = SubCatDataModel.fromJson(value.data);
      log(value.data.toString());
      subCatDataList = subCatDataModel.date;
      log('${subCatDataList[0].name}');
      emit(HomeSubCatSuccess());
    }).catchError((err) {
      emit(HomeSubCatError());
      log("///Home Err:${err.toString()}");
    });
  }

  ///End of SubCategories List Data

  /// Get  Product in  Sub category List Data
  ProductFromCatModel productFromCatModel;
  List<DataProduct> productFromCatList;
  List<DataProduct> searchLocal = [];

  Future<void> getProductSubCatData({@required param, @required ProId}) async {
    log('in getProductSubCatData function');
    emit(ProductLoading());
    await Mhelper.getData(
      url: productEndPoint,
      token: kToken,
      query: {"category_id": ProId, 'lang': kLanguage},
    ).then((value) {
      log(value.data.toString());
      productFromCatModel = ProductFromCatModel.fromJson(value.data);

      log('${productFromCatModel.data}');
      productFromCatList = productFromCatModel.data;
      log('$productFromCatList');
      emit(ProductSuccess());
    }).catchError((err) {
      emit(ProductError());
      log("///Home Err:${err.toString()}");
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
        for (int i = 0; i < productFromCatList.length; i++) {
          if (productFromCatList[i].id == prodId) {
            if (productFromCatList[i].hasFavorites == 0) {
              productFromCatList[i].hasFavorites = 1;
              emit(ProductSuccess());
              break;
            } else {
              productFromCatList[i].hasFavorites = 0;
              emit(ProductSuccess());
              break;
            }
          }
        }
      }
    });
  }

  void localSearch(String keyWord) {
    searchLocal.clear();
    if (productFromCatList != null) {
      productFromCatList.forEach((element) {
        if (keyWord.contains(element.name)) {
          searchLocal.add(element);
        }
      });
    }
  }

  ///End of  Product in  Sub category List Data

}
