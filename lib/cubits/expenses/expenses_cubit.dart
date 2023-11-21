import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:safsofa/models/expenses/expenses_model.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/shared/constants.dart';

import '../../network/local/cache_helper.dart';

part 'expenses_state.dart';

class ExpensesCubit extends Cubit<ExpensesState> {
  ExpensesCubit() : super(ExpensesInitial());

  static ExpensesCubit get(context) => BlocProvider.of(context);

  ExpensesModel? expensesModel;

  getExpenses() {
    emit(GetExpensesLoadingState());
    Mhelper.getData(url: '/api/expenses', token: CacheHelper.getData('token'),query: {
      'lang':kLanguage
    })
        .then((value) {
          expensesModel=ExpensesModel.fromJson(value.data);
          emit(GetExpensesSuccessState());
    })
        .catchError((error) {
          print(error);
          emit(GetExpensesErrorState());
    });
  }
}
