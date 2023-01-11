import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safsofa/cubits/appCubit/app_states.dart';
import 'package:safsofa/models/cart_models/cart_local_model/cart_local_model.dart';
import 'package:safsofa/models/construction_link_model.dart';
import 'package:safsofa/models/departments_model.dart';
import 'package:safsofa/models/favourites_products_model.dart';
import 'package:safsofa/models/homeModel/main_cat_model.dart';
import 'package:safsofa/models/homeModel/main_home_banner.dart';
import 'package:safsofa/models/notifications_list_model.dart';
import 'package:safsofa/models/offer_model.dart';
import 'package:safsofa/models/product_reviews_model.dart';
import 'package:safsofa/models/products_model.dart';
import 'package:safsofa/models/register_success_model.dart';
import 'package:safsofa/models/user_profile_data_model.dart';
import 'package:safsofa/network/local/cache_helper.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/screens/bottom_navigation_screens/cart_screen.dart';
import 'package:safsofa/screens/bottom_navigation_screens/home_screen.dart';
import 'package:safsofa/screens/bottom_navigation_screens/menu_screen.dart';
import 'package:safsofa/screens/bottom_navigation_screens/my_account_screen.dart';
import 'package:safsofa/screens/favourites_screen.dart';

import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';

import '../../models/my_products_details_model.dart';
import 'package:easy_localization/easy_localization.dart';
import '../cartCubit/cart_cubit.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    HomeScreen(),
    FavouritesScreen(), // StoresScreen(), // OffersScreen(), // ChatsScreen(),
    CartScreen(),
    MyAccountScreen(),
    MenuScreen(),
  ];

  int selectedIndex = 0;
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

  RegisterSuccessModel userInfo;

  void getCache() {
    if (CacheHelper.getData('userInfo') != null) {
      log("sa");
      userInfo = RegisterSuccessModel.fromJson(
          jsonDecode(CacheHelper.getData('userInfo')));
    } else {
      log("-" * 10);
    }
  }

  UserProfileDataModel myAccountData;
  void getUserAccountData({bool loading = true}) {
    if (loading) {
      emit(GetAccountDataLoadingState());
    }

    Mhelper.getData(
        url: userProfileDataURL,
        token: kToken,
        query: {'lang': kLanguage}).then((value) {
      myAccountData = UserProfileDataModel.fromJson(value.data);
      log(value.data.toString());
      emit(GetAccountDataSuccessState());
    }).catchError((error) {
      log('Error on loading account data:: ${error.toString()}');
      emit(GetAccountDataErrorState());
    });
  }

  // YoutubePlayerController videoController;
  ConstructionLinkModel constructionLink = ConstructionLinkModel();
  void getConstructionData() {
    emit(GetConstructionLoadingState());
    Mhelper.getData(url: '/api/construction_link', query: {
      'lang': kLanguage,
    }).then((value) {
      constructionLink = ConstructionLinkModel.fromJson(value.data);
      // videoController = YoutubePlayerController(
      //   initialVideoId: constructionLink.data.videoLink,
      //   flags: YoutubePlayerFlags(
      //     autoPlay: false,
      //     loop: true,
      //     hideThumbnail: true,
      //     mute: true,
      //   ),
      // );

      emit(GetConstructionSuccessState());
    }).then((error) {
      emit(GetConstructionErrorState());
    });
  }

  void updateFavorite({@required int prodId}) {
    log('inside is favorite of sub_cat_cubit');
    Mhelper.postData(
        url: 'api/FavProduct',
        data: {"product_id": prodId},
        token: kToken,
        query: {'lang': kLanguage}).then((value) {
      log(value.data.toString());
      if (value.data['status']) {
        for (int i = 0; i < constructionLink.data.productList.length; i++) {
          if (constructionLink.data.productList[i].id == prodId) {
            if (constructionLink.data.productList[i].hasFavorites == 0) {
              constructionLink.data.productList[i].hasFavorites = 1;
              emit(GetConstructionSuccessState());
              break;
            } else {
              constructionLink.data.productList[i].hasFavorites = 0;
              emit(GetConstructionSuccessState());
              break;
            }
          }
        }
      }
    });
  }

  MyProductsDetailsModel productDetailsModel;
  void getProductDetails({int productId}) {
    emit(GetProductDetailsLoadingState());
    log(CacheHelper.getData("token")
        .toString()); //product_id=$productId&lang=${ CacheHelper.getData("lan") }
    Mhelper.getData(
        url: 'api/productDetails',
        token: CacheHelper.getData("token"),
        query: {"product_id": productId, 'lang': kLanguage}).then((value) {
      log(value.realUri.toString());
      log(value.statusCode.toString());
      log("dddddddddddddd   ${value.data}");
      productDetailsModel = MyProductsDetailsModel.fromJson(value.data);
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

  void updateProductDetailsFavorite({@required int prodId}) {
    log('inside is favorite of updateProductDetailsFavorite');
    Mhelper.postData(
        url: 'api/FavProduct',
        data: {"product_id": prodId},
        token: kToken,
        query: {'lang': kLanguage}).then((value) {
      log(value.data.toString());
      if (value.data['status']) {
        if (productDetailsModel.data.productDetails[0].hasFavorites == 0) {
          productDetailsModel.data.productDetails[0].hasFavorites = 1;
          emit(GetProductDetailsSuccessState());
        } else {
          productDetailsModel.data.productDetails[0].hasFavorites = 0;
          emit(GetProductDetailsSuccessState());
        }
      }
    });
  }

  void updateRelatedProductsFavorite({@required int prodId}) {
    log('inside is favorite of updateProductDetailsFavorite');
    Mhelper.postData(
        url: 'api/FavProduct',
        data: {"product_id": prodId},
        token: kToken,
        query: {'lang': kLanguage}).then((value) {
      log(value.data.toString());
      if (value.data['status']) {
        for (int i = 0;
            i < productDetailsModel.data.relatedProducts.length;
            i++) {
          if (productDetailsModel.data.relatedProducts[i].id == prodId) {
            if (productDetailsModel.data.relatedProducts[i].hasFavorites == 0) {
              productDetailsModel.data.relatedProducts[i].hasFavorites = 1;
              emit(GetProductDetailsSuccessState());
              break;
            } else {
              productDetailsModel.data.relatedProducts[i].hasFavorites = 0;
              emit(GetProductDetailsSuccessState());
              break;
            }
          }
        }
      }
    });
  }

  /// Get Home Main Category Data
  HomeScreenMainCatModel homeScreenMainCatModel;
  List<Data> homeMainCatList;

  /// Get Home Main banner Data
  HomeScreenMainCatBannerModel homeScreenMainCatBannerModel;
  List<DataBanner> homeBannersList;

  void gethomeMainBanners() {
    emit(HomeMainCatLoading());
    Mhelper.getData(url: homeMainBannerEndPoint).then((value) {
      homeScreenMainCatBannerModel =
          HomeScreenMainCatBannerModel.fromJson(value.data);
      log(value.data.toString());
      homeBannersList = homeScreenMainCatBannerModel.data;
      log(homeBannersList[0].image.toString());
      emit(HomeMainCatSuccess());
    }).catchError((err) {
      emit(HomeMainCatError());
      log("///Home Err:${err.toString()}");
    });
  }

  /// Get Home Main Offer List Data
  OfferModel offerModel;
  // List<OfferModelData> offerDataList;

  void gethomeMainOfferData() {
    emit(HomeMainCatLoading());
    Mhelper.getData(url: offersEndpoint).then((value) {
      offerModel = OfferModel.fromJson(value.data);
      log(value.data.toString());
      // offerDataList = offerModel.data;
      log(homeBannersList[0].image.toString());
      emit(HomeMainCatSuccess());
    }).catchError((err) {
      emit(HomeMainCatError());
      log("///Home Err:${err.toString()}");
    });
  }

  HomeScreenMainCatModel homeScreenModel;

  void getHomeScreen() {
    emit(GetHomeScreenLoadingState());
    Mhelper.getData(
      url:
          'https://taqiviolet.com/api/categories?store_id=34&lang=${kLanguage}',
    ).then((value) {
      log("the data of ${value.data}");
      homeScreenMainCatModel = HomeScreenMainCatModel.fromJson(value.data);
      homeMainCatList = homeScreenMainCatModel.data;
      log("000000000000000000000000000000000000000000000000");
      emit(GetHomeScreenSuccessState());
    }).catchError((error) {
      emit(GetHomeScreenErrorState());
      log("8888888888888888888888888888888888888888888888888888888888    $error");
      log(error.toString());
    });
  }

  int currentDepIndex = 0;
  DepartmentsModel departmentsModel;

  void getAllDepartments({int catId, int pageNumber = 0}) {
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
          catId: departmentsModel.result.allDepartments[currentDepIndex].catId,
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
  ProductsModel productsModel;

  void getProducts({int catId}) {
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
      log(error.toString());
    });
  }

  ProductsModel moreProducts;
  int pageNum = 0;

  void fetchMore({int catId}) {
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
      log('there is error');
      log(e.toString());
    });
  }

  FavouritesProductsModel favouritesModel;

  void getFavouritesProducts() {
    emit(GetFavouritesLoadingState());
    Mhelper.postData(url: 'user_api/get_all_myfavorite', data: {
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
      log(error.toString());
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

  ProductReviewsModel productReviewsModel;

  void getProductReviews({int productId}) {
    emit(GetProductReviewsLoadingState());
    Mhelper.postData(url: 'user_api/get_all_rate', data: {
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
      log(error.toString());
    });
  }

  NotificationsListModel notificationsListModel;

  void getAllNotifications() {
    emit(GetAllNotificationsLoadingState());
    Mhelper.getData(
            url: getallnotifications + CacheHelper.getData('id').toString())
        .then((value) {
      if (value.data["status"] == true) {
        notificationsListModel = NotificationsListModel.fromJson(value.data);
        // print(notificationsListModel.toJson());
        emit(GetAllNotificationsSuccessState());
      } else
        emit(GetAllNotificationsErrorState());
    }).catchError((error) {
      emit(GetAllNotificationsErrorState());
      log(error.toString());
    });
  }

  void delAllNotifications() {
    emit(GetAllNotificationsLoadingState());
    Mhelper.postData(url: dellallnotifications, data: {
      "client_id": CacheHelper.getData('id'),
    }).then((value) {
      //  print(value.data);
      if (value.data["status"] == true) {
        getAllNotifications();
        // emit(GetAllNotificationsSuccessState());
      } else
        emit(GetAllNotificationsErrorState());
    }).catchError((error) {
      emit(GetAllNotificationsErrorState());
      log(error.toString());
    });
  }

  void deloneNotifications(id) {
    emit(GetAllNotificationsLoadingState());
    Mhelper.postData(url: getonenotifications + id.toString(), data: {
      "id": id,
    }).then((value) {
      // print(value.data);
      if (value.data["status"] == true) {
        getAllNotifications();
        //   emit(GetAllNotificationsSuccessState());
      } else
        emit(GetAllNotificationsErrorState());
    }).catchError((error) {
      emit(GetAllNotificationsErrorState());
      log(error.toString());
    });
  }

  void addToCartServer(
      {@required product_id,
      @required quantity,
      @required int price,
      @required String featureSize}) {
    log('price====>$price');
    log('features====>$featureSize');
    // emit(AddToCartLoadingState());
    Mhelper.postData(
            url: AddToCartURL,
            data: {
              "product_id": product_id,
              "quantity": quantity,
              "price": "$price",
              "features": featureSize,
            },
            token: CacheHelper.getData("token"))
        .then((value) {
      // print(value.data);
      log('Server Cart data==>${value.data}');
      if (value.data["status"] == true) {
        productDetailsModel.data.productDetails[0].hascart = 1;
        // getAllNotifications();
        // emit(GetAllNotificationsSuccessState());
        // emit(AddToCartSuccessState());
        emit(GetProductDetailsSuccessState());
      }
    }).catchError((error) {
      emit(AddToCartErrorState());
      log(error.toString());
    });
  }

  void addToCartLocal({
    @required bool withSmartFeature,
    @required int quantity,
    @required int price,
    @required int smartPrice,
    @required String productName,
    @required String productImage,
    @required int productId,
    @required int isFav,
  }) {
    // log('${cartProducts == null} && ${cartProducts.cartProducts.length == 0}');
    // log('Before add to cart ${cartProducts.cartProducts.length}');
    if (cartProducts == null /*&& cartProducts.cartProducts.length == 0*/) {
      cartProducts = CartLocalModel(cartProducts: []);
      cartProducts.cartProducts.add(CartProducts(
        productName: productName,
        quantity: quantity,
        productImage: productImage,
        withSmartFeature: withSmartFeature,
        smartPrice: smartPrice,
        price: withSmartFeature ? quantity * smartPrice : quantity * price,
        productId: productId,
        isFav: isFav,
      ));
      String localCart = jsonEncode(cartProducts);
      CacheHelper.setData(key: 'localCart', value: localCart);
      // showToast(
      //     text: "theProductHasBeenAddedToTheShoppingCart".tr(),
      //     color: Colors.green);
      log('After add to cart ${cartProducts.cartProducts.length}');
      emit(GetProductDetailsSuccessState());
    } else {
      bool isExist = false;
      for (int i = 0; i < cartProducts.cartProducts.length; i++) {
        if (cartProducts.cartProducts[i].productId == productId) {
          isExist = true;
          break;
        }
      }
      if (isExist) {
        // showToast(
        //     text: "theProductIsAlreadyInTheCart".tr(), color: Colors.black);
        emit(GetProductDetailsSuccessState());
      } else {
        cartProducts.cartProducts.add(CartProducts(
          productName: productName,
          productId: productId,
          productImage: productImage,
          quantity: quantity,
          withSmartFeature: withSmartFeature,
          smartPrice: smartPrice,
          price: withSmartFeature ? quantity * smartPrice : quantity * price,
          isFav: isFav,
        ));
        log('After add to cart [Else statement] ${cartProducts.cartProducts.length}');
        String localCart = jsonEncode(cartProducts);
        CacheHelper.setData(key: 'localCart', value: localCart);
        // showToast(
        //     text: "theProductHasBeenAddedToTheShoppingCart".tr(),
        //     color: Colors.green);
        emit(GetProductDetailsSuccessState());
      }
    }
    cartCount = 0;
    cartProducts.cartProducts.forEach((element) {
      cartCount += element.quantity;
    });
    CacheHelper.setData(key: 'cartCount', value: cartCount);
    cartCountControlller.add(cartCount);
  }

  delITemFromCartLocally({int product_id}) {
    log('$product_id');
    log("0000000000000000000000000000");
    Map<String, dynamic> json = jsonDecode(CacheHelper.getData('localCart'));
    cartProducts = CartLocalModel.fromJson(json);
    for (int i = 0; i < cartProducts.cartProducts.length; i++) {
      if (cartProducts.cartProducts[i].productId == product_id) {
        cartProducts.cartProducts.removeAt(i);
        break;
      }
    }
    cartCount = 0;
    cartProducts.cartProducts.forEach((element) {
      cartCount += element.quantity;
    });
    cartCountControlller.add(cartCount);
    CacheHelper.setData(key: 'cartCount', value: cartCount);
    String localCart = jsonEncode(cartProducts);
    CacheHelper.setData(key: 'localCart', value: localCart);
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
        productDetailsModel.data.productDetails[0].hascart = 0;
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

  File file1;

  File file2;

  File file3;

  Future<XFile> pickImage(file) async {
    final ImagePicker _picker = ImagePicker();
    file = await _picker.pickImage(source: ImageSource.gallery);
    log('${file.path}');
    emit(PickImageSuccessState());
    return file;
  }

  var lat, long, address;
}
