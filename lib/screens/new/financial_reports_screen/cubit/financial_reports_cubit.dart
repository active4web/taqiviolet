import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/models/order_sales_model.dart';
import 'package:safsofa/models/partner_orders_model.dart';
import 'package:safsofa/network/local/cache_helper.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/screens/new/financial_reports_screen/models/partner_wating_order_model.dart';
import 'package:safsofa/screens/new/personel_page/help/toast/toast.dart';
import 'package:safsofa/screens/new/personel_page/help/toast/toast_states.dart';
import 'package:safsofa/shared/constants.dart';

part 'financial_reports_state.dart';


class FinancialReportsCubit extends Cubit<FinancialReportsState> {
  FinancialReportsCubit() : super(FinancialReportsInitial());

  static FinancialReportsCubit get(context) => BlocProvider.of(context);

  List<Tab> tabs = [
    Tab(
      text: "الطلبات المنتظرة",
    ),
    Tab(
      text: "الحالية",
    ),
    Tab(
      text: "المعلقه",
    ),

    Tab(
      text: "المنتهية",
    ),
  ];

  PartnerWatingOrderModel? watingOrderModel;

  Future<void> getWatingOrders() async {
    emit(GetPartnerWatingOrderLoading());
    final response = await Mhelper.getData(
        url: 'api/partner_waiting_orders', token: kToken);
    if (response.statusCode == 200) {
      if (response.data['status']) {
        watingOrderModel = PartnerWatingOrderModel.fromJson(response.data);
        print('qqqqqqqqqqqqqqqqqqqqqqqqqqqqq${watingOrderModel?.data?.length??0}');
        emit(GetPartnerWatingOrderSuccess());
      } else {
        emit(GetPartnerWatingOrderError());
      }
    } else {
      emit(GetPartnerWatingOrderError());
    }
  }

  PartnerWatingOrderModel? currentOrderModel;

  Future<void> getCurrentOrders() async {
    emit(GetPartnerCurrentOrderLoading());
    final response = await Mhelper.getData(
        url: 'api/partner_current_orders', token: kToken);
    if (response.statusCode == 200) {
      if (response.data['status']) {
        currentOrderModel = PartnerWatingOrderModel.fromJson(response.data);
        emit(GetPartnerCurrentOrderSuccess());
      } else {
        emit(GetPartnerCurrentOrderError());
      }
    } else {
      emit(GetPartnerCurrentOrderError());
    }
  }

  PartnerWatingOrderModel? holdingOrderModel;

  Future<void> getHoldingOrders() async {
    emit(GetPartnerHoldingOrderLoading());
    final response = await Mhelper.getData(
        url: 'api/partner_holding_orders', token: kToken);
    if (response.statusCode == 200) {
      if (response.data['status']) {
        holdingOrderModel = PartnerWatingOrderModel.fromJson(response.data);
        emit(GetPartnerHoldingOrderSuccess());
      } else {
        emit(GetPartnerHoldingOrderError());
      }
    } else {
      emit(GetPartnerHoldingOrderError());
    }
  }

  PartnerWatingOrderModel? oldOrderModel;

  Future<void> getOldOrders() async {
    emit(GetPartnerOldOrderLoading());
    final response = await Mhelper.getData(
        url: 'api/partner_old_orders', token: kToken);
    if (response.statusCode == 200) {
      if (response.data['status']) {
        oldOrderModel = PartnerWatingOrderModel.fromJson(response.data);
        emit(GetPartnerOldOrderSuccess());
      } else {
        emit(GetPartnerOldOrderError());
      }
    } else {
      emit(GetPartnerOldOrderError());
    }
  }

  var commentController = TextEditingController();

  Future<void> changeStatus({
    required num orderId,
    required int status}) async {
    emit(ChangeStatusLoading());
    print("orderId: $orderId ______ status: $status");
    final  response = await Mhelper.postData(
        url: 'api/change_status', token: kToken, data: {
      'order_id': orderId,
      'status': status,
      'note': commentController.text
    });
    if (response.statusCode==200){
      if(response.data['status']){
        emit(ChangeStatusSuccess());
        if(CacheHelper.getData('type')==3){
          getSalesOrder();
        }else{
          getWatingOrders();
          getHoldingOrders();
          getCurrentOrders();
          getOldOrders();
        }
        ToastConfig.showToast(msg: response.data['msg'], toastStates: ToastStates.success);
        commentController.clear();
      }else{
        emit(ChangeStatusError());
      }
    }else{
      emit(ChangeStatusError());
    }
  }

bool isHold=false;
  changeHoldState(){
    isHold=!isHold;
    emit(ChangeHoldState());
  }

  OrderSalesModel?salesOrders;
  Future<void>getSalesOrder()async{
    watingOrderModel=null;
    emit(GetSalesOrdersLoading());
    final response=await Mhelper.getData(url: 'api/orders',token: kToken);
    if(response.data['status']){
      emit(GetSalesOrdersSuccess());
      salesOrders=OrderSalesModel.fromJson(response.data);
      waiting=salesOrders?.data?.orders?.waiting??[];
      holding=salesOrders?.data?.orders?.holding??[];
      current=salesOrders?.data?.orders?.current??[];
      old=salesOrders?.data?.orders?.old??[];
      // if(salesOrders!=null&&salesOrders!.data!.orders!.isNotEmpty){
      //   waitingData.addAll(salesOrders!.data!.orders!.where((element) => element.status=="0"));
      //   currentData.addAll(salesOrders!.data!.orders!.where((element) => element.status=="1"||element.status=='3'||element.status=='6'));
      //   previousData.addAll(salesOrders!.data!.orders!.where((element) => element.status=="4"||element.status=='2'));
      //   pendingData.addAll(salesOrders!.data!.orders!.where((element) => element.status=="5"));
      // }
      // watingOrderModel=PartnerWatingOrderModel(
      //   errNum: "1",
      //   data: waitingData,
      //   msg: "",
      //   status: true
      // );
      // currentOrderModel=PartnerWatingOrderModel(
      //   errNum: "1",
      //   data: currentData,
      //   msg: "",
      //   status: true
      // );
      // oldOrderModel=PartnerWatingOrderModel(
      //   errNum: "1",
      //   data: previousData,
      //   msg: "",
      //   status: true
      // );
      // holdingOrderModel=PartnerWatingOrderModel(
      //   errNum: "1",
      //   data: pendingData,
      //   msg: "",
      //   status: true
      // );
      // print(watingOrderModel?.data);

    }else{
      emit(GetSalesOrdersError());
    }
  }

  List<Waiting>? waiting;
  List<Waiting>? current;
  List<Waiting>? holding;
  List<Waiting>? old;
  PartnerOrdersModel? partnerOrdersModel;
  Future<void> getPartnerOrders()async{
    emit(GetPartnerOrdersLoading());
    final response=await Mhelper.getData(url: 'api/partner/orders',token: kToken);
    if(response.data['status']){
      partnerOrdersModel=PartnerOrdersModel.fromJson(response.data);
      waiting=partnerOrdersModel?.data?.orders?.waiting??[];
      current=partnerOrdersModel?.data?.orders?.current??[];
      holding=partnerOrdersModel?.data?.orders?.holding??[];
      old=partnerOrdersModel?.data?.orders?.old??[];
      emit(GetPartnerOrdersSuccess());
    }else{
      emit(GetPartnerOrdersError());
    }
  }
}
