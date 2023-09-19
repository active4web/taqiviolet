
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/technicalSupportCubit/technical_support_state.dart';
import 'package:safsofa/models/send_contact_us_model.dart';

import '../../models/contact_us.dart';
import '../../network/remote/dio_Mhelper.dart';
import '../../shared/constants.dart';

class TechnicalSupportCubit extends Cubit<TechnicalSupportState> {
  TechnicalSupportCubit() : super(TechnicalSupportInitial());

  static TechnicalSupportCubit get(context) => BlocProvider.of(context);
  ContactUs contactsData = ContactUs();
  void getContactData() async {
    log('GETING CONTACT US DATA');
    emit(GetContactUsLoadingState());
    await Mhelper.getData(url: dataFromcontacts).then((value) async {
      var _myMap = Map<String, dynamic>.from(value.data);
      contactsData = ContactUs.fromJson(_myMap);
      log('k ' * 6 + '${contactsData.data?.mail}' + ' k' * 6);
      emit(GetContactUsSuccessState());
    }).catchError((error) {
      log("X" * 10 + " error in getting contacts data " + "X" * 10);
      log(error.toString());
      emit(GetContactUsErrorState());
    });
  }

  SendContactUsModel? sendingModel;

  void sendContactUs(
      {String? name, String? phone, String? email, String? comment}) async {
    emit(ContactUsSendingLoadingState());
    await Mhelper.postData(url: "/api/contactUs", data: {
      'name': name,
      'phone': phone,
      'email': email,
      'message': comment,
    }).then((value) async {
      sendingModel = SendContactUsModel.fromJson(value.data);
      print(value.data);
      emit(ContactUsSendingSuccessState());
      // emit(GetContactUsSuccessState());
    }).catchError((error) {
      emit(ContactUsSendingErrorState());
    });
  }

  ///Get Data From stories
  // AllSupportsModel allSupportsModel;
  // List<AllSupportsData>AllSupportsListOfData;
  //
  // void getTechnicalSupport() async {
  //   emit(GetTechnicalSupportLoadingState());
  //   await Mhelper.getData(UrlPath: dataFromallSupports).then((value) async {
  //     print("0"*50);
  //     print(value.data);
  //     print("0"*50);
  //     allSupportsModel = AllSupportsModel.fromJson(value.data);
  //     AllSupportsListOfData = allSupportsModel.data;
  //
  //
  //     emit(GetTechnicalSupportSuccessState());
  //   }).catchError((err) {
  //     print("Error form dio:$err");
  //     emit(GetTechnicalSupportErrorState());
  //   });
  // }
  ///***********************************************************************************************************************///
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
