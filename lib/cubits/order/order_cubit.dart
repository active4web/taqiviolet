import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  static OrderCubit get(context)=>BlocProvider.of(context);

  bool promo=false;
  bool cache=false;
  bool gift=false;
  promoActive(){
    promo=true;
     cache=false;
     gift=false;
     emit(ChangeActive());
  }
  cacheActive(){
    promo=false;
     cache=true;
     gift=false;
    emit(ChangeActive());

  }
  giftActive(){
    promo=false;
    cache=false;
    gift=true;
    emit(ChangeActive());

  }
}
