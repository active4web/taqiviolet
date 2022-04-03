part of 'offer_cubit.dart';

@immutable
abstract class OfferState {}

class OfferInitial extends OfferState {}

class GetOfferLoadingState extends OfferState{}

class GetOfferSuccessState extends OfferState{}

class GetOfferErrorState extends OfferState{}
