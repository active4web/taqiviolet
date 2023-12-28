part of 'assignment_cubit.dart';

@immutable
abstract class AssignmentState {}

class AssignmentInitial extends AssignmentState {}

class GetAssignmentSuccessState extends AssignmentState {}
class GetAssignmentLoadingState extends AssignmentState {}
class GetAssignmentErrorState extends AssignmentState {}
