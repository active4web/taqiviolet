import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safsofa/cubits/reviews_cubit/cubit/reviews_comments_state.dart';
import 'package:safsofa/models/reviews_comments_model.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/screens/new/personel_page/help/toast/toast.dart';
import 'package:safsofa/screens/new/personel_page/help/toast/toast_states.dart';
import 'package:safsofa/shared/constants.dart';

class ReviewsCommentsCubit extends Cubit<ReviewsCommentsState> {
  ReviewsCommentsCubit() : super(ReviewsCommentsInitial());

  static ReviewsCommentsCubit get(context) => BlocProvider.of(context);

ReviewsCommentsModel? allReviews;

  void getAllReviews({required int productId}) {
    emit(AllReviewsLoadingState());
    Mhelper.getData(url: 'api/allReviews', token: kToken, query: {
      'lang': kLanguage,
      'prod_id': '$productId',
    }).then((value) {
      allReviews=ReviewsCommentsModel.fromJson(value.data);
      log('Reviews data is: ${value.data }');
       emit(AllReviewsSuccessState());
    }).catchError((error){
      log('error:${error}');
       emit(AllReviewsErrorState());
    });
  }

  List<XFile>? images;

  Future geImageGallery1() async {
    images = await ImagePicker().pickMultiImage();
    emit(ImageSuccess());
  }
  removeImage({required int value}){
    images?.removeAt(value);
    emit(ChangeRate());
  }
  var commentController=TextEditingController();
  double? rate;
  changeRate({required double value}){
    rate=value;
    emit(ChangeRate());
  }
  Future<void> addProductReview({required int id})async{
    emit(ProductReviewLoading());
    final response=await Mhelper.postData(url: 'api/reviews',token: kToken, data: FormData.fromMap(
        {
          "rate":rate,
          "product_id":id,
          "comment":commentController.text,
          // if(images!=null)
          // "img[]":images==null?null:await MultipartFile.fromFile(images?[0].path ?? '')
        }
    ));
    if(response.data['status']){
      emit(ProductReviewSuccess());
      getAllReviews(productId: id);
      commentController.clear();
      rate=0.0;
      ToastConfig.showToast(msg: 'add comment successfully', toastStates: ToastStates.success);
    }else{
      emit(ProductReviewError());
    }
}
}
