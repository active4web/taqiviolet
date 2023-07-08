import 'package:safsofa/network/remote/dio_Mhelper.dart';

import '../../models/new_card_details_model.dart';
import '../../models/new_list_cards_model.dart';
import '../../shared/constants.dart';
import 'new_gifts_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewGiftsCubit extends Cubit<NewGiftsStates> {
  NewGiftsCubit() : super(NewGiftsInitState());

  static NewGiftsCubit get(context) => BlocProvider.of(context);


  NewListCardsModel? newListCardsModel;
  getAllNewGiftsData()
  {
    emit(GetAllNewGiftsLoadingState());
    Mhelper.getData(
        url: "api/listcards",
    )
        .then((value){
          newListCardsModel = NewListCardsModel.fromJson(value.data);
          print(newListCardsModel!.data!.listcards!.length);
          print("done -----------");
          emit(GetAllNewGiftsSuccessState());
    }).catchError((error){
      print("error in get all new Gifts data ${error.toString()}");
      emit(GetAllNewGiftsErrorState());
    });
  }

  NewCardDetailsModel? newCardDetailsModel;
  getNewGiftsDetailsData({
    required int id,
})
  {
    emit(GetNewGiftsDetailsLoadingState());
    Mhelper.getData(
      url: "api/carddetails?list_id=${id}",
    )
        .then((value){
      newCardDetailsModel = NewCardDetailsModel.fromJson(value.data);
      print(newCardDetailsModel!.data!.listcardprice);
      print("done -----------");
      emit(GetNewGiftsDetailsSuccessState());
    }).catchError((error){
      print("error in get new Gifts details data ${error.toString()}");
      emit(GetNewGiftsDetailsErrorState());
    });
  }

  String? newImage = "";
  int? newImageId;
  changeImage(String image, int imageId){
    newImage = image;
    newImageId = imageId;
    emit(ChangeImageState());
  }

  String? newPrice = "";
  int? newPriceId;
  changePrice(String price , int priceId){
    newPrice = price;
    newPriceId = priceId;
    emit(ChangePriceState());
  }


  addNewCard({
    required int cartId,
    required String phone,
    required String message,
    required String senderName,
    required String price,
    required int imgId,
    required int priceId,
})
  {
    emit(SendNewCardLoadingState());
    Mhelper.postData(
        url: "api/sendcard",
      data: {
          "lang" : "ar",
          "cart_id" : cartId,
          "phone" : phone,
          "sender_name" : senderName,
          "message" : message,
          "price" : price,
          "payment_type" : 1,
          "result_payment" : 1,
          "payment_number" : "123456789",
          "img_id" : imgId,
          "price_id" : priceId,
      },
      token: kToken,
    ).then((value){
      print(value.data);
      print("------ send is don ----------");
      emit(SendNewCardSuccessState());
    }).catchError((error){
      print("error in send card ${error.toString()}");
      emit(SendNewCardErrorState());
    });
  }
}