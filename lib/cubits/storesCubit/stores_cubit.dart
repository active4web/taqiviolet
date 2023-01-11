import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:safsofa/models/AllStoreDataModel.dart';
import 'package:safsofa/models/homeModel/main_cat_model.dart';
import 'package:safsofa/models/shopsModel/shops_model.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/shared/constants.dart';

import '../../models/phones_model.dart';
import '../../network/local/cache_helper.dart';

part 'store_state.dart';

class StoresCubit extends Cubit<StoresState> {
  StoresCubit() : super(ShopsInitial());

  static StoresCubit get(context) => BlocProvider.of(context);

  ///Get Data From stories
  StoreModel storeModel;
  List<DataOfStore> storeListOfData;

  void getDataFromShops() async {
    emit(ShopsLoading());
    await Mhelper.getData(
        url: dataFromStores,
        token: kToken,
        query: {'lang': kLanguage}).then((value) async {
      storeModel = StoreModel.fromJson(value.data);
      storeListOfData = storeModel.data;
      log(value.data.toString());
      log('${storeListOfData[0].name}');
      emit(ShopsSuccess());
    }).catchError((err) {
      log("Error form dio:$err");
      emit(ShopsError());
    });
  }

  ///End of get Store Data
  void emitAllShops() => emit(AllShopsInitial());

  AllStoreDataModel allStoreDataModel;
  List<Category> AllCat;
  List<SubCategory> SubCat;
  List<Product> AllPro;
  List<Product> DetectedProduct = List<Product>();

  void getDetectedProduct({SubCatindex = 0}) {
    AllPro.forEach((element) {
      element.categoryId == AllCat[SubCatindex].id
          ? DetectedProduct.add(element)
          : log("no");
      emit(DectectListProduct());
    });
  }

  int SubCatindex = 1;
  void getDataFromAllShops({
    Id,
  }) async {
    emit(AllShopsLoading());
    await Mhelper.getData(url: dataFromAllStores + Id).then((value) async {
      log(value.data.toString());
      allStoreDataModel = AllStoreDataModel.fromJson(value.data);
      AllCat = allStoreDataModel.data.category;
      SubCat = allStoreDataModel.data.subCategory;
      AllPro = allStoreDataModel.data.product;
    }).then((v) {
      DetectedProduct != null ? DetectedProduct.clear() : log("sa");
      AllPro.forEach((element) {
        element.categoryId == AllCat[SubCatindex].id
            ? DetectedProduct.add(element)
            : log("no");
        emit(DectectListProduct());
        emit(AllShopsSuccess());
      });
    }).catchError((err) {
      emit(AllShopsError());
      log("err:$err");
    });
  }

  PhonesModel phonesModel;
  void getData() {
    emit(ShopsLoading());

    Mhelper.getData(
      token: CacheHelper.getData("token"),
      url: phonesURL,
    ).then((value) {
      phonesModel = PhonesModel.fromJson(value.data);
      //  print(getdataprofileModel.toJson());
      // allOffer=offerModel.data;
      // print("${allOffer}");
      emit(ShopsSuccess());
    }).catchError((error) {
      emit(ShopsError());
      log(error.toString());
    });
  }

  HomeScreenMainCatModel storeCats;
  void getStoreCategories({@required int storeId}) {
    emit(StoreCategoryLoadingState());
    Mhelper.getData(url: 'api/categories', token: kToken, query: {
      'lang': kLanguage,
      'store_id': '$storeId',
    }).then((value) {
      storeCats = HomeScreenMainCatModel.fromJson(value.data);
      log(value.data.toString());
       emit(StoreCategorySuccessState());
    }).catchError((error) {
      log('Error in getting store categories ${error.toString()}');
       emit(StoreCategoryErrorState());
    });
  }
}
