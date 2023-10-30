import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/subCategory/sub_cat_cubit.dart';
import 'package:safsofa/screens/product_details_screen.dart';
import 'package:safsofa/shared/components/custom_app_bar_with_search.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/components/custom_network_image.dart';
import 'package:safsofa/shared/components/custom_text_form_field.dart';
import 'package:safsofa/shared/components/store_components/product_cards.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import '../cubits/appCubit/app_cubit.dart';
import '../shared/defaults.dart';

class DisplayProductsScreen extends StatefulWidget {
  DisplayProductsScreen({
    this.categoryName,
    this.hasDepartments,
    this.category_id,
  });

  final String? category_id;
  final String? categoryName;
  final hasDepartments;

  @override
  State<DisplayProductsScreen> createState() => _DisplayProductsScreenState();
}

bool ProductFromSubCat = false;

class _DisplayProductsScreenState extends State<DisplayProductsScreen> {
  ScrollController _scrollController = new ScrollController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    print('9' * 100);
    print(widget.category_id);
    return BlocConsumer<SubCatCubit, SubCatState>(
      listener: (context, state) {},
      builder: (context, state) {
        SubCatCubit cubit = SubCatCubit.get(context);
        AppCubit appCubit = AppCubit.get(context);
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomAppBarWithSearch(
                colorIcon: kDarkGoldColor,
                title: widget.categoryName,
                colorAB: Colors.white),
            body: cubit.productFromCatList == null &&
                    cubit.subCatDataList == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : state is ProductLoading
                    ? Center(child: CircularProgressIndicator())
                    : cubit.productFromCatList!.length == 0
                        ? Center(
                            child: Text(
                            'NoProducts'.tr(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.grey),
                          ))
                        : SingleChildScrollView(
                            child: Padding(
                              padding: MediaQuery.of(context).viewInsets,
                              child: widget.hasDepartments
                                  ? Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        cubit.subCatDataList == null
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator(
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

                                                                log('${cubit.subCatDataList![index].id}');
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
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.25,
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.25,
                                                                    decoration: BoxDecoration(
                                                                        // color: kBGColor,
                                                                        color: kBGColor,
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        image: DecorationImage(
                                                                          image:
                                                                              NetworkImage("${cubit.subCatDataList![index].image}"),
                                                                          fit: BoxFit
                                                                              .contain,
                                                                        ),
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
                                                                    "${cubit.subCatDataList![index].name}",
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
                                                                            FontWeight.w500),
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
                                                        .subCatDataList!
                                                        .length),
                                              ),
                                        ProductFromSubCat ==
                                                    widget.hasDepartments ||
                                                cubit.productFromCatList == null
                                            ? SizedBox()
                                            : GridView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: cubit
                                                    .productFromCatList!.length,
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 2,
                                                        childAspectRatio:
                                                            15 / 30,
                                                        mainAxisSpacing: 20,
                                                        crossAxisSpacing: 10),
                                                itemBuilder: (context, indexProduct) =>
                                                    VerticalProductCard(
                                                  cubit: cubit,
                                                  isFavourite: cubit
                                                          .productFromCatList![
                                                              indexProduct]
                                                          .hasFavorites ==
                                                      1,
                                                  image: cubit
                                                      .productFromCatList![
                                                          indexProduct]
                                                      .image,
                                                  currentPrice: cubit
                                                      .productFromCatList![
                                                          indexProduct]
                                                      .currentPrice,
                                                  oldPrice: cubit
                                                      .productFromCatList![
                                                          indexProduct]
                                                      .oldPrice,
                                                  productName: cubit
                                                      .productFromCatList![
                                                          indexProduct]
                                                      .name,
                                                  productId: cubit
                                                      .productFromCatList![
                                                          indexProduct]
                                                      .id,
                                                  totalRate: cubit
                                                      .productFromCatList![
                                                          indexProduct]
                                                      .hasReview,
                                                  onFavPressed: () {
                                                    if (kToken != null &&
                                                        kToken!.isNotEmpty) {
                                                      if (cubit
                                                              .productFromCatList![
                                                                  indexProduct]
                                                              .hasFavorites ==
                                                          1) {
                                                        cubit.removeFavorite(
                                                            prodId: cubit
                                                                .productFromCatList![
                                                                    indexProduct]
                                                                .id!);
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
                                                                listener:
                                                                    (context,
                                                                        state) {

                                                                    },
                                                                builder:
                                                                    (context,
                                                                        state) {
                                                                  return Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            MediaQuery.of(context).size.width /
                                                                                60,
                                                                        vertical:
                                                                            MediaQuery.of(context).size.height /
                                                                                70),
                                                                    child: state
                                                                            is ProductSuccess
                                                                        ? Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            children: [
                                                                              Align(
                                                                                alignment: AlignmentDirectional.center,
                                                                                child: Text(
                                                                                  "addToOneOfYourFavoriteLists".tr(),
                                                                                  textAlign: TextAlign.center,
                                                                                  style: TextStyle(color: kDarkGoldColor, fontSize: 22, fontWeight: FontWeight.w600),
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                height: MediaQuery.of(context).size.height / 35,
                                                                              ),
                                                                              SizedBox(
                                                                                height: 80,
                                                                                child: ListView(
                                                                                  scrollDirection: Axis.horizontal,
                                                                                  children: [
                                                                                    if (cubit.favListModel!.data!.isNotEmpty)
                                                                                      SizedBox(
                                                                                        height: 80,
                                                                                        child: ListView.separated(
                                                                                          physics: NeverScrollableScrollPhysics(),
                                                                                          shrinkWrap: true,
                                                                                          scrollDirection: Axis.horizontal,
                                                                                          itemCount: cubit.favListModel!.data!.length,
                                                                                          itemBuilder: (context, index) {
                                                                                            return InkWell(
                                                                                              onTap: () {
                                                                                                cubit.addFavProductToFavList(listId: cubit.favListModel!.data![index].iD!,
                                                                                                    productId: cubit.productFromCatModel?.data?[indexProduct].id??0,
                                                                                                    index: indexProduct,
                                                                                                    context: context);
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
                                                                                                      "${cubit.favListModel?.data![index].name}",
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
                                                                                    if (cubit.favListModel!.data!.isNotEmpty)
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
                                                                                                listener: (context, state) {
                                                                                                  if(state is ProductSuccess){
                                                                                                    print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
                                                                                                  }
                                                                                                },
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
                                                                                                              cubit.createNewFavList(
                                                                                                                listName: listName.text,
                                                                                                                context: context,
                                                                                                                productId: cubit.productFromCatList![indexProduct].id,
                                                                                                                index: indexProduct,
                                                                                                              );
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
                                                                                child: CircularProgressIndicator(),
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
                                                          text:
                                                              'pleaseLoginFirst'
                                                                  .tr(),
                                                          color: Colors.black);
                                                    }
                                                  },
                                                ),
                                              ),
                                      ],
                                    )
                                  : Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        cubit.productFromCatList == null &&
                                                state != ProductSuccess
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator(
                                                color: kDarkGoldColor,
                                              ))
                                            : GridView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: cubit
                                                    .productFromCatList!.length,
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 2,
                                                        childAspectRatio:
                                                            15 / 30,
                                                        mainAxisSpacing: 15,
                                                        crossAxisSpacing: 1),
                                                itemBuilder: (context, indexProduct) =>
                                                    VerticalProductCard(
                                                  onclick: () {
                                                    appCubit.getProductDetails(
                                                      productId: cubit
                                                          .productFromCatList![
                                                              indexProduct]
                                                          .id,
                                                    );
                                                    navigateTo(context,
                                                        ProductDetailsScreen());
                                                  },
                                                  cubit: cubit,
                                                  isFavourite: cubit
                                                          .productFromCatList![
                                                              indexProduct]
                                                          .hasFavorites ==
                                                      1,
                                                  totalRate: cubit
                                                      .productFromCatList![
                                                          indexProduct]
                                                      .hasReview,
                                                  image: cubit
                                                      .productFromCatList![
                                                          indexProduct]
                                                      .image,
                                                  currentPrice: cubit
                                                      .productFromCatList![
                                                          indexProduct]
                                                      .currentPrice,
                                                  oldPrice: cubit
                                                      .productFromCatList![
                                                          indexProduct]
                                                      .oldPrice,
                                                  productName: cubit
                                                      .productFromCatList![
                                                          indexProduct]
                                                      .name,
                                                  productId: cubit
                                                      .productFromCatList![
                                                          indexProduct]
                                                      .id,
                                                  onFavPressed: () {
                                                    print(
                                                        "${"id" * 100}${cubit.productFromCatModel!.data![indexProduct].id!}");

                                                    if (kToken != null &&
                                                        kToken!.isNotEmpty) {
                                                      if (cubit
                                                              .productFromCatModel
                                                              ?.data?[indexProduct]
                                                              .hasFavorites ==
                                                          1) {
                                                        cubit.removeFavorite(
                                                            prodId: cubit
                                                                .productFromCatModel!
                                                                .data![indexProduct]
                                                                .id!);
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
                                                                listener:
                                                                    (context,
                                                                        state) {

                                                                    },
                                                                builder:
                                                                    (context,
                                                                        state) {
                                                                  return Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            MediaQuery.of(context).size.width /
                                                                                60,
                                                                        vertical:
                                                                            MediaQuery.of(context).size.height /
                                                                                70),
                                                                    child: state
                                                                            is ProductSuccess
                                                                        ? Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  Text(
                                                                                    "addToOneOfYourFavoriteLists".tr(),
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(color: kDarkGoldColor, fontSize: 18, fontWeight: FontWeight.w400),
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
                                                                                  "addToOneOfYourFavoriteListsVlate".tr(),
                                                                                  textAlign: TextAlign.center,
                                                                                  style: TextStyle(
                                                                                    color: Colors.grey,
                                                                                    fontSize: 16,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                height: MediaQuery.of(context).size.height / 35,
                                                                              ),
                                                                              SizedBox(
                                                                                height: 80,
                                                                                child: ListView(
                                                                                  scrollDirection: Axis.horizontal,
                                                                                  children: [
                                                                                    if (cubit.favListModel!.data!.isNotEmpty)
                                                                                      SizedBox(
                                                                                        height: 80,
                                                                                        child: ListView.separated(
                                                                                          physics: NeverScrollableScrollPhysics(),
                                                                                          shrinkWrap: true,
                                                                                          scrollDirection: Axis.horizontal,
                                                                                          itemCount: cubit.favListModel!.data!.length,
                                                                                          itemBuilder: (context, index) {
                                                                                            return InkWell(
                                                                                              onTap: () {
                                                                                                cubit.addFavProductToFavList(
                                                                                                  listId: cubit.favListModel!.data![index].iD!,
                                                                                                  productId: cubit.productFromCatModel?.data?[indexProduct].id??0,
                                                                                                  index: indexProduct,
                                                                                                  context: context,
                                                                                                );
                                                                                              },
                                                                                              child: Wrap(
                                                                                                direction: Axis.vertical,
                                                                                                crossAxisAlignment: WrapCrossAlignment.center,
                                                                                                children: [
                                                                                                  CustomNetworkImage(
                                                                                                    image: '${cubit.favListModel?.data![index].image}',
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
                                                                                                      "${cubit.favListModel?.data![index].name}",
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
                                                                                    if (cubit.favListModel!.data!.isNotEmpty)
                                                                                      SizedBox(
                                                                                        width: MediaQuery.of(context).size.width / 60,
                                                                                      ),
                                                                                    InkWell(
                                                                                      onTap: () {
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
                                                                                              return BlocConsumer<SubCatCubit, SubCatState>(
                                                                                                listener: (context, state) {},
                                                                                                builder: (context, state) {
                                                                                                  return Form(
                                                                                                    key: _formKey,
                                                                                                    child: Padding(
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
                                                                                                                  style: TextStyle(color: kDarkGoldColor, fontSize: 18, fontWeight: FontWeight.w500),
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
                                                                                                                if (_formKey.currentState!.validate()) {
                                                                                                                  Navigator.pop(context);
                                                                                                                  cubit.createNewFavList(
                                                                                                                    listName: listName.text,
                                                                                                                    context: context,
                                                                                                                    productId: cubit.productFromCatList![indexProduct].id,
                                                                                                                    index: indexProduct,
                                                                                                                  );
                                                                                                                } else {}
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
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                height: MediaQuery.of(context).size.height / 35,
                                                                              ),
                                                                              CustomButton(
                                                                                onTap: () {
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                height: 50,
                                                                                text: "Done".tr(),
                                                                              )
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
                                                                                child: CircularProgressIndicator(),
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
                                                          text:
                                                              'pleaseLoginFirst'
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
