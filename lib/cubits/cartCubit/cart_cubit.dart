import 'dart:convert';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/models/MakeOrderNewNewNewModel.dart';
import 'package:safsofa/models/cart_models/country_model.dart';

import 'package:safsofa/models/cart_models/remote_cart_model/cart_product_prices_model.dart';
import 'package:safsofa/models/cities_location_model.dart';
import 'package:safsofa/models/order_sales_model.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import '../../models/cart_models/cart_local_model/cart_local_model.dart';
import '../../models/make_order_model.dart';
import '../../models/my_cart_model.dart';
import '../../models/promo_code_model.dart';
import '../../network/local/cache_helper.dart';
import '../../screens/success_scr.dart';
import '../../shared/constants.dart';
import '../../shared/defaults.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartStateInitial());

  static CartCubit get(context) => BlocProvider.of(context);

   double total=0.0 ;
   double temptotal=0.0;
  final GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();

  ////////////////////////////////////////////////**HANDLE CART PART FROM SERVER**//////////////////////////////////////////////////////////
  MyCartModel? myCartModel;
  String countryCode = '';
  var globalKey = GlobalKey<FormState>();

  TextEditingController nameOfReceiver =
  TextEditingController();
  TextEditingController phoneOfReceiver = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController addressOfReceiver = TextEditingController();
  TextEditingController zibCode = TextEditingController();

  getServerCartData({bool withLoading = true}) {
    myCartModel=null;
    myCartlocalModel=null;
    if (withLoading) {
      emit(CartLoadingState());
    }
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

                temptotal=total;
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
    emit(DeleteCartLoadingState());
    Mhelper.postData(data: {
      "key": 1234567890,
    }, url: delItem + "$cartId", token: CacheHelper.getData("token"))
        .then((value) {
      if (value.data['status']) {
        emit(DeleteCartSuccessState());
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
     // total =0;
    myCartlocalModel=null;
    emit(CartLoadingState());
    if (CacheHelper.getData('localCart') != null) {
      total=0;
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


  bool? isCopunValid;
 var promoCode=TextEditingController();
 var cashback=TextEditingController();
 var cashFormKey=GlobalKey<FormState>();

 var discountValue;
 var discount;
  PromoCodeModel? promoCodeModel;
 Future<void>checkPromoStatus() async{
   emit(CheckPromoLoadingState());
  final response=await  Mhelper.postData(
      url: promoCodeURL,
      query: {'lang': kLanguage},
      data: {
        'code': promoCode.text,
      },
      token: kToken,
    );
  if(response.data['status']){
    isCopunValid = true;
    sendPromoCode=promoCode.text;
    promoCodeModel=PromoCodeModel.fromJson(response.data);
    total=temptotal-(temptotal*promoCodeModel!.data!.code!.value!/100);
    discount=promoCodeModel!.data!.code!.value!;
    discountValue=temptotal*promoCodeModel!.data!.code!.value!/100;

    print('${response.data['data']["code"]['value']}');
    emit(CheckPromoSuccessState());
  }else{
    isCopunValid = false;
    emit(CheckPromoErrorState());
  }
  }
  CitiesLocationsModel? allCitiesLocation;

 ListCites? cites;
 CountryModel?country;
 Future<void>getAllCountries()async{
   emit(GetCountriesLoadingState());
   final response=await Mhelper.getData(url: 'api/countries',data: {
     "lang":kLanguage
   });
   if(response.data['status']){
     country=CountryModel.fromJson(response.data);

     emit(GetCountriesSuccessState());
   }else{
     emit(GetCountriesErrorState());
   }
 }
  getAllLocationsOfCities() {
    Mhelper.getData(
      url: locationsURL,
      query: {
        'lang': kLanguage,
      },
      token: kToken,
    ).then((value) {
      allCitiesLocation = CitiesLocationsModel.fromJson(value.data);
      allCitiesLocation?.data?.countryList?.forEach((element) {
        if(newOrder?.data?.lastOrder?.countryId!=null)
        {
          if(element.id==int.parse(newOrder?.data?.lastOrder?.countryId??"")){
            selectedCountry=element;
            allCities?.addAll(selectedCountry?.listCites as Iterable<ListCites>);
            allCities?.forEach((element) {
              if(element.idCity==int.parse(newOrder?.data?.lastOrder?.stateId??"")){
                selectedCity=element;
              }
            });
          }
        }
      });
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
    emit(ChoseCountryState());
  }

    ListCites? selectedCity;

  void chooseCity(ListCites choosenCity) {
    selectedCity = choosenCity;
    emit(ChoseCityState());
  }

  bool promo=false;
  bool cache=false;
  bool gift=false;
  promoActive(){
    promo=true;
    cache=false;
    gift=false;
    emit(ChangeActive());
  }
  cacheActive(){
    promo=false;
    cache=true;
    gift=false;
    emit(ChangeActive());

  }
  giftActive(){
    promo=false;
    cache=false;
    gift=true;
    emit(ChangeActive());

  }

  var sendCachBack;
  bool validCashback=false;
  Future<void>checkCachBack()async{
    emit(CacheBackLoadingState());
    final response=await Mhelper.postData(url: 'api/check-cashback',data: {
      'amount':cashback.text
    },token: kToken);
    if(response.data['status']){
      sendCachBack=cashback.text;
      validCashback=true;
      total=temptotal-int.parse(cashback.text);
      emit(CacheBackSuccessState());
    }else{
      emit(CacheBackErrorState());
    }
  }
String? sendPromoCode;


  void cancelPromoCode(){
    promoCode.clear();
    sendPromoCode=null;
    promo=false;
    isCopunValid=false;
    total=temptotal;
    emit(CancelPromoCode());
  }

  void cancelCashback(){
    cache=false;
    total=temptotal;
    cashback.clear();
    sendCachBack=null;
    validCashback=false;
    emit(CancelPromoCode());
  }


MakeNewOrderModel? newOrder;
  Future<void>makeNewOrder()async{
    emit(MakeNewOrderLoadingState());
    final response=await Mhelper.postData(url: 'api/orders',token: kToken,data: {
      "promo_code":promo?isCopunValid??false?sendPromoCode:'':'',
      "cash_back":cache?sendCachBack:''
    });
    if(response.data['status']){
      sendPromoCode=null;
      total=temptotal;
      promo=false;
      cache=false;
      newOrder=MakeNewOrderModel.fromJson(response.data);
      // CartCubit.get(context)..getAllLocationsOfCities();
      // CartCubit.get(context).email.text = AppCubit.get(context).userInfo?.data?.email ?? '';
      // CartCubit.get(context).phoneOfReceiver.text =
      //     AppCubit.get(context).userInfo?.data?.phone ?? '';
      // CartCubit.get(context).addressOfReceiver.text =
      //     AppCubit.get(context).userInfo?.data?.address ?? '';
      // CartCubit.get(context).nameOfReceiver.text =
      //     AppCubit.get(context).userInfo?.data?.name ?? '';
      if(newOrder?.data?.lastOrder?.userPhone!=""){
        phoneOfReceiver.text=newOrder?.data?.lastOrder?.userPhone?.split('+966')[1]??'';
      }
      addressOfReceiver.text=newOrder?.data?.lastOrder?.address??'';
      nameOfReceiver.text=newOrder?.data?.lastOrder?.userName??'';
      email.text=newOrder?.data?.lastOrder?.email??'';
      isCopunValid=null;
      emit(MakeNewOrderSuccessState());
    }else{
      emit(MakeNewOrderErrorState());
    }
  }
}
