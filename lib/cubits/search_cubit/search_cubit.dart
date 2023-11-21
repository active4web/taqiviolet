import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/search_cubit/search_state.dart';
import 'package:safsofa/models/search_results_model.dart';
import 'package:safsofa/network/local/cache_helper.dart';

import '../../models/homeModel/main_cat_model.dart';
import '../../network/remote/dio_Mhelper.dart';
import '../../shared/constants.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
  HomeScreenMainCatModel? homeScreenMainCatModel;
  List<Data> categories = [];
  var validationKey = GlobalKey<FormState>();
  void getCategories() {
    emit(SearchLoadingState());
    Mhelper.getData(
            url: '/api/categories',
            query: {'store_id': 34, 'lang': CacheHelper.getData("language")})
        .then((value) {
      homeScreenMainCatModel = HomeScreenMainCatModel.fromJson(value.data);
      startValue=homeScreenMainCatModel?.msg?.minPrice?.toDouble();
      endValue=homeScreenMainCatModel?.msg?.maxPrice?.toDouble();
      homeScreenMainCatModel?.data?.forEach((element) {
        categories.add(element);
      });
      emit(SearchSuccessState());
    }).catchError((error) {
      emit(SearchErrorState());
    });
  }

  Data? selectedValue;


  int? activeCatIndex;
  changeCatIndex({required int index}){
    activeCatIndex=index;
    emit(ChangeIndex());
  }
  void dropDownChoiceSelection(Data value) {
    selectedValue = value;
    emit(SelectItem());
  }

  SearchResultsModel? searchResults;
  void getSearchData(
      { int? categoryId,
      String? productName}) {
    emit(LoadingSearchResults());
    Mhelper.postData(url: '/api/searchByPrice', data: {
      'category_id': categoryId,
      'start_price': startValue??'',
      'end_price': endValue??'',
      'productName': productName??'',
      "price_order":index,
      "created":index
    }, query: {
      'lang': CacheHelper.getData("language")
    }).then((value) {
      searchResults = SearchResultsModel.fromJson(value.data);
      // log(value.data.toString());
      print(value.data);
      emit(SuccessSearchResults());
    }).catchError((error) {
      print("error ${error.toString()}");
      emit(ErrorSearchResults());
    });
  }

  void updateFavorite({required int prodId}) {
    log('inside is favorite of sub_cat_cubit');
    Mhelper.postData(
        url: 'api/FavProduct',
        data: {"product_id": prodId},
        token: kToken,
        query: {'lang': kLanguage}).then((value) {
      log(value.data.toString());
      if (value.data['status']) {
        for (int i = 0; i < searchResults!.data!.length; i++) {
          if (searchResults!.data![i].id == prodId) {
            if (searchResults?.data![i].hasFavorites == 0) {
              searchResults?.data![i].hasFavorites = 1;
              emit(SuccessSearchResults());
              break;
            } else {
              searchResults?.data![i].hasFavorites = 0;
              emit(SuccessSearchResults());
              break;
            }
          }
        }
      }
    });
  }

int index=0;
  changeIndex({required int value}){
    index=value;
    emit(ChangeIndex());
  }
  double? startValue;
  double? endValue;
  changeSliderValue(start,end){
    startValue=start;
    endValue=end;
    emit(ChangeSlider());
  }

}
