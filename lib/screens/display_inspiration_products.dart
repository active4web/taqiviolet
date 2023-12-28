import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:safsofa/cubits/inspirationCubit/inspiration_cubit.dart';
import 'package:safsofa/cubits/subCategory/sub_cat_cubit.dart';
import 'package:safsofa/models/inspiration_model.dart';
import 'package:safsofa/screens/product_details_screen.dart';
import 'package:safsofa/shared/components/video_server_display.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../cubits/appCubit/app_cubit.dart';
import '../cubits/inspirationCubit/inspiration_state.dart';
import '../shared/components/custom_app_bar_with_search.dart';
import '../shared/components/custom_button.dart';
import '../shared/components/custom_network_image.dart';
import '../shared/components/custom_text_form_field.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InspirationCubit()..getInspirationData(),
      child: BlocConsumer<InspirationCubit, InspirationStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit appCubit = AppCubit.get(context);
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: CustomAppBarWithSearch(
                title: widget.categoryName?.tr(),
                controller: searchController,
                withFilter: true,
                function: () {
                  InspirationCubit.get(context).changeShow();
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
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MasonryGridView.count(
                    itemCount:
                    InspirationCubit.get(context).inspirationData.length,
                    crossAxisCount:
                    InspirationCubit.get(context).oneList ? 1 : 2,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 4,
                    itemBuilder: (context, productIndex) {
                      return InkWell(
                        onTap: () {
                          appCubit.getProductDetails(
                              productId: InspirationCubit.get(context)
                                  .inspirationData[productIndex]
                                  .urlLink);
                          navigateTo(context, ProductDetailsScreen());

                          // _launchURLBrowser(
                          //     cubit.inspirationData[index].urlLink);
                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.r),
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                InspirationCubit.get(context)
                                    .inspirationData[productIndex]
                                    .image!
                                    .endsWith('.mp4')
                                    ? VideoServerDisplay(
                                  videoUrl: InspirationCubit.get(context)
                                      .inspirationData[productIndex]
                                      .image,
                                )
                                    : CachedNetworkImage(
                                  imageUrl: InspirationCubit.get(context)
                                      .inspirationData[productIndex]
                                      .image
                                      .toString(),
                                  imageBuilder:
                                      (context, imageProvider) => Image(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                        baseColor: Colors.grey.shade400,
                                        highlightColor: Colors.grey,
                                        child: Container(
                                          height: 250.h,
                                          width: InspirationCubit.get(context)
                                              .oneList
                                              ? double.infinity
                                              : 200.w,
                                          decoration: BoxDecoration(
                                            color: kCustomBlack,
                                            borderRadius:
                                            BorderRadius.circular(20.r),
                                          ),
                                        ),
                                      ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (kToken != null) {
                                      if (InspirationCubit.get(context)
                                          .inspirationData[productIndex]
                                          .hasFavorites ==
                                          1) {
                                        InspirationCubit.get(context)
                                            .inspirationData[productIndex]
                                            .hasFavorites = 0;

                                        SubCatCubit.get(context).removeFavorite(
                                            prodId:
                                            InspirationCubit.get(context)
                                                .inspirationData[
                                            productIndex]
                                                .urlLink ??
                                                0);
                                      } else {
                                        var listName = TextEditingController();
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            SubCatCubit.get(context)
                                                .getFavListData();
                                            return BlocProvider(
                                              create: (context) =>
                                              InspirationCubit()
                                                ..getInspirationData(),
                                              child: BlocConsumer<
                                                  InspirationCubit,
                                                  InspirationStates>(
                                                listener: (context, state) {
                                                  // TODO: implement listener
                                                },
                                                builder: (context, state) {
                                                  return Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "addToOneOfYourFavoriteLists"
                                                                .tr(),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color:
                                                                kCustomBlack,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                          ),
                                                          Spacer(),
                                                          IconButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            icon: Icon(
                                                              Icons.close,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .height /
                                                            35,
                                                      ),
                                                      Align(
                                                        alignment:
                                                        AlignmentDirectional
                                                            .center,
                                                        child: Text(
                                                          "addToOneOfYourFavoriteListsVlate"
                                                              .tr(),
                                                          textAlign:
                                                          TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .height /
                                                            35,
                                                      ),

                                                      SizedBox(
                                                          height: 80,
                                                          child: ListView(
                                                            scrollDirection:
                                                            Axis.horizontal,
                                                            children: [
                                                              if (SubCatCubit.get(
                                                                  context)
                                                                  .favListModel
                                                                  ?.data
                                                                  ?.isNotEmpty ??
                                                                  SubCatCubit.get(context)
                                                                      .favListModel
                                                                      ?.data !=
                                                                      null)
                                                                SizedBox(
                                                                  height:
                                                                  80.h,
                                                                  child: ListView
                                                                      .separated(
                                                                    physics:
                                                                    NeverScrollableScrollPhysics(),
                                                                    shrinkWrap:
                                                                    true,
                                                                    scrollDirection:
                                                                    Axis.horizontal,
                                                                    itemCount:
                                                                    SubCatCubit.get(context).favListModel?.data?.length ??
                                                                        0,
                                                                    itemBuilder:
                                                                        (context,
                                                                        index) {
                                                                      return InkWell(
                                                                        onTap:
                                                                            () {
                                                                          InspirationCubit.get(context).inspirationData[productIndex].hasFavorites = 1;
                                                                          SubCatCubit.get(context).addFavProductToFavList(listId: SubCatCubit.get(context).favListModel!.data![index].iD!, productId: InspirationCubit.get(context).inspirationData[productIndex].urlLink!, index: productIndex, context: context, productIndex: productIndex);
                                                                        },
                                                                        child:
                                                                        Wrap(
                                                                          direction: Axis.vertical,
                                                                          crossAxisAlignment: WrapCrossAlignment.center,
                                                                          children: [
                                                                            CustomNetworkImage(
                                                                              image: '${SubCatCubit.get(context).favListModel?.data![index].image}',
                                                                              height: 60,
                                                                              width: 60,
                                                                              border: BorderRadius.circular(16),
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
                                                                            //   child: NetworkImage('${cubit.favListModel?.data![index].image}'),
                                                                            // ),
                                                                            ConstrainedBox(
                                                                              constraints: BoxConstraints(
                                                                                maxWidth: 70,
                                                                              ),
                                                                              child: Text(
                                                                                "${SubCatCubit.get(context).favListModel?.data![index].name}",
                                                                                style: TextStyle(
                                                                                  color: kCustomBlack,
                                                                                  fontWeight: FontWeight.w400,
                                                                                ),
                                                                                textAlign: TextAlign.center,
                                                                                maxLines: 1,
                                                                                overflow: TextOverflow.ellipsis,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      );
                                                                    },
                                                                    separatorBuilder:
                                                                        (context, index) =>
                                                                        SizedBox(
                                                                          width:
                                                                          MediaQuery.of(context).size.width / 60,
                                                                        ),
                                                                  ),
                                                                ),
                                                              if (SubCatCubit.get(
                                                                  context)
                                                                  .favListModel
                                                                  ?.data
                                                                  ?.isNotEmpty ??
                                                                  SubCatCubit.get(context)
                                                                      .favListModel
                                                                      ?.data !=
                                                                      null)
                                                                SizedBox(
                                                                  width: MediaQuery.of(context)
                                                                      .size
                                                                      .width /
                                                                      60,
                                                                ),
                                                              InkWell(
                                                                onTap: () {
                                                                  showModalBottomSheet(
                                                                    context:
                                                                    context,
                                                                    elevation:
                                                                    0.0,
                                                                    isScrollControlled:
                                                                    true,
                                                                    backgroundColor: Colors
                                                                        .grey
                                                                        .shade50,
                                                                    shape: const RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.vertical(
                                                                          top: Radius.circular(
                                                                              30),
                                                                        )),
                                                                    builder:
                                                                        (context) {
                                                                      return Form(
                                                                        child:
                                                                        Padding(
                                                                          padding: EdgeInsets.only(right: 20, left: 20, top: 20, bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                          child: SingleChildScrollView(
                                                                            child: Column(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              children: [
                                                                                Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      "newList".tr(),
                                                                                      textAlign: TextAlign.center,
                                                                                      style: TextStyle(color: kCustomBlack, fontSize: 18, fontWeight: FontWeight.w500),
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
                                                                                      fontSize: 17,
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
                                                                                      fontSize: 17,
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
                                                                                  textColor: Colors.black87,
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
                                                                                    Navigator.pop(context);
                                                                                    SubCatCubit.get(context).createNewFavList(
                                                                                      listName: listName.text,
                                                                                      context: context,
                                                                                      productId: 0,
                                                                                      index: 0,
                                                                                    );
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
                                                                },
                                                                child: Wrap(
                                                                  direction:
                                                                  Axis.vertical,
                                                                  crossAxisAlignment:
                                                                  WrapCrossAlignment
                                                                      .center,
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                      60,
                                                                      height:
                                                                      60,
                                                                      alignment:
                                                                      Alignment.center,
                                                                      decoration:
                                                                      BoxDecoration(
                                                                        shape:
                                                                        BoxShape.rectangle,
                                                                        borderRadius:
                                                                        BorderRadius.circular(16),
                                                                        color:
                                                                        Colors.grey.shade200,
                                                                      ),
                                                                      child:
                                                                      Icon(
                                                                        CupertinoIcons.add_circled,
                                                                        color:
                                                                        Colors.black,
                                                                      ),
                                                                    ),
                                                                    ConstrainedBox(
                                                                      constraints:
                                                                      BoxConstraints(
                                                                        maxWidth:
                                                                        70,
                                                                      ),
                                                                      child:
                                                                      Text(
                                                                        "createList".tr(),
                                                                        style:
                                                                        TextStyle(
                                                                          color: Colors.grey,
                                                                          fontWeight: FontWeight.w400,
                                                                        ),
                                                                        textAlign:
                                                                        TextAlign.center,
                                                                        maxLines:
                                                                        1,
                                                                        overflow:
                                                                        TextOverflow.ellipsis,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),

                                                              // InkWell(
                                                              //   onTap: () {
                                                              //     showDialog(
                                                              //       context: context,
                                                              //       builder: (context) {
                                                              //
                                                              //
                                                              //         return AlertDialog(
                                                              //           content: BlocConsumer<SubCatCubit, SubCatState>(
                                                              //             listener: (context, state) {},
                                                              //             builder: (context, state) {
                                                              //               return Column(
                                                              //                 mainAxisSize: MainAxisSize.min,
                                                              //                 children: [
                                                              //                   CustomTextFormField(
                                                              //                     hintText: "theNameOfYourFavoriteList".tr(),
                                                              //                     controller: listName,
                                                              //                     fillColor: Colors.grey,
                                                              //                     hintColor: Colors.black87,
                                                              //                     textColor: kDarkGoldColor,
                                                              //                     validate: (value){},
                                                              //
                                                              //                   ),
                                                              //                   SizedBox(
                                                              //                     height: MediaQuery.of(context).size.height / 50,
                                                              //                   ),
                                                              //                   Row(
                                                              //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                              //                     children: [
                                                              //                       InkWell(
                                                              //                         onTap: () {
                                                              //                           Navigator.pop(context);
                                                              //                           cubit.createNewFavList(listName: listName.text, context: context, productId: cubit.productFromCatList![index].id, index: index);
                                                              //                         },
                                                              //                         child: Container(
                                                              //                           alignment: Alignment.center,
                                                              //                           width: 70,
                                                              //                           height: 40,
                                                              //                           decoration: BoxDecoration(
                                                              //                             color: Colors.green,
                                                              //                             shape: BoxShape.rectangle,
                                                              //                             borderRadius: BorderRadius.circular(14),
                                                              //                           ),
                                                              //                           child: Text(
                                                              //                             "create".tr(),
                                                              //                             style: TextStyle(
                                                              //                               color: Colors.white,
                                                              //                             ),
                                                              //                           ),
                                                              //                         ),
                                                              //                       ),
                                                              //                       InkWell(
                                                              //                         onTap: () => Navigator.of(context).pop(),
                                                              //                         child: Container(
                                                              //                           alignment: Alignment.center,
                                                              //                           width: 70,
                                                              //                           height: 40,
                                                              //                           decoration: BoxDecoration(
                                                              //                             color: Colors.grey,
                                                              //                             shape: BoxShape.rectangle,
                                                              //                             borderRadius: BorderRadius.circular(14),
                                                              //                           ),
                                                              //                           child: Text(
                                                              //                             "cancel".tr(),
                                                              //                             style: TextStyle(
                                                              //                               color: Colors.red,
                                                              //                             ),
                                                              //                           ),
                                                              //                         ),
                                                              //                       )
                                                              //                     ],
                                                              //                   ),
                                                              //                 ],
                                                              //               );
                                                              //             },
                                                              //           ),
                                                              //         );
                                                              //
                                                              //
                                                              //       },
                                                              //     );
                                                              //   },
                                                              //   child: Wrap(
                                                              //     direction: Axis.vertical,
                                                              //     crossAxisAlignment: WrapCrossAlignment.center,
                                                              //     children: [
                                                              //       Container(
                                                              //         width: 60,
                                                              //         height: 60,
                                                              //         alignment: Alignment.center,
                                                              //         decoration: BoxDecoration(
                                                              //           shape: BoxShape.rectangle,
                                                              //           borderRadius: BorderRadius.circular(16),
                                                              //           color: Colors.grey.shade200,
                                                              //         ),
                                                              //         child: Icon(
                                                              //           CupertinoIcons.add_circled,
                                                              //           color: Colors.black,
                                                              //         ),
                                                              //       ),
                                                              //       ConstrainedBox(
                                                              //         constraints: BoxConstraints(
                                                              //           maxWidth: 70,
                                                              //         ),
                                                              //         child: Text(
                                                              //           "createList".tr(),
                                                              //           style: TextStyle(
                                                              //             color: Colors.grey,
                                                              //             fontWeight: FontWeight.w400,
                                                              //           ),
                                                              //           textAlign: TextAlign.center,
                                                              //           maxLines: 1,
                                                              //           overflow: TextOverflow.ellipsis,
                                                              //         ),
                                                              //       )
                                                              //     ],
                                                              //   ),
                                                              // ),
                                                            ],
                                                          ))

                                                      ,
                                                      SizedBox(
                                                        height: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .height /
                                                            35,
                                                      ),
                                                      CustomButton(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        height: 50,
                                                        text: "Done".tr(),
                                                      )
                                                    ],
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    }
                                    else{
                                      showToast(text: 'يجب عليك تسجيل الدخول', color: kCustomBlack);
                                    }

                                    // if (kToken != null && kToken!.isNotEmpty) {
                                    //   InspirationCubit.get(context)
                                    //       .updateFavorite(
                                    //           prodId:
                                    //               InspirationCubit.get(context)
                                    //                   .inspirationData[index]
                                    //                   .urlLink!);
                                    // } else {
                                    //   showToast(
                                    //       text: 'pleaseLoginFirst'.tr(),
                                    //       color: Colors.black);
                                    // }
                                  },
                                  child: BlocConsumer<SubCatCubit, SubCatState>(
                                    listener: (context, state) {
                                      if(state is AddToFavoriteSuccess){
                                        InspirationCubit.get(context).getInspirationData();
                                      }
                                    },
                                    builder: (context, state) {
                                      return Container(
                                        alignment: AlignmentDirectional.center,
                                        height:
                                        MediaQuery.of(context).size.width /
                                            10,
                                        width:
                                        MediaQuery.of(context).size.width /
                                            10,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          shape: BoxShape.circle,
                                        ),
                                        child: InspirationCubit.get(context)
                                            .inspirationData[
                                        productIndex]
                                            .hasFavorites !=
                                            0
                                            ? Icon(
                                          Icons.bookmark_add,
                                          color: kDarkGoldColor,
                                        )
                                            : Icon(
                                          Icons.bookmark_add_outlined,
                                          color: Colors.white,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )),
                      );
                    },
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