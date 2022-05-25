import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/my_orders_model.dart';
import '../network/local/cache_helper.dart';
import '../network/remote/dio_Mhelper.dart';
import '../shared/constants.dart';
part 'my_orders_state.dart';

class MyOrdersCubit extends Cubit<MyOrdersState> {
  MyOrdersCubit() : super(MyOrdersInitial());

  static MyOrdersCubit get(context) => BlocProvider.of(context);


  MyOrdersModel myOrdersModel;

  void getmyOrders( ) {
    emit(MyOrdersLoadingState());



    print("CacheHelper. ${CacheHelper.getData("token")}");
    Mhelper.getData(token: CacheHelper.getData("token"),
      UrlPath: myOrdersURL,
    ).then((value) {

      myOrdersModel = MyOrdersModel.fromJson(value.data);
      print("my order 000000000000000000000000000000000000");
        print(myOrdersModel.toJson());
      print("my order 000000000000000000000000000000000000");
      // allOffer=offerModel.data;
      // print("${allOffer}");
      emit(MyOrdersSuccessState());
    }).catchError(
            (error) {
          emit(MyOrdersErrorState());
          print(error.toString());
        }
    );



  }
}
