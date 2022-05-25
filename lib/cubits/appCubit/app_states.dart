import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';

abstract class AppStates {}

class AppInitial extends AppStates {}

class BottomNavState extends AppStates {}

class PickLocationSuccess extends AppStates {}

class GetHomeScreenLoadingState extends AppStates {}

class GetHomeScreenSuccessState extends AppStates {}

class GetHomeScreenErrorState extends AppStates {}

class GetCachedUserInfoSuccess extends AppStates {}

class GetDepartmentsLoadingState extends AppStates {}

class GetDepartmentsSuccessState extends AppStates {}

class GetDepartmentsErrorState extends AppStates {}

class GetProductsLoadingState extends AppStates {}

class GetProductsSuccessState extends AppStates {
  printData() {
    return print("this data completed in importing");
  }
}

class GetProductsErrorState extends AppStates {}

class GetProductDetailsLoadingState extends AppStates {}
///States of Main Category in Home Screen
class HomeMainCatLoading extends AppStates{}
class HomeMainCatSuccess extends AppStates{}
class HomeMainCatError extends AppStates{}

///TODO:End of HomeCat States

class GetProductDetailsSuccessState extends AppStates {}

class GetProductDetailsErrorState extends AppStates {}

class LoadMoreLoadingState extends AppStates {}

class LoadMoreSuccessState extends AppStates {}

class LoadMoreErrorState extends AppStates {}

class LoadMoreEndState extends AppStates {}

class GetFavouritesLoadingState extends AppStates {}

class GetFavouritesSuccessState extends AppStates {}

class GetFavouritesErrorState extends AppStates {}

class UpdateFavouriteSuccessState extends AppStates {}

class UpdateFavouriteErrorState extends AppStates {}

class ChangeIconColor extends AppStates {}

class AddReviewLoadingState extends AppStates {}

class AddReviewSuccessState extends AppStates {
  AddReviewSuccessState({this.message});

  final String message;
}

class AddReviewErrorState extends AppStates {
  AddReviewErrorState({this.message});

  final String message;
}

class PickImageSuccessState extends AppStates {}

class GetProductReviewsLoadingState extends AppStates {}

class GetProductReviewsSuccessState extends AppStates {}

class GetProductReviewsErrorState extends AppStates {}

class GetAllNotificationsLoadingState extends AppStates {}

class GetAllNotificationsSuccessState extends AppStates {}

class GetAllNotificationsErrorState extends AppStates {}

class AddToCartErrorState extends AppStates {}

class AddToCartLoadingState extends AppStates {}

class AddToCartSuccessState extends AppStates {}
