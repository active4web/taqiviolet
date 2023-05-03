import 'dart:developer';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:safsofa/cubits/inspirationCubit/inspiration_cubit.dart';
import 'package:safsofa/models/inspiration_model.dart';
import 'package:safsofa/network/local/cache_helper.dart';
import 'package:safsofa/screens/product_details_screen.dart';
import 'package:safsofa/shared/components/video_server_display.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import '../cubits/appCubit/app_cubit.dart';
import '../cubits/inspirationCubit/inspiration_state.dart';
import '../shared/components/custom_app_bar_with_search.dart';
import '../shared/defaults.dart';

TextEditingController searchController = TextEditingController();

class DisplayInspirationProducts extends StatefulWidget {
  DisplayInspirationProducts({
    this.categoryName,
  });

  final String? categoryName;

  @override
  State<DisplayInspirationProducts> createState() =>
      _DisplayInspirationProductsState();
}

class _DisplayInspirationProductsState
    extends State<DisplayInspirationProducts> {
  List<Data> inspirationSearchResult = [];
  bool oneList = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InspirationCubit()..getInspirationData(),
      child: BlocConsumer<InspirationCubit, InspirationStates>(
        listener: (context, state) {
          log("get dataحخهحخهعخهحخهخخحهحخ");
        },
        builder: (context, state) {
          AppCubit appCubit = AppCubit.get(context);
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: CustomAppBarWithSearch(
                title: widget.categoryName?.tr(),
                controller: searchController,
                withFilter: true,
                function: (){
                  oneList == false ?
                  setState(() {
                    oneList = true ;
                    CacheHelper.removeData('filter');
                    CacheHelper.setData(key: 'filter',value: true);
                  }) :   setState(() {
                    oneList = false ;
                    CacheHelper.removeData('filter');
                    CacheHelper.setData(key: 'filter',value: false);

                  });
                  print(oneList);
                },
                onChange: (String val) {
                  setState(() {
                    searchController.text = val;
                    searchController.selection = TextSelection.fromPosition(
                        TextPosition(offset: searchController.text.length));
                  });
                  inspirationSearchResult.clear();
                  InspirationCubit.get(context)
                      .inspirationData
                      .forEach((element) {
                    if (element.productName!.contains(searchController.text)) {
                      inspirationSearchResult.add(element);
                      log('${element.image}');
                    }
                  });
                  log('=' * 50 +
                      ' ${inspirationSearchResult.length} ' +
                      '=' * 50);
                  setState(() {});
                  log('$val');
                  // cubit.searchInspirationData(searchQuery: searchController.text);
                },
              ),
              body: ConditionalBuilder(
                condition:
                    (InspirationCubit.get(context).inspirationData.isNotEmpty ||
                            state is GetInspirationSuccessState) ||
                        state is SearchInspirationSuccessState,
                builder: (context) => oneList == false ||
                CacheHelper.getData('filter') == false
                    ? inspirationSearchResult.isEmpty
                        ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MasonryGridView.count(
                              itemCount: InspirationCubit.get(context)
                                  .inspirationData
                                  .length,
                              crossAxisCount: 2,
                              mainAxisSpacing: 2,
                              crossAxisSpacing: 4,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    appCubit.getProductDetails(
                                        productId: InspirationCubit.get(context)
                                            .inspirationData[index]
                                            .urlLink);
                                    navigateTo(context, ProductDetailsScreen());

                                    // _launchURLBrowser(
                                    //     cubit.inspirationData[index].urlLink);
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: InspirationCubit.get(context)
                                            .inspirationData[index]
                                            .image!
                                            .endsWith('.mp4')
                                        ? Stack(
                                            alignment:
                                                AlignmentDirectional.topEnd,
                                            children: [
                                              VideoServerDisplay(
                                                  videoUrl: InspirationCubit.get(
                                                          context)
                                                      .inspirationData[index]
                                                      .image
                                                  // VideoPlayerController.network(
                                                  //     InspirationCubit.get(context)
                                                  //         .inspirationData[index]
                                                  //         .image),
                                                  ),
                                              InkWell(
                                                onTap: () {
                                                  if (kToken != null &&
                                                      kToken!.isNotEmpty) {
                                                    InspirationCubit.get(context)
                                                        .updateFavorite(
                                                            prodId: InspirationCubit
                                                                    .get(context)
                                                                .inspirationData[
                                                                    index]
                                                                .urlLink!);
                                                  } else {
                                                    showToast(
                                                        text: 'pleaseLoginFirst'
                                                            .tr(),
                                                        color: Colors.black);
                                                  }
                                                },
                                                child: Container(
                                                  alignment:
                                                      AlignmentDirectional.center,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      10,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      10,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.6),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: InspirationCubit.get(
                                                                  context)
                                                              .inspirationData[
                                                                  index]
                                                              .hasFavorites ==
                                                          1
                                                      ? Icon(
                                                          Icons.favorite_rounded,
                                                          color: kDarkGoldColor,
                                                        )
                                                      : Icon(
                                                          Icons
                                                              .favorite_border_rounded,
                                                          color: Colors.grey,
                                                        ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Stack(
                                            alignment:
                                                AlignmentDirectional.topEnd,
                                            children: [
                                              Image(
                                                image: NetworkImage(
                                                  "${InspirationCubit.get(context).inspirationData[index].image}",
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  if (kToken != null &&
                                                      kToken!.isNotEmpty) {
                                                    InspirationCubit.get(context)
                                                        .updateFavorite(
                                                            prodId: InspirationCubit
                                                                    .get(context)
                                                                .inspirationData[
                                                                    index]
                                                                .urlLink!);
                                                  } else {
                                                    showToast(
                                                        text: 'pleaseLoginFirst'
                                                            .tr(),
                                                        color: Colors.black);
                                                  }
                                                },
                                                child: Container(
                                                  alignment:
                                                      AlignmentDirectional.center,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      10,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      10,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.6),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: InspirationCubit.get(
                                                                  context)
                                                              .inspirationData[
                                                                  index]
                                                              .hasFavorites ==
                                                          1
                                                      ? Icon(
                                                          Icons.favorite_rounded,
                                                          color: kDarkGoldColor,
                                                        )
                                                      : Icon(
                                                          Icons
                                                              .favorite_border_rounded,
                                                          color: Colors.grey,
                                                        ),
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                );
                              },
                            ),
                        )
                        : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MasonryGridView.count(
                              itemCount: inspirationSearchResult.length,
                              crossAxisCount: 2,
                              mainAxisSpacing: 2,
                              crossAxisSpacing: 4,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    appCubit.getProductDetails(
                                        productId: inspirationSearchResult[index]
                                            .urlLink);
                                    navigateTo(context, ProductDetailsScreen());

                                    // _launchURLBrowser(
                                    //     cubit.inspirationData[index].urlLink);
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: inspirationSearchResult[index]
                                            .image!
                                            .endsWith('.mp4')
                                        ? Stack(
                                            alignment:
                                                AlignmentDirectional.topEnd,
                                            children: [
                                              VideoServerDisplay(
                                                  videoUrl:
                                                      inspirationSearchResult[
                                                              index]
                                                          .image
                                                  // VideoPlayerController.network(
                                                  //     inspirationSearchResult[index]
                                                  //         .image),
                                                  ),
                                              InkWell(
                                                onTap: () {
                                                  print("Bishooo");

                                                  if (kToken != null &&
                                                      kToken!.isNotEmpty) {
                                                    print("Bishooo");

                                                    InspirationCubit.get(context)
                                                        .updateFavorite(
                                                            prodId:
                                                                inspirationSearchResult[
                                                                        index]
                                                                    .urlLink!);
                                                  } else {
                                                    print("Bishooo");

                                                    showToast(
                                                        text: 'pleaseLoginFirst'
                                                            .tr(),
                                                        color: Colors.black);
                                                  }
                                                },
                                                child: Container(
                                                  alignment:
                                                      AlignmentDirectional.center,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      10,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      10,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.6),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: inspirationSearchResult[
                                                                  index]
                                                              .hasFavorites ==
                                                          1
                                                      ? Icon(
                                                          Icons.favorite_rounded,
                                                          color: kDarkGoldColor,
                                                        )
                                                      : Icon(
                                                          Icons
                                                              .favorite_border_rounded,
                                                          color: Colors.grey,
                                                        ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Stack(
                                            alignment:
                                                AlignmentDirectional.topEnd,
                                            children: [
                                              Image(
                                                image: NetworkImage(
                                                  "${inspirationSearchResult[index].image}",
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  if (kToken != null &&
                                                      kToken!.isNotEmpty) {
                                                    print("Bishooo");
                                                    InspirationCubit.get(context)
                                                        .updateFavorite(
                                                            prodId:
                                                                inspirationSearchResult[
                                                                        index]
                                                                    .urlLink!);
                                                  } else {
                                                    print("Bishooo");

                                                    showToast(
                                                        text: 'pleaseLoginFirst'
                                                            .tr(),
                                                        color: Colors.black);
                                                  }
                                                },
                                                child: Container(
                                                  alignment:
                                                      AlignmentDirectional.center,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      10,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      10,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.6),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: inspirationSearchResult[
                                                                  index]
                                                              .hasFavorites ==
                                                          1
                                                      ? Icon(
                                                          Icons.favorite_rounded,
                                                          color: kDarkGoldColor,
                                                        )
                                                      : Icon(
                                                          Icons
                                                              .favorite_border_rounded,
                                                          color: Colors.grey,
                                                        ),
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                );
                              },
                            ),
                        )
                    : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index)=>InkWell(
                            onTap: () {
                              appCubit.getProductDetails(
                                  productId: InspirationCubit.get(context)
                                      .inspirationData[index]
                                      .urlLink);
                              navigateTo(context, ProductDetailsScreen());

                              // _launchURLBrowser(
                              //     cubit.inspirationData[index].urlLink);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: InspirationCubit.get(context)
                                  .inspirationData[index]
                                  .image!
                                  .endsWith('.mp4')
                                  ? Stack(
                                alignment:
                                AlignmentDirectional.topEnd,
                                children: [
                                  VideoServerDisplay(
                                      videoUrl: InspirationCubit.get(
                                          context)
                                          .inspirationData[index]
                                          .image
                                    // VideoPlayerController.network(
                                    //     InspirationCubit.get(context)
                                    //         .inspirationData[index]
                                    //         .image),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (kToken != null &&
                                          kToken!.isNotEmpty) {
                                        InspirationCubit.get(context)
                                            .updateFavorite(
                                            prodId: InspirationCubit
                                                .get(context)
                                                .inspirationData[
                                            index]
                                                .urlLink!);
                                      } else {
                                        showToast(
                                            text: 'pleaseLoginFirst'
                                                .tr(),
                                            color: Colors.black);
                                      }
                                    },
                                    child: Container(
                                      alignment:
                                      AlignmentDirectional.center,
                                      height: MediaQuery.of(context)
                                          .size
                                          .width /
                                          10,
                                      width: MediaQuery.of(context)
                                          .size
                                          .width /
                                          10,
                                      decoration: BoxDecoration(
                                        color: Colors.white
                                            .withOpacity(0.6),
                                        shape: BoxShape.circle,
                                      ),
                                      child: InspirationCubit.get(
                                          context)
                                          .inspirationData[
                                      index]
                                          .hasFavorites ==
                                          1
                                          ? Icon(
                                        Icons.favorite_rounded,
                                        color: kDarkGoldColor,
                                      )
                                          : Icon(
                                        Icons
                                            .favorite_border_rounded,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                                  : Stack(
                                alignment:
                                AlignmentDirectional.topEnd,
                                children: [
                                  Image(
                                    image: NetworkImage(
                                      "${InspirationCubit.get(context).inspirationData[index].image}",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (kToken != null &&
                                          kToken!.isNotEmpty) {
                                        InspirationCubit.get(context)
                                            .updateFavorite(
                                            prodId: InspirationCubit
                                                .get(context)
                                                .inspirationData[
                                            index]
                                                .urlLink!);
                                      } else {
                                        showToast(
                                            text: 'pleaseLoginFirst'
                                                .tr(),
                                            color: Colors.black);
                                      }
                                    },
                                    child: Container(
                                      alignment:
                                      AlignmentDirectional.center,
                                      height: MediaQuery.of(context)
                                          .size
                                          .width /
                                          10,
                                      width: MediaQuery.of(context)
                                          .size
                                          .width /
                                          10,
                                      decoration: BoxDecoration(
                                        color: Colors.white
                                            .withOpacity(0.6),
                                        shape: BoxShape.circle,
                                      ),
                                      child: InspirationCubit.get(
                                          context)
                                          .inspirationData[
                                      index]
                                          .hasFavorites ==
                                          1
                                          ? Icon(
                                        Icons.favorite_rounded,
                                        color: kDarkGoldColor,
                                      )
                                          : Icon(
                                        Icons
                                            .favorite_border_rounded,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          separatorBuilder: (context, index)=>SizedBox(height: 10,),
                          itemCount: InspirationCubit.get(context)
                              .inspirationData
                              .length,
                ),
                    ),
                fallback: (context) => Center(
                  child: CircularProgressIndicator(
                    color: kDarkGoldColor,
                  ),
                ),
              ));
        },
      ),
    );
  }
}

_launchURLBrowser(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
