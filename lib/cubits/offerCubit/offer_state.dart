part of 'offer_cubit.dart';

@immutable
abstract class OfferState {}

class OfferInitial extends OfferState {}

class GetOfferLoadingState extends OfferState{}

class GetOfferSuccessState extends OfferState{}

class GetOfferErrorState extends OfferState{}
class GetOfferLoadingState2 extends OfferState{}

class GetOfferSuccessState2 extends OfferState{}

class GetOfferErrorState2 extends OfferState{}

class GetProductsOfferLoadingState extends OfferState {}

class GetProductsOfferSuccessState extends OfferState {}

class GetProductsOfferErrorState extends OfferState {}
