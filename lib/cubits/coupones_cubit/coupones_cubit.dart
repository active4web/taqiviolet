import 'package:safsofa/network/remote/dio_Mhelper.dart';

import 'coupones_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CouponesCubit extends Cubit<CouponesStates> {
  CouponesCubit() : super(CouponesInitState());

  static CouponesCubit get(context) => BlocProvider.of(context);


  // CouponesModel? couponesModel;
  // getAllCoupones()
  // {
  //   emit(GetAllCouponesLoadingState());
  //   Mhelper.getData(
  //       url: "",
  //   ).then((value){
  //     couponesModel = CouponesModel.fromJson(value.data);
  //     emit(GetAllCouponesSuccessState());
  //   }).catchError((error){
  //     print("error in get all coupones ${error.toString()}");
  //     emit(GetAllCouponesErrorState());
  //   });
  // }

}