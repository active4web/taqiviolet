import 'dart:io';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/cubits/reviews_cubit/cubit/reviews_comments_cubit.dart';
import 'package:safsofa/cubits/reviews_cubit/cubit/reviews_comments_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/shared/constants.dart';

import '../../../screens/reviews_and_comments_screen.dart';
import '../../defaults.dart';
import 'package:easy_localization/easy_localization.dart';

import '../custom_button.dart';
import '../custom_label.dart';
import '../description_text_field.dart';

class CommentsComponent extends StatefulWidget {
  final int id;

  const CommentsComponent({super.key, required this.id});

  @override
  State<CommentsComponent> createState() => _CommentsComponentState();
}

class _CommentsComponentState extends State<CommentsComponent> {
  @override
  void initState() {
    ReviewsCommentsCubit.get(context)..getAllReviews(productId: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReviewsCommentsCubit, ReviewsCommentsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ReviewsCommentsCubit.get(context);
        return Column(
          children: [
            Divider(),
            // TextButton(onPressed: (){}, child: Text(
            //     'add review +',style: TextStyle(
            //   fontWeight: FontWeight.bold
            // ),
            // )),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => BlocConsumer<ReviewsCommentsCubit,
                            ReviewsCommentsState>(
                          listener: (context, state) {
                            if (state is ProductReviewSuccess) {
                              Navigator.pop(context);
                            }
                          },
                          builder: (context, state) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom,
                                  right: 10.w,
                                  left: 10.w),
                              child: Wrap(
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Center(
                                          child: Text(
                                        'AddReview'.tr(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.sp,
                                            color: kCustomBlack),
                                      )),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Center(
                                        child: RatingBar.builder(
                                          initialRating: cubit.rate ?? 0.0,
                                          minRating: 1,
                                          itemSize: 40,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          glowColor: Color(0xffF3E184),
                                          unratedColor: Color(0xffCFD8DC),
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 1, vertical: 5),
                                          onRatingUpdate: (value) {
                                            cubit.changeRate(value: value);
                                          },
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star_rate_rounded,
                                            color: Color(0xffF3E184),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      DescriptionTextField(
                                        hintText:
                                            "Write your comment on the product"
                                                .tr(),
                                        controller: cubit.commentController,
                                        maxLines: 6,
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        'ProductImages'.tr(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      InkWell(
                                        onTap: () => cubit.geImageGallery1(),
                                        child: Icon(Icons.add_a_photo_outlined),
                                      ),
                                      if (cubit.images != null &&
                                          cubit.images!.isNotEmpty)
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              5,
                                          child: ListView.separated(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        60),
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) =>
                                                ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Stack(
                                                children: [
                                                  Image(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2,
                                                    image: FileImage(
                                                      File(cubit
                                                          .images![index].path),
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      cubit.removeImage(
                                                          value: index);
                                                    },
                                                    child: CircleAvatar(
                                                      backgroundColor: Colors
                                                          .white
                                                          .withOpacity(0.7),
                                                      child: Icon(
                                                        Icons.close,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            separatorBuilder:
                                                (context, index) => SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  30,
                                            ),
                                            itemCount: cubit.images!.length,
                                          ),
                                        ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      state is ProductReviewLoading
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator())
                                          : CustomButton(
                                              height: 50.h,
                                              text: 'AddReview'.tr(),
                                              onTap: () {
                                                cubit.addProductReview(
                                                    id: widget.id);
                                              },
                                            ),
                                      SizedBox(
                                        height: 10.h,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ));
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  color: kCustomBlack,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30))
                ),
                child: Center(
                  child: Text(
                    'addReview'.tr(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: kDarkGoldColor,fontSize: 12.sp),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5.h,),
            Label(text: 'ReviewsAndComments'.tr()),
            if (cubit.allReviews?.data?.list?.length == 0)
              Text("dontHaveComments".tr(),style: TextStyle(
                fontSize: 9.sp
              ),),
            if (cubit.allReviews != null &&
                (cubit.allReviews?.data?.list?.isNotEmpty ??
                    cubit.allReviews?.data?.list != []))
              BlocConsumer<ReviewsCommentsCubit, ReviewsCommentsState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        print(ReviewsCommentsCubit.get(context)
                            .allReviews
                            ?.data
                            ?.list![0]
                            .comment);
                      },
                      child: CommentItem(
                        commentAuthorName: ReviewsCommentsCubit.get(context)
                            .allReviews
                            ?.data
                            ?.list![0]
                            .clientName,
                        commentCreationDate: ReviewsCommentsCubit.get(context)
                            .allReviews
                            ?.data
                            ?.list![0]
                            .date,
                        commentText: ReviewsCommentsCubit.get(context)
                            .allReviews
                            ?.data
                            ?.list![0]
                            .comment,
                        ratingValue: ReviewsCommentsCubit.get(context)
                            .allReviews
                            ?.data
                            ?.list![0]
                            .rate,
                        imagesUrl: ReviewsCommentsCubit.get(context)
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
            if (cubit.allReviews != null &&
                (cubit.allReviews?.data?.list?.isNotEmpty ??
                    cubit.allReviews?.data?.list != []))
              GestureDetector(
                onTap: () {
                  // cubit.getProductReviews(
                  //     productId: cubit.productDetailsModel.data
                  //         .productDetails[0].id);
                  navigateTo(
                      context,
                      ReviewsAndCommentsScreen(
                        productId: widget.id,
                      ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${'More'.tr()}',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
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
    );
  }
}
