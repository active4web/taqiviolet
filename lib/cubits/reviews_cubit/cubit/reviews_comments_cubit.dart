import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/reviews_cubit/cubit/reviews_comments_state.dart';
import 'package:safsofa/models/reviews_comments_model.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/shared/constants.dart';

class ReviewsCommentsCubit extends Cubit<ReviewsCommentsState> {
  ReviewsCommentsCubit() : super(ReviewsCommentsInitial());

  static ReviewsCommentsCubit get(context) => BlocProvider.of(context);

ReviewsCommentsModel allReviews;

  void getAllReviews({@required int productId}) {
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
}
