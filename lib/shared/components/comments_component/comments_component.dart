import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart%20';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/cubits/reviews_cubit/cubit/reviews_comments_cubit.dart';
import 'package:safsofa/cubits/reviews_cubit/cubit/reviews_comments_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../screens/reviews_and_comments_screen.dart';
import '../../defaults.dart';
import 'package:easy_localization/easy_localization.dart';

import '../custom_label.dart';

class CommentsComponent extends StatelessWidget {
  final int id;
  const CommentsComponent({super.key,
  required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => ReviewsCommentsCubit()..getAllReviews(productId: id),
  child: BlocConsumer<ReviewsCommentsCubit, ReviewsCommentsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit=ReviewsCommentsCubit.get(context);
        return Column(
          children: [

            Divider(),
            Label(text: 'ReviewsAndComments'.tr()),
            if (cubit
                .allReviews
                ?.data
                ?.list
                ?.length ==
                0)
              Text('لايوجد تعليقات على هذا المنتج'),
            if (cubit
                .allReviews !=
                null &&
                (cubit
                    .allReviews
                    ?.data
                    ?.list
                    ?.isNotEmpty ??
                    cubit
                        .allReviews
                        ?.data
                        ?.list !=
                        []))
              BlocConsumer<ReviewsCommentsCubit,
                  ReviewsCommentsState>(
                  listener: (context, state) {

                  },
                  builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        print(
                            ReviewsCommentsCubit.get(
                                context)
                                .allReviews
                                ?.data
                                ?.list![0]
                                .comment);
                      },
                      child: CommentItem(
                        commentAuthorName:
                        ReviewsCommentsCubit.get(
                            context)
                            .allReviews
                            ?.data
                            ?.list![0]
                            .clientName,
                        commentCreationDate:
                        ReviewsCommentsCubit.get(
                            context)
                            .allReviews
                            ?.data
                            ?.list![0]
                            .date,
                        commentText:
                        ReviewsCommentsCubit.get(
                            context)
                            .allReviews
                            ?.data
                            ?.list![0]
                            .comment,
                        ratingValue:
                        ReviewsCommentsCubit.get(
                            context)
                            .allReviews
                            ?.data
                            ?.list![0]
                            .rate,
                        imagesUrl:
                        ReviewsCommentsCubit.get(
                            context)
                            .allReviews
                            ?.data
                            ?.list![0]
                            .listImg,
                      ),
                    );
                  }),
            SizedBox(
              height: 7,
            ),
            if (cubit
                .allReviews !=
                null &&
                (cubit
                    .allReviews
                    ?.data
                    ?.list
                    ?.isNotEmpty ??
                    cubit
                        .allReviews
                        ?.data
                        ?.list !=
                        []))
              GestureDetector(
                onTap: () {
                  // cubit.getProductReviews(
                  //     productId: cubit.productDetailsModel.data
                  //         .productDetails[0].id);
                  navigateTo(
                      context,
                      ReviewsAndCommentsScreen(
                        productId: id,
                      ));
                },
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${'More'.tr()}',
                      style:
                      TextStyle(fontSize: 16.sp),
                    ),
                    Icon(
                      Icons
                          .arrow_forward_ios_outlined,
                      color: Colors.grey,
                      size: 20,
                    )
                  ],
                ),
              ),
            SizedBox(
              height: 7,
            ),
            Divider(),
          ],
        );
      },
    ),
);
  }
}
