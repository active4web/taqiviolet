import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safsofa/cubits/appCubit/app_states.dart';
import 'package:safsofa/models/cart_models/cart_local_model/cart_local_model.dart';
import 'package:safsofa/models/construction_link_model.dart';
import 'package:safsofa/models/departments_model.dart';
import 'package:safsofa/models/empty_image_model.dart';
import 'package:safsofa/models/favorites_lists_model.dart';
import 'package:safsofa/models/homeModel/main_cat_model.dart' as homeMainCat;
import 'package:safsofa/models/homeModel/main_home_banner.dart';
import 'package:safsofa/models/notifications_list_model.dart';
import 'package:safsofa/models/offer_model.dart';
import 'package:safsofa/models/offers_model.dart';
import 'package:safsofa/models/products_model.dart';
import 'package:safsofa/models/recommended_product_model.dart';
import 'package:safsofa/models/register_success_model.dart';
import 'package:safsofa/models/services_model/services_model.dart';
import 'package:safsofa/models/user_profile_data_model.dart';
import 'package:safsofa/network/local/cache_helper.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/screens/bottom_navigation_screens/cart_screen.dart';
import 'package:safsofa/screens/bottom_navigation_screens/home_screen.dart';
import 'package:safsofa/screens/bottom_navigation_screens/menu_screen.dart';
import 'package:safsofa/screens/bottom_navigation_screens/my_account_screen.dart';
import 'package:safsofa/screens/mylist_screen.dart';
import 'package:safsofa/screens/home_layout.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';

import '../../models/my_products_details_model.dart';
import '../cartCubit/cart_cubit.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);



  List<String>featuresImages=[

    'assets/images/ourFeature4.png',
    'assets/images/ourFeature3.png',
    'assets/images/ourFeature2.png',
    'assets/images/ourFutures1.png',
  ];
  List<String>featuresTitles=[
    '24/24 خدمه عملاء',
    'دفع امن',
    'شحن مجاني',
    '3 يوم استرداد',
  ];
  List<String>featuresSubTitles=[
    'دعم متخصص',
    'آمن ومضمون 100%',
    'للطلبات اكثر من 5000 ريال',
    'يمكنك الاستردار 3 أيام من الشراء',
  ];

  OffersModel? offer;
  Future<void>getOffers()async{
    emit(CheckOfferLoadingState());
    final response=await Mhelper.getData(url: 'api/checkoffer');
    if(response.data['status']){
      offer=OffersModel.fromJson(response.data);
      print("hhhhhhhhhhhhhhhhhh ${offer?.data?.promoCodeName??''}");
      emit(CheckOfferSuccessState());

    }else{
      emit(CheckOfferErrorState());
    }
  }
  ServicesModel? servicesModel;
