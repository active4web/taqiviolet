import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:safsofa/models/assignment/assignment_model.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/shared/constants.dart';

import '../../network/local/cache_helper.dart';

part 'assignment_state.dart';

class AssignmentCubit extends Cubit<AssignmentState> {
  AssignmentCubit() : super(AssignmentInitial());

  static AssignmentCubit get(context)=>BlocProvider.of(context);

  AssignmentModel? assignmentModel;

  getAssignment(){
    emit(GetAssignmentLoadingState());
    Mhelper.getData(url: '/api/assignment',token: CacheHelper.getData('token'),query: {
      'lang':kLanguage
    }).then((value) {
      assignmentModel=AssignmentModel.fromJson(value.data);
      emit(GetAssignmentSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetAssignmentErrorState());
    });
  }
}
