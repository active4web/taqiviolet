import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:safsofa/models/commitments/commitments_model.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/shared/constants.dart';

import '../../network/local/cache_helper.dart';

part 'commitments_state.dart';

class CommitmentsCubit extends Cubit<CommitmentsState> {
  CommitmentsCubit() : super(CommitmentsInitial());

  static CommitmentsCubit get(context) => BlocProvider.of(context);


  CommitmentsModel? commitmentsModel;

  getCommitmentsDetails({required int type}) {
    emit(GetCommitmentsLoading());
    Mhelper.getData(
        url: '/api/obligations', token: CacheHelper.getData('token'),query: {
          'type':type,
      'lang':kLanguage
    }).then((
        value) {
          commitmentsModel=CommitmentsModel.fromJson(value.data);
          emit(GetCommitmentsSuccess());
    }).catchError((error){
          print(error);
          emit(GetCommitmentsError());
    });
  }
}