Future<void>getHomeServices()async{
  emit(GetHomeServicesLoadingState());
  final response=await Mhelper.getData(url: 'api/details-services',query: {
    'lang':kLanguage
  });
  if(response.data['status']){
    servicesModel=ServicesModel.fromJson(response.data);
    emit(GetHomeServicesSuccessState());
  }else{
  emit(GetHomeServicesErrorState());
  }
}



  List<Widget> screens = [
  HomeScreen(),
    MyListScreen(), // StoresScreen(), // OffersScreen(), // ChatsScreen(),
    CartScreen(),
    MyAccountScreen(),
    MenuScreen(),
  ];

  int? selectedIndex = 0;

  addtolist(product_id) {
    Mhelper.postData(url: "/api/addToRoster", data: {"product_id": product_id});
  }

  void changeNavBar(int value, context) {
    selectedIndex = value;
    if (value == 2) {
      log("get myyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
      CartCubit.get(context).getLocalCartData();
    }
    emit(BottomNavState());
  }

  RegisterSuccessModel? userInfo;

  void getCache() {
    if (CacheHelper.getData('userInfo') != null) {
      log("sa");
      userInfo = RegisterSuccessModel.fromJson(
          jsonDecode(CacheHelper.getData('userInfo')));
    } else {
      log("-" * 10);
    }
  }

//////////////////////////////USER ACCOUNT DATA SCREEN LOGIC///////////////////////////////
  UserProfileDataModel? myAccountData;

  void getUserAccountData({bool loading = true}) {
    if (loading) {
      emit(GetAccountDataLoadingState());
    }
    print('555555555551111');
    Mhelper.getData(
        url: userProfileDataURL,
        token: kToken,
        query: {'lang': kLanguage}).then((value) {
      log('55555555555 ${value.data['lastOrder']}');
      log('55555555555 ${myAccountData?.data?.lastOrder}');

      myAccountData = UserProfileDataModel.fromJson(value.data);
      print(myAccountData?.data?.bonus);
      print("mostafa");
/*      print(myAccountData?.data?.myOrder);
      print("LastOrder ${myAccountData?.data?.lastOrder?.createdAt.toString().substring(0,11)}");*/
      // print(myAccountData?.data?.userProfile);
      print('55555555555');
      emit(GetAccountDataSuccessState());
    }).catchError((error) {
      log('Error on loading account data:: ${error.toString()}');
      emit(GetAccountDataErrorState(error.toString()));
    });
  }

  void deleteUserAccount({required BuildContext context}) {
    Mhelper.postData(url: deleteAccountURL, token: kToken, data: {
      'token': kToken,
    }, query: {
      'lang': kLanguage
    }).then((value) {
      log(value.data.toString());
      if (value.data['status']) {
        CacheHelper.removeData('userInfo');
        CacheHelper.removeData('token');
        CacheHelper.removeData('id');
        kToken = '';
        CacheHelper.removeData('localCart');
        CacheHelper.removeData('cartCount');
        showToast(
            text: "yourAccountHasBeenDeletedSuccessfully".tr(),
            color: Colors.green,
            location: ToastGravity.CENTER);
        emit(DeleteAccountDataSuccessState());
        navigateAndFinish(context, HomeLayout());
      } else {
        showToast(
            text: "somethingWentWrong".tr(),
            color: Colors.red,
            location: ToastGravity.CENTER);
      }
    }).catchError((error) {
      log('Error on deleting account :: ${error.toString()}');
      emit(DeleteAccountDataErrorState(error.toString()));
    });
  }

  void removeFavoriteSuugestion({required int prodId, required int index}) {
    log('inside is favorite of sub_cat_cubit');
    Mhelper.postData(
        url: 'api/FavProduct',
        data: {"product_id": prodId},
        token: kToken,
        query: {'lang': kLanguage}).then((value) {
      log(value.data.toString());
      if (value.data['status']) {
        myAccountData?.data?.suggestion![index].hasFavorites = 0;
        emit(GetAccountDataSuccessState());
      }
    });
  }

  FavoritesListsModel? favListModelOfSuggestion;

  void getFavListDataSuggestion() {
    emit(GetFavoritesListLoading());
    Mhelper.getData(
      url: 'api/favlist',
      token: kToken,
      query: {
        'lang': kLanguage,
      },
    ).then((value) {
      favListModelOfSuggestion = FavoritesListsModel.fromJson(value.data);
      log(value.data.toString());
      emit(GetFavoritesListSuccess());
    }).catchError((error) {
      log('Error on loading fav list>>${error.toString()}');
      emit(GetFavoritesListError(error.toString()));
    });
  }

  void addFavProductToFavListSuggestion(
      {required int listId,
      required int productId,
      required int index,
      required BuildContext context}) {
    Mhelper.postData(
        url: '/api/FavProduct',
        data: {
          'list_id': '$listId',
          'product_id': '$productId',
        },
        token: kToken,
        query: {
          'lang': kLanguage,
        }).then((value) {
      log(value.data.toString());
      if (value.data['status']) {
        myAccountData?.data?.suggestion![index].hasFavorites = 1;
        emit(addFavoritesListSuccess());
        Navigator.pop(context);
      } else {
        showToast(text: "somethingWentWrong".tr(), color: Colors.red);
      }
    });
  }

  void createNewFavListSuggestion(
      {required String listName,
      required BuildContext context,
      int? productId,
      required int index}) {
    Mhelper.postData(
      url: 'api/addfavlist',
      data: {
        'name': listName,
        if (productId != null) 'prod_id': '$productId',
      },
      token: kToken,
      query: {'lang': kLanguage},
    ).then((value) {
      log('Crating new list data: ${value.data}');
      if (value.data['status']) {
        myAccountData?.data?.suggestion![index].hasFavorites = 1;
        emit(createNewFavoritesListSuccess());
        Navigator.of(context).pop();
      } else {
        showToast(text: value.data['msg'], color: Colors.red);
      }
    });
  }

//////////////////////////////USER ACCOUNT DATA SCREEN LOGIC///////////////////////////////
  // YoutubePlayerController videoController;
  ConstructionLinkModel? constructionLink = ConstructionLinkModel();

  Future<void> getConstructionData() async{
    emit(GetConstructionLoadingState());
    final response=await Mhelper.getData(url: 'api/construction_link', token: kToken, query: {
      'lang': kLanguage,
    });
    if(response.data['status']){
      constructionLink = ConstructionLinkModel.fromJson(response.data);
      print(response.data);
      emit(GetConstructionSuccessState());
    }else{
      print(response.data);
      emit(GetConstructionErrorState());
    }
    // .then((value) {
    //   constructionLink = ConstructionLinkModel.fromJson(value.data);
    //   emit(GetConstructionSuccessState());
    // }).then((error) {
    //
    //   print("errorrrrrrششششششششششش: ${error.toString()}");
    //   emit(GetConstructionErrorState());
    // });
  }

  void removeFavoriteHome({required int prodId, required int index}) {
    log('inside is favorite of sub_cat_cubit');
    Mhelper.postData(
        url: 'api/FavProduct',
        data: {"product_id": prodId},
        token: kToken,
        query: {'lang': kLanguage}).then((value) {
      log(value.data.toString());
      if (value.data['status']) {
        constructionLink?.data?.productList![index].hasFavorites = 0;
        emit(removeFavoriteHomeSuccess());
      }
    });
  }

  FavoritesListsModel? favListModelOfHome;

  void getFavListDataOfHome() {
    emit(GetFavoritesListLoading());
    Mhelper.getData(
      url: 'api/favlist',
      token: kToken,
      query: {
        'lang': kLanguage,
      },
    ).then((value) {
      favListModelOfHome = FavoritesListsModel.fromJson(value.data);
      log(value.data.toString());
      emit(GetConstructionSuccessState());
    }).catchError((error) {
      log('Error on loading fav list>>${error.toString()}');
      emit(GetConstructionSuccessState());
    });
  }

  void addFavProductToFavListHome(
      {required int listId,
      required int productId,
      required int index,
      required BuildContext context}) {
    Mhelper.postData(
        url: '/api/FavProduct',
        data: {
          'list_id': '$listId',
          'product_id': '$productId',
        },
        token: kToken,
        query: {
          'lang': kLanguage,
        }).then((value) {
      log(value.data.toString());
      if (value.data['status']) {
        constructionLink?.data?.productList![index].hasFavorites = 1;
        emit(GetConstructionSuccessState());
        Navigator.pop(context);
      } else {
        showToast(text: "somethingWentWrong".tr(), color: Colors.red);
      }
    });
  }

  void createNewFavListHome(
      {required String listName,
      required BuildContext context,
      int? productId,
      required int index}) {
    Mhelper.postData(
      url: 'api/addfavlist',
      data: {
        'name': listName,
        if (productId != null) 'prod_id': '$productId',
      },
      token: kToken,
      query: {'lang': kLanguage},
    ).then((value) {
      log('Crating new list data: ${value.data}');
      if (value.data['status']) {
        constructionLink?.data?.productList![index].hasFavorites = 1;
        emit(GetConstructionSuccessState());
        Navigator.of(context).pop();
      } else {
        showToast(text: value.data['msg'], color: Colors.red);
      }
    });
  }

  ///////////////////////////////////////PRODUCT DETAILS SECTION//////////////////////////////////////////
  MyProductsDetailsModel? productDetailsModel;
  List<dynamic>?images;
  void getProductDetails({int? productId}) {
    emit(GetProductDetailsLoadingState());
    log(CacheHelper.getData("token")
        .toString()); //product_id=$productId&lang=${ CacheHelper.getData("lan") }
    Mhelper.getData(
        url: 'api/productDetails',
        token: CacheHelper.getData("token"),
        query: {"product_id": productId, 'lang': kLanguage}).then((value) {

      productDetailsModel = MyProductsDetailsModel.fromJson(value.data);
      images=productDetailsModel?.data?.productDetails?[0].images;
      // print("4444   ${productDetailsModel}");
      // if (value.data["status"] == true) {
      //
      //
      emit(GetProductDetailsSuccessState());
      // } else
      //   emit(GetProductDetailsErrorState());
    }).catchError((error) {
      log(error.toString());
      emit(GetProductDetailsErrorState());
    });
  }

  void removeProductDetailsFavorite({
    int? prodId,
  }) {
    log('inside is favorite of updateProductDetailsFavorite');
    Mhelper.postData(
        url: 'api/FavProduct',
        data: {"product_id": prodId},
        token: kToken,
        query: {'lang': kLanguage}).then((value) {
      log(value.data.toString());
      if (value.data['status']) {
        productDetailsModel?.data?.productDetails![0].hasFavorites = 0;
        emit(GetProductDetailsSuccessState());
      }
    });
  }

  void removeRelatedProductsFavorite({required int prodId}) {
    log('inside is favorite of updateProductDetailsFavorite');
    Mhelper.postData(
        url: 'api/FavProduct',
        data: {"product_id": prodId},
        token: kToken,
        query: {'lang': kLanguage}).then((value) {
      log(value.data.toString());
      if (value.data['status']) {
        for (int i = 0;
            i < productDetailsModel!.data!.relatedProducts!.length;
            i++) {
          if (productDetailsModel!.data!.relatedProducts![i].id == prodId) {
            productDetailsModel?.data?.relatedProducts![i].hasFavorites = 0;
            emit(GetProductDetailsSuccessState());
            break;
          }
        }
      }
    });
  }

  // هنا بنتجيب كل قوائم المفضلة
  FavoritesListsModel? favListModelOfProdDetails;

  void getFavListDataOfProdDetails() {
    emit(GetFavoritesListLoading());
    Mhelper.getData(
      url: 'api/favlist',
      token: kToken,
      query: {
        'lang': kLanguage,
      },
    ).then((value) {
      favListModelOfProdDetails = FavoritesListsModel.fromJson(value.data);
      log(value.data.toString());
      emit(GetProductDetailsSuccessState());
    }).catchError((error) {
      log('Error on loading fav list>>${error.toString()}');
      emit(GetProductDetailsSuccessState());
    });
  }

  void addFavProductToFavListProdDetails(
      {int? listId, int? productId, required BuildContext context}) {
    Mhelper.postData(
        url: '/api/FavProduct',
        data: {
          'list_id': '$listId',
          'product_id': '$productId',
        },
        token: kToken,
        query: {
          'lang': kLanguage,
        }).then((value) {
      log(value.data.toString());
      if (value.data['status']) {
        productDetailsModel?.data?.productDetails![0].hasFavorites = 1;
        emit(GetProductDetailsSuccessState());
        Navigator.pop(context);
      } else {
        showToast(text: "somethingWentWrong".tr(), color: Colors.red);
      }
    });
  }

  void createNewFavListProdDetails({
    required String listName,
    required BuildContext context,
    int? productId,
  }) {
    Mhelper.postData(
      url: 'api/addfavlist',
      data: {
        'name': listName,
        if (productId != null) 'prod_id': '$productId',
      },
      token: kToken,
      query: {'lang': kLanguage},
    ).then((value) {
      log('Crating new list data: ${value.data}');
      if (value.data['status']) {
        productDetailsModel?.data?.productDetails![0].hasFavorites = 1;
        emit(GetConstructionSuccessState());
      } else {
        showToast(text: value.data['msg'], color: Colors.red);
      }
    });
  }

///////////////////////////////////////////////END PRODUCT DETAILS SECTION////////////////////////////////////////

  /// Get Home Main Category Data
  homeMainCat.HomeScreenMainCatModel? homeScreenMainCatModel;
  List<homeMainCat.Data>? homeMainCatList;

  /// Get Home Main banner Data
  HomeScreenMainCatBannerModel? homeScreenMainCatBannerModel;
  List<DataBanner>? homeBannersList;

  void gethomeMainBanners() {
    emit(HomeMainCatLoading());
    Mhelper.getData(url: homeMainBannerEndPoint).then((value) {
      homeScreenMainCatBannerModel =
          HomeScreenMainCatBannerModel.fromJson(value.data);
      homeBannersList = homeScreenMainCatBannerModel?.data;
      emit(HomeMainCatSuccess());
    }).catchError((err) {
      emit(HomeMainCatError());
      log("///Home Err:${err.toString()}");
    });
  }

  /// Get Home Main Offer List Data
  OfferModel? offerModel;

  // List<OfferModelData> offerDataList;

  void gethomeMainOfferData() {
    emit(HomeMainCatLoading());
    Mhelper.getData(url: offersEndpoint).then((value) {
      offerModel = OfferModel.fromJson(value.data);
      // offerDataList = offerModel.data;
      emit(HomeMainCatSuccess());
    }).catchError((err) {
      emit(HomeMainCatError());
    });
  }

  homeMainCat.HomeScreenMainCatModel? homeScreenModel;

  void getHomeScreen() {
    emit(GetHomeScreenLoadingState());
    Mhelper.getData(
      url:
          'https://taqi.axistrading.com.sa/api/categories?store_id=34&lang=${kLanguage}',
    ).then((value) {
      log("the data of ${value.data}");
      homeScreenMainCatModel =
          homeMainCat.HomeScreenMainCatModel.fromJson(value.data);
      homeMainCatList = homeScreenMainCatModel?.data;
      emit(GetHomeScreenSuccessState());
    }).catchError((error) {
      emit(GetHomeScreenErrorState());
      log(error.toString());
    });
  }

  int currentDepIndex = 0;
  DepartmentsModel? departmentsModel;

  void getAllDepartments({int? catId, int pageNumber = 0}) {
    emit(GetDepartmentsLoadingState());
    Mhelper.postData(url: 'user_api/get_all_departments', data: {
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
          catId: (departmentsModel
              ?.result?.allDepartments![currentDepIndex].catId)!,
        );
      } else
        emit(GetDepartmentsErrorState());
    }).catchError((error) {
      emit(GetDepartmentsErrorState());
      log(error.toString());
    });
  }

  getCartData() {
    log("getDatagetDatagetDatagetData");
    // emit(CartLoadingState());
    Mhelper.getData(url: myCartURL, token: CacheHelper.getData("token"))
        .then((value) {
      //  print(value.data);
      //  emit(CartStateSuccessState());
    }).catchError((e) {
      //emit(CartStateErrorState());
    });
  }

  void getAllData() {
    Mhelper.postData(url: 'user_api/get_all_product', data: {
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
  ProductsModel? productsModel;

  void getProducts({int? catId}) {
    emit(GetProductsLoadingState());
    Mhelper.postData(
        url: 'user_api/get_all_product',
        data: {
          "key": 1234567890,
          "lang": kLanguage,
          "token_id": kToken,
          "cat_id": catId,
          "limit": 10,
          "page_number": 0
        },
        token: kToken,
        query: {
          'lang': kLanguage,
        }).then((value) {
      productsModel = ProductsModel.fromJson(value.data);
      productsModel?.result?.allProducts?.forEach((element) {
        favourites.addAll({element.prodId: element.isFav} as Map<int, bool>);
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
      log(error.toString());
    });
  }

  ProductsModel? moreProducts;
  int pageNum = 0;

  void fetchMore({int? catId}) {
    emit(LoadMoreLoadingState());
    pageNum++;
    // print('loading page ${pageNum}');
    Mhelper.postData(url: 'user_api/get_all_product', data: {
      "key": 1234567890,
      "lang": kLanguage,
      "token_id": kToken,
      "cat_id": catId,
      "limit": 10,
      "page_number": pageNum
    }).then((value) {
      if (productsModel!.total! > productsModel!.result!.allProducts!.length) {
        moreProducts = ProductsModel.fromJson(value.data);
        productsModel?.result?.allProducts
            ?.addAll(moreProducts?.result?.allProducts as Iterable<AllProduct>);
        productsModel?.result?.allProducts?.forEach((element) {
          favourites.addAll({element.prodId: element.isFav} as Map<int, bool>);
        });
        // print(favourites.toString());
        emit(LoadMoreSuccessState());
      } else if (productsModel?.total ==
          productsModel!.result?.allProducts!.length) {
        emit(LoadMoreEndState());
      }
      //  print(value.data["result"]["all_products"]);
    }).catchError((e) {
      emit(LoadMoreErrorState());
      log('there is error');
      log(e.toString());
    });
  }

  // FavouritesProductsModel favouritesModel;

  // void getFavouritesProducts() {
  //   emit(GetFavouritesLoadingState());
  //   Mhelper.postData(url: 'user_api/get_all_myfavorite', data: {
  //     "key": 1234567890,
  //     "lang": kLanguage,
  //     "token_id": kToken,
  //     "limit": 0,
  //     "page_number": 0
  //   }).then((value) {
  //     favouritesModel = FavouritesProductsModel.fromJson(value.data);
  //     favouritesModel.result.allFavourites.forEach((element) {
  //       favourites.addAll({element.prodId: element.isFav});
  //     });

  //     if (value.data["status"] == true) {
  //       emit(GetFavouritesSuccessState());
  //       //  print("Get Fovrite Success State");
  //       //   print(value.data);
  //     } else if (value.data["status"] == false) {
  //       emit(GetFavouritesErrorState());
  //     }
  //   }).catchError((error) {
  //     emit(GetFavouritesErrorState());
  //     log(error.toString());
  //   });
  // }

  Future<void> addReview(
      {int? productId,
      int? rating,
      String? comment,
      File? image1,
      File? image2,
      File? image3}) async {
    emit(AddReviewLoadingState());
    Mhelper.postData(url: 'user_api/add_review', data: {
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
      log(error.toString());
    });
  }

  // ProductReviewsModel? productReviewsModel;
  //
  // void getProductReviews({int? productId}) {
  //   emit(GetProductReviewsLoadingState());
  //   Mhelper.postData(url: 'user_api/get_all_rate', data: {
  //     "key": 1234567890,
  //     "lang": kLanguage,
  //     "token_id": kToken,
  //     "prod_id": productId,
  //     "limit": 0,
  //     "page_number": 0
  //   }).then((value) {
  //     //   print(value.data);
  //     productReviewsModel = ProductReviewsModel.fromJson(value.data);
  //     if (value.data["status"] == true) {
  //       productReviewsModel = ProductReviewsModel.fromJson(value.data);
  //       emit(GetProductReviewsSuccessState());
  //     } else
  //       emit(GetProductReviewsErrorState());
  //   }).catchError((error) {
  //     emit(GetProductReviewsErrorState());
  //     log(error.toString());
  //   });
  // }

  NotificationsListModel? notificationsListModel;

  void getAllNotifications() {
    emit(GetAllNotificationsLoadingState());
    Mhelper.getData(
            url: getallnotifications,token: CacheHelper.getData('token'))
        .then((value) {
      if (value.data["status"] == true) {
        notificationsListModel = NotificationsListModel.fromJson(value.data);
         print(value.data);
        emit(GetAllNotificationsSuccessState());
      } else
        emit(GetAllNotificationsErrorState());
      print(value.data);
    }).catchError((error) {
      print(error);
      emit(GetAllNotificationsErrorState());
      log(error.toString());
    });
  }

  void readAllNotifications() async{
    emit(ReadAllNotificationLoadingState());
   final response=await Mhelper.postData(url: getallnotifications, data: {
    },token: CacheHelper.getData('token'));
   if(response.data['status']){
     getAllNotifications();
     emit(ReadAllNotificationSuccessState());
   }
   else{
     emit(ReadAllNotificationErrorState());
   }
  }

  void readOneNotification(id) async{
    emit(ReadOneNotificationLoadingState());
   final response=await Mhelper.postData(url: getallnotifications + "/$id", data: {
    },token: CacheHelper.getData('token'));
    if(response.data['status']){
      emit(ReadOneNotificationSuccessState());
      getAllNotifications();
    }else{
     emit(ReadOneNotificationErrorState());
    }
  }

  void addToCartServer(
      {required int product_id,
      required int quantity,
      dynamic price,
      required String featureSize,
      dynamic smartPrice,
      dynamic smartType,
      }) {
    log('price====>$price');
    log('features====>$featureSize');
    // emit(AddToCartLoadingState());
    Mhelper.postData(
            url: AddToCartURL,
            data: {
              "product_id": '$product_id',
              "quantity": '$quantity',
              "price": "$price",
              "features": featureSize,
              "smart_price" : smartPrice,
              "smart_type" : smartType,
            },
            token: CacheHelper.getData("token"))
        .then((value) {
      // print(value.data);
      log('Server Cart data==>${value.data}');
      print( productDetailsModel?.data?.productDetails![0].smartPrice);
      log("8   $state"*20);
      if (value.data["status"]) {
        productDetailsModel?.data?.productDetails![0].hascart = 1;
        // getAllNotifications();
        // emit(GetAllNotificationsSuccessState());
        // emit(AddToCartSuccessState());
        emit(AddToCartSuccessState());
        // cartCountControlller.add(int.parse(quantity));
      }
    }).catchError((error) {
      emit(AddToCartErrorState());
      log(error.toString());
    });
  }

  void addToCartLocal({
    required bool withSmartFeature,
    required String feature,
    required int quantity,
    int? price,
  required  dynamic oneProductPrice,
    dynamic smartPrice,
    String? productName,
    String? productImage,
    int? productId,
    int? isFav,
  }) {
    // log('${cartProducts == null} && ${cartProducts.cartProducts.length == 0}');
    // log('Before add to cart ${cartProducts.cartProducts.length}');
    if (cartProducts == null /*&& cartProducts.cartProducts.length == 0*/) {
      cartProducts = CartLocalModel(cartProducts: []);
      cartProducts?.cartProducts?.add(CartProducts(
        productName: productName,
        quantity: quantity,
        productImage: productImage,
        oneProdctPrice: oneProductPrice,
        withSmartFeature: withSmartFeature,
        smartPrice: smartPrice,
        price:smartPrice != null ? withSmartFeature == true? quantity * smartPrice+price! : quantity * price!: quantity * price!,
        onePiecePrice:smartPrice != null ? withSmartFeature== true ? price+smartPrice : price:price,
        productId: productId,
        isFav: isFav,
        features: feature,
      ));

      String localCart = jsonEncode(cartProducts);
      CacheHelper.setData(key: 'localCart', value: localCart);
      // showToast(
      //     text: "theProductHasBeenAddedToTheShoppingCart".tr(),
      //     color: Colors.green);
      log('After add to cart ${cartProducts?.cartProducts!.length}');
      // log('After add to cart ${cartProducts?.cartProducts?[1].smartPrice}');
      emit(GetProductDetailsSuccessState());
    } else {
      bool isExist = false;
      for (int i = 0; i < cartProducts!.cartProducts!.length; i++) {
        if (cartProducts!.cartProducts![i].productId == productId) {
          isExist = true;
          break;
        }
      }
      if (isExist) {
        // showToast(
        //     text: "theProductIsAlreadyInTheCart".tr(), color: Colors.black);
        emit(GetProductDetailsSuccessState());
      } else {
        cartProducts?.cartProducts?.add(CartProducts(
          productName: productName,
          productId: productId,
          productImage: productImage,
          quantity: quantity,
          oneProdctPrice: oneProductPrice,
          withSmartFeature: withSmartFeature,
          smartPrice: smartPrice,
          price:smartPrice != null ?
          withSmartFeature == true ?
          quantity * smartPrice + price! :
          quantity * price! :
          quantity * price!,
          onePiecePrice:smartPrice != null ? withSmartFeature == true ? smartPrice+price : price : price,
          isFav: isFav,
          features: feature,
        ));
        log('After add to cart [Else statement] ${cartProducts?.cartProducts?.length}');
        String localCart = jsonEncode(cartProducts);
        CacheHelper.setData(key: 'localCart', value: localCart);
        // showToast(
        //     text: "theProductHasBeenAddedToTheShoppingCart".tr(),
        //     color: Colors.green);
        emit(GetProductDetailsSuccessState());
      }
    }
    cartCount = 0;
    withSmartFeature = false ;
    cartProducts?.cartProducts?.forEach((element) {
      cartCount += element.quantity!;
    });
    CacheHelper.setData(key: 'cartCount', value: cartCount);
    cartCountControlller.add(cartCount);
  }

  delITemFromCartLocally({required int product_id}) {
    log('$product_id');
    log("0000000000000000000000000000");
    if(cartProducts!.cartProducts!.length == 0){
      CacheHelper.removeData('localCart');
    }else{
      Map<String, dynamic> json = jsonDecode(CacheHelper.getData('localCart'));
      log("0000000000000000000000000000");
      cartProducts = CartLocalModel.fromJson(json);
      log("0000000000000000000000000000");
      for (int i = 0; i < cartProducts!.cartProducts!.length; i++) {
        log("0000000000000000000000000000");
        if (cartProducts?.cartProducts![i].productId == product_id) {
          cartProducts?.cartProducts?.removeAt(i);
          break;
        }
      }
      cartCount = 0;
      cartProducts?.cartProducts?.forEach((element) {
        cartCount += element.quantity!;
      });
      bool? withSmartFeature = false;
      cartProducts?.cartProducts?.forEach((element) {
        withSmartFeature = element.withSmartFeature;
      });
      cartCountControlller.add(cartCount);
      CacheHelper.setData(key: 'cartCount', value: cartCount);
      String localCart = jsonEncode(cartProducts);
      CacheHelper.setData(key: 'localCart', value: localCart);
    }

    emit(GetProductDetailsSuccessState());
  }

  delITemFromCartServer({product_id}) {
    log('Will delete item $product_id');
    print("0000000000000000000000000000");
    Mhelper.postData(
        data: {
          "key": 1234567890,
        },
        url: delItem + "$product_id",
        token: kToken,
        query: {'lang': kLanguage}).then((value) {
      log(value.data.toString());
      if (value.data['status']) {
        productDetailsModel?.data?.productDetails![0].hascart = 0;
        emit(GetProductDetailsSuccessState());
      } else {
        showToast(text: "somethingWentWrong".tr(), color: Colors.red);
      }
    });
  }

  void fetchData() async {
    //Mostafa
    gethomeMainBanners();
    getConstructionData();
    //getHomeData();
    gethomeMainOfferData();
    //mostafa
    getCache();
    getHomeScreen();
    //  getAllNotifications();
    // getFavouritesProducts();
    // getCartData();
  }

  Future<XFile> pickImage(file) async {
    final ImagePicker _picker = ImagePicker();
    file = await _picker.pickImage(source: ImageSource.gallery);
    log('${file.path}');
    emit(PickImageSuccessState());
    return file;
  }

  var lat, long, address;

  EmptyImageModel? emptyImages;
  Future<void>getEmptyImages()async{
    emit(GetImagesLoadingState());
    final response=await Mhelper.getData(url: 'api/new-settings',query: {
      'lang':kLanguage
    });
    if(response.data['status']){
      emptyImages=EmptyImageModel.fromJson(response.data);
      emit(GetImagesSuccessState());
    }else{
      emit(GetImagesErrorState());
    }
  }

  RecommendedProductsModel? recommended;
  Future<void> getRecommendedProducts()async{
    emit(GetRecommendedLoadingState());
    final response=await Mhelper.getData(url: 'api/recommended-products',token: kToken,data: {
      'lang':kLanguage
    });
    if(response.data['status']){
      recommended=RecommendedProductsModel.fromJson(response.data);
      emit(GetRecommendedSuccessState());
    }else{
      emit(GetRecommendedErrorState());
    }
  }
}
