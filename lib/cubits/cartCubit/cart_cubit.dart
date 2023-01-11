import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/models/cart_models/remote_cart_model/cart_product_prices_model.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:easy_localization/easy_localization.dart';
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
  MyCartModel myCartModel;
  double total = 0;
  final GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();

  getServerCartData() {
    emit(CartLoadingState());
    total = 0;
    Mhelper.getData(
        url: myCartURL,
        token: CacheHelper.getData("token"),
        query: {
          'lang': kLanguage,
        }).then((value) {
      myCartModel = MyCartModel.fromJson(value.data);
      log(value.data.toString());
      for (int i = 0; i < myCartModel.data.length; i++) {
        log("item id ${myCartModel.data[i].price}");
        total += myCartModel.data[i].price * myCartModel.data[i].quantity;
      }
      // myCartModel.data.forEach((element) {});
      // print(myCartModel.toJson());
      // print("i get data from  $myCartURL");
      // print(value.data);
      emit(CartStateSuccessState());
    }).catchError((e) {
      log(e.toString());
      emit(CartStateErrorState());
    });
  }

  CartLocalModel myCartlocalModel;
  CartProductsPricesModel productCartPrices;
  getLocalCartData() {
    emit(CartLoadingState());
    if (CacheHelper.getData('localCart') != null) {
      Map<String, dynamic> json = jsonDecode(CacheHelper.getData('localCart'));
      myCartlocalModel = CartLocalModel.fromJson(json);
      String productIds = '';
      myCartlocalModel.cartProducts.forEach((element) {
        productIds += '${element.productId},';
      });
      Mhelper.getData(url: '/api/productprice', query: {
        'lang': kLanguage,
        'product_id': productIds.substring(0, productIds.length - 1)
      }).then((value) {
        productCartPrices = CartProductsPricesModel.fromJson(value.data);

        calculateTotalPrice(cartData: myCartlocalModel);
        emit(CartStateSuccessState());
      }).catchError((error) {
        log('Error on getting cart product prices: ${error.toString()}');
        emit(CartStateErrorState());
      });
    } else {
      myCartlocalModel = CartLocalModel();
      emit(CartStateSuccessState());
    }
  }

  addquantityLocally(
      {@required product_id,
      @required int product_quantity,
      @required int index}) {
    log('${CacheHelper.getData("token")}');
    log('$product_id');
    log("0000000000000000000000000000");
    for (int i = 0; i < productCartPrices.data.listProducts.length; i++) {
      if (productCartPrices.data.listProducts[i].id == product_id) {
        log('product quantity=$product_quantity <= existing quantity=${int.parse(productCartPrices.data.listProducts[i].quantity)}');
        if (product_quantity <=
            int.parse(productCartPrices.data.listProducts[i].quantity)) {
          myCartlocalModel.cartProducts[index].quantity = product_quantity;
          if (myCartlocalModel.cartProducts[index].withSmartFeature) {
            myCartlocalModel.cartProducts[index].price = product_quantity *
                productCartPrices.data.listProducts[i].smartPrice;
          } else {
            myCartlocalModel.cartProducts[index].price = product_quantity *
                productCartPrices.data.listProducts[i].currentPrice;
          }
          cartProducts = myCartlocalModel;
          cartCount = 0;
          cartProducts.cartProducts
              .map((e) => cartCount += e.quantity)
              .toList();
          calculateTotalPrice(cartData: myCartlocalModel);
          CacheHelper.setData(key: 'cartCount', value: cartCount);
          cartCountControlller.add(cartCount);
          String localCart = jsonEncode(cartProducts);
          CacheHelper.setData(key: 'localCart', value: localCart);
          emit(CartStateSuccessState());
          break;
        } else {
          showToast(
              text: "noMoreAvailableForThisProduct".tr(), color: Colors.black);
          emit(CartStateSuccessState());
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

  delITemFRomCart({int product_id}) {
    log('$product_id');
    log("0000000000000000000000000000");
    Map<String, dynamic> json = jsonDecode(CacheHelper.getData('localCart'));
    myCartlocalModel = CartLocalModel.fromJson(json);
    for (int i = 0; i < myCartlocalModel.cartProducts.length; i++) {
      if (myCartlocalModel.cartProducts[i].productId == product_id) {
        myCartlocalModel.cartProducts.removeAt(i);
        break;
      }
    }
    cartProducts = myCartlocalModel;
    cartCount = 0;
    cartProducts.cartProducts.forEach((element) {
      cartCount += element.quantity;
    });
    cartCountControlller.add(cartCount);
    CacheHelper.setData(key: 'cartCount', value: cartCount);
    String localCart = jsonEncode(cartProducts);
    CacheHelper.setData(key: 'localCart', value: localCart);
    calculateTotalPrice(cartData: myCartlocalModel);
    emit(CartStateSuccessState());
    // Mhelper.postData(data: {
    //   "key": 1234567890,
    // }, url: delItem + "$product_id", token: CacheHelper.getData("token"))
    //     .then((value) {
    //   log("i add it");
    //   log(value.data.toString());
    //   getCartData();
    // });
  }

  void calculateTotalPrice({@required CartLocalModel cartData}) {
    total = 0;
    cartData.cartProducts.forEach((element) {
      total += element.price;
    });
  }

  make_order(
      {payment_status,
      payment_type,
      sub_total,
      address_save,
      address_id,
      context}) {
    log('${CacheHelper.getData("token")}');

    log("0000000000000000000000000000");
    Mhelper.postData(data: {
      "key": 1234567890,
      "payment_status": payment_status,
      "payment_type": payment_type,
      "sub_total": sub_total,
      "address_save": address_save,
      "address_id": address_id,
    }, url: make_orderURL, token: CacheHelper.getData("token"))
        .then((value) {
      //ScaffoldMessenger.of( scaffoldkey.currentContext).showSnackBar(SnackBar(content:Text(value.data["msg"])));
      MakeOrderModel makeOrderModel = MakeOrderModel.fromJson(value.data);
      log("i add it");
      log(value.data.toString());
      navigateTo(context, SuccessScr(makeOrderModel));
    });
  }

  sendgiftCards({receiver, phone, message, address, type, link, context}) {
    log('${CacheHelper.getData("token")}');

    log("0000000000000000000000000000");
    Mhelper.postData(data: {
      "key": 1234567890,
      "receiver": receiver,
      "phone": phone,
      "address": address,
      "message": message,
      "type": type,
      "link": link,
    }, url: giftCardsURL, token: CacheHelper.getData("token"))
        .then((value) {
      //  ScaffoldMessenger.of( scaffoldkey.currentContext).showSnackBar(SnackBar(content:Text(value.data["msg"])));
      log("i add it");
      log(value.data.toString());
    });
  }

  void emptyCartProducts() {
    myCartlocalModel.cartProducts.clear();
    cartProducts.cartProducts.clear();
    CacheHelper.removeData('localCart');
    total = 0.0;
    cartCount = 0;
    CacheHelper.setData(key: 'cartCount', value: cartCount);
    cartCountControlller.add(cartCount);
    emit(CartStateSuccessState());
  }
}
