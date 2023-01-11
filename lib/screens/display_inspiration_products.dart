import 'dart:developer';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:safsofa/cubits/inspirationCubit/inspiration_cubit.dart';
import 'package:safsofa/models/inspiration_model.dart';
import 'package:safsofa/screens/product_details_screen.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../cubits/appCubit/app_cubit.dart';
import '../cubits/inspirationCubit/inspiration_state.dart';
import '../shared/components/custom_app_bar_with_search.dart';
import '../shared/defaults.dart';
import '../shared/video_server_display.dart';

TextEditingController searchController = TextEditingController();

class DisplayInspirationProducts extends StatefulWidget {
  DisplayInspirationProducts({
    Key key,
    this.categoryName,
  }) : super(key: key);

  final String categoryName;

  @override
  State<DisplayInspirationProducts> createState() =>
      _DisplayInspirationProductsState();
}

class _DisplayInspirationProductsState
    extends State<DisplayInspirationProducts> {
  List<Data> inspirationSearchResult = [];

  @override
  Widget build(BuildContext context) {
    // InspirationCubit cubit = InspirationCubit.get(context);
    // cubit.getInspirationData();
    return BlocProvider(
      create: (context) => InspirationCubit()..getInspirationData(),
      child: BlocConsumer<InspirationCubit, InspirationStates>(
        listener: (context, state) {
          log("get dataحخهحخهعخهحخهخخحهحخ");
        },
        builder: (context, state) {
          // log('<' * 10 +'${ cubit.inspirationModel.data[0].image}' + '>' * 10);CustomAppBar(title: this.categoryName.tr()),
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: CustomAppBarWithSearch(
                title: widget.categoryName.tr(),
                controller: searchController,
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
                    if (element.productName.contains(searchController.text)) {
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
                builder: (context) => inspirationSearchResult.isEmpty
                    ? MasonryGridView.count(
                        itemCount: InspirationCubit.get(context)
                            .inspirationData
                            .length,
                        crossAxisCount: 2,
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 4,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              AppCubit appCubit = AppCubit.get(context);
                              appCubit.getProductDetails(
                                  productId: InspirationCubit.get(context)
                                      .inspirationData[index]
                                      .iD);
                              navigateTo(context, ProductDetailsScreen());

                              // _launchURLBrowser(
                              //     cubit.inspirationData[index].urlLink);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: InspirationCubit.get(context)
                                      .inspirationData[index]
                                      .image
                                      .endsWith('.mp4')
                                  ? Stack(
                                      alignment: AlignmentDirectional.topEnd,
                                      children: [
                                        VideoServerDisplay(
                                          videoPlayerController:
                                              VideoPlayerController.network(
                                                  InspirationCubit.get(context)
                                                      .inspirationData[index]
                                                      .image),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (kToken != null &&
                                                kToken.isNotEmpty) {
                                              InspirationCubit.get(context)
                                                  .updateFavorite(
                                                      prodId:
                                                          InspirationCubit.get(
                                                                  context)
                                                              .inspirationData[
                                                                  index]
                                                              .urlLink);
                                            } else {
                                              showToast(
                                                  text: 'pleaseLoginFirst'.tr(),
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
                                              color:
                                                  Colors.white.withOpacity(0.6),
                                              shape: BoxShape.circle,
                                            ),
                                            child: InspirationCubit.get(context)
                                                        .inspirationData[index]
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
                                      alignment: AlignmentDirectional.topEnd,
                                      children: [
                                        Image(
                                          image: NetworkImage(
                                            InspirationCubit.get(context)
                                                .inspirationData[index]
                                                .image,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (kToken != null &&
                                                kToken.isNotEmpty) {
                                              InspirationCubit.get(context)
                                                  .updateFavorite(
                                                      prodId:
                                                          InspirationCubit.get(
                                                                  context)
                                                              .inspirationData[
                                                                  index]
                                                              .urlLink);
                                            } else {
                                              showToast(
                                                  text: 'pleaseLoginFirst'.tr(),
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
                                              color:
                                                  Colors.white.withOpacity(0.6),
                                              shape: BoxShape.circle,
                                            ),
                                            child: InspirationCubit.get(context)
                                                        .inspirationData[index]
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
                      )
                    : MasonryGridView.count(
                        itemCount: inspirationSearchResult.length,
                        crossAxisCount: 2,
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 4,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              AppCubit appCubit = AppCubit.get(context);
                              appCubit.getProductDetails(
                                  productId: inspirationSearchResult[index].iD);
                              navigateTo(context, ProductDetailsScreen());

                              // _launchURLBrowser(
                              //     cubit.inspirationData[index].urlLink);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: inspirationSearchResult[index]
                                      .image
                                      .endsWith('.mp4')
                                  ? Stack(
                                      alignment: AlignmentDirectional.topEnd,
                                      children: [
                                        VideoServerDisplay(
                                          videoPlayerController:
                                              VideoPlayerController.network(
                                                  inspirationSearchResult[index]
                                                      .image),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (kToken != null &&
                                                kToken.isNotEmpty) {
                                              InspirationCubit.get(context)
                                                  .updateFavorite(
                                                      prodId:
                                                          inspirationSearchResult[
                                                                  index]
                                                              .urlLink);
                                            } else {
                                              showToast(
                                                  text: 'pleaseLoginFirst'.tr(),
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
                                              color:
                                                  Colors.white.withOpacity(0.6),
                                              shape: BoxShape.circle,
                                            ),
                                            child:
                                                inspirationSearchResult[index]
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
                                      alignment: AlignmentDirectional.topEnd,
                                      children: [
                                        Image(
                                          image: NetworkImage(
                                            inspirationSearchResult[index]
                                                .image,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (kToken != null &&
                                                kToken.isNotEmpty) {
                                              InspirationCubit.get(context)
                                                  .updateFavorite(
                                                      prodId:
                                                          inspirationSearchResult[
                                                                  index]
                                                              .urlLink);
                                            } else {
                                              showToast(
                                                  text: 'pleaseLoginFirst'.tr(),
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
                                              color:
                                                  Colors.white.withOpacity(0.6),
                                              shape: BoxShape.circle,
                                            ),
                                            child:
                                                inspirationSearchResult[index]
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
