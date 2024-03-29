import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:safsofa/models/cart_models/remote_cart_model/cart_product_prices_model.dart';
import 'package:safsofa/models/cities_location_model.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import '../../models/MakeOrderNewNewNewModel.dart';
import '../../models/cart_models/cart_local_model/cart_local_model.dart';
import '../../models/make_order_model.dart';
import '../../models/my_cart_model.dart';
import '../../network/local/cache_helper.dart';
import '../../screens/success_scr.dart';
import '../../shared/constants.dart';
import '../../shared/defaults.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartStateInitial());

  static CartCubit get(context) => BlocProvider.of(context);

  double total = 0;
  final GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();

  ////////////////////////////////////////////////**HANDLE CART PART FROM SERVER**//////////////////////////////////////////////////////////
  MyCartModel? myCartModel;

  getServerCartData({bool withLoading = true}) {
    if (withLoading) {
      emit(CartLoadingState());
    }
    emit(CartLoadingState());
    total = 0;
    Mhelper.getData(
        url: myCartURL,
        token: CacheHelper.getData("token"),
        query: {
          'lang': kLanguage,
        }).then((value) {
      myCartModel = MyCartModel.fromJson(value.data);
      // log(value.data.toString());
      for (int i = 0; i < myCartModel!.data!.listItem!.length; i++) {
        log("item price ${myCartModel?.data?.listItem![i].id}");
        // if (myCartModel?.data?.listItem![i].smartPrice == null){
                total += (myCartModel?.data?.listItem![i].price) *
              (myCartModel?.data?.listItem![i].quantity).toDouble();
       /* }else {
          total += (myCartModel?.data?.listItem![i].price) *
              (myCartModel?.data?.listItem![i].quantity)
              +
      (double.parse(myCartModel?.data?.listItem![i].smartPrice)) *
      (myCartModel?.data?.listItem![i].quantity);
          print('22222222222222');
        }*/

        print("Bisho ${myCartModel?.data?.listItem![i].price}");
        print("Bisho ${myCartModel?.data?.listItem![i].smartPrice}");
        print("Bisho ${myCartModel?.data?.listItem![i].quantity}");
        print("Bisho ${total}");
 /*       print(double.parse(myCartModel?.data?.listItem![i].smartPrice) *
                (myCartModel?.data?.listItem![i].quantity));*/
     /*   if(myCartModel?.data?.listItem![i].price != 0){
          print('11111111111111');
          total += (myCartModel?.data?.listItem![i].price)! *
              (myCartModel?.data?.listItem![i].quantity)!; +
              (int.parse(myCartModel?.data?.listItem![i].smartPrice!)) *
                  (myCartModel?.data?.listItem![i].quantity)!;
          print('11111111111111');
          print(
              (myCartModel?.data?.listItem![i].smartPrice)! *
                  (myCartModel?.data?.listItem![i].quantity.toString())!
          );
        }else{
          total += (myCartModel?.data?.listItem![i].price)!.toDouble() *
              (myCartModel?.data?.listItem![i].quantity)!;
        }*/
      }
      emit(CartSuccessState());
    }).catchError((e) {
      log(e.toString());
      emit(CartErrorState());
    });
  }

  addquantityServer({
    @required cart_id,
    required int product_quantity,
  }) async {
    emit(CartLoadingState());
    log('${CacheHelper.getData("token")}');
    log('$cart_id');
    log("0000000000000000000000000000");
    Mhelper.postData(
        data: {
          "key": 1234567890,
        },
        url: sumItemCartURL,
        token: CacheHelper.getData("token"),
        query: {
          // "product_id": "$product_id",
          "cart_id": "$cart_id",
          "product_quantity": "$product_quantity",
        }).then((value) {
          print(value.data);
      if (value.data['status']) {
        getServerCartData(withLoading: false);
      } else {
        showToast(text: value.data['msg'], color: Colors.red);
      }
    });
  }

  delItemFromCartServer({required int cartId}) {
    emit(CartLoadingState());
    Mhelper.postData(data: {
      "key": 1234567890,
    }, url: delItem + "$cartId", token: CacheHelper.getData("token"))
        .then((value) {
      if (value.data['status']) {
        getServerCartData(withLoading: false);
      } else {
        showToast(text: "somethingWentWrong".tr(), color: Colors.red);
      }
    });
  }

  emptyCartProductsServer() {
    emit(CartLoadingState());
    Mhelper.postData(
      data: {},
      url: 'api/emptycart',
      token: CacheHelper.getData("token"),
    ).then((value) {
      if (value.data['status']) {
        getServerCartData(withLoading: false);
      } else {
        showToast(text: "somethingWentWrong".tr(), color: Colors.red);
      }
    });
  }

  ////////////////////////////////////////////////**HANDLE CART PART FROM SERVER**//////////////////////////////////////////////////////////
  ///                                          ***********************************************
  ///                                          ***********************************************
