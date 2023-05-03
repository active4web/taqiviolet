import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/models/coupons_model.dart';
import 'package:safsofa/network/local/cache_helper.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/shared/constants.dart';

part 'gift_state.dart';

class GiftCubit extends Cubit<GiftState> {
  GiftCubit() : super(GiftInitial());

  static GiftCubit get(context) => BlocProvider.of(context);

  bool isSelectedCheck = false;

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
}
