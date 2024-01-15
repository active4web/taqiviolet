import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/screens/bottom_navigation_screens/orders_section/current_orders_screen.dart';
import 'package:safsofa/screens/bottom_navigation_screens/orders_section/holding_orders_screen.dart';
import 'package:safsofa/screens/bottom_navigation_screens/orders_section/pending_orders_screen.dart';
import 'package:safsofa/screens/bottom_navigation_screens/orders_section/previous_orders_screen.dart';

import '../models/my_orders_model.dart';
import '../network/local/cache_helper.dart';
import '../network/remote/dio_Mhelper.dart';
import '../shared/constants.dart';

part 'my_orders_state.dart';

class MyOrdersCubit extends Cubit<MyOrdersState> {
  MyOrdersCubit() : super(MyOrdersInitial());

  static MyOrdersCubit get(context) => BlocProvider.of(context);

  List<Tab> tabs = [
    Tab(
      text: "pendingOrders".tr(),
    ),
    Tab(
      text: "current".tr(),
    ),
    Tab(
      text: "pending".tr(),
    ),

    Tab(
      text: "previous".tr(),
    ),
  ];

  List<Widget> tabBarsContent =  [
    PendingOrdersScreen(),
    CurrentOrdersScreen(),
    HoldingOrdersScreen(),
    PreviousOrdersScreen(),
  ];
  MyOrdersModel? waitingOrders;
  void getMyWaitingOrders() {
    emit(MyOrdersLoadingState());

    log("CacheHelper. ${CacheHelper.getData("token")}");
    Mhelper.getData(
      token: CacheHelper.getData("token"),
      url: waitingOrdersURL,
      query: {
        'lang': kLanguage,
      },
    ).then((value) {
      waitingOrders = MyOrdersModel.fromJson(value.data);
      log("my order 000000000000000000000000000000000000");
      // log('${waitingOrders.toJson()}');
      log("my order 000000000000000000000000000000000000");
      emit(MyOrdersSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(MyOrdersErrorState());
    });
  }

  MyOrdersModel? currentOrders;
  void getMyCurrentOrders() {
    emit(MyOrdersLoadingState());

    log("CacheHelper. ${CacheHelper.getData("token")}");
    Mhelper.getData(
      token: CacheHelper.getData("token"),
      url: currentOrdersURL,
      query: {
        'lang': kLanguage,
      },
    ).then((value) {
      currentOrders = MyOrdersModel.fromJson(value.data);
      log("my order 000000000000000000000000000000000000");
      // log('${currentOrders.toJson()}');
      log("my order 000000000000000000000000000000000000");
      emit(MyOrdersSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(MyOrdersErrorState());
    });
  }

  MyOrdersModel? holdingOrder;
  void getHoldingOrders() {
    emit(MyOrdersLoadingState());

    Mhelper.getData(
      token: CacheHelper.getData("token"),
      url: 'api/pending-orders',
      query: {
        'lang': kLanguage,
      },
    ).then((value) {
      holdingOrder = MyOrdersModel.fromJson(value.data);
      log("my order 000000000000000000000000000000000000");
      // log('${currentOrders.toJson()}');
      log("my order 000000000000000000000000000000000000");
      emit(MyOrdersSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(MyOrdersErrorState());
    });
  }



  MyOrdersModel? previousOrders;
  void getMyPreviousOrders() {
    emit(MyOrdersLoadingState());

    log("CacheHelper. ${CacheHelper.getData("token")}");
    Mhelper.getData(
      token: CacheHelper.getData("token"),
      url: oldOrdersURL,
      query: {
        'lang': kLanguage,
      },
    ).then((value) {
      previousOrders = MyOrdersModel.fromJson(value.data);
      log("my order 000000000000000000000000000000000000");
      // log('${previousOrders.toJson()}');
      log("my order 000000000000000000000000000000000000");
      emit(MyOrdersSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(MyOrdersErrorState());
    });
  }

  var searchController=TextEditingController();
  MyOrdersModel? searchOrderModel;
  Future<void>searchOrder()async{
    emit(SearchOrderLoadingState());
    final response=await Mhelper.getData(url: 'api/my-orders',query: {
      "code_order":searchController.text
    },token: kToken);
    if(response.data['status']){
      searchOrderModel=MyOrdersModel.fromJson(response.data);
      emit(SearchOrderSuccessState());
      searchController.clear();
    }else{
      emit(SearchOrderErrorState());

    }
  }
}
