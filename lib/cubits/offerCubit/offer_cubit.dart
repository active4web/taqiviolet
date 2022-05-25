import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:safsofa/models/offer_model.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/shared/constants.dart';

part 'offer_state.dart';

class OfferCubit extends Cubit<OfferState> {
  OfferCubit() : super(OfferInitial());

  static OfferCubit get(context) => BlocProvider.of(context);

  ///TODO:Get Offer Data
  OfferModel offerModel;
  List <OfferModelData>allOffer;
  void getOfferData() {
    emit(GetOfferLoadingState());
    Mhelper.getData(
      UrlPath: offersEndpoint,
    ).then((value) {

      print("the offer ${value.data}");
      offerModel = OfferModel.fromJson(value.data);
      allOffer=offerModel.data;
      print("${allOffer}");
      emit(GetOfferSuccessState());
    }).catchError(
            (error) {
          emit(GetOfferErrorState());
          print(error.toString());
        }
    );
  }
}
