import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';

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

  getCartData() {
    emit(CartLoadingState());
    total = 0;
    Mhelper.getData(UrlPath: myCartURL, token: CacheHelper.getData("token"))
        .then((value) {



      myCartModel = MyCartModel.fromJson(value.data);
      // for (int i = 0; i < myCartModel.data.items.length; i++) {
      //   print("item id ${myCartModel.data[i].price}");
      //   total = total +
      //      myCartModel.data.items[i].price *
      //           myCartModel.data.items[i].quantity;
      // }
      // myCartModel.data.((element) {});
      // print(myCartModel.toJson());
      // print("i get data from  $myCartURL");
      // print(value.data);
      emit(CartStateSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(CartStateErrorState());
    });
  }

  addquantity({product_id, product_quantity}) {
    print(CacheHelper.getData("token"));
    print(product_id);
    print("0000000000000000000000000000");
    Mhelper.postData(
            data: {
          "key": 1234567890,
        },
            url: sumItemCartURL +
                "product_id=$product_id&product_quantity=$product_quantity",
            token: CacheHelper.getData("token"))
        .then((value) {
      print("i add it");
      print(value.data);
      getCartData();
    });
  }

  delITemFRomCart({product_id}) {
    print(CacheHelper.getData("token"));
    print(product_id);
    print("0000000000000000000000000000");
    Mhelper.postData(data: {
      "key": 1234567890,
    }, url: delItem + "$product_id", token: CacheHelper.getData("token"))
        .then((value) {
      print("i add it");
      print(value.data);
      getCartData();
    });
  }

  make_order({
    payment_status,payment_type,sub_total,address_save,address_id
 ,context }) {
    print(CacheHelper.getData("token"));

    print("0000000000000000000000000000");
    Mhelper.postData(data: {
      "key": 1234567890,
      "payment_status": payment_status,
      "payment_type": payment_type,
      "sub_total": sub_total,   "address_save": address_save,   "address_id": address_id,
    }, url: make_orderURL, token: CacheHelper.getData("token"))
        .then((value) {

      //ScaffoldMessenger.of( scaffoldkey.currentContext).showSnackBar(SnackBar(content:Text(value.data["msg"])));
      MakeOrderModel makeOrderModel=MakeOrderModel.fromJson(value.data);
      print("i add it");
      print(value.data);
      navigateTo(context, SuccessScr(makeOrderModel));
    });
  }


  sendgiftCards({
    receiver,phone,message,address,type,
    link
    ,context }) {
    print(CacheHelper.getData("token"));

    print("0000000000000000000000000000");
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
      print("i add it");
      print(value.data);

    });
  }
}
