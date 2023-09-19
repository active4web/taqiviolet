part of 'data_in_list_cubit.dart';

@immutable
abstract class DataInListState {}

class DataInListInitial extends DataInListState {}
class DataInListLoadingState extends DataInListState{}
class DataInListSuccessState extends DataInListState{}
class DataInListErrorState extends DataInListState{}