//////////////////////////////////////////////**HANDLE CART PART LOCALLY**////////////////////////////////////////////////////////////
  CartLocalModel? myCartlocalModel;
  CartProductsPricesModel? productCartPrices;

  getLocalCartData() {
    emit(CartLoadingState());
    total =0;
    if (CacheHelper.getData('localCart') != null) {
      Map<String, dynamic> json = jsonDecode(CacheHelper.getData('localCart'));
      myCartlocalModel = CartLocalModel.fromJson(json);
      String productIds = '';
      myCartlocalModel?.cartProducts?.forEach((element) {
        productIds += '${element.productId},';
        total+=element.quantity!.toDouble() * element.onePiecePrice;
        print(element.quantity!.toDouble() * element.onePiecePrice);
      });
      Mhelper.getData(url: '/api/productprice', query: {
        'lang': kLanguage,
        'product_id': productIds.substring(0, productIds.length - 1)
      }).then((value) {
        productCartPrices = CartProductsPricesModel.fromJson(value.data);
        print('Bisho0000');
        print("Bisho ${total}");

        // calculateTotalPrice(cartData: (myCartlocalModel!));
        emit(CartSuccessState());
      }).catchError((error) {
        log('Error on getting cart product prices: ${error.toString()}');
        emit(CartErrorState());
      });
    } else {
      myCartlocalModel = CartLocalModel();
      emit(CartSuccessState());
    }
  }

  addquantityLocally(
      {@required product_id,
      required int product_quantity,
      required int index}) {
    log('${CacheHelper.getData("token")}');
    log('$product_id');
    log("0000000000000000000000000000");
    for (int i = 0; i < productCartPrices!.data!.listProducts!.length; i++) {
      if (productCartPrices?.data?.listProducts![i].id == product_id) {
        log('product quantity=$product_quantity <= existing quantity=${int.parse(productCartPrices!.data!.listProducts![i].quantity!)}');

        if (product_quantity <=
            int.parse(productCartPrices!.data!.listProducts![i].quantity!)) {
          myCartlocalModel?.cartProducts![index].quantity = product_quantity;
          print(myCartlocalModel!.cartProducts![index].withSmartFeature!);
          if (myCartlocalModel!.cartProducts![index].withSmartFeature! == true &&
              myCartlocalModel!.cartProducts![index].smartPrice != null ) {
            myCartlocalModel?.cartProducts![index].price =product_quantity *
                productCartPrices!.data!.listProducts![i].currentPrice +
                (productCartPrices!.data!.listProducts![i].smartPrice) * product_quantity;
            print('a66661');
            print(productCartPrices!.data!.listProducts![i].currentPrice +
                productCartPrices!.data!.listProducts![i].smartPrice);
            print(myCartlocalModel!.cartProducts![i].withSmartFeature);
            print(productCartPrices!.data!.listProducts![i].currentPrice);
            print(myCartlocalModel!.cartProducts![index].smartPrice);
            print(myCartlocalModel?.cartProducts![index].price);
             print("A7a ${myCartlocalModel?.cartProducts![index].price}");
          } else {
            myCartlocalModel?.cartProducts![index].price = product_quantity *
            productCartPrices!.data!.listProducts![i].currentPrice;
            // print('a6666');

          }
          cartProducts = myCartlocalModel;
          cartCount = 0;
          cartProducts?.cartProducts
              ?.map((e) => cartCount += e.quantity!)
              .toList();
           calculateTotalPrice(cartData: myCartlocalModel!);
          CacheHelper.setData(key: 'cartCount', value: cartCount);
          cartCountControlller.add(cartCount);
          String localCart = jsonEncode(cartProducts);
          CacheHelper.setData(key: 'localCart', value: localCart);
          emit(CartSuccessState());
          break;
        } else {
          showToast(
              text: "noMoreAvailableForThisProduct".tr(), color: Colors.black);
          emit(CartSuccessState());
        }
      }
    }
    // Mhelper.postData(
    //         data: {
    //       "key": 1234567890,
    //     },
    //         url: sumItemCartURL +
    //             "product_id=$product_id&product_quantity=$product_quantity",
    //         token: CacheHelper.getData("token"))
    //     .then((value) {
    //   log("i add it");
    //   log(value.data.toString());
    //   getCartData();
    // });
  }

  delITemFRomCartLocal({int? product_id}) {
    log('$product_id');
    log("0000000000000000000000000000");
    Map<String, dynamic> json = jsonDecode(CacheHelper.getData('localCart'));
    myCartlocalModel = CartLocalModel.fromJson(json);
    for (int i = 0; i < myCartlocalModel!.cartProducts!.length; i++) {
      if (myCartlocalModel?.cartProducts![i].productId == product_id) {
        myCartlocalModel?.cartProducts?.removeAt(i);
        break;
      }
    }
    cartProducts = myCartlocalModel!;
    cartCount = 0;
    cartProducts?.cartProducts?.forEach((element) {
      cartCount += element.quantity!;
    });
    cartCountControlller.add(cartCount);
    CacheHelper.setData(key: 'cartCount', value: cartCount);
    String localCart = jsonEncode(cartProducts);
    CacheHelper.setData(key: 'localCart', value: localCart);
    calculateTotalPrice(cartData: myCartlocalModel!);
    emit(CartSuccessState());
    // Mhelper.postData(data: {
    //   "key": 1234567890,
    // }, url: delItem + "$product_id", token: CacheHelper.getData("token"))
    //     .then((value) {
    //   log("i add it");
    //   log(value.data.toString());
    //   getCartData();
    // });
  }

  void calculateTotalPrice({required CartLocalModel cartData}) {
     total = 0;
    cartData.cartProducts?.forEach((element) {
     print('Bisho555');
      total += element.price;
      print(total);
    });
  }

  void emptyCartProductsLocally() {
    myCartlocalModel?.cartProducts?.clear();
    cartProducts?.cartProducts?.clear();
    CacheHelper.removeData('localCart');
    total = 0.0;
    cartCount = 0;
    CacheHelper.setData(key: 'cartCount', value: cartCount);
    cartCountControlller.add(cartCount);
    emit(CartSuccessState());
  }

