import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/models/coupons_model.dart';
import 'package:safsofa/network/local/cache_helper.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/shared/constants.dart';

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
      emit(ShowCouponsDataSuccess());
    }).catchError((error){
      emit(ShowCouponsDataFailure(error.toString()));
      print(error.toString());
    });
  }


  NewListGiftsWalletModel? newListGiftsWalletModel;
  getAllListGiftsWalletData()
  {
    emit(GetAllListGiftsWalletLoadingState());
    Mhelper.getData(url: "api/giftwallet",
      token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvdGFxaXZpb2xldC5jb21cL1wvYXBpXC9sb2dpbiIsImlhdCI6MTY4ODgzNTY4NywibmJmIjoxNjg4ODM1Njg3LCJqdGkiOiJWR2V5a0JvRnFHSUFBaDE2Iiwic3ViIjoxNjksInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ.iCrjN4gFwxvEm-JnzPOv2-OmWx8XYtI3s3CrXOtOtb4",
      query: {
      "lang" : "ar",
      },
    ).then((value){
      print(value.data);
      newListGiftsWalletModel = NewListGiftsWalletModel.fromJson(value.data);
      print("samy------------");
      print("newListGiftsWalletModel");
      emit(GetAllListGiftsWalletSuccessState());
    }).catchError((error){
      print("error in ........ ${error.toString()}");
      emit(GetAllListGiftsWalletErrorState());
    });
  }
}
