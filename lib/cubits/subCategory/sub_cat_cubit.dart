import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:safsofa/models/subCat_home_Model.dart';
import 'package:safsofa/network/local/cache_helper.dart';
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
    emit(HomeSubCatLoading());
    print("CatIdCatId  $CatId");
    await Mhelper.getData(
        UrlPath: SubCatEndPoint + CatId,
        query: {'lang': CacheHelper.getData('language')}).then((value) {
      subCatDataModel = SubCatDataModel.fromJson(value.data);
      print(value.data);
      subCatDataList = subCatDataModel.date;
      print(subCatDataList[0].name);
      emit(HomeSubCatSuccess());
    }).catchError((err) {
      emit(HomeSubCatError());
      print("///Home Err:${err.toString()}");
    });
  }

  ///TODO:End of SubCategories List Data

  /// Get  Product in  Sub category List Data
  ProductFromCatModel productFromCatModel;
  List<DataProduct> productFromCatList;
  List<DataProduct> searchLocal = [];

  Future<void> getProductSubCatData({@required param, @required ProId}) async {
    emit(ProductLoading());
    await Mhelper.getData(
        UrlPath: productEndPoint + ProId.toString(),
        query: {"$param": ProId}).then((value) {
      print(value.data);
      productFromCatModel = ProductFromCatModel.fromJson(value.data);

      print(productFromCatModel.data);
      productFromCatList = productFromCatModel.data;
      print(productFromCatList);
      emit(ProductSuccess());
    }).catchError((err) {
      emit(ProductError());
      print("///Home Err:${err.toString()}");
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

  ///TODO:End of  Product in  Sub category List Data

}
