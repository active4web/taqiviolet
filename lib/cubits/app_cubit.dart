import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safsofa/cubits/app_states.dart';
import 'package:safsofa/models/departments_model.dart';
import 'package:safsofa/models/favourites_products_model.dart';
import 'package:safsofa/models/home_screen_model.dart';
import 'package:safsofa/models/product_details_model.dart';
import 'package:safsofa/models/products_model.dart';
import 'package:safsofa/models/register_success_model.dart';
import 'package:safsofa/network/local/cache_helper.dart';
import 'package:safsofa/network/remote/dio_helper.dart';
import 'package:safsofa/screens/bottom_navigation_screens/cart_screen.dart';
import 'package:safsofa/screens/bottom_navigation_screens/chats_screen.dart';
import 'package:safsofa/screens/bottom_navigation_screens/home_screen.dart';
import 'package:safsofa/screens/bottom_navigation_screens/menu_screen.dart';
import 'package:safsofa/screens/bottom_navigation_screens/my_account_screen.dart';
import 'package:safsofa/shared/constants.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    HomeScreen(),
    ChatsScreen(),
    CartScreen(),
    MyAccountScreen(),
    MenuScreen(),
  ];

  int selectedIndex = 0;
  void changeNavBar(int value) {
    selectedIndex = value;
    emit(BottomNavState());
  }

  RegisterSuccessModel userInfo;
  void getCache() {
    if (CacheHelper.getData('userInfo') != null) {
      userInfo = RegisterSuccessModel.fromJson(
          jsonDecode(CacheHelper.getData('userInfo')));
      emit(GetCachedUserInfoSuccess());
    }
  }

  HomeScreenModel homeScreenModel;
  void getHomeScreen() {
    emit(GetHomeScreenLoadingState());
    DioHelper.postData(
            url: 'user_api/get_home',
            data: {"key": 1234567890, "lang": kLanguage, "token_id": kToken})
        .then((value) {
      print(value.data);
      homeScreenModel = HomeScreenModel.fromJson(value.data);
      emit(GetHomeScreenSuccessState());
    }).catchError((error) {
      emit(GetHomeScreenErrorState());
      print(error);
    });
  }

  int currentDepIndex = 0;
  DepartmentsModel departmentsModel;
  void getAllDepartments({int catId, int pageNumber = 0}) {
    emit(GetDepartmentsLoadingState());
    DioHelper.postData(url: 'user_api/get_all_departments', data: {
      "key": 1234567890,
      "lang": kLanguage,
      "token_id": kToken,
      "cat_id": catId,
      "limit": 0,
      "page_number": pageNumber
    }).then((value) {
      departmentsModel = DepartmentsModel.fromJson(value.data);
      // print(value.data);
      if (value.data["status"] == true) {
        emit(GetDepartmentsSuccessState());
        getProducts(
          catId: departmentsModel.result.allDepartments[currentDepIndex].catId,
        );
      } else
        emit(GetDepartmentsErrorState());
    }).catchError((error) {
      emit(GetDepartmentsErrorState());
      print(error);
    });
  }

  ProductsModel productsModel;
  void getProducts({int catId}) {
    emit(GetProductsLoadingState());
    DioHelper.postData(url: 'user_api/get_all_product', data: {
      "key": 1234567890,
      "lang": kLanguage,
      "token_id": kToken,
      "cat_id": catId,
      "limit": 10,
      "page_number": 0
    }).then((value) {
      productsModel = ProductsModel.fromJson(value.data);
      // print(value.data["result"]["all_products"]);
      if (value.data["status"] == true) {
        emit(GetProductsSuccessState());
        pageNum = 0;
      } else if (value.data["status"] == false) {
        emit(GetProductsErrorState());
      }
    }).catchError((error) {
      emit(GetProductsErrorState());
      print(error);
    });
  }

  ProductsModel moreProducts;
  int pageNum = 0;
  void fetchMore({int catId}) {
    emit(LoadMoreLoadingState());
    pageNum++;
    print('loading page ${pageNum}');
    DioHelper.postData(url: 'user_api/get_all_product', data: {
      "key": 1234567890,
      "lang": kLanguage,
      "token_id": kToken,
      "cat_id": catId,
      "limit": 10,
      "page_number": pageNum
    }).then((value) {
      if (productsModel.total > productsModel.result.allProducts.length) {
        moreProducts = ProductsModel.fromJson(value.data);
        productsModel.result.allProducts
            .addAll(moreProducts.result.allProducts);
        emit(LoadMoreSuccessState());
      } else if (productsModel.total ==
          productsModel.result.allProducts.length) {
        emit(LoadMoreEndState());
      }
      print(value.data["result"]["all_products"]);
    }).catchError((e) {
      emit(LoadMoreErrorState());
      print('there is error');
      print(e);
    });
  }

  FavouritesProductsModel favouritesModel;
  void getFavouritesProducts() {
    emit(GetFavouritesLoadingState());
    DioHelper.postData(url: 'user_api/get_all_myfavorite', data: {
      "key": 1234567890,
      "lang": kLanguage,
      "token_id": kToken,
      "limit": 0,
      "page_number": 0
    }).then((value) {
      favouritesModel = FavouritesProductsModel.fromJson(value.data);
      if (value.data["status"] == true) {
        emit(GetFavouritesSuccessState());
      } else if (value.data["status"] == false) {
        emit(GetFavouritesErrorState());
      }
    }).catchError((error) {
      emit(GetFavouritesErrorState());
      print(error.toString());
    });
  }

  void updateFavourite({bool isFav, int prodId}) {
    print(prodId);
    print(isFav ? 1 : 2);
    DioHelper.postData(url: 'user_api/update_myfavorite', data: {
      "key": 1234567890,
      "lang": kLanguage,
      "token_id": kToken,
      "id_key": isFav ? 1 : 2,
      "prod_id": prodId
    }).then((value) {
      print(value.data);
      if (value.data["status"] == true) {
        emit(UpdateFavouriteSuccessState());
        getFavouritesProducts();
      } else if (value.data["status"] == false) {
        emit(UpdateFavouriteErrorState());
      }
    }).catchError((error) {
      emit(UpdateFavouriteErrorState());
      print(error);
    });
  }

  ProductDetailsModel productDetailsModel;
  void getProductDetails({int productId}) {
    emit(GetProductDetailsLoadingState());
    DioHelper.postData(url: 'user_api/get_product_details', data: {
      "key": 1234567890,
      "lang": kLanguage,
      "token_id": kToken,
      "prod_id": productId
    }).then((value) {
      print(value.data);
      productDetailsModel = ProductDetailsModel.fromJson(value.data);
      if (value.data["status"] == true) {
        emit(GetProductDetailsSuccessState());
      } else
        emit(GetProductDetailsErrorState());
    }).catchError((error) {
      emit(GetProductDetailsErrorState());
      print(error);
    });
  }

  void addReview(
      {int productId,
      int rating,
      String comment,
      File image1,
      File image2,
      File image3}) {
    emit(AddReviewLoadingState());
    DioHelper.postData(url: 'user_api/add_review', data: {
      "key": 1234567890,
      "lang": kLanguage,
      "token_id": kToken,
      "prod_id": productId,
      "rating": rating,
      "comment": comment,
      "img1": image1,
      "img2": image2,
      "img3": image3,
    }).then((value) {
      if (value.data["status"] == true) {
        emit(AddReviewSuccessState());
      } else
        emit(AddReviewErrorState());
    }).catchError((error) {
      emit(AddReviewErrorState());
      print(error);
    });
  }

  void fetchData() async {
    getCache();
    getHomeScreen();
    getFavouritesProducts();
  }

  Future<XFile> pickImage(file) async {
    final ImagePicker _picker = ImagePicker();
    file = await _picker.pickImage(source: ImageSource.gallery);
    print(file.path);
    emit(PickImageSuccessState());
    return file;
  }

  var lat, long, address;
}
