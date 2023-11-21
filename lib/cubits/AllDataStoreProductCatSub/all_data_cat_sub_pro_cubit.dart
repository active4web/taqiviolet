/*
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:safsofa/models/common_question_model.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/shared/constants.dart';
part 'all_data_cat_sub_pro_state.dart';

class AllDataCatSubProCubit extends Cubit<AllDataCatSubProState> {
  AllDataCatSubProCubit() : super(AllDataCatSubProInitial());

  static AllDataCatSubProCubit get(context) => BlocProvider.of(context);

  AllStoreDataModel? allStoreDataModel;
  List<Category>? AllCat;
  List<SubCategory>? SubCat;
  List<Product>? AllPro;
  void getDataFromAllShops({Id}) async {
    emit(AllShopsLoading());
    await Mhelper.getData(url: dataFromAllStores + Id).then((value) async {
      log(value.data.toString());
      allStoreDataModel = AllStoreDataModel.fromJson(value.data);
      AllCat = await allStoreDataModel?.data?.category;
      SubCat = await allStoreDataModel?.data?.subCategory;
      AllPro = await allStoreDataModel?.data?.product;
      log("/" * 10);
      log(AllCat!.length.toString());
      log("/" * 10);

      emit(AllShopsSuccess());
    }).catchError((err) {
      emit(AllShopsError());
      log("err:$err");
    });
  }
}
*/
