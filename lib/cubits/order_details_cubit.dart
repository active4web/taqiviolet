import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../models/order_details.dart';
import '../network/local/cache_helper.dart';
import '../network/remote/dio_Mhelper.dart';
import '../shared/constants.dart';

part 'order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit() : super(OrderDetailsInitial());

  static OrderDetailsCubit get(context) => BlocProvider.of(context);
  OrderDetailsModel? orderDetails;

  void getOrderDetails(int id, [bool withLoading = true]) {
    if (withLoading) {
      emit(OrderDetailsLoadingState());
    }

    Mhelper.postData(
        token: CacheHelper.getData("token"),
        url: orderDetailsURL,
        data: {
          "order_id": '$id',
        },
        query: {
          'lang': kLanguage,
        }).then((value) {
      orderDetails = OrderDetailsModel.fromJson(value.data);
      log("my order 000000000000000000000000000000000000");
      log(value.data.toString());
      log("my order 000000000000000000000000000000000000");
      emit(OrderDetailsSuccessState());
    }).catchError((error) {
      emit(OrderDetailsErrorState());
      log(error.toString());
    });
  }

  Future<Response> addReviewForProduct({
    required int productId,
    required int orderId,
    required String rate,
    required String comment,
    required List<XFile> reviewImages,
  }) async {
    log('Rating value: ${rate}');
    emit(OrderDetailsLoadingState());
    List uploadList = [];
    if (reviewImages != null && reviewImages.isNotEmpty) {
      for (int i = 0; i < reviewImages.length; i++) {
        MultipartFile multipartFile = MultipartFile.fromFileSync(
          reviewImages[i].path,
        );
        uploadList.add([multipartFile]);
      }
    }
    var response =
        await Mhelper.postData(token: kToken, url: 'api/reviews', data: {
      "rate": rate,
      "product_id": "$productId",
      "comment": comment,
      "order_id": "$orderId",
      if (uploadList.isNotEmpty) "img": await uploadList,
    }, query: {
      'lang': kLanguage,
    });
    if (response.data['status']) {
      emit(OrderDetailsSuccessState());
    } else {
      emit(OrderDetailsErrorState());
    }
    return response;
  }
}
