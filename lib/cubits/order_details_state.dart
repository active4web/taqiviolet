part of 'order_details_cubit.dart';

@immutable
abstract class OrderDetailsState {}

class OrderDetailsInitial extends OrderDetailsState {}

class OrderDetailsLoadingState extends OrderDetailsState{}
class OrderDetailsSuccessState extends OrderDetailsState{}
class OrderDetailsErrorState extends OrderDetailsState{}

class AddReviewForOrderSuccess extends OrderDetailsState{}
class AddReviewForOrderError extends OrderDetailsState{}
class AddReviewForOrderLoading extends OrderDetailsState{}
class ChangeRateState extends OrderDetailsState{}