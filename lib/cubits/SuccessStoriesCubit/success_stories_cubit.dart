import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/SuccessStoriesCubit/success_stories_state.dart';

import '../../models/success_stories_model.dart';
import '../../network/remote/dio_Mhelper.dart';
import '../../shared/constants.dart';


class SuccessStoriesCubit extends Cubit<SuccessState> {
  SuccessStoriesCubit() : super(SuccessInitial() );

  static SuccessStoriesCubit get(context) => BlocProvider.of(context);

  ///Get Data From stories
  SuccessStoriesModel storiesModel;
 List<SuccessStoriesData> storeListOfData;

  void getSuccessStories() async {
    emit(GetSuccessLoadingState());
    await Mhelper.getData(UrlPath: dataFromstories).then((value) async {
      print("0"*50);
      print(value.data);
      print("0"*50);
      storiesModel = SuccessStoriesModel.fromJson(value.data);
      storeListOfData = storiesModel.data;
      print(value.data);
      print(storeListOfData[0].content);
      emit(GetSuccessSuccessState());
    }).catchError((err) {
      print("Error form dio:$err");
      emit(GetSuccessErrorState());
    });
  }

  ///End of get Store Data
 // void emitAllShops() => emit(SuccessInitial());
  //
  // SuccessStoriesModel allStoreDataModel;
  // List<Category> AllCat;
  // List<SubCategory> SubCat;
  // List<Product> AllPro;
  // List<Product> DetectedProduct = List<Product>();
  //
  // void getDetectedProduct({SubCatindex=0}) {
  //   AllPro.forEach((element) {
  //     element.categoryId == AllCat[SubCatindex].id
  //         ? DetectedProduct.add(element)
  //         : print("no");
  //     emit(DectectListProduct());
  //   });
  // }
  //
  // int SubCatindex=1;
  // void getDataFromAllShops({Id,}) async {
  //   emit(AllShopsLoading());
  //   await Mhelper.getData(UrlPath: dataFromAllStores + Id).then((value) async {
  //     print(value.data);
  //     allStoreDataModel = AllStoreDataModel.fromJson(value.data);
  //     AllCat = allStoreDataModel.data.category;
  //     SubCat = allStoreDataModel.data.subCategory;
  //     AllPro = allStoreDataModel.data.product;
  //   }).then((v) {
  //     DetectedProduct !=null?DetectedProduct.clear():print("sa");
  //     AllPro.forEach((element) {
  //       element.categoryId == AllCat[SubCatindex].id
  //           ? DetectedProduct.add(element)
  //           : print("no");
  //       emit(DectectListProduct());
  //       emit(AllShopsSuccess());
  //
  //     });
  //   }).catchError((err) {
  //     emit(AllShopsError());
  //     print("err:$err");
  //   });
  // }
}
