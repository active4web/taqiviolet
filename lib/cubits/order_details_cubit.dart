import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/order_details.dart';
import '../network/local/cache_helper.dart';
import '../network/remote/dio_Mhelper.dart';
import '../shared/constants.dart';
import 'my_orders_cubit.dart';
part 'order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit() : super(OrderDetailsInitial());
  static OrderDetailsCubit get(context) => BlocProvider.of(context);
  OrderDetails orderDetails;
double total=0;
  double alltotal=0;
  void getOrderDetails( id) {
    emit(OrderDetailsLoadingState());



    Mhelper.postData(token: CacheHelper.getData("token"),
   url: orderDetailsURL,data: {
      "order_id":id

        }
    ).then((value) {

      orderDetails = OrderDetails.fromJson(value.data);
      print("my order 000000000000000000000000000000000000");
      print(orderDetails.toJson());
     orderDetails.data.forEach((element) {

       total+=(double.tryParse(element.price)*int.tryParse(element.quantity));
     });
      print("my order 000000000000000000000000000000000000");
      // allOffer=offerModel.data;
      // print("${allOffer}");
      emit(OrderDetailsSuccessState());
    }).catchError(
            (error) {
          emit(OrderDetailsErrorState());
          print(error.toString());
        }
    );



  }


  String getALLTotal(){
    return (alltotal=total).toString();
  }
}
