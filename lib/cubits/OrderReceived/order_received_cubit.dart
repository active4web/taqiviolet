import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/ReOrderModel.dart';
import '../../network/local/cache_helper.dart';
import '../../network/remote/dio_Mhelper.dart';
import '../../shared/constants.dart';
part 'order_received_state.dart';

class OrderReceivedCubit extends Cubit<OrderReceivedState> {
  OrderReceivedCubit() : super(OrderReceivedInitial());

  static OrderReceivedCubit get(context) => BlocProvider.of(context);

  ReOrderModel reOrderModel;
  void getOrderReceivedData( ) {
    emit(OrderReceivedLoadingState());


    Mhelper.getData(token: CacheHelper.getData("token"),
      UrlPath: reOrderURL,
    ).then((value) {

      reOrderModel = ReOrderModel.fromJson(value.data);
       print(reOrderModel.toJson());
      // allOffer=offerModel.data;
      // print("${allOffer}");
      emit(OrderReceivedSuccessState());
    }).catchError(
            (error) {
          emit(OrderReceivedErrorState());
          print(error.toString());
        }
    );



  }
}
