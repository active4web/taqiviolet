import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/screens/bottom_navigation_screens/orders_section/all_orders_screen.dart';
import 'package:safsofa/screens/bottom_navigation_screens/orders_section/current_orders_screen.dart';
import 'package:safsofa/screens/bottom_navigation_screens/orders_section/holding_orders_screen.dart';
import 'package:safsofa/screens/bottom_navigation_screens/orders_section/pending_orders_screen.dart';
import 'package:safsofa/screens/bottom_navigation_screens/orders_section/previous_orders_screen.dart';

import '../models/client_orders_model.dart';
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
      text:'كل الطلبات' ,
    ),
    Tab(
      text: "pendingOrders".tr(),
    ),
    Tab(
      text: "جاري تجهيزه".tr(),
    ),
    Tab(
      text: "pending".tr(),
    ),

    Tab(
      text: "تم توصيله".tr(),
    ),
  ];

  List<Widget> tabBarsContent =  [
    AllOrdersScreen(),
    PendingOrdersScreen(),
    CurrentOrdersScreen(),
    HoldingOrdersScreen(),
    PreviousOrdersScreen(),
  ];





  ClintOrdersModel? clientOrdersModel;
  Future<void>getAllOrders()async{
    emit(MyOrdersLoadingState());
    final response=await Mhelper.getData(url: 'https://taqiviolet.com/api/client-orders',query: {
      "lang":kLanguage
    },token: CacheHelper.getData('token'));
    if(response.data['status']){
      clientOrdersModel=ClintOrdersModel.fromJson(response.data);
      emit(MyOrdersSuccessState());
    }
    else{
      emit(MyOrdersErrorState());
    }
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
