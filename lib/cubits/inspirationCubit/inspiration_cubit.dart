import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/inspirationCubit/inspiration_state.dart';
import 'package:safsofa/models/inspiration_model.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/shared/constants.dart';

class InspirationCubit extends Cubit<InspirationStates> {
  InspirationCubit() : super(InspirationInitialState());
  static InspirationCubit get(context) => BlocProvider.of(context);
  InspirationModel _inspirationModel;
  List<Data> inspirationData = [];

  void getInspirationData() async {
    emit(GetInspirationLoadingState());
    await Mhelper.getData(UrlPath: inspiration).then((value) async {
      _inspirationModel = InspirationModel.fromJson(value.data);
      inspirationData = _inspirationModel.data;
      print(inspirationData[0].urlLink);
      emit(GetInspirationSuccessState());
    }).catchError((error) {
      print('=' * 10 + 'error in inspiration' + '=' * 10);
      print('*' * 10 + error.toString() + '*' * 10);
      emit(GetInspirationErrorState());
    });
  }
}
