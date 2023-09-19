
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../models/OrderReceivedItemInList_model.dart';
import '../../network/local/cache_helper.dart';
import '../../network/remote/dio_Mhelper.dart';
import '../../shared/constants.dart';

part 'order_received_item_in_list_state.dart';

class OrderReceivedItemInListCubit extends Cubit<OrderReceivedItemInListState> {
  OrderReceivedItemInListCubit() : super(OrderReceivedItemInListInitial());

  static OrderReceivedItemInListCubit get(context) => BlocProvider.of(context);

  OrderReceivedItemInListModel? orderReceivedItemInListModel;
  void getOrderReceivedData(String id) {
    emit(OrderReceivedItemInListLoadingState());

    Mhelper.getData(
      token: CacheHelper.getData("token"),
      url: reOrderItemURL + id,
    ).then((value) {
      log(value.data.toString());
      orderReceivedItemInListModel =
          OrderReceivedItemInListModel.fromJson(value.data);

      // allOffer=offerModel.data;
      // log("${allOffer}");
      emit(OrderReceivedItemInListSuccessState());
    }).catchError((error) {
      emit(OrderReceivedItemInListErrorState());
      log(error.toString());
    });
  }
}
