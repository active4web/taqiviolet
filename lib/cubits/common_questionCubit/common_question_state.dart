part of 'common_question_cubit.dart';

@immutable
abstract class CommonQuestionState {}

class CommonQuestionInitial extends CommonQuestionState {}

class ChangeState extends  CommonQuestionState {}

/*class ShopsLoading extends CommonQuestionState {}

class ShopsSuccess extends CommonQuestionState {}

class ShopsError extends CommonQuestionState {}

///All Shops States
class AllShopsInitial extends CommonQuestionState {}

class AllShopsLoading extends CommonQuestionState {}

class AllShopsSuccess extends CommonQuestionState {}

class AllShopsError extends CommonQuestionState {}

class DectectListProduct extends CommonQuestionState {}

class StoreCategoryLoadingState extends CommonQuestionState {}
 class StoreCategorySuccessState extends CommonQuestionState {}
 class StoreCategoryErrorState extends CommonQuestionState {}*/

class getCommonQuestionLoading extends CommonQuestionState{}

class getCommonQuestionSuccess extends CommonQuestionState{}

class getCommonQuestionError extends CommonQuestionState{
  final String error;

  getCommonQuestionError(this.error);
}

class getAnswerCommonQuestionLoading extends CommonQuestionState{}

class getAnswerCommonQuestionSuccess extends CommonQuestionState{}

class getAnswerCommonQuestionError extends CommonQuestionState{
  final String error;

  getAnswerCommonQuestionError(this.error);
}
