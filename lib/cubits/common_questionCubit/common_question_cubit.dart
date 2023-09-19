import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:safsofa/models/common_question_model.dart';
import 'package:safsofa/models/get_answer_common_question.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/shared/constants.dart';
part 'common_question_state.dart';

class CommonQuestionCubit extends Cubit<CommonQuestionState> {
  CommonQuestionCubit() : super(CommonQuestionInitial());

  static CommonQuestionCubit get(context) => BlocProvider.of(context);
  CommonQuestionModel? commonQuestionModel;
 Future<void> getCommonQuestion() async {
    emit(getCommonQuestionLoading());
  await  Mhelper.getData(url: commonQuestionUrl).then((value) {
    print('Bbbbbbbbbbbbbbbbbbbbbbb');
      commonQuestionModel = CommonQuestionModel.fromJson(value.data);
      emit(getCommonQuestionSuccess());
    }).catchError((error) {
      emit(getCommonQuestionError(error.toString()));

    });
  }

  AnswerCommonQuestionModel? answerCommonQuestionModel;
  Future<void> getAnswerCommonQuestion({
  required int id,
}) async {
    emit(getAnswerCommonQuestionLoading());
    await  Mhelper.getData(url: answerCommonQuestionUrl,
    query: {
      "id":id
    }
    ).then((value) {
      print('Bbbbbbbbbbbbbbbbbbbbbbb');
      answerCommonQuestionModel = AnswerCommonQuestionModel.fromJson(value.data);
      emit(getAnswerCommonQuestionSuccess());
    }).catchError((error) {
      emit(getAnswerCommonQuestionError(error.toString()));

    });
  }

  int? selectedIndex = -1;
  void changeState(int index) {
    selectedIndex = index;
    emit(ChangeState());
  }

/* ///Get Data From stories
  StoreModel? storeModel;
  List<DataOfStore>? storeListOfData;

  void getDataFromShops() async {
    emit(ShopsLoading());
    await Mhelper.getData(
        url: dataFromStores,
        token: kToken,
        query: {'lang': kLanguage}).then((value) async {
      storeModel = StoreModel.fromJson(value.data);
      storeListOfData = storeModel?.data;
      log(value.data.toString());
      log('${storeListOfData![0].name}');
      emit(ShopsSuccess());
    }).catchError((err) {
      log("Error form dio:$err");
      emit(ShopsError());
    });
  }

  ///End of get Store Data
  void emitAllShops() => emit(AllShopsInitial());

  AllStoreDataModel ?allStoreDataModel;
  List<Category>? AllCat;
  List<SubCategory>? SubCat;
  List<Product>? AllPro;
  List<Product> DetectedProduct = <Product>[];

  void getDetectedProduct({SubCatindex = 0}) {
    AllPro?.forEach((element) {
      element.categoryId == AllCat![SubCatindex].id
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
      AllCat = allStoreDataModel?.data!.category!;
      SubCat = allStoreDataModel?.data!.subCategory!;
      AllPro = allStoreDataModel?.data!.product!;
    }).then((v) {
      DetectedProduct != null ? DetectedProduct.clear() : log("sa");
      AllPro?.forEach((element) {
        element.categoryId == AllCat![SubCatindex].id
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

  PhonesModel? phonesModel;
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

  HomeScreenMainCatModel? storeCats;
  void getStoreCategories({required int storeId}) {
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
  }*/
}
