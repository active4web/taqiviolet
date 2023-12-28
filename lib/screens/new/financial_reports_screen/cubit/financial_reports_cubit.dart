import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        getWatingOrders();
        getHoldingOrders();
        getCurrentOrders();
        getOldOrders();
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
}
