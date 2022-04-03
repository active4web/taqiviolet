import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/models/AllStoreDataModel.dart';
import 'package:safsofa/models/shopsModel/shops_model.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/shared/constants.dart';

part 'shops_state.dart';

class ShopsCubit extends Cubit<ShopsState> {
  ShopsCubit() : super(ShopsInitial());

  static ShopsCubit get(context) => BlocProvider.of(context);

  ///Get Data From stories
  StoreModel storeModel;
  List<DataOfStore> storeListOfData;

  void getDataFromShops() async {
    emit(ShopsLoading());
    await Mhelper.getData(UrlPath: dataFromStores).then((value) async {
      storeModel = StoreModel.fromJson(value.data);
      storeListOfData = storeModel.data;
      print(value.data);
      print(storeListOfData[0].name);
      emit(ShopsSuccess());
    }).catchError((err) {
      print("Error form dio:$err");
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

  void getDetectedProduct({SubCatindex=0}) {
    AllPro.forEach((element) {
      element.categoryId == AllCat[SubCatindex].id
          ? DetectedProduct.add(element)
          : print("no");
      emit(DectectListProduct());
    });
  }

int SubCatindex=1;
  void getDataFromAllShops({Id,}) async {
    emit(AllShopsLoading());
    await Mhelper.getData(UrlPath: dataFromAllStores + Id).then((value) async {
      print(value.data);
      allStoreDataModel = AllStoreDataModel.fromJson(value.data);
      AllCat = allStoreDataModel.data.category;
      SubCat = allStoreDataModel.data.subCategory;
      AllPro = allStoreDataModel.data.product;
    }).then((v) {
      DetectedProduct !=null?DetectedProduct.clear():print("sa");
      AllPro.forEach((element) {
        element.categoryId == AllCat[SubCatindex].id
            ? DetectedProduct.add(element)
            : print("no");
        emit(DectectListProduct());
        emit(AllShopsSuccess());

      });
    }).catchError((err) {
      emit(AllShopsError());
      print("err:$err");
    });
  }
}