////////////////////////////////////////////////////**HANDLE CART PART LOCALLY**//////////////////////////////////////////////////////
  make_order(
      {required int
          payment_status, //1-->Payment has been done , 0-->Payment not completed
      required int payment_type, // 1-->Pay online , 0-->Pay Cash
      required num orderPrice,
      required String phone,
      required String name,
      required String address,
      required int
          deliveryType, //0-->Deliver Order to home , 1-->Recieve order from store
      required int countryId,
      required int cityId,
      context}) {
    log('${CacheHelper.getData("token")}');

    log("0000000000000000000000000000");
    log('Data is:');
    log('countryId: $countryId');
    log('cityId: $cityId');
    log('cipoun id: $copunId');
    log('order price: $orderPrice');
    Mhelper.postData(
      data: {
        "payment_status": payment_status,
        "payment_type": payment_type,
        "sub_total": '$orderPrice',
        "phone": phone,
        "name": name,
        "address": address,
        if (copunId != null) "promo_code_id": "$copunId",
        "delivery_type": "$deliveryType"
      },
      url: make_orderURL,
      token: CacheHelper.getData("token"),
      query: {
        'lang': kLanguage,
      },
    ).then((value) {
      if (value.data['status']) {
        //ScaffoldMessenger.of( scaffoldkey.currentContext).showSnackBar(SnackBar(content:Text(value.data["msg"])));
        MakeOrderModel makeOrderModel = MakeOrderModel.fromJson(value.data);
        log("i add it");
        log(value.data.toString());
        navigateReplacement(context, SuccessScr( makeOrderNewNewNewModel!));
      } else {
        showToast(
            text: value.data['msg'],
            color: Colors.red,
            location: ToastGravity.CENTER);
      }
    });
  }

  bool? isCopunValid;
  int? copunId;

  checkCopunStatus({required String copun}) {
    Mhelper.postData(
      url: promoCodeURL,
      query: {'lang': kLanguage},
      data: {
        'code': copun,
      },
      token: kToken,
    ).then((value) {
      log('CUPOUN STATUS' + value.data.toString());
      if (value.data['status']) {
        isCopunValid = true;
        copunId = value.data['data']['code']['id'];
      } else {
        isCopunValid = false;
      }
      emit(CartSuccessState());
    });
  }

  sendgiftCards(
      {receiver,
      phone,
      message,
      address,
      type,
      GlobalKey? qrKey,
      String? qrData,
      int? orderId,
      context}) async {
    log('${CacheHelper.getData("token")}');
    File? qrImageFile;
    if (qrData!.isNotEmpty) {
      RenderRepaintBoundary? boundary =
          qrKey?.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      ui.Image image = await boundary!.toImage(pixelRatio: 2.5);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      final tempDir = await getExternalStorageDirectory();
      final file = await new File('${tempDir?.path}/gift_card.png').create();
      await file.writeAsBytes(pngBytes);

      qrImageFile = file;
      log('file=${file.path}');
      log('qrImageFile=${qrImageFile.path}');
    }
    log("0000000000000000000000000000");
    Mhelper.postData(data: {
      "receiver": receiver,
      "phone": phone,
      // "address": address,
      "message": message,
      "type": type,
      if (qrImageFile != null)
        "qr_image": await MultipartFile.fromFile(qrImageFile.path,
            filename: qrImageFile.path.split('/').last),
      'id_order': "$orderId",
      // "link": link,
    }, url: giftCardsURL, token: CacheHelper.getData("token"))
        .then((value) {
      //  ScaffoldMessenger.of( scaffoldkey.currentContext).showSnackBar(SnackBar(content:Text(value.data["msg"])));
      log("i add it");
      log(value.data.toString());
    });
  }

  CitiesLocationsModel? allCitiesLocation;

  getAllLocationsOfCities() {
    Mhelper.getData(
      url: locationsURL,
      query: {
        'lang': kLanguage,
      },
      token: kToken,
    ).then((value) {
      allCitiesLocation = CitiesLocationsModel.fromJson(value.data);
      log('all Locations data is: ${value.data}');
      emit(CartSuccessState());
    }).catchError((error) {
      log('Error on getting all locations data: ${error.toString()}');
      emit(CartErrorState());
    });
  }

  CountryList? selectedCountry;
  List<ListCites>? allCities = [];

  void chooseCountry(CountryList chooseCountry) {
    if (allCities!.isNotEmpty) {
      allCities = [];
      selectedCity = null;
    }
    selectedCountry = chooseCountry;
    allCities?.addAll(selectedCountry?.listCites as Iterable<ListCites>);
    emit(CartSuccessState());
  }

  ListCites? selectedCity;

  void chooseCity(ListCites choosenCity) {
    selectedCity = choosenCity;
    emit(CartSuccessState());
  }


  MakeOrderNewNewNewModel? makeOrderNewNewNewModel;
  makeOrderDetails({
    required BuildContext context,
    required int paymentStatus,
    required int paymentType,
    required int subTotal,
    required int countryId,
    required int cityId,
    required int promoCodeId,
    required String phone,
    required String name,
    required String address,
    required int deliveryType,
    required String cashBack,
    required String totalGift,
})
  {
    emit(MakeOrderLoadingStateNew());
    Mhelper.postData(
        url: "api/make_order",
      token: CacheHelper.getData("token"),
      data: {
        'payment_status': paymentStatus,
        'payment_type': paymentType,
        'sub_total': subTotal,
        'country_id': countryId,
        'city_id': cityId,
        'promo_code_id': promoCodeId,
        'phone': phone,
        'name': name,
        'address': address,
        'delivery_type': deliveryType,
        'cashback': cashBack,
        'totalgift': totalGift,
      },
    ).then((value){
      print(value.data);
      makeOrderNewNewNewModel = MakeOrderNewNewNewModel.fromJson(value.data);
      emit(MakeOrderSuccessStateNew());
      navigateReplacement(context, SuccessScr(   makeOrderNewNewNewModel! ));
      showToast(text: "okay", color: Colors.green);
    }).catchError((error){
      print("errror in make order mostafa ${error.toString()}");
      emit(MakeOrderErrorStateNew());
    });
  }
}
