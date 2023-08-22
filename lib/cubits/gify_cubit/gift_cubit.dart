import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/models/coupons_model.dart';
import 'package:safsofa/network/local/cache_helper.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/shared/constants.dart';

import '../../models/GetAllNewProductsNewModel.dart';
import '../../models/NewListGiftsWalletModelOld.dart';
import '../../models/OldCouponsModel.dart';
import '../../models/new_list_gifts_wallet_model.dart';

part 'gift_state.dart';

class GiftCubit extends Cubit<GiftState> {
  GiftCubit() : super(GiftInitial());

  static GiftCubit get(context) => BlocProvider.of(context);

  bool isSelectedCheck = false;

  int index = 1;
  changePageIndex(newIndex)
  {
    index = newIndex;
    emit(ChangePageIndexState());
  }

  void changedSelectedCheck({required bool value}) {
    isSelectedCheck != isSelectedCheck;
    isSelectedCheck = value;
    if (isSelectedCheck) {
      isSelectedCheck = true;
    } else {
      isSelectedCheck = false;
    }
    emit(ShowAndHideSelected());
  }

  int? selectedIndex = 0;

  void changeBorderPrice(int index) {
    selectedIndex = index;
    emit(ChangeBorderPrice());
  }

  int? selectedImageIndex = 0;

  void changeBorderImage(int index) {
    selectedImageIndex = index;
    emit(ChangeBorderImage());
  }
  CouponsModel? couponsModel;
  void showCouponsData() {
    emit(ShowCouponsDataLoading());
    Mhelper.postData(
      url: '/api/MyCouponList',
      token: CacheHelper.getData('token'),
      query: {
        'lang':CacheHelper.getData('language'),
      },
    ).then((value) {
      couponsModel = CouponsModel.fromJson(value.data);
      print("mostafa كوبون");
      emit(ShowCouponsDataSuccess());
    }).catchError((error){
      emit(ShowCouponsDataFailure(error.toString()));
      print(error.toString());
    });
  }

  OldCouponsModel? oldCouponsModel;
  void showOldCouponsData() {
    emit(ShowOldCouponsDataLoading());
    Mhelper.postData(
      url: '/api/MyCouponListold',
      token: CacheHelper.getData('token'),
      query: {
        'lang':CacheHelper.getData('language'),
      },
    ).then((value) {
      oldCouponsModel = OldCouponsModel.fromJson(value.data);
      print("mostafa   كوبون قديمة");
      print(oldCouponsModel!.data!.couponLists!.length);
      emit(ShowOldCouponsDataSuccess());
    }).catchError((error){
      emit(ShowOldCouponsDataFailure(error.toString()));
      print(error.toString());
    });
  }

  NewListGiftsWalletModel? newListGiftsWalletModel;
  getAllListGiftsWalletData()
  {
    emit(GetAllListGiftsWalletLoadingState());
    Mhelper.getData(url: "api/giftwallet",
      token: CacheHelper.getData('token'),
      query: {
      "lang" : "ar",
      },
    ).then((value){
      print(value.data);
      newListGiftsWalletModel = NewListGiftsWalletModel.fromJson(value.data);
      print("mostafa new------------");
      print("newListGiftsWalletModel");
      emit(GetAllListGiftsWalletSuccessState());
    }).catchError((error){
      print("error in ........ ${error.toString()}");
      emit(GetAllListGiftsWalletErrorState());
    });
  }


  NewListGiftsWalletModelOld? newListGiftsWalletModelOld;
  getAllListGiftsWalletDataOld()
  {
    emit(GetAllListGiftsWalletLoadingStateOld());
    Mhelper.getData(url: "api/giftwallet_old",
      token: CacheHelper.getData('token'),
      query: {
        "lang" : "ar",
      },
    ).then((value){
      print(value.data);
      newListGiftsWalletModelOld = NewListGiftsWalletModelOld.fromJson(value.data);
      print("mostafa old ------------");
      print("newListGiftsWalletModel");
      emit(GetAllListGiftsWalletSuccessStateOld());
    }).catchError((error){
      print("error in ........ ${error.toString()}");
      emit(GetAllListGiftsWalletErrorStateOld());
    });
  }



  deleteGiftsWalletDataOld({
    required int id,
})
  {
    emit(DeleteGiftsWalletLoadingStateOld());
    Mhelper.postData(url: "api/deletegiftwallet",
      token: CacheHelper.getData('token'),
      data: {
      "id" : id,
      },
      query: {
        "lang" : "ar",
      },
    ).then((value){
      print(value.data);
      newListGiftsWalletModelOld = NewListGiftsWalletModelOld.fromJson(value.data);
      print("mostafa delete old ------------");
      emit(DeleteGiftsWalletSuccessStateOld());
    }).catchError((error){
      print("error in ........ ${error.toString()}");
      emit(DeleteGiftsWalletErrorStateOld());
    });
  }


  GetAllNewProductsNewModel? getAllNewProductsNewModel;
  getAllNewProductsData()
  {
    emit(GetAllNewProductsLoadingStateOld());
    Mhelper.getData(url: "api/get_all_products",
      token: CacheHelper.getData('token'),
      query: {
        "lang" : "ar",
      },
    ).then((value){
      print(value.data);
      getAllNewProductsNewModel = GetAllNewProductsNewModel.fromJson(value.data);
      print("mostafa products ------------");
      print("get all new products");
      emit(GetAllNewProductsSuccessStateOld());
    }).catchError((error){
      print("error in ........ ${error.toString()}");
      emit(GetAllNewProductsErrorStateOld());
    });
  }

}
