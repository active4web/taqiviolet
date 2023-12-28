part of 'expenses_cubit.dart';

@immutable
abstract class ExpensesState {}

class ExpensesInitial extends ExpensesState {}
class GetExpensesSuccessState extends ExpensesState {}
class GetExpensesLoadingState extends ExpensesState {}
class GetExpensesErrorState extends ExpensesState {}
