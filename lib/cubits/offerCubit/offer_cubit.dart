import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:safsofa/models/offer_model.dart';
import 'package:safsofa/models/offer_products_model.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/shared/constants.dart';

import '../../models/new_offer_model2.dart';

part 'offer_state.dart';

class OfferCubit extends Cubit<OfferState> {
  OfferCubit() : super(OfferInitial());

  static OfferCubit get(context) => BlocProvider.of(context);

  OfferModel? offerModel;
  List<OfferModelData>? allOffer;
  void getOfferData() {
    emit(GetOfferLoadingState());
    Mhelper.getData(
      url: offersEndpoint,
    ).then((value) {
      print("mostafa --------------------------------");
      offerModel = OfferModel.fromJson(value.data);
      allOffer = offerModel?.data;
      print(allOffer!.length);
      print(offerModel!.data!.length);
      print("mostafa --------------------------------");
      emit(GetOfferSuccessState());
    }).catchError((error) {
      emit(GetOfferErrorState());
      log(error.toString());
    });
  }

  NewOfferModel? newOfferModel;
  List<NewOfferModelData>? allOfferNew;
  void getOfferData2() {
    emit(GetOfferLoadingState2());
    Mhelper.getData(
      url: offersEndpoint2,
    ).then((value) {
      print("222222222222222mostafa --------------------------------");
      newOfferModel = NewOfferModel.fromJson(value.data);
      allOfferNew = newOfferModel?.data;
      print("2222222222222mostafa --------------------------------");
      emit(GetOfferSuccessState2());
    }).catchError((error) {
      emit(GetOfferErrorState2());
      log(error.toString());
    });
  }

  OfferProductsModel? productOffers;
  void getOffersProduct() {
    emit(GetProductsOfferLoadingState());
    Mhelper.getData(url: offerProductsURL, token: kToken, query: {
      'lang': kLanguage,
    }).then((value) {
      productOffers = OfferProductsModel.fromJson(value.data);
      log(value.data.toString());
      emit(GetProductsOfferSuccessState());
    }).catchError((error) {
      log('Error in getting offers products: ${error.toString()}');
      emit(GetProductsOfferErrorState());
    });
  }

  void updateFavorite({required int prodId}) {
    log('inside is favorite of sub_cat_cubit');
    Mhelper.postData(
        url: 'api/FavProduct',
        data: {"product_id": prodId},
        token: kToken,
        query: {'lang': kLanguage}).then((value) {
      log(value.data.toString());
      if (value.data['status']) {
        for (int i = 0; i < productOffers!.data!.length; i++) {
          if (productOffers?.data![i].id == prodId) {
            if (productOffers?.data![i].hasFavorites == 0) {
              productOffers?.data![i].hasFavorites = 1;
              emit(GetProductsOfferSuccessState());
              break;
            } else {
              productOffers?.data![i].hasFavorites = 0;
              emit(GetProductsOfferSuccessState());
              break;
            }
          }
        }
      }
    });
  }
}
