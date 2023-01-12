import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/subCategory/sub_cat_cubit.dart';
import 'package:safsofa/screens/product_details_screen.dart';
import 'package:safsofa/shared/components/custom_app_bar_with_search.dart';
import 'package:safsofa/shared/components/custom_text_form_field.dart';
import 'package:safsofa/shared/components/store_components/product_cards.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import '../cubits/appCubit/app_cubit.dart';
import '../shared/defaults.dart';

class DisplayProductsScreen extends StatefulWidget {
  DisplayProductsScreen({
    Key key,
    this.categoryName,
    this.hasDepartments,
    this.category_id,
  }) : super(key: key);
  final String category_id;
  final String categoryName;
  final hasDepartments;

  @override
  State<DisplayProductsScreen> createState() => _DisplayProductsScreenState();
}

bool ProductFromSubCat = false;

class _DisplayProductsScreenState extends State<DisplayProductsScreen> {
  ScrollController _scrollController = new ScrollController();
  @override
  void initState() {
    widget.hasDepartments
        ? SubCatCubit.get(context).getSubCatData(CatId: widget.category_id)
        : SubCatCubit.get(context).getProductSubCatData(
            param: "category_id", ProId: widget.category_id);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubCatCubit, SubCatState>(
      listener: (context, state) {
        log("get dataحخهحخهعخهحخهخخحهحخ");
      },
      builder: (context, state) {
        SubCatCubit cubit = SubCatCubit.get(context);
        AppCubit appCubit = AppCubit.get(context);
        log('${cubit.productFromCatList == null}');
        log('${cubit.subCatDataList == null}');
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomAppBarWithSearch(
                colorIcon: kDarkGoldColor,
                title: widget.categoryName,
                colorAB: Colors.white),
            body:
                cubit.productFromCatList == null && cubit.subCatDataList == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: widget.hasDepartments
                              ? Column(
                                  children: [
                                    cubit.subCatDataList == null
                                        ? Center(
                                            child: CircularProgressIndicator(
                                              color: kDarkGoldColor,
                                            ),
                                          )
                                        : SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.20,
                                            child: ListView.separated(
                                                physics:
                                                    AlwaysScrollableScrollPhysics(),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder:
                                                    (context, index) =>
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {});

                                                            log('${cubit.subCatDataList[index].id}');
                                                            cubit.getProductSubCatData(
                                                                param:
                                                                    "category_id",
                                                                ProId: 2

                                                                // cubit
                                                                //     .subCatDataList[
                                                                //         index]
                                                                //     .id

                                                                );
                                                            ProductFromSubCat =
                                                                false;

                                                            log('${widget.hasDepartments}');
                                                          },
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.25,
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.25,
                                                                decoration: BoxDecoration(
                                                                    color: kBGColor,
                                                                    borderRadius: BorderRadius.circular(10),
                                                                    image: DecorationImage(image: NetworkImage(cubit.subCatDataList[index].image), fit: BoxFit.cover),
                                                                    border:
                                                                        // cubit
                                                                        //             .currentDepIndex ==
                                                                        //         index
                                                                        //     ? Border.all(
                                                                        //         color:
                                                                        //             kDarkGoldColor)
                                                                        //     :
                                                                        Border.all(color: Colors.transparent)),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text(
                                                                cubit
                                                                    .subCatDataList[
                                                                        index]
                                                                    .name,
                                                                style: TextStyle(
                                                                    color:
                                                                        // cubit.currentDepIndex ==
                                                                        //     index
                                                                        //     ? kDarkGoldColor
                                                                        //     :
                                                                        Colors.black45,
                                                                    fontWeight:
                                                                        // cubit.currentDepIndex ==
                                                                        //     index
                                                                        //     ? FontWeight
                                                                        //     .bold
                                                                        //     :
                                                                        FontWeight.bold),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                separatorBuilder:
                                                    (context, index) =>
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                itemCount: cubit
                                                    .subCatDataList.length),
                                          ),
                                    ProductFromSubCat ==
                                                widget.hasDepartments ||
                                            cubit.productFromCatList == null
                                        ? SizedBox()
                                        : GridView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount:
                                                cubit.productFromCatList.length,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    childAspectRatio: 15 / 30,
                                                    mainAxisSpacing: 20,
                                                    crossAxisSpacing: 10),
                                            itemBuilder: (context, index) =>
                                                VerticalProductCard(
                                              cubit: cubit,
                                              isFavourite: cubit
                                                      .productFromCatList[index]
                                                      .hasFavorites ==
                                                  1,
                                              image: cubit
                                                  .productFromCatList[index]
                                                  .image,
                                              currentPrice: cubit
                                                  .productFromCatList[index]
                                                  .currentPrice,
                                              oldPrice: cubit
                                                  .productFromCatList[index]
                                                  .oldPrice,
                                              productName: cubit
                                                  .productFromCatList[index]
                                                  .name,
                                              productId: cubit
                                                  .productFromCatList[index].id,
                                              totalRate: cubit
                                                  .productFromCatList[index]
                                                  .hasReview,
                                              onFavPressed: () {
                                                if (kToken != null &&
                                                    kToken.isNotEmpty) {
                                                  if (cubit
                                                          .productFromCatList[
                                                              index]
                                                          .hasFavorites ==
                                                      1) {
                                                    cubit.removeFavorite(
                                                        prodId: cubit
                                                            .productFromCatList[
                                                                index]
                                                            .id);
                                                  } else {
                                                    ///////////////////////////////////////////////////

                                                    TextEditingController
                                                        listName =
                                                        TextEditingController();
                                                    showModalBottomSheet(
                                                        context: context,
                                                        builder: (context) {
                                                          cubit
                                                              .getFavListData();
                                                          return BlocConsumer<
                                                              SubCatCubit,
                                                              SubCatState>(
                                                            listener: (context,
                                                                state) {},
                                                            builder: (context,
                                                                state) {
                                                              return Padding(
                                                                padding: EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        MediaQuery.of(context).size.width /
                                                                            60,
                                                                    vertical: MediaQuery.of(context)
                                                                            .size
                                                                            .height /
                                                                        70),
                                                                child: state
                                                                        is ProductSuccess
                                                                    ? Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional.center,
                                                                            child:
                                                                                Text(
                                                                              "addToOneOfYourFavoriteLists".tr(),
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(color: kDarkGoldColor, fontSize: 22, fontWeight: FontWeight.w600),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                MediaQuery.of(context).size.height / 35,
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                80,
                                                                            child:
                                                                                ListView(
                                                                              scrollDirection: Axis.horizontal,
                                                                              children: [
                                                                                if (cubit.favListModel.data.isNotEmpty)
                                                                                  SizedBox(
                                                                                    height: 80,
                                                                                    child: ListView.separated(
                                                                                      physics: NeverScrollableScrollPhysics(),
                                                                                      shrinkWrap: true,
                                                                                      scrollDirection: Axis.horizontal,
                                                                                      itemCount: cubit.favListModel.data.length,
                                                                                      itemBuilder: (context, index) {
                                                                                        return InkWell(
                                                                                          onTap: () {
                                                                                            cubit.addFavProductToFavList(listId: cubit.favListModel.data[index].id, productId: cubit.productFromCatList[index].id, index: index, context: context);
                                                                                          },
                                                                                          child: Wrap(
                                                                                            direction: Axis.vertical,
                                                                                            crossAxisAlignment: WrapCrossAlignment.center,
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
                                                                                                  CupertinoIcons.heart_circle_fill,
                                                                                                  color: Colors.red,
                                                                                                ),
                                                                                              ),
                                                                                              ConstrainedBox(
                                                                                                constraints: BoxConstraints(
                                                                                                  maxWidth: 70,
                                                                                                ),
                                                                                                child: Text(
                                                                                                  cubit.favListModel.data[index].name,
                                                                                                  style: TextStyle(
                                                                                                    color: kDarkGoldColor,
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
                                                                                      separatorBuilder: (context, index) => SizedBox(
                                                                                        width: MediaQuery.of(context).size.width / 60,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                if (cubit.favListModel.data.isNotEmpty)
                                                                                  SizedBox(
                                                                                    width: MediaQuery.of(context).size.width / 60,
                                                                                  ),
                                                                                InkWell(
                                                                                  onTap: () {
                                                                                    showDialog(
                                                                                      context: context,
                                                                                      builder: (context) {
                                                                                        return AlertDialog(
                                                                                          content: BlocConsumer<SubCatCubit, SubCatState>(
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
                                                                                                          cubit.createNewFavList(listName: listName.text, context: context, productId: cubit.productFromCatList[index].id, index: index);
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
                                                                                    );
                                                                                  },
                                                                                  child: Wrap(
                                                                                    direction: Axis.vertical,
                                                                                    crossAxisAlignment: WrapCrossAlignment.center,
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
                                                                            MainAxisSize.min,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
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
                                                  //////////////////////////////////////////////////////////

                                                  // isFavourite = !isFavourite;
                                                  // log(cubit
                                                  //         .productFromCatList[
                                                  //             index]
                                                  //         .id
                                                  //         .toString() +
                                                  //     "DDDDD");
                                                  // cubit.updateFavorite(
                                                  //     prodId: cubit
                                                  //         .productFromCatList[
                                                  //             index]
                                                  //         .id);

                                                  // cubit.emit(ChangeIconColor());
                                                } else {
                                                  showToast(
                                                      text: 'pleaseLoginFirst'
                                                          .tr(),
                                                      color: Colors.black);
                                                }
                                              },
                                            ),
                                          ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    cubit.productFromCatList == null &&
                                            state != ProductSuccess
                                        ? Center(
                                            child: CircularProgressIndicator(
                                            color: kDarkGoldColor,
                                          ))
                                        : GridView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount:
                                                cubit.productFromCatList.length,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    childAspectRatio: 15 / 30,
                                                    mainAxisSpacing: 15,
                                                    crossAxisSpacing: 1),
                                            itemBuilder: (context, index) =>
                                                VerticalProductCard(
                                              onclick: () {
                                                log("000000000000000000000000");
                                                log("000000000000000000000000     ${cubit.productFromCatList[index].id}");
                                                appCubit.getProductDetails(
                                                  productId: cubit
                                                      .productFromCatList[index]
                                                      .id,
                                                );
                                                navigateTo(context,
                                                    ProductDetailsScreen());
                                              },
                                              cubit: cubit,
                                              isFavourite: cubit
                                                      .productFromCatList[index]
                                                      .hasFavorites ==
                                                  1,
                                              totalRate: cubit
                                                  .productFromCatList[index]
                                                  .hasReview,
                                              image: cubit
                                                  .productFromCatList[index]
                                                  .image,
                                              currentPrice: cubit
                                                  .productFromCatList[index]
                                                  .currentPrice,
                                              oldPrice: cubit
                                                  .productFromCatList[index]
                                                  .oldPrice,
                                              // oldPrice: cubit
                                              //     .productsModel.result.allProducts[index].oldPrice,
                                              productName: cubit
                                                  .productFromCatList[index]
                                                  .name,
                                              productId: cubit
                                                  .productFromCatList[index].id,
                                              onFavPressed: () {
                                                if (kToken != null &&
                                                    kToken.isNotEmpty) {
                                                  if (cubit
                                                          .productFromCatList[
                                                              index]
                                                          .hasFavorites ==
                                                      1) {
                                                    cubit.removeFavorite(
                                                        prodId: cubit
                                                            .productFromCatList[
                                                                index]
                                                            .id);
                                                  } else {
                                                    ///////////////////////////////////////////////////

                                                    TextEditingController
                                                        listName =
                                                        TextEditingController();
                                                    showModalBottomSheet(
                                                        context: context,
                                                        builder: (context) {
                                                          cubit
                                                              .getFavListData();
                                                          return BlocConsumer<
                                                              SubCatCubit,
                                                              SubCatState>(
                                                            listener: (context,
                                                                state) {},
                                                            builder: (context,
                                                                state) {
                                                              return Padding(
                                                                padding: EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        MediaQuery.of(context).size.width /
                                                                            60,
                                                                    vertical: MediaQuery.of(context)
                                                                            .size
                                                                            .height /
                                                                        70),
                                                                child: state
                                                                        is ProductSuccess
                                                                    ? Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional.center,
                                                                            child:
                                                                                Text(
                                                                              "addToOneOfYourFavoriteLists".tr(),
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(color: kDarkGoldColor, fontSize: 22, fontWeight: FontWeight.w600),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                MediaQuery.of(context).size.height / 35,
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                80,
                                                                            child:
                                                                                ListView(
                                                                              scrollDirection: Axis.horizontal,
                                                                              children: [
                                                                                if (cubit.favListModel.data.isNotEmpty)
                                                                                  SizedBox(
                                                                                    height: 80,
                                                                                    child: ListView.separated(
                                                                                      physics: NeverScrollableScrollPhysics(),
                                                                                      shrinkWrap: true,
                                                                                      scrollDirection: Axis.horizontal,
                                                                                      itemCount: cubit.favListModel.data.length,
                                                                                      itemBuilder: (context, index) {
                                                                                        return InkWell(
                                                                                          onTap: () {
                                                                                            cubit.addFavProductToFavList(listId: cubit.favListModel.data[index].id, productId: cubit.productFromCatList[index].id, index: index, context: context);
                                                                                          },
                                                                                          child: Wrap(
                                                                                            direction: Axis.vertical,
                                                                                            crossAxisAlignment: WrapCrossAlignment.center,
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
                                                                                                  CupertinoIcons.heart_circle_fill,
                                                                                                  color: Colors.red,
                                                                                                ),
                                                                                              ),
                                                                                              ConstrainedBox(
                                                                                                constraints: BoxConstraints(
                                                                                                  maxWidth: 70,
                                                                                                ),
                                                                                                child: Text(
                                                                                                  cubit.favListModel.data[index].name,
                                                                                                  style: TextStyle(
                                                                                                    color: kDarkGoldColor,
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
                                                                                      separatorBuilder: (context, index) => SizedBox(
                                                                                        width: MediaQuery.of(context).size.width / 60,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                if (cubit.favListModel.data.isNotEmpty)
                                                                                  SizedBox(
                                                                                    width: MediaQuery.of(context).size.width / 60,
                                                                                  ),
                                                                                InkWell(
                                                                                  onTap: () {
                                                                                    showDialog(
                                                                                      context: context,
                                                                                      builder: (context) {
                                                                                        return AlertDialog(
                                                                                          content: BlocConsumer<SubCatCubit, SubCatState>(
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
                                                                                                          cubit.createNewFavList(listName: listName.text, context: context, productId: cubit.productFromCatList[index].id, index: index);
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
                                                                                    );
                                                                                  },
                                                                                  child: Wrap(
                                                                                    direction: Axis.vertical,
                                                                                    crossAxisAlignment: WrapCrossAlignment.center,
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
                                                                            MainAxisSize.min,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
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
                                                      text: 'pleaseLoginFirst'
                                                          .tr(),
                                                      color: Colors.black);
                                                }
                                              },
                                            ),
                                          ),
                                  ],
                                ),
                        ),
                      ));
      },
    );
  }
}
