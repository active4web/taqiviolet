import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../models/my_orders_model.dart';
import '../network/local/cache_helper.dart';
import '../network/remote/dio_Mhelper.dart';
import '../shared/constants.dart';

part 'my_orders_state.dart';

class MyOrdersCubit extends Cubit<MyOrdersState> {
  MyOrdersCubit() : super(MyOrdersInitial());

  static MyOrdersCubit get(context) => BlocProvider.of(context);

  MyOrdersModel myOrdersModel;

  void getmyOrders() {
    emit(MyOrdersLoadingState());

    log("CacheHelper. ${CacheHelper.getData("token")}");
    Mhelper.getData(
      token: CacheHelper.getData("token"),
      url: myOrdersURL,
    ).then((value) {
      myOrdersModel = MyOrdersModel.fromJson(value.data);
      log("my order 000000000000000000000000000000000000");
      log('${myOrdersModel.toJson()}');
      log("my order 000000000000000000000000000000000000");
      // allOffer=offerModel.data;
      // log("${allOffer}");
      emit(MyOrdersSuccessState());
    }).catchError((error) {
      emit(MyOrdersErrorState());
      log(error.toString());
    });
  }
}
