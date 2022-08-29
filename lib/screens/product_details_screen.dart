import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/appCubit/app_states.dart';
import 'package:safsofa/screens/bottom_navigation_screens/cart_screen.dart';
import 'package:safsofa/screens/reviews_and_comments_screen.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:safsofa/shared/components/store_components/product_cards.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../cubits/listsCubit/lists_cubit.dart';
import 'Lists.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key key}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

int quantity = 1;
bool isFavourite = false;

Future<void> getFav(context) async {
  AppCubit cubit = AppCubit.get(context);
  // isFavourite =
  //     await cubit.productDetailsModel?.data.productDetails[0]. == 1
  //         ? true
  //         : false;
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    //getFav(context);
    // setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PageController pageController = new PageController();
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        print("99999999999999999999999999999999999999999   $state");
        print(cubit.productDetailsModel);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          extendBodyBehindAppBar: true,
          body: cubit.productDetailsModel == null
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(color: Color(0xffF5F6F8)),
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                child: PageView.builder(
                                  controller: pageController,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 4,
                                  itemBuilder: (context, index) => Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    decoration: BoxDecoration(
                                      color: kBGColor,
                                      image: DecorationImage(
                                        image: NetworkImage(cubit
                                            .productDetailsModel
                                            .data
                                            .productDetails[0]
                                            .images),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SmoothPageIndicator(
                                  controller: pageController, // PageController
                                  count: 4,
                                  effect: WormEffect(
                                      dotWidth: 12,
                                      dotColor: Colors.grey.shade300,
                                      dotHeight: 12), // your preferred effect
                                  onDotClicked: (index) {})
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 0.5,
                                  spreadRadius: 0.1)
                            ],
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30))),
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 30),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      cubit.productDetailsModel.data
                                          .productDetails[0].name,
                                      maxLines: null,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: 10,
                              ),
                              // Row(
                              //   children: [
                              //     Text(
                              //       'Purchased'.tr() +
                              //           ' : ' +
                              //           ' ${cubit.productDetailsModel.data.productDetails[0].} ' +
                              //           'Times'.tr(),
                              //       style: TextStyle(
                              //           color: Colors.green, fontSize: 15),
                              //     )
                              //   ],
                              // ),
                              SizedBox(
                                height: 10,
                              ),
                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.end,
                              //   children: [
                              //     // CustomRatingBar(
                              //     //   itemSize: 20,
                              //     //   rating: double.parse(cubit
                              //     //       .productDetailsModel
                              //     //       .productDetails
                              //     //       .productDetails[0].),
                              //     // ),
                              //     SizedBox(
                              //       width: 10,
                              //     ),
                              //     // Text(
                              //     //   double.parse(cubit.productDetailsModel
                              //     //           .result.serviceDetails[0].totalRate)
                              //     //       .toString(),
                              //     //   style: TextStyle(
                              //     //       fontWeight: FontWeight.bold,
                              //     //       fontSize: 17,
                              //     //       color: Colors.black54),
                              //     // )
                              //   ],
                              // ),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        cubit.productDetailsModel.data
                                            .productDetails[0].price
                                            .toString(),
                                        style: TextStyle(
                                            color: Color(0xffFE9C8F),
                                            fontSize: 20),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'ريال',
                                        style: TextStyle(
                                            color: Color(0xffFE9C8F),
                                            fontSize: 20),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        cubit.productDetailsModel.data
                                                .productDetails[0].discount
                                                .toString() ??
                                            "",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontSize: 17),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'ريال',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontSize: 17),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CounterRow(
                                fontSize: 20,
                                containerSize: 36,
                                quantity: quantity.toString(),
                                onAdd: () {
                                  quantity++;
                                  setState(() {});
                                },
                                onRemove: () {
                                  if (quantity > 0) quantity--;
                                  setState(() {});
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomButton(
                                      onTap: () {
                                        cubit.AddToCart(
                                            quantity: quantity,
                                            product_id: cubit
                                                .productDetailsModel
                                                .data
                                                .relatedProducts[0]
                                                .id);
                                      },
                                      height: 50,
                                      text: 'AddToCart'.tr(),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      // cubit.productDetailsModel.productDetails.productDetails[0].hasFavorites
                                      //         .serviceDetails[0].isFav =
                                      //     !cubit.productDetailsModel.result
                                      //         .serviceDetails[0].isFav;
                                      // cubit.updateFavourite(
                                      //     prodId: cubit.productDetailsModel
                                      //         .result.serviceDetails[0].id,
                                      //     isFav: cubit.productDetailsModel
                                      //         .result.serviceDetails[0].isFav);
                                      // print(cubit.productDetailsModel.result
                                      //     .serviceDetails[0].isFav);
                                      // setState(() {});
                                    },
                                    icon:
                                        false //cubit.productDetailsModel.data.productDetails[0].hasFavorites==0

                                            ? Icon(
                                                CupertinoIcons.heart_fill,
                                                size: 35,
                                                color: Color(0xffFE9C8F),
                                              )
                                            : Icon(
                                                CupertinoIcons.heart,
                                                size: 35,
                                                color: Colors.black26,
                                              ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      ListsCubit.get(context)
                                              .productDetailsModel =
                                          cubit.productDetailsModel;

                                      print("77777777777777777777777777");
                                      print(ListsCubit.get(context)
                                              .productDetailsModel ==
                                          null);
                                      navigateTo(context, MyLists());

                                      //cubit
                                    },
                                    icon: Icon(
                                      CupertinoIcons.share,
                                      size: 30,
                                      color: Colors.black26,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Label(
                                text: 'ProductDetails'.tr(),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                cubit.productDetailsModel.data.productDetails[0]
                                    .details,
                                style: TextStyle(color: Colors.black54),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              if (cubit.productDetailsModel.data.productFeatures
                                  .isNotEmpty)
                                Label(
                                  text: 'ProductFeatures'.tr(),
                                ),
                              if (cubit.productDetailsModel.data.productFeatures
                                  .isNotEmpty)
                                SizedBox(
                                  height: 10,
                                ),
                              if (cubit.productDetailsModel.data.productFeatures
                                  .isNotEmpty)
                                ListView.separated(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) => Row(
                                          children: [
                                            Text(
                                              '${cubit.productDetailsModel.data.productFeatures[index].name}: ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              '${cubit.productDetailsModel.data.productFeatures[index].description}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                          height: 10,
                                        ),
                                    itemCount: cubit.productDetailsModel.data
                                        .productFeatures.length),
                              if (cubit.productDetailsModel.data.productFeatures
                                  .isNotEmpty)
                                SizedBox(
                                  height: 10,
                                ),
                              Divider(),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  cubit.getProductReviews(
                                      productId: cubit.productDetailsModel.data
                                          .productDetails[0].id);
                                  navigateTo(
                                      context, ReviewsAndCommentsScreen());
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Label(text: 'ReviewsAndComments'.tr()),
                                    IconButton(
                                        onPressed: () {
                                          cubit.getProductReviews(
                                              productId: cubit
                                                  .productDetailsModel
                                                  .data
                                                  .productDetails[0]
                                                  .id);
                                          navigateTo(context,
                                              ReviewsAndCommentsScreen());
                                        },
                                        icon: Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          color: Colors.grey,
                                          size: 20,
                                        ))
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(),
                              SizedBox(
                                height: 20,
                              ),
                              Label(
                                text: 'RelatedProducts'.tr(),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.17,
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) => SizedBox(
                                        width: 300,
                                        child: HorizontalProductCard(
                                          relatedProducts: cubit
                                              .productDetailsModel
                                              .data
                                              .relatedProducts[index],
                                        )),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                          width: 10,
                                        ),
                                    itemCount: cubit.productDetailsModel.data
                                        .relatedProducts.length),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
