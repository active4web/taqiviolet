import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safsofa/cubits/appCubit/app_states.dart';
import 'package:safsofa/cubits/homeCubit/home_cubit.dart';
import 'package:safsofa/models/departments_model.dart';
import 'package:safsofa/models/favourites_products_model.dart';
import 'package:safsofa/models/homeModel/main_cat_model.dart';
import 'package:safsofa/models/homeModel/main_home_banner.dart';
import 'package:safsofa/models/home_screen_model.dart';
import 'package:safsofa/models/notifications_list_model.dart';
import 'package:safsofa/models/offer_model.dart';

import 'package:safsofa/models/product_reviews_model.dart';
import 'package:safsofa/models/products_model.dart';
import 'package:safsofa/models/register_success_model.dart';
import 'package:safsofa/models/subCat_home_Model.dart';
import 'package:safsofa/network/local/cache_helper.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/network/remote/dio_helper.dart';
import 'package:safsofa/screens/bottom_navigation_screens/cart_screen.dart';
import 'package:safsofa/screens/bottom_navigation_screens/chats_screen.dart';
import 'package:safsofa/screens/bottom_navigation_screens/home_screen.dart';
import 'package:safsofa/screens/bottom_navigation_screens/menu_screen.dart';
import 'package:safsofa/screens/bottom_navigation_screens/my_account_screen.dart';
import 'package:safsofa/shared/constants.dart';

import '../../models/my_product_details_model.dart';
import '../../models/product_details_model.dart';
import '../../screens/menu_screens/offers_screen.dart';
import '../cartCubit/cart_cubit.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);


  MYProductDetailsModel productDetailsModel;
  List<Widget> screens = [
    HomeScreen(),
    OffersScreen(),// ChatsScreen(),
    CartScreen(),
    MyAccountScreen(),
    MenuScreen(),
  ];

  int selectedIndex = 0;
