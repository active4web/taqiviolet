import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/offerCubit/offer_cubit.dart';
import 'package:safsofa/screens/product_details_screen.dart';
import 'package:safsofa/shared/components/store_components/product_cards.dart';
import 'package:safsofa/shared/defaults.dart';
import '../../shared/components/custom_app_bar_with_search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/constants.dart';

class OffersProductsScreen extends StatefulWidget {

  @override
  State<OffersProductsScreen> createState() => _OffersProductsScreenState();
}

class _OffersProductsScreenState extends State<OffersProductsScreen> {
  @override
  Widget build(BuildContext context) {
    var kDarkGoldColor;
    OfferCubit cubit = OfferCubit.get(context);
    AppCubit appCubit = AppCubit.get(context);
    cubit.getOffersProduct();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarWithSearch(
          // colorIcon: kDarkGoldColor,
          title: "OffersAndDiscounts".tr(),
          colorAB: Colors.white),
      body: BlocConsumer<OfferCubit, OfferState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  cubit.productOffers == null &&
                          state != GetProductsOfferSuccessState
                      ? Center(
                          child: CircularProgressIndicator(
                          color: kDarkGoldColor,
                        ))
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: cubit.productOffers!.data!.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 15 / 30,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 1),
                          itemBuilder: (context, index) => VerticalProductCard(
                            onclick: () {
                              log("000000000000000000000000");
                              log("000000000000000000000000     ${cubit.productOffers?.data![index].id}");
                              appCubit.getProductDetails(
                                productId: cubit.productOffers?.data![index].id!.toInt(),
                              );
                              navigateTo(context, ProductDetailsScreen());
                            },
                            cubit: cubit,
                            isFavourite:
                                cubit.productOffers?.data![index].hasFavorites ==
                                    1,
                            totalRate:
                                cubit.productOffers?.data![index].hasReviews,
                            image: cubit.productOffers?.data![index].image,
                            currentPrice:
                                cubit.productOffers?.data![index].currentPrice,
                            oldPrice: cubit.productOffers?.data![index].oldPrice,
                            // oldPrice: cubit
                            //     .productsModel.result.allProducts[index].oldPrice,
                            productName: cubit.productOffers?.data![index].name,
                            productId: cubit.productOffers?.data![index].id!.toInt(),
                            onFavPressed: () {
                              if (kToken != null && kToken!.isNotEmpty) {
                                // isFavourite = !isFavourite;
                                // log(cubit.productOffers?.data![index].id.toString() +
                                //     "DDDDD");
                                cubit.updateFavorite(
                                    prodId: (cubit.productOffers?.data![index].id)!.toInt());
                                // cubit.emit(ChangeIconColor());
                              } else {
                                showToast(
                                    text: 'pleaseLoginFirst'.tr(),
                                    color: Colors.black);
                              }
                            },
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
