part of 'commitments_cubit.dart';

@immutable
abstract class CommitmentsState {}

class CommitmentsInitial extends CommitmentsState {}
class GetCommitmentsSuccess extends CommitmentsState {}
class GetCommitmentsLoading extends CommitmentsState {}
class GetCommitmentsError extends CommitmentsState {}