addtolist(product_id){
  Mhelper.postData( url: "/api/addToRoster",data: {
    "product_id":product_id
  });
}
  void changeNavBar(int value,context) {
    selectedIndex = value;
    if(value==2){
      print("get myyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
      CartCubit.get(context).getCartData();
    }
    emit(BottomNavState());
  }

  RegisterSuccessModel userInfo;

  void getCache() {
    if (CacheHelper.getData('userInfo') != null) {
      print("sa");
      userInfo = RegisterSuccessModel.fromJson(
          jsonDecode(CacheHelper.getData('userInfo')));
    } else {
      print("-" * 10);
    }
  }

  /// Get Home Main Category Data
  HomeScreenMainCatModel homeScreenMainCatModel;
  List<Data> homeMainCatList;

  // void getHomeData() {
  //   emit(HomeMainCatLoading());
  //   Mhelper.getData(UrlPath: homeMainCatEndPoint).then((value) {
  //    homeScreenMainCatModel = HomeScreenMainCatModel.fromJson(value.data);
  //     print("/" * 100);
  //     log(value.data);
  //     print("*/*" * 100);
  //
  //    homeMainCatList = homeScreenMainCatModel.data;
  //     // print(homeMainCatList[0].image);
  //     print("sas");
  //    print(value.statusCode);
  //     print(homeScreenModel.data.length);
  //     print("sas");
  //
  //     emit(HomeMainCatSuccess());
  //   }).catchError((err) {
  //
  //     emit(HomeMainCatError());
  //     print("///Home Err:${err.toString()}");
  //   });
  // }

  ///TODO:End of Getting home data

  /// Get Home Main banner Data
  HomeScreenMainCatBannerModel homeScreenMainCatBannerModel;
  List<DataBanner> homeBannersList;

  void gethomeMainBanners() {
    emit(HomeMainCatLoading());
    Mhelper.getData(UrlPath: homeMainBannerEndPoint).then((value) {
      homeScreenMainCatBannerModel =
          HomeScreenMainCatBannerModel.fromJson(value.data);
      print(value.data);
      homeBannersList = homeScreenMainCatBannerModel.data;
      print(homeBannersList[0].image);
      emit(HomeMainCatSuccess());
    }).catchError((err) {
      emit(HomeMainCatError());
      print("///Home Err:${err.toString()}");
    });
  }

  ///TODO:End of Getting Main banners data

  /// Get Home Main Offer List Data
  OfferModel offerModel;
  List<OfferModelData> offerDataList;

  void gethomeMainOfferData() {
    emit(HomeMainCatLoading());
    Mhelper.getData(UrlPath: offersEndpoint).then((value) {
      offerModel = OfferModel.fromJson(value.data);
      print(value.data);
      offerDataList = offerModel.data;
      print(homeBannersList[0].image);
      emit(HomeMainCatSuccess());
    }).catchError((err) {
      emit(HomeMainCatError());
      print("///Home Err:${err.toString()}");
    });
  }

  ///TODO:End of Home Main Offer List Data

  HomeScreenMainCatModel homeScreenModel;

  void getHomeScreen() {
    emit(GetHomeScreenLoadingState());
    DioHelper.getData(
            url: 'https://taqiviolet.com/api/categories?store_id=34&lang=ar',
          )
        .then((value) {
      print("the data of ${value.data}");
      homeScreenMainCatModel = HomeScreenMainCatModel.fromJson(value.data);
      homeMainCatList = homeScreenMainCatModel.data;
      print( "000000000000000000000000000000000000000000000000");
      emit(GetHomeScreenSuccessState());
    }).catchError((error) {
      emit(GetHomeScreenErrorState());
      print( "8888888888888888888888888888888888888888888888888888888888    $error");
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
  getCartData(){
    print("getDatagetDatagetDatagetData");
   // emit(CartLoadingState());
    Mhelper.getData(UrlPath: myCartURL,token: CacheHelper.getData("token")).then((value) {

    //  print(value.data);
    //  emit(CartStateSuccessState());
    }).catchError((e){
      //emit(CartStateErrorState());
    });
  }
  void getAllData() {
    DioHelper.postData(url: 'user_api/get_all_product', data: {
      "key": 1234567890,
      "lang": kLanguage,
      "token_id": kToken,
      "cat_id": 1,
      "limit": 10,
      "page_number": 0
    }).then((value) {
      ProductsModel most = ProductsModel.fromJson(value.data);
     // print(most.result.allProducts[0].productName + "data in ///GETALLDATA");
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
     // print(favourites.toString() + "mostafa there is favorite");
      getAllData();
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
   // print('loading page ${pageNum}');
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
       // print(favourites.toString());
        emit(LoadMoreSuccessState());
      } else if (productsModel.total ==
          productsModel.result.allProducts.length) {
        emit(LoadMoreEndState());
      }
    //  print(value.data["result"]["all_products"]);
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
      //  print("Get Fovrite Success State");
     //   print(value.data);
      } else if (value.data["status"] == false) {
        emit(GetFavouritesErrorState());
      }
    }).catchError((error) {
      emit(GetFavouritesErrorState());
      print(error.toString());
    });
  }

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
    //  print(value.data);
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


Future<String>getconstructionLink()async{
  String url="";
 await DioHelper.getData(url:  "api/construction_link").then((value) {
url=value.data["data"][0];
  });
 return url;
}
  void getProductDetails({int productId}) {
    emit(GetProductDetailsLoadingState());
    print( CacheHelper.getData("token"));//product_id=$productId&lang=${ CacheHelper.getData("lan") }
    Mhelper.getData( UrlPath:  'api/productDetails?',token: CacheHelper.getData("token")
    //     , data: {
    //   "key": 1234567890,
    //   "lang": CacheHelper.getData("lan"),
    //   "token_id": CacheHelper.getData("token"),
    //   "prod_id": productId
    // }
    ,  query: {

      "product_id":productId
        }
    ).then((value) {
print(value.realUri);
print(value.statusCode);
print("dddddddddddddd   ${value.data}");
productDetailsModel = MYProductDetailsModel.fromJson(value.data);
print("4444   ${productDetailsModel}");
      // if (value.data["status"] == true) {
      //
      //
     emit(GetProductDetailsSuccessState());
      // } else
      //   emit(GetProductDetailsErrorState());
    }).catchError((error) {
      print(error.toString());
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
      // "img1": image1 != null
      //     ? await MultipartFile.fromFile(image1.path,
      //         filename: image1.path.split('/').last)
      //     : null,
      // "img2": image2 != null
      //     ? await MultipartFile.fromFile(image2.path,
      //         filename: image2.path.split('/').last)
      //     : null,
      // "img3": image3 != null
      //     ? await MultipartFile.fromFile(image3.path,
      //         filename: image3.path.split('/').last)
      //     : null,
    }).then((value) {
     // print(value.data);
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
   //   print(value.data);
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
    DioHelper.getData(url: getallnotifications+CacheHelper.getData('id').toString() ).then((value) {

      if (value.data["status"] == true) {
        notificationsListModel = NotificationsListModel.fromJson(value.data);
       // print(notificationsListModel.toJson());
        emit(GetAllNotificationsSuccessState());
      } else
        emit(GetAllNotificationsErrorState());
    }).catchError((error) {
      emit(GetAllNotificationsErrorState());
      print(error);
    });
  }
  void delAllNotifications() {
    emit(GetAllNotificationsLoadingState());
    DioHelper.postData(url: dellallnotifications ,data: {
      "client_id":CacheHelper.getData('id'),
    }).then((value) {
    //  print(value.data);
      if (value.data["status"] == true) {
        getAllNotifications();
       // emit(GetAllNotificationsSuccessState());
      } else
        emit(GetAllNotificationsErrorState());
    }).catchError((error) {
      emit(GetAllNotificationsErrorState());
      print(error);
    });
  }
  void deloneNotifications(id) {
    emit(GetAllNotificationsLoadingState());
    DioHelper.postData(url: getonenotifications+id.toString() ,data: {
      "id":id,
    }).then((value) {
     // print(value.data);
      if (value.data["status"] == true) {
        getAllNotifications();
     //   emit(GetAllNotificationsSuccessState());
      } else
        emit(GetAllNotificationsErrorState());
    }).catchError((error) {
      emit(GetAllNotificationsErrorState());
      print(error);
    });
  }



  void AddToCart({product_id,quantity}) {
    emit(AddToCartLoadingState());
    Mhelper.postData(url: AddToCartURL ,data: {
      "product_id":product_id,
      "quantity":quantity
    },token: CacheHelper.getData("token") ).then((value) {
     // print(value.data);
      if (value.data["status"] == true) {
        getAllNotifications();
        // emit(GetAllNotificationsSuccessState());
      } else
        emit(AddToCartSuccessState());
    }).catchError((error) {
      emit(AddToCartErrorState());
      print(error);
    });
  }


  void fetchData() async {
    //Mostafa
    gethomeMainBanners();
          //getHomeData();
     gethomeMainOfferData();
        //mostafa
    getCache();
    getHomeScreen();
                       //  getAllNotifications();
                      // getFavouritesProducts();
                     // getCartData();
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
