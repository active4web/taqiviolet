import 'dart:ui';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/appCubit/app_states.dart';
import 'package:safsofa/cubits/favorites_cubit/favorites_cubit.dart';
import 'package:safsofa/cubits/favorites_cubit/favorites_state.dart';
import 'package:safsofa/screens/register_screens/login_screen.dart';
import 'package:safsofa/screens/register_screens/register_choice_screen.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/components/store_components/product_cards.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Favourites'.tr(),
      ),
      body: BlocProvider(
        create: (context) => FavoritesCubit()..getAllFavoritesData(),
        child: BlocConsumer<FavoritesCubit, FavoritesState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Visibility(
              visible: kToken != null && kToken.isNotEmpty,
              child: FavoritesCubit.get(context).allFavData == null
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topStart,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "createNewFavoriteList".tr(),
                                  style: TextStyle(
                                    color: kDarkGoldColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 1.1,
                              height: 5,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 30,
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, mainIndex) {
                                return Wrap(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          FavoritesCubit.get(context)
                                              .allFavData
                                              .data
                                              .list[mainIndex]
                                              .listName,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () =>
                                              FavoritesCubit.get(context)
                                                  .deleteFavList(
                                                      listId:
                                                          FavoritesCubit.get(
                                                                  context)
                                                              .allFavData
                                                              .data
                                                              .list[mainIndex]
                                                              .listId,
                                                      listIndex: mainIndex),
                                          child: Icon(
                                            CupertinoIcons.trash,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              18,
                                    ),
                                    if (FavoritesCubit.get(context)
                                        .allFavData
                                        .data
                                        .list[mainIndex]
                                        .listProducts
                                        .isNotEmpty)
                                      GridView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: FavoritesCubit.get(context)
                                            .allFavData
                                            .data
                                            .list[mainIndex]
                                            .listProducts
                                            .length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                childAspectRatio: 15 / 30,
                                                mainAxisSpacing: 20,
                                                crossAxisSpacing: 10),
                                        itemBuilder: (context, index) =>
                                            VerticalProductCard(
                                          // cubit: cubit,
                                          isFavourite:
                                              FavoritesCubit.get(context)
                                                      .allFavData
                                                      .data
                                                      .list[mainIndex]
                                                      .listProducts[index]
                                                      .hasFavorites ==
                                                  1,
                                          totalRate: FavoritesCubit.get(context)
                                              .allFavData
                                              .data
                                              .list[mainIndex]
                                              .listProducts[index]
                                              .hasReviews,
                                          image: FavoritesCubit.get(context)
                                              .allFavData
                                              .data
                                              .list[mainIndex]
                                              .listProducts[index]
                                              .image,
                                          currentPrice:
                                              FavoritesCubit.get(context)
                                                  .allFavData
                                                  .data
                                                  .list[mainIndex]
                                                  .listProducts[index]
                                                  .currentPrice,
                                          oldPrice: FavoritesCubit.get(context)
                                              .allFavData
                                              .data
                                              .list[mainIndex]
                                              .listProducts[index]
                                              .oldPrice,
                                          productName:
                                              FavoritesCubit.get(context)
                                                  .allFavData
                                                  .data
                                                  .list[mainIndex]
                                                  .listProducts[index]
                                                  .name,
                                          productId: FavoritesCubit.get(context)
                                              .allFavData
                                              .data
                                              .list[mainIndex]
                                              .listProducts[index]
                                              .id,
                                        ),
                                      ),
                                  ],
                                );
                              },
                              separatorBuilder: (context, mainIndex) => Divider(
                                color: Colors.grey,
                                thickness: 1.1,
                                height: 5,
                              ),
                              itemCount: FavoritesCubit.get(context)
                                  .allFavData
                                  .data
                                  .list
                                  .length,
                            ),
                            // GridView.builder(
                            //   shrinkWrap: true,
                            //   physics: NeverScrollableScrollPhysics(),
                            //   itemCount: cubit
                            //       .favouritesModel.result.allFavourites.length,
                            //   gridDelegate:
                            //       SliverGridDelegateWithFixedCrossAxisCount(
                            //           crossAxisCount: 2,
                            //           childAspectRatio: 15 / 30,
                            //           mainAxisSpacing: 20,
                            //           crossAxisSpacing: 10),
                            //   itemBuilder: (context, index) =>
                            //       VerticalProductCard(
                            //     // cubit: cubit,
                            //     isFavourite: cubit.favourites[cubit
                            //         .favouritesModel
                            //         .result
                            //         .allFavourites[index]
                            //         .prodId],
                            //     totalRate: cubit.favouritesModel.result
                            //         .allFavourites[index].totalRate,
                            //     image: cubit.favouritesModel.result
                            //         .allFavourites[index].productImage,
                            //     currentPrice: cubit.favouritesModel.result
                            //         .allFavourites[index].price,
                            //     oldPrice: cubit.favouritesModel.result
                            //         .allFavourites[index].oldPrice,
                            //     productName: cubit.favouritesModel.result
                            //         .allFavourites[index].serviceName,
                            //     productId: cubit.favouritesModel.result
                            //         .allFavourites[index].prodId,
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),
              replacement: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.heart_circle,
                        color: Colors.grey,
                        size: MediaQuery.of(context).size.width / 5,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 40,
                      ),
                      Text(
                        "logInToViewYourFavoriteProducts".tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: MediaQuery.of(context).size.width / 22,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 30),
                        child: InkWell(
                          onTap: () => navigateTo(context, LoginScreen()),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 14,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5),
                              color: kDarkGoldColor,
                              gradient: LinearGradient(
                                colors: [
                                  kLightGoldColor,
                                  kDarkGoldColor,
                                ],
                              ),
                            ),
                            child: Text(
                              "Login".tr(),
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 16,
                                color: Colors.white,
                                letterSpacing: 1.8,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 40,
                      ),
                      Text.rich(
                        TextSpan(
                            text: "DoNotHaveAnAccount?".tr(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width / 22),
                            children: [
                              TextSpan(
                                  text: "SignUp".tr(),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      return navigateTo(
                                          context, RegisterChoiceScreen());
                                    },
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 192, 135, 13)))
                            ]),
                        textAlign: TextAlign.center,
                      ),
                    ]),
              ),
            );
          },
        ),
      ),
    );
  }
}
