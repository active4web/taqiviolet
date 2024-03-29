import 'dart:developer';
import 'package:badges/badges.dart';
import 'package:badges/badges.dart' as badges;
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/appCubit/app_states.dart';
import 'package:safsofa/cubits/cartCubit/cart_cubit.dart';
 import 'package:safsofa/screens/bottom_navigation_screens/cart_screen.dart';
 import 'package:safsofa/screens/home_layout.dart';
import 'package:safsofa/screens/reviews_and_comments_screen.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:safsofa/shared/components/custom_network_image.dart';
import 'package:safsofa/shared/components/custom_text_form_field.dart';
import 'package:safsofa/shared/components/store_components/product_cards.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

 import '../cubits/cartCubit/cart_state.dart';
import '../network/local/cache_helper.dart';

class ProductDetailsScreen extends StatefulWidget {
  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

int quantity = 1;
bool isFavourite = false;
bool isSmartFeatureSelected = false;
GlobalKey<FormState> _formKey = GlobalKey<FormState>();

Future<void> getFav(context) async {
  // AppCubit cubit = AppCubit.get(context);
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
    // CartCubit.get(context).getServerCartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(CacheHelper.getData("token"));

    String featureSize = '';
    PageController pageController = new PageController();
    AppCubit cubit = AppCubit.get(context);
    // print(cubit.productDetailsModel!.data!.productDetails![0].smartPrice);
    // print(cubit.productDetailsModel!.data!.productDetails![0].smartType);
    // print(cubit.productDetailsModel!.data!.productDetails![0].hascart);
    // print(cubit.productDetailsModel!.data!.productDetails![0].id);
    print("mostafa bahr");
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(state is  AddToCartSuccessState){
          cubit.getProductDetails(
            productId: cubit.productDetailsModel!.data!.productDetails![0].id,
          );
          showToast(text: "تمت اضافه المنتج بنجاح", color: Colors.green);
        }
        if(state is GetConstructionSuccessState){
          showToast(text: "تمت اضافه المنتج بنجاح", color: Colors.green);
        }
      },
      builder: (context, state) {
        log("99999999999999999999999999999999999999999   $state");
        // log('${cubit.productDetailsModel!.data!.productDetails![0].smartPrice}');
        // log("99999999999999999999999999999999999999999   $state");
        return
          (cubit.productDetailsModel != null &&
              state is GetProductDetailsSuccessState) ||
              state is GetFavoritesListLoading
              ?  Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white70,
                statusBarIconBrightness: Brightness.dark),
            actions: [
              badges.Badge(
                position: badges.BadgePosition.topEnd(top: 5, end: 8),
                badgeContent: Text('${cubit.productDetailsModel!.data!.productDetails![0].cartTotal}',
                  style: TextStyle(
                    color: Colors.white,
                  ),),
                child:  IconButton(onPressed: (){
                  cubit.selectedIndex = 2;
                  navigateAndFinish(context, HomeLayout());
                }, icon: Icon(Icons.shopping_cart)),
              ),
              PopupMenuButton(                 onSelected: (value){
                if(value == 'home'){
                  cubit.selectedIndex =0;
                  navigateAndFinish(context, HomeLayout());
                }else if(value == 'favourite'){
                  print('fav');
                  cubit.selectedIndex = 1;
                  navigateAndFinish(context, HomeLayout());
                }
                // else{
                //   print(value);
                //   cubit.selectedIndex = 2;
                //   navigateAndFinish(context, HomeLayout());
                // }
              },
                  itemBuilder: (BuildContext context){
                    return [

                      PopupMenuItem(child: Text('Home'.tr(),),
                        value: 'home',
                      ),
                      PopupMenuItem(child: Text('Favourites'.tr(),),value: 'favourite'),
                      // PopupMenuItem(child: Text('Cart'.tr(),),value: 'cart'),

                    ];
                  }),
            ],
          ),
          // extendBodyBehindAppBar: true,
          body: (cubit.productDetailsModel != null &&
              state is GetProductDetailsSuccessState) ||
              state is GetFavoritesListLoading
              ? SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.white),
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
                            itemCount: cubit.productDetailsModel!.data!
                                .productDetails![0].images!.length,
                            itemBuilder: (context, index) => Container(
                              height: MediaQuery.of(context).size.height *
                                  0.3,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                  image: NetworkImage(cubit
                                      .productDetailsModel!
                                      .data!
                                      .productDetails![0]
                                      .images![index]),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SmoothPageIndicator(
                            controller: pageController, // PageController
                            count: cubit.productDetailsModel!.data!
                                .productDetails![0].images!.length,
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
                                "${cubit.productDetailsModel?.data?.productDetails![0].name}",
                                maxLines: null,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                  cubit.productDetailsModel!.data!
                                      .productDetails![0].currentPrice
                                      .toString(),
                                  style: TextStyle(
                                      color: Color(0xffFE9C8F),
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "SAR".tr(),
                                  style: TextStyle(
                                      color: Color(0xffFE9C8F),
                                      fontSize: 18),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            if (cubit.productDetailsModel?.data
                                ?.productDetails![0].oldPrice !=
                                0)
                              Row(
                                children: [
                                  Text(
                                    cubit.productDetailsModel!.data!
                                        .productDetails![0].oldPrice
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.grey,
                                        decoration:
                                        TextDecoration.lineThrough,
                                        fontSize: 14),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "SAR".tr(),
                                    style: TextStyle(
                                        color: Colors.grey,
                                        decoration:
                                        TextDecoration.lineThrough,
                                        fontSize: 14),
                                  )
                                ],
                              ),
                          ],
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        if (cubit.productDetailsModel?.data
                            ?.productDetails![0].smartPrice !=
                            0 &&
                            cubit.productDetailsModel?.data
                                ?.productDetails![0].smartPrice !=
                                null)
                          SizedBox(
                            height: 8,
                          ),
                        if (cubit.productDetailsModel?.data
                            ?.productDetails![0].smartPrice !=
                            0 &&
                            cubit.productDetailsModel?.data
                                ?.productDetails![0].smartPrice !=
                                null)
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${"priceSmartControlFeature".tr()}${cubit.productDetailsModel?.data?.productDetails![0].smartPrice} ${"SAR".tr()}",
                                        style: TextStyle(
                                            color: Color(0xffFE9C8F),
                                            fontSize: 12),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    // SizedBox(
                                    //   width: 3,
                                    // ),
                                    // Text(
                                    //   cubit.productDetailsModel!.data!
                                    //       .productDetails![0].currentPrice
                                    //       .toString(),
                                    //   style: TextStyle(
                                    //       color: Color(0xffFE9C8F),
                                    //       fontSize: 14),
                                    // ),
                                    // // SizedBox(
                                    // //   width: 3,
                                    // // ),
                                    // Text(
                                    //   "SAR".tr(),
                                    //   style: TextStyle(
                                    //       color: Color(0xffFE9C8F),
                                    //       fontSize: 14),
                                    // )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              if (cubit.productDetailsModel?.data
                                  ?.productDetails![0].oldPrice !=
                                  0)
                                Row(
                                  children: [
                                    Text(
                                      cubit.productDetailsModel!.data!
                                          .productDetails![0].oldPrice
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.grey,
                                          decoration:
                                          TextDecoration.lineThrough,
                                          fontSize: 14),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "SAR".tr(),
                                      style: TextStyle(
                                          color: Colors.grey,
                                          decoration:
                                          TextDecoration.lineThrough,
                                          fontSize: 14),
                                    )
                                  ],
                                ),
                            ],
                          ),
                        if (cubit.productDetailsModel?.data
                            ?.productDetails![0].smartPrice !=
                            0 &&
                            cubit.productDetailsModel?.data
                                ?.productDetails![0].smartPrice !=
                                null)
                          SizedBox(
                            height: 5,
                          ),
                        if (
                        cubit.productDetailsModel?.data?.productDetails![0].smartPrice != 0 &&
                            cubit.productDetailsModel?.data?.productDetails![0].smartPrice != null
                        )
                          Row(
                            children: [
                              Transform.scale(
                                scale: 1,
                                child: Checkbox(
                                  activeColor: Colors.green,
                                  value: isSmartFeatureSelected,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isSmartFeatureSelected = value!;
                                      print(isSmartFeatureSelected);
                                      print("web");
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Expanded(
                                  child: Text(
                                    'chooseSmartControlFeature'.tr(),
                                  )),
                            ],
                          ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              "${cubit.productDetailsModel?.data?.productDetails![0].deliveryTime}",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.green.shade300,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        
                        // Row(
                        //   children: [
                        //     Text(
                        //       '${"priceWithTheSmartControlFeature".tr()} ${cubit.productDetailsModel?.data?.productDetails![0].smartPrice} ${"SAR".tr()}',
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //         color: kDarkGoldColor.withOpacity(0.8),
                        //         fontSize: 18,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              "notePricesIncludeVAT".tr(),
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.green.shade300,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        // if (cubit.productDetailsModel?.data
                        //             ?.productDetails![0].smartPrice !=
                        //         0 &&
                        //     cubit.productDetailsModel?.data
                        //             ?.productDetails![0].smartPrice !=
                        //         null)
                        //   Row(
                        //     children: [
                        //       Expanded(
                        //         child: StatefulBuilder(
                        //             builder: (context, setState) {
                        //           return ListTile(
                        //             contentPadding: EdgeInsets.zero,
                        //             leading: Checkbox(
                        //               value: isSmartFeatureSelected,
                        //               onChanged: (val) {
                        //                 setState(() {
                        //                   isSmartFeatureSelected =
                        //                       !isSmartFeatureSelected;
                        //                 });
                        //               },
                        //               activeColor: kDarkGoldColor,
                        //               checkColor: Color.fromARGB(
                        //                   255, 238, 213, 138),
                        //             ),
                        //             title: Text(
                        //               "chooseTheSmartControlFeature".tr(),
                        //               style: TextStyle(
                        //                 fontSize: 16,
                        //                 color: Colors.black87,
                        //                 fontWeight: FontWeight.w700,
                        //               ),
                        //             ),
                        //           );
                        //         }),
                        //       ),
                        //     ],
                        //   ),
                        if (cubit.productDetailsModel?.data
                            ?.productDetails![0].smartPrice !=
                            0 &&
                            cubit.productDetailsModel?.data
                                ?.productDetails![0].smartPrice !=
                                null)
                          SizedBox(
                            height: 5,
                          ),
                        Row(
                          children: [
                            cubit
                                .productDetailsModel!
                                .data!
                                .productDetails![0]
                                .quantity!
                                .isNotEmpty &&
                                cubit
                                    .productDetailsModel
                                    ?.data
                                    ?.productDetails![0]
                                    .quantity !=
                                    '0'
                                ? Text(
                              'available'.tr(),
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                                : Text(
                              'soldOut'.tr(),
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CounterRow(
                          fontSize: 16,
                          containerSize: 30,
                          quantity: quantity.toString(),
                          onAdd: () {
                            if (quantity <
                                int.parse((cubit.productDetailsModel?.data
                                    ?.productDetails![0].quantity)
                                    .toString())) {
                              quantity++;
                              setState(() {});
                            } else {
                              showToast(
                                  text: "noMoreAvailableForThisProduct"
                                      .tr(),
                                  color: Colors.black);
                            }
                          },
                          onRemove: () {
                            if (quantity > 0) quantity--;
                            setState(() {});
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        if (cubit.productDetailsModel!.data!.productsize!
                            .isNotEmpty)
                          StatefulBuilder(
                              builder: (context, setState) => SizedBox(
                                height: MediaQuery.of(context)
                                    .size
                                    .height /
                                    25,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) =>
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            featureSize =
                                            "${cubit.productDetailsModel?.data?.productsize![index].name}";
                                          });
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                            BorderRadius.circular(5),
                                            border: Border.all(
                                              color: featureSize ==
                                                  cubit
                                                      .productDetailsModel
                                                      ?.data
                                                      ?.productsize![
                                                  index]
                                                      .name
                                                  ? kDarkGoldColor
                                                  : Colors.grey,
                                              width: 1.8,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets
                                                .symmetric(
                                                horizontal: 10,
                                                vertical: 8),
                                            child: Text(
                                              "${cubit.productDetailsModel?.data?.productsize![index].name}",
                                              style: TextStyle(
                                                color: featureSize ==
                                                    cubit
                                                        .productDetailsModel
                                                        ?.data
                                                        ?.productsize![
                                                    index]
                                                        .name
                                                    ? kDarkGoldColor
                                                    : Colors.grey,
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  separatorBuilder:
                                      (context, index) => SizedBox(
                                    width: 20,
                                  ),
                                  itemCount: cubit
                                      .productDetailsModel!
                                      .data!
                                      .productsize!
                                      .length,
                                ),
                              )),
                        if (cubit.productDetailsModel!.data!.productsize!
                            .isNotEmpty)
                          SizedBox(
                            height: 10,
                          ),
                        Row(
                          children: [
                            //Server
                            if (kToken != null && kToken!.isNotEmpty)
                              cubit.productDetailsModel?.data?.productDetails![0].hascart == 1 &&
                                  cubit.productDetailsModel?.data?.productDetails![0].smartType == 0 ||
                                  cubit.productDetailsModel?.data?.productDetails![0].hascart == 1 &&
                                      cubit.productDetailsModel?.data?.productDetails![0].smartType == 3
                                  ?
                              Container(
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Color(0xff393846),
                                    borderRadius: BorderRadius.circular(35)),
                                child: IconButton(
                                  onPressed: () {
                                    navigateTo(context, CartScreen());
                                  },
                                  icon:Icon(
                                    Icons.shopping_cart,
                                    size: 25,
                                    color: kLightGoldColor,
                                  ),
                                ),

                              )
                              // CustomButton(
                              //   onTap: () {
                              //     navigateTo(context, CartScreen());
                              //     // cubit.delITemFromCartServer(
                              //     //     product_id: cubit
                              //     //         .productDetailsModel
                              //     //         ?.data
                              //     //         ?.productDetails![0]
                              //     //         .id);
                              //     // CartCubit.get(context).total =
                              //     //     0;
                              //     // Future.delayed(Duration(seconds: 1));
                              //   },
                              //   height: 50,
                              //   text: 'shoppingCart'.tr(),
                              // )
                                  :
                                  state is AddToCartSuccessState ? Container(
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Color(0xff393846),
                                        borderRadius: BorderRadius.circular(35)),
                                    child: IconButton(
                                      onPressed: () {
                                        navigateTo(context, CartScreen());
                                      },
                                      icon:Icon(
                                        Icons.shopping_cart,
                                        size: 25,
                                        color: kLightGoldColor,
                                      ),
                                    ),

                                  ):
                              Expanded(
                                child: CustomButton(
                                  onTap: () {
                                    //   if(cubit.productDetailsModel?.data?.productDetails![0].hascart == 1 &&
                                    //       cubit.productDetailsModel?.data?.productDetails![0].smartPrice==null
                                    //   && isSmartFeatureSelected==true
                                    //   ){
                                    //     print("Dddd"*10);
                                    //     showToast(
                                    //         text: 'thisProductAlreadyInCart'.tr(),
                                    //         color: Colors.black);
                                    //   }
                                    // else
                                    // {
                                    print(cubit.productDetailsModel?.data?.productDetails![0].smartPrice);
                                    print(cubit.productDetailsModel?.data?.productDetails![0].id);
                                    print(cubit.productDetailsModel?.data?.productDetails![0].currentPrice);
                                    cubit.addToCartServer(
                                      quantity: quantity,
                                      smartType: cubit.productDetailsModel?.data?.productDetails![0].smartPrice == 0  ? 0 :
                                      isSmartFeatureSelected==true ? 2:1 ,
                                      featureSize: featureSize,
                                      product_id: cubit.productDetailsModel!.data!.productDetails![0].id!,
                                      price: isSmartFeatureSelected
                                          ? cubit.productDetailsModel?.data?.productDetails![0].currentPrice + cubit.productDetailsModel?.data?.productDetails![0].smartPrice
                                          : cubit.productDetailsModel?.data?.productDetails![0].currentPrice,
                                      smartPrice:
                                      isSmartFeatureSelected
                                          ? cubit.productDetailsModel?.data?.productDetails![0].smartPrice
                                          : null,
                                    );
                                    // }
                                  },
                                  height: 50,
                                  text: 'AddToCart'.tr(),
                                ),
                              ),
                            //local
                            if (kToken == null || kToken!.isEmpty)
                              Expanded(
                                child: (cartProducts != null &&
                                    cartProducts?.cartProducts
                                        ?.indexWhere(
                                          (element) =>
                                      element.productId ==
                                          cubit
                                              .productDetailsModel
                                              ?.data
                                              ?.productDetails![0]
                                              .id,
                                    ) !=
                                        -1)
                                    ? CustomButton(
                                  onTap: () {
                                    cubit.delITemFromCartLocally(product_id: cubit.productDetailsModel!
                                        .data!
                                        .productDetails![0]
                                        .id);
                                    // Future.delayed(Duration(seconds: 1));
                                  },
                                  height: 50,
                                  text: 'removeFromCart'.tr(),
                                )
                                    : CustomButton(
                                  onTap: () {
                                    print(
                                        "aaaaaaaaaaaaa${cubit.productDetailsModel?.data?.productDetails![0].smartPrice}");
                                    print(
                                        "${isSmartFeatureSelected == true ? Text('1') : Text('2')}");
                                    print(cubit
                                        .productDetailsModel
                                        ?.data
                                        ?.productDetails![0]
                                        .currentPrice);
                                    print('object');
                                    print(quantity);

                                    print(
                                        "kkkk dd ${isSmartFeatureSelected}");
                                    cubit.addToCartLocal(
                                      oneProductPrice: (cubit
                                          .productDetailsModel
                                          ?.data
                                          ?.productDetails![0]
                                          .currentPrice)
                                          .toInt(),
                                      withSmartFeature:
                                      isSmartFeatureSelected,
                                      feature: featureSize,
                                      smartPrice:
                                      isSmartFeatureSelected
                                          ? cubit
                                          .productDetailsModel
                                          ?.data
                                          ?.productDetails![
                                      0]
                                          .smartPrice
                                          : '',
                                      productImage: cubit
                                          .productDetailsModel
                                          ?.data
                                          ?.productDetails![0]
                                          .image,
                                      quantity: quantity,
                                      price: (cubit
                                          .productDetailsModel
                                          ?.data
                                          ?.productDetails![0]
                                          .currentPrice)
                                          .toInt(),
                                      productName: cubit
                                          .productDetailsModel
                                          ?.data
                                          ?.productDetails![0]
                                          .name,
                                      productId: cubit
                                          .productDetailsModel
                                          ?.data
                                          ?.productDetails![0]
                                          .id,
                                      isFav: cubit
                                          .productDetailsModel
                                          ?.data
                                          ?.productDetails![0]
                                          .hasFavorites,
                                    );
                                  },
                                  height: 50,
                                  text: 'AddToCart'.tr(),
                                ),
                              ),
                            SizedBox(
                              width: 10,
                            ),
                            cubit.productDetailsModel?.data?.productDetails![0].hascart == 1 &&
                                cubit.productDetailsModel?.data?.productDetails![0].smartType == 1  ||
                                cubit.productDetailsModel?.data?.productDetails![0].hascart == 1 &&
                                    cubit.productDetailsModel?.data?.productDetails![0].smartType == 2 ?
                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0xff393846),
                                  borderRadius: BorderRadius.circular(35)),
                              child: IconButton(
                                onPressed: () {
                                  navigateTo(context, CartScreen());
                                },
                                icon:Icon(
                                  Icons.shopping_cart,
                                  size: 25,
                                  color: kLightGoldColor,
                                ),
                              ),

                            ) : Text(""),
                            IconButton(
                              onPressed: () {
                                if (kToken != null &&
                                    kToken!.isNotEmpty) {
                                  if (cubit.productDetailsModel?.data?.productDetails![0].hasFavorites == 1) {
                                    cubit.removeProductDetailsFavorite(
                                        prodId: cubit.productDetailsModel?.data?.productDetails![0].id);
                                  } else {
                                    ///////////////////////////////////////////////////

                                    TextEditingController listName =
                                    TextEditingController();
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          cubit
                                              .getFavListDataOfProdDetails();
                                          return BlocConsumer<AppCubit,
                                              AppStates>(
                                            listener: (context, state) {},
                                            builder: (context, state) {
                                              return Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                    MediaQuery.of(
                                                        context).size.width / 60,
                                                    vertical: MediaQuery.of(context).size.height / 70),
                                                child: state
                                                is GetProductDetailsSuccessState
                                                    ? Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Align(alignment: AlignmentDirectional.center,
                                                      child: Text("addToOneOfYourFavoriteLists".tr(),
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(color: kCustomBlack,
                                                            fontSize: 22,
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: MediaQuery.of(context).size.height / 35,
                                                    ),
                                                    SizedBox(
                                                      height: 80,
                                                      child: ListView(
                                                        scrollDirection:
                                                        Axis.horizontal,
                                                        children: [
                                                          if (cubit.favListModelOfProdDetails!.data!.isNotEmpty)
                                                            SizedBox(height: 80,
                                                              child:
                                                              ListView.separated(
                                                                physics: NeverScrollableScrollPhysics(),
                                                                shrinkWrap: true,
                                                                scrollDirection:
                                                                Axis.horizontal,
                                                                itemCount:
                                                                cubit.favListModelOfProdDetails!.data!.length,
                                                                itemBuilder: (context, index) {
                                                                  return InkWell(
                                                                    onTap: () {
                                                                      print(cubit.favListModelOfProdDetails!.data![index].iD);
                                                                      cubit.addFavProductToFavListProdDetails(
                                                                        listId: cubit.favListModelOfProdDetails?.data![index].iD,
                                                                        productId: cubit.productDetailsModel?.data?.productDetails![0].id,
                                                                        context: context,
                                                                      );
                                                                    },
                                                                    child: Wrap(
                                                                      direction: Axis.vertical,
                                                                      crossAxisAlignment: WrapCrossAlignment.center,
                                                                      children: [
                                                                        // تم تعديل الصوورة
                                                                        CustomNetworkImage(
                                                                          image: cubit.favListModelOfProdDetails?.data![index].image ==null ?
                                                                          "https://img.freepik.com/free-photo/side-view-hand-pouring-coffee-cup_23-2149703752.jpg?w=1380&t=st=1692799770~exp=1692800370~hmac=37430a00eeb04960f95e92262675ef0794b64cc253fcefe5d7234c51b9223de1" :
                                                                          '${cubit.favListModelOfProdDetails?.data![index].image}',
                                                                          height: 60,
                                                                          width: 60,
                                                                          border: BorderRadius.circular(16),
                                                                        ),
                                                                        /*
                                                                                    Container(
                                                                                      width: 60,
                                                                                      height: 60,
                                                                                      alignment: Alignment.center,
                                                                                      decoration: BoxDecoration(
                                                                                        shape: BoxShape.rectangle,
                                                                                        borderRadius: BorderRadius.circular(16),
                                                                                        color: Colors.grey.shade200,
                                                                                      ),
                                                                                      child: Icon(
                                                                                        CupertinoIcons.heart_circle_fill,
                                                                                        color: Colors.red,
                                                                                      ),
                                                                                    ),
*/

                                                                        Text("${cubit.favListModelOfProdDetails?.data![index].name}",
                                                                          style: TextStyle(
                                                                            color: kCustomBlack,
                                                                            fontWeight: FontWeight.w400,
                                                                          ),
                                                                          textAlign: TextAlign.center,
                                                                          maxLines: 1,
                                                                          overflow: TextOverflow.ellipsis,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                                separatorBuilder: (context, index) =>
                                                                    SizedBox(
                                                                      width: MediaQuery.of(context).size.width / 60,
                                                                    ),
                                                              ),
                                                            ),
                                                          if (cubit.favListModelOfProdDetails!.data!.isNotEmpty)
                                                            SizedBox(width: MediaQuery.of(context).size.width / 60,),
                                                          InkWell(
                                                            onTap:
                                                                () {
                                                              showModalBottomSheet(
                                                                  context: context,
                                                                  elevation: 0.0,
                                                                  isScrollControlled: true,
                                                                  backgroundColor: Colors.grey.shade50,
                                                                  shape: const RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.vertical(
                                                                        top: Radius.circular(30),
                                                                      )),
                                                                  builder: (context) {
                                                                    return BlocConsumer<AppCubit, AppStates>(
                                                                      listener: (context, state) {},
                                                                      builder: (context, state) {
                                                                        return Form(
                                                                          key:_formKey ,
                                                                          child: Padding(
                                                                            padding: EdgeInsets.only(right: 20, left: 20, top: 20, bottom: MediaQuery.of(context).viewInsets.bottom,
                                                                            ),
                                                                            child: SingleChildScrollView(
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                children: [
                                                                                  Row(
                                                                                    children: [
                                                                                      Text(
                                                                                        "newList".tr(),
                                                                                        textAlign: TextAlign.center,
                                                                                        style: TextStyle(color: kCustomBlack, fontSize: 22, fontWeight: FontWeight.w600),
                                                                                      ),
                                                                                      Spacer(),
                                                                                      IconButton(
                                                                                        onPressed: () {
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                        icon: Icon(
                                                                                          Icons.close,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: MediaQuery.of(context).size.height / 35,
                                                                                  ),
                                                                                  Align(
                                                                                    alignment: AlignmentDirectional.center,
                                                                                    child: Text(
                                                                                      "descriList".tr(),
                                                                                      textAlign: TextAlign.center,
                                                                                      style: TextStyle(
                                                                                        color: Colors.grey,
                                                                                        fontSize: 20,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: MediaQuery.of(context).size.height / 35,
                                                                                  ),
                                                                                  Align(
                                                                                    alignment: AlignmentDirectional.center,
                                                                                    child: Text(
                                                                                      "descriListshare".tr(),
                                                                                      textAlign: TextAlign.center,
                                                                                      style: TextStyle(
                                                                                        color: Colors.grey,
                                                                                        fontSize: 20,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: MediaQuery.of(context).size.height / 35,
                                                                                  ),
                                                                                  CustomTextFormField(
                                                                                    hintText: "theNameOfYourFavoriteList".tr(),
                                                                                    controller: listName,
                                                                                    fillColor: Colors.grey,
                                                                                    hintColor: Colors.black87,
                                                                                    textColor: kCustomBlack,
                                                                                    validate: (value) {
                                                                                      if (value!.isEmpty) {
                                                                                        return 'thisFieldCanNotBeEmpty'.tr();
                                                                                      } else {
                                                                                        return null;
                                                                                      }
                                                                                    },
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: MediaQuery.of(context).size.height / 50,
                                                                                  ),
                                                                                  CustomButton(
                                                                                    onTap: () {
                                                                                      if(_formKey.currentState!.validate()){
                                                                                        Navigator.pop(context);
                                                                                        cubit.createNewFavListProdDetails(listName: listName.text, context: context, productId: cubit.productDetailsModel?.data?.productDetails![0].id);

                                                                                      }else{}

                                                                                    },
                                                                                    text: 'create'.tr(),
                                                                                  ),
                                                                                  /*
                                                                                                        InkWell(
                                                                                                          onTap: () {
                                                                                                            Navigator.pop(context);
                                                                                                            cubit.createNewFavList(listName: listName.text, context: context, productId: cubit.productFromCatList![index].id, index: index);
                                                                                                          },
                                                                                                          child: Container(
                                                                                                            alignment: Alignment.center,
                                                                                                            width: 70,
                                                                                                            height: 40,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: Colors.green,
                                                                                                              shape: BoxShape.rectangle,
                                                                                                              borderRadius: BorderRadius.circular(14),
                                                                                                            ),
                                                                                                            child: Text(
                                                                                                              "create".tr(),
                                                                                                              style: TextStyle(
                                                                                                                color: Colors.white,
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
*/
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    );
                                                                  });

                                                              /*     showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              return AlertDialog(
                                                                                content: BlocConsumer<AppCubit, AppStates>(
                                                                                  listener: (context, state) {},
                                                                                  builder: (context, state) {
                                                                                    return Column(
                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                      children: [
                                                                                        CustomTextFormField(
                                                                                          hintText: "theNameOfYourFavoriteList".tr(),
                                                                                          controller: listName,
                                                                                          fillColor: Colors.grey,
                                                                                          hintColor: Colors.black87,
                                                                                          textColor: kDarkGoldColor,
                                                                                          validate: (value) {},
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: MediaQuery.of(context).size.height / 50,
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                          children: [
                                                                                            InkWell(
                                                                                              onTap: () {
                                                                                                Navigator.pop(context);
                                                                                                cubit.createNewFavListProdDetails(listName: listName.text, context: context, productId: cubit.productDetailsModel?.data?.productDetails![0].id);
                                                                                              },
                                                                                              child: Container(
                                                                                                alignment: Alignment.center,
                                                                                                width: 70,
                                                                                                height: 40,
                                                                                                decoration: BoxDecoration(
                                                                                                  color: Colors.green,
                                                                                                  shape: BoxShape.rectangle,
                                                                                                  borderRadius: BorderRadius.circular(14),
                                                                                                ),
                                                                                                child: Text(
                                                                                                  "create".tr(),
                                                                                                  style: TextStyle(
                                                                                                    color: Colors.white,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            InkWell(
                                                                                              onTap: () => Navigator.of(context).pop(),
                                                                                              child: Container(
                                                                                                alignment: Alignment.center,
                                                                                                width: 70,
                                                                                                height: 40,
                                                                                                decoration: BoxDecoration(
                                                                                                  color: Colors.grey,
                                                                                                  shape: BoxShape.rectangle,
                                                                                                  borderRadius: BorderRadius.circular(14),
                                                                                                ),
                                                                                                child: Text(
                                                                                                  "cancel".tr(),
                                                                                                  style: TextStyle(
                                                                                                    color: Colors.red,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    );
                                                                                  },
                                                                                ),
                                                                              );
                                                                            },
                                                                          );*/
                                                            },
                                                            child:
                                                            Wrap(
                                                              direction:
                                                              Axis.vertical,
                                                              crossAxisAlignment:
                                                              WrapCrossAlignment.center,
                                                              children: [
                                                                Container(
                                                                  width: 60,
                                                                  height: 60,
                                                                  alignment: Alignment.center,
                                                                  decoration: BoxDecoration(
                                                                    shape: BoxShape.rectangle,
                                                                    borderRadius: BorderRadius.circular(16),
                                                                    color: Colors.grey.shade200,
                                                                  ),
                                                                  child: Icon(
                                                                    CupertinoIcons.add_circled,
                                                                    color: Colors.black,
                                                                  ),
                                                                ),
                                                                ConstrainedBox(
                                                                  constraints: BoxConstraints(
                                                                    maxWidth: 70,
                                                                  ),
                                                                  child: Text(
                                                                    "createList".tr(),
                                                                    style: TextStyle(
                                                                      color: Colors.grey,
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                    textAlign: TextAlign.center,
                                                                    maxLines: 1,
                                                                    overflow: TextOverflow.ellipsis,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    // Container(
                                                    //   width: 60,
                                                    //   height: 60,
                                                    //   alignment: Alignment.center,
                                                    //   decoration: BoxDecoration(
                                                    //     shape: BoxShape.rectangle,
                                                    //     borderRadius: BorderRadius.circular(16),
                                                    //     color: Colors.grey.shade200,
                                                    //   ),
                                                    //   child: Icon(
                                                    //     CupertinoIcons.add_circled,
                                                    //     color: Colors.black,
                                                    //   ),
                                                    // ),
                                                  ],
                                                )
                                                    : Column(
                                                  mainAxisSize:
                                                  MainAxisSize
                                                      .min,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .center,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  children: [
                                                    Center(
                                                      child:
                                                      CircularProgressIndicator(),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        });
                                  }
                                } else {
                                  showToast(
                                      text: 'pleaseLoginFirst'.tr(),
                                      color: Colors.black);
                                }
                              },
                              icon: cubit
                                  .productDetailsModel
                                  ?.data
                                  ?.productDetails![0]
                                  .hasFavorites ==
                                  1
                                  ? Icon(
                                Icons.bookmark_add,
                                size: 35,
                                color: kDarkGoldColor,
                              )
                                  : Icon(
                                Icons.bookmark_add_outlined,
                                size: 35,
                                color: Colors.black26,
                              ),
                            ),
                            // SizedBox(
                            //   width: 5,
                            // ),
                            // IconButton(
                            //   onPressed: () {
                            //     ListsCubit.get(context)
                            //             .productDetailsModel =
                            //         cubit.productDetailsModel;
                            //
                            //     log("77777777777777777777777777");
                            //     log('${ListsCubit.get(context).productDetailsModel == null}');
                            //     navigateTo(context, MyLists());
                            //
                            //     //cubit
                            //   },
                            //   icon: Icon(
                            //     CupertinoIcons.share,
                            //     size: 30,
                            //     color: Colors.black26,
                            //   ),
                            // )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Label(
                          text: 'ProductDetails'.tr(),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          "${cubit.productDetailsModel?.data?.productDetails![0].details}",
                          style: TextStyle(color: Colors.black54),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        if (cubit.productDetailsModel!.data!
                            .productfeatures!.length >
                            0)
                          Label(
                            text: 'ProductFeatures'.tr(),
                          ),
                        if (cubit.productDetailsModel!.data!
                            .productfeatures!.length >
                            0)
                          SizedBox(
                            height: 7,
                          ),
                        if (cubit.productDetailsModel!.data!
                            .productfeatures!.length >
                            0)
                          ListView.separated(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => Row(
                                children: [
                                  Text(
                                    '${cubit.productDetailsModel?.data?.productfeatures![index].name}: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    '${cubit.productDetailsModel?.data?.productfeatures![index].description}',
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
                              itemCount: cubit.productDetailsModel!.data!
                                  .productfeatures!.length),
                        if (cubit.productDetailsModel!.data!
                            .productfeatures!.length >
                            0)
                          SizedBox(
                            height: 7,
                          ),
                        Divider(),
                        SizedBox(
                          height: 7,
                        ),
                        GestureDetector(
                          onTap: () {
                            // cubit.getProductReviews(
                            //     productId: cubit.productDetailsModel.data
                            //         .productDetails[0].id);
                            navigateTo(
                                context,
                                ReviewsAndCommentsScreen(
                                  productId: cubit.productDetailsModel
                                      ?.data?.productDetails![0].id,
                                ));
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
                                            ?.data
                                            ?.productDetails![0]
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
                          height: 7,
                        ),
                        Divider(),
                        SizedBox(
                          height: 10,
                        ),
                        Label(
                          text: 'RelatedProducts'.tr(),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.22,
                          child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => SizedBox(
                                  width: 300,
                                  child: HorizontalProductCard(
                                    relatedProducts: cubit.productDetailsModel!.data!.relatedProducts![index],
                                  )),
                              separatorBuilder: (context, index) =>
                                  SizedBox(
                                    width: 10,
                                  ),
                              itemCount: cubit.productDetailsModel!.data!
                                  .relatedProducts!.length),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
              : Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          ),
          /*   floatingActionButton: Visibility(
            // if condition true process will go based on server
            visible: kToken != null && kToken!.isNotEmpty,
            child: cubit.productDetailsModel == null ||
                    state is! GetProductDetailsSuccessState
                ? SizedBox()
                : cubit.productDetailsModel?.data?.productDetails![0].hascart ==
                        1
                    ? InkWell(
                        onTap: (() => navigateTo(context, CartScreen())),
                        child: Container(
                          alignment: AlignmentDirectional.center,
                          width: MediaQuery.of(context).size.width / 1.1,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [kLightGoldColor, kDarkGoldColor],
                              begin: AlignmentDirectional.centerEnd,
                              end: AlignmentDirectional.centerStart,
                            ),
                          ),
                          child: Wrap(
                            direction: Axis.horizontal,
                            children: [
                              Icon(
                                CupertinoIcons.cart_fill,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "shoppingCart".tr(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width / 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : SizedBox(),
            replacement: cubit.productDetailsModel == null ||
                    state is! GetProductDetailsSuccessState
                ? SizedBox()
                : (cartProducts != null &&
                        cartProducts?.cartProducts?.indexWhere(
                              (element) =>
                                  element.productId ==
                                  cubit.productDetailsModel?.data
                                      ?.productDetails![0].id,
                            ) !=
                            -1)
                    ? InkWell(
                        onTap: (() => navigateTo(context, CartScreen())),
                        child: Container(
                          alignment: AlignmentDirectional.center,
                          width: MediaQuery.of(context).size.width / 1.1,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [kLightGoldColor, kDarkGoldColor],
                              begin: AlignmentDirectional.centerEnd,
                              end: AlignmentDirectional.centerStart,
                            ),
                          ),
                          child: Wrap(
                            direction: Axis.horizontal,
                            children: [
                              Icon(
                                CupertinoIcons.cart_fill,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "shoppingCart".tr(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width / 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : SizedBox(),
          ),*/
        ) : Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: kDarkGreyColor,
              ),
            ),
          );

      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    quantity = 1;
  }
}
