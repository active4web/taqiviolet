import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/cubits/app_cubit.dart';
import 'package:safsofa/cubits/app_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/screens/bottom_navigation_screens/cart_screen.dart';
import 'package:safsofa/screens/reviews_and_comments_screen.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:safsofa/shared/components/custom_rating_bar.dart';
import 'package:safsofa/shared/components/store_components/product_cards.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key key}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

int quantity = 1;
bool isFavourite = false;

// Future<void> getFav(context) async {
//   AppCubit cubit = AppCubit.get(context);
//   isFavourite =
//       await cubit.productDetailsModel.result.serviceDetails[0].favExit == 1
//           ? true
//           : false;
// }

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    // getFav(context);
    // setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PageController pageController = new PageController();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          extendBodyBehindAppBar: true,
          body: cubit.productDetailsModel == null ||
                  state is GetProductDetailsLoadingState
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
                                            .result
                                            .serviceDetails[0]
                                            .productImage),
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
                              Label(
                                text: cubit.productDetailsModel.result
                                    .serviceDetails[0].serviceName,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Purchased'.tr() +
                                        ' : ' +
                                        ' ${cubit.productDetailsModel.result.serviceDetails[0].totalSales} ' +
                                        'Times'.tr(),
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 15),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  CustomRatingBar(
                                    itemSize: 20,
                                    rating: double.parse(cubit
                                        .productDetailsModel
                                        .result
                                        .serviceDetails[0]
                                        .totalRate),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    double.parse(cubit.productDetailsModel
                                            .result.serviceDetails[0].totalRate)
                                        .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        color: Colors.black54),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        cubit.productDetailsModel.result
                                            .serviceDetails[0].price,
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
                                        cubit.productDetailsModel.result
                                            .serviceDetails[0].oldPrice,
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
                                quantity: quantity,
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
                                      height: 50,
                                      text: 'AddToCart'.tr(),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      cubit.productDetailsModel.result
                                              .serviceDetails[0].isFav =
                                          !cubit.productDetailsModel.result
                                              .serviceDetails[0].isFav;
                                      cubit.updateFavourite(
                                          prodId: cubit.productDetailsModel
                                              .result.serviceDetails[0].id,
                                          isFav: cubit.productDetailsModel
                                              .result.serviceDetails[0].isFav);
                                      print(cubit.productDetailsModel.result
                                          .serviceDetails[0].isFav);
                                      setState(() {});
                                    },
                                    icon: cubit.productDetailsModel.result
                                            .serviceDetails[0].isFav
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
                                    onPressed: () {},
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
                                cubit.productDetailsModel.result
                                    .serviceDetails[0].description,
                                style: TextStyle(color: Colors.black54),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
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
                                        child: HorizontalProductCard()),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                          width: 10,
                                        ),
                                    itemCount: 4),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        );
      },
    );
  }
}
