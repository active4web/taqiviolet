import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safsofa/cubits/app_states.dart';
import 'package:safsofa/models/departments_model.dart';
import 'package:safsofa/models/favourites_products_model.dart';
import 'package:safsofa/models/home_screen_model.dart';
import 'package:safsofa/models/notifications_list_model.dart';
import 'package:safsofa/models/product_details_model.dart';
import 'package:safsofa/models/product_reviews_model.dart';
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

  Map<int, bool> favourites = {};
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
      productsModel.result.allProducts.forEach((element) {
        favourites.addAll({element.prodId: element.isFav});
      });
      print(favourites.toString());
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
        productsModel.result.allProducts.forEach((element) {
          favourites.addAll({element.prodId: element.isFav});
        });
        print(favourites.toString());
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
      favouritesModel.result.allFavourites.forEach((element) {
        favourites.addAll({element.prodId: element.isFav});
      });
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

  // Icon favIcon = Icon(
  //   Icons.favorite_border_rounded,
  //   color: Colors.grey,
  // );
  // void changeFavIcon({bool isFavourite}) {
  //   bool isFav = isFavourite;
  //   isFav = !isFav;
  //   favIcon = isFav
  //       ? Icon(
  //           Icons.favorite_rounded,
  //           color: Color(0xffFE9C8F),
  //         )
  //       : Icon(
  //           Icons.favorite_border_rounded,
  //           color: Colors.grey,
  //         );
  //   emit(ChangeIconColor());
  // }

  void updateFavourite({bool isFav, int prodId}) {
    favourites[prodId] = !favourites[prodId];
    emit(UpdateFavouriteSuccessState());
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
        favourites[prodId] = !favourites[prodId];
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

  Future<void> addReview(
      {int productId,
      int rating,
      String comment,
      File image1,
      File image2,
      File image3}) async {
    emit(AddReviewLoadingState());
    DioHelper.postData(url: 'user_api/add_review', data: {
      "key": 1234567890,
      "lang": kLanguage,
      "token_id": kToken,
      "prod_id": productId,
      "rating": rating,
      "comment": comment,
      "img1": image1 != null
          ? await MultipartFile.fromFile(image1.path,
              filename: image1.path.split('/').last)
          : null,
      "img2": image2 != null
          ? await MultipartFile.fromFile(image2.path,
              filename: image2.path.split('/').last)
          : null,
      "img3": image3 != null
          ? await MultipartFile.fromFile(image3.path,
              filename: image3.path.split('/').last)
          : null,
    }).then((value) {
      print(value.data);
      if (value.data["status"] == true) {
        emit(AddReviewSuccessState(message: value.data["message"]));
      } else
        emit(AddReviewErrorState(message: value.data["message"]));
    }).catchError((error) {
      emit(AddReviewErrorState(message: error.toString()));
      print(error);
    });
  }

  ProductReviewsModel productReviewsModel;
  void getProductReviews({int productId}) {
    emit(GetProductReviewsLoadingState());
    DioHelper.postData(url: 'user_api/get_all_rate', data: {
      "key": 1234567890,
      "lang": kLanguage,
      "token_id": kToken,
      "prod_id": productId,
      "limit": 0,
      "page_number": 0
    }).then((value) {
      print(value.data);
      productReviewsModel = ProductReviewsModel.fromJson(value.data);
      if (value.data["status"] == true) {
        productReviewsModel = ProductReviewsModel.fromJson(value.data);
        emit(GetProductReviewsSuccessState());
      } else
        emit(GetProductReviewsErrorState());
    }).catchError((error) {
      emit(GetProductReviewsErrorState());
      print(error);
    });
  }

  NotificationsListModel notificationsListModel;
  void getAllNotifications() {
    emit(GetAllNotificationsLoadingState());
    DioHelper.postData(url: 'pages/get_list_notifications', data: {
      "key": 1234567890,
      "lang": kLanguage,
      "token_id": kToken,
      "limit": 0,
      "page_number": 0
    }).then((value) {
      print(value.data);
      if (value.data["status"] == true) {
        notificationsListModel = NotificationsListModel.fromJson(value.data);
        emit(GetAllNotificationsSuccessState());
      } else
        emit(GetAllNotificationsErrorState());
    }).catchError((error) {
      emit(GetAllNotificationsErrorState());
      print(error);
    });
  }

  void fetchData() async {
    getCache();
    getHomeScreen();
    getAllNotifications();
    getFavouritesProducts();
  }

  File file1;

  File file2;

  File file3;

  Future<XFile> pickImage(file) async {
    final ImagePicker _picker = ImagePicker();
    file = await _picker.pickImage(source: ImageSource.gallery);
    print(file.path);
    emit(PickImageSuccessState());
    return file;
  }

  var lat, long, address;
}
