import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/app_cubit.dart';
import 'package:safsofa/cubits/app_states.dart';
import 'package:safsofa/screens/add_review_screen.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/components/custom_rating_bar.dart';
import 'package:safsofa/shared/defaults.dart';

class ReviewsAndCommentsScreen extends StatelessWidget {
  const ReviewsAndCommentsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'ReviewsAndComments'.tr(),
      ),
      body: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          double.parse(cubit.productDetailsModel.result
                                  .serviceDetails[0].totalRate)
                              .toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              color: Colors.black),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomRatingBar(
                              itemSize: 30,
                              rating: double.parse(cubit.productDetailsModel
                                  .result.serviceDetails[0].totalRate),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              cubit.productDetailsModel.result.allRate.length
                                      .toString() +
                                  'Review'.tr(),
                              style: TextStyle(
                                  color: Colors.black38, fontSize: 15),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                    height: 50,
                    text: 'AddReview'.tr(),
                    onTap: () {
                      navigateTo(
                          context,
                          AddReviewScreen(
                            prodId: cubit.productDetailsModel.result
                                .serviceDetails[0].id,
                          ));
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  cubit.productReviewsModel == null ||
                          state is GetProductsLoadingState
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        cubit.productReviewsModel.result
                                            .allRates[index].username,
                                        style: TextStyle(fontSize: 17),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomRatingBar(
                                        itemSize: 20,
                                        rating: double.parse(cubit
                                            .productReviewsModel
                                            .result
                                            .allRates[index]
                                            .rateValue),
                                      ),
                                      Text(
                                        cubit.productReviewsModel.result
                                            .allRates[index].createdAt
                                            .toString()
                                            .substring(0, 10),
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    // 'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق'
                                    cubit.productReviewsModel.result
                                        .allRates[index].comments,

                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 5,
                                            mainAxisSpacing: 10,
                                            childAspectRatio: 9 / 8),
                                    itemBuilder: (context, ndx) => Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 0.5)
                                          ],
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(cubit
                                                  .productReviewsModel
                                                  .result
                                                  .allRates[index]
                                                  .allSlider[ndx]
                                                  .image)),
                                          color: Colors.grey.shade400),
                                    ),
                                    itemCount: cubit.productReviewsModel.result
                                        .allRates[index].allSlider.length,
                                  )
                                ],
                              ),
                          separatorBuilder: (context, index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Divider(),
                              ),
                          itemCount:
                              cubit.productReviewsModel.result.allRates.length)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
