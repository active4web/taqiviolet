import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../models/ReOrderModel.dart';
import '../../network/local/cache_helper.dart';
import '../../network/remote/dio_Mhelper.dart';
import '../../shared/constants.dart';

part 'order_received_state.dart';

class OrderReceivedCubit extends Cubit<OrderReceivedState> {
  OrderReceivedCubit() : super(OrderReceivedInitial());

  static OrderReceivedCubit get(context) => BlocProvider.of(context);

  ReOrderModel? reOrderModel;

  void getOrderReceivedData() {
    emit(OrderReceivedLoadingState());

    Mhelper.getData(
      token: CacheHelper.getData("token"),
      url: reOrderURL,
    ).then((value) {
      reOrderModel = ReOrderModel.fromJson(value.data);
      // log('${reOrderModel.toJson()}');
      // allOffer=offerModel.data;
      // print("${allOffer}");
      emit(OrderReceivedSuccessState());
    }).catchError((error) {
      emit(OrderReceivedErrorState());
      log(error.toString());
    });
  }
}
