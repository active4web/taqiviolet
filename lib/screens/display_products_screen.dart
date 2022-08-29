import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/subCategory/sub_cat_cubit.dart';
import 'package:safsofa/screens/product_details_screen.dart';
import 'package:safsofa/shared/components/custom_app_bar_with_search.dart';
import 'package:safsofa/shared/components/store_components/product_cards.dart';
import 'package:safsofa/shared/constants.dart';

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
  bool hasDepartments;

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
        print("get dataحخهحخهعخهحخهخخحهحخ");
      },
      builder: (context, state) {
        SubCatCubit cubit = SubCatCubit.get(context);
        AppCubit appCubit = AppCubit.get(context);
        print(cubit.productFromCatList == null);
        print(cubit.subCatDataList == null);
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

                                                            print(cubit
                                                                .subCatDataList[
                                                                    index]
                                                                .id);
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

                                                            print(widget
                                                                .hasDepartments);
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
                                              // isFavourite: cubit.favourites[cubit
                                              //     .productsModel.result.allProducts[index].prodId],
                                              // totalRate: cubit
                                              //     .productsModel.result.allProducts[index].totalRate,
                                              image: cubit
                                                  .productFromCatList[index]
                                                  .image,
                                              discount: cubit
                                                  .productFromCatList[index]
                                                  .discount,
                                              price: cubit
                                                  .productFromCatList[index]
                                                  .price,
                                              // oldPrice: cubit
                                              //     .productsModel.result.allProducts[index].oldPrice,
                                              productName: cubit
                                                  .productFromCatList[index]
                                                  .name,
                                              productId: cubit
                                                  .productFromCatList[index].id,
                                            ),
                                          ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    cubit.productFromCatList == null
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
                                                print(
                                                    "000000000000000000000000");
                                                print(
                                                    "000000000000000000000000     ${cubit.productFromCatList[index].id}");
                                                appCubit.getProductDetails(
                                                  productId: cubit
                                                      .productFromCatList[index]
                                                      .id,
                                                );
                                                navigateTo(context,
                                                    ProductDetailsScreen());
                                              },
                                              cubit: cubit,
                                              // isFavourite: cubit.favourites[cubit
                                              //     .productsModel.result.allProducts[index].prodId],
                                              // totalRate: cubit
                                              //     .productsModel.result.allProducts[index].totalRate,
                                              image: cubit
                                                  .productFromCatList[index]
                                                  .image,
                                              discount: cubit
                                                  .productFromCatList[index]
                                                  .discount,
                                              price: cubit
                                                  .productFromCatList[index]
                                                  .price,
                                              // oldPrice: cubit
                                              //     .productsModel.result.allProducts[index].oldPrice,
                                              productName: cubit
                                                  .productFromCatList[index]
                                                  .name,
                                              productId: cubit
                                                  .productFromCatList[index].id,
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
