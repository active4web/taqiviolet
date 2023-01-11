part of 'policies_cubit.dart';

@immutable
abstract class PoliciesState {}

class PoliciesInitial extends PoliciesState {}

class GetPoliciesLoadingState extends PoliciesState {}

class GetPoliciesSuccessState extends PoliciesState {}

class GetPoliciesErrorState extends PoliciesState {}

class GetPolicyDetailsLoadingState extends PoliciesState {}

class GetPolicyDetailsSuccessState extends PoliciesState {}

class GetPolicyDetailsErrorState extends PoliciesState {}
