part of 'lists_cubit.dart';

@immutable
abstract class ListsState {}

class ListsInitial extends ListsState {}
class ListsLoadingState extends ListsState{}
class ListsSuccessState extends ListsState{}
class ListsErrorState extends ListsState{}