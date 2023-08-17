part of 'gift_cubit.dart';

abstract class GiftState {}

class GiftInitial extends GiftState {}

class ShowAndHideSelected extends GiftState {}
class ChangePageIndexState extends GiftState {}

class ChangeBorderPrice extends GiftState{}
class ChangeBorderImage extends GiftState{}


class ShowCouponsDataLoading extends GiftState{}
class ShowCouponsDataSuccess extends GiftState{}

class GetAllListGiftsWalletLoadingState extends GiftState{}
class GetAllListGiftsWalletSuccessState extends GiftState{}
class GetAllListGiftsWalletErrorState extends GiftState{}

class ShowCouponsDataFailure extends GiftState{
  final String error;

  ShowCouponsDataFailure(this.error);
}


