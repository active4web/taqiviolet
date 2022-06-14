part of 'policies_cubit.dart';

@immutable
abstract class PoliciesState {}

class PoliciesInitial extends PoliciesState {}

class GetPoliciesLoadingState extends PoliciesState {}

class GetPoliciesSuccessState extends PoliciesState {}

class GetPoliciesErrorState extends PoliciesState {}
