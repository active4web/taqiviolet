import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/cubits/reviews_cubit/cubit/reviews_comments_state.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/reviews_cubit/cubit/reviews_comments_cubit.dart';
import 'package:intl/intl.dart';

class ReviewsAndCommentsScreen extends StatelessWidget {
  final int productId;
  const ReviewsAndCommentsScreen({Key key, @required this.productId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'ReviewsAndComments'.tr(),
      ),
      body: BlocProvider(
        create: (context) =>
            ReviewsCommentsCubit()..getAllReviews(productId: productId),
        child: BlocConsumer<ReviewsCommentsCubit, ReviewsCommentsState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return state is AllReviewsSuccessState
                ? ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 70,
                      vertical: MediaQuery.of(context).size.height / 60,
                    ),
                    itemBuilder: (context, index) => CommentItem(
                      commentAuthorName: ReviewsCommentsCubit.get(context)
                          .allReviews
                          .data
                          .list[index]
                          .clientName,
                      commentCreationDate: ReviewsCommentsCubit.get(context)
                          .allReviews
                          .data
                          .list[index]
                          .date,
                      commentText: ReviewsCommentsCubit.get(context)
                          .allReviews
                          .data
                          .list[index]
                          .comment,
                      ratingValue: ReviewsCommentsCubit.get(context)
                          .allReviews
                          .data
                          .list[index]
                          .rate,
                      imagesUrl: ReviewsCommentsCubit.get(context)
                          .allReviews
                          .data
                          .list[index]
                          .listImg,
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                    itemCount: ReviewsCommentsCubit.get(context)
                        .allReviews
                        .data
                        .list
                        .length,
                  )
                : Center(
                    child: CircularProgressIndicator(color: kDarkGoldColor),
                  );
          },
        ),
      ),
    );
  }
}

class CommentItem extends StatelessWidget {
  final String commentAuthorName;
  final String commentCreationDate;
  final String commentText;
  final String ratingValue;
  final List<String> imagesUrl;
  const CommentItem(
      {Key key,
      @required this.commentAuthorName,
      @required this.commentCreationDate,
      @required this.commentText,
      @required this.ratingValue,
      this.imagesUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 55,
            vertical: MediaQuery.of(context).size.height / 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  commentAuthorName,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  DateFormat.yMd()
                      .add_jm()
                      .format(DateTime.parse(commentCreationDate)),
                  style: TextStyle(color: Colors.blue),
                )
              ],
            ),
            RatingBarIndicator(
              direction: Axis.horizontal,
              itemCount: 5,
              rating: double.parse(ratingValue),
              itemSize: 24,
              itemBuilder: (context, index) => Icon(
                Icons.star_purple500_sharp,
                color: Colors.amber,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 80,
            ),
            Text(
              commentText,
              style: TextStyle(color: Colors.brown.shade700, fontSize: 14),
            ),
            if (imagesUrl.isNotEmpty)
              ExpansionTile(
                tilePadding: EdgeInsets.zero,
                title: Text(
                  "pictures".tr(),
                  style: TextStyle(
                    color: kDarkGoldColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Image(
                          height: MediaQuery.of(context).size.width / 5,
                          width: MediaQuery.of(context).size.width / 2,
                          image: NetworkImage(imagesUrl[index]),
                          fit: BoxFit.cover,
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        width: 15,
                      ),
                      itemCount: imagesUrl.length,
                    ),
                  )
                ],
              )
          ],
        ),
      ),
    );
  }
}
