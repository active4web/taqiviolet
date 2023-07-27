import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/search_cubit/search_cubit.dart';
import 'package:safsofa/cubits/search_cubit/search_state.dart';
import 'package:safsofa/shared/components/custom_form_field.dart';
import 'package:safsofa/shared/components/store_components/product_cards.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';

import '../../models/homeModel/main_cat_model.dart';
import '../shared/components/custom_app_bar.dart';
import '../shared/components/custom_button.dart';

TextEditingController fromPrice = TextEditingController();
TextEditingController toPrice = TextEditingController();
TextEditingController productName = TextEditingController();

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => SearchCubit()..getCategories(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomAppBar(
              title: 'Search'.tr(),
              // colorIcon: Colors.white,
            ),
            body: (state is SearchSuccessState &&
                        SearchCubit.get(context).categories.isNotEmpty) ||
                    state is SelectItem ||
                    state is! SearchErrorState
                ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PleaseChooseTheDepartment'.tr(),
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: width / 22),
                          ),
                          SizedBox(
                            height: height / 35,
                          ),
                          Form(
                            key: SearchCubit.get(context).validationKey,
                            child: DropdownButtonFormField<Data>(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null) {
                                  return "YouMustChooseTheDepartment".tr();
                                } else {
                                  return null;
                                }
                              },
                              style: TextStyle(
                                  fontSize: width / 22, color: Colors.black),
                              hint: Text(
                                "chooseDepartment".tr(),
                                style: TextStyle(fontSize: width / 22),
                              ),
                              value: SearchCubit.get(context).selectedValue,
                              decoration: InputDecoration(
                                  // contentPadding: EdgeInsets.symmetric(
                                  //     horizontal: 15, vertical: 10),
                                  border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(width / 18),
                              )),
                              items: SearchCubit.get(context)
                                  .categories
                                  .map(
                                    (item) => DropdownMenuItem<Data>(
                                      value: item,
                                      child: Text(
                                        "${item.name}",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              isExpanded: true,
                              onChanged: (value) {
                                SearchCubit.get(context)
                                    .dropDownChoiceSelection(value!);
                              },
                              // onSaved: (String val) => SearchCubit.get(context)
                              //     .dropDownChoiceSelection(val),
                              // validator: (value) {
                              //   if (value != null) {
                              //     return "can't empty";
                              //   } else {
                              //     return null;
                              //   }
                              // }
                            ),
                          ),
                          SizedBox(
                            height: height / 35,
                          ),
                          Text(
                            'price'.tr(),
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: width / 22),
                          ),
                          SizedBox(
                            height: height / 35,
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.only(
                                          start: width / 60),
                                      child: Text(
                                        "from".tr(),
                                        style: TextStyle(
                                          color: const Color(0xFF707070),
                                          fontSize: width / 22,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: fromPrice,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                        fontSize: width / 22,
                                        color: const Color(0xff9692A5),
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: kDarkGoldColor,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(width / 25),
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(width / 25),
                                          ),
                                          borderSide: const BorderSide(
                                            color: kDarkGoldColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: width / 80,
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.only(
                                          start: width / 60),
                                      child: Text(
                                        "to".tr(),
                                        style: TextStyle(
                                          color: const Color(0xFF707070),
                                          fontSize: width / 22,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: toPrice,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                        fontSize: width / 22,
                                        color: const Color(0xff9692A5),
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: kDarkGoldColor,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(width / 25),
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(width / 25),
                                          ),
                                          borderSide: const BorderSide(
                                            color: kDarkGoldColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height / 35,
                          ),
                          Text(
                            'productName'.tr(),
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: width / 22),
                          ),
                          SizedBox(
                            height: height / 35,
                          ),
                          CustomFormField(
                            controller: productName,
                            minLines: 1,
                              validate: (va){}
                          ),
                          SizedBox(
                            height: height / 35,
                          ),
                          CustomButton(
                            height: height / 18,
                            text: "Search".tr(),
                            onTap: () {
                              if (SearchCubit.get(context)
                                  .validationKey
                                  .currentState!
                                  .validate()) {
                                log('VALIDATED');
                                log(SearchCubit.get(context).selectedValue!.id!.toString());
                                log( fromPrice.text);
                                log(toPrice.text);
                                log(productName.text);
                                log("mostafa do search");
                                SearchCubit.get(context).getSearchData(
                                    categoryId: SearchCubit.get(context).selectedValue!.id!,
                                    startPrice: fromPrice.text,
                                    endPrice: toPrice.text,
                                    productName: productName.text);
                                // productName.clear();
                                // fromPrice.clear();
                                // toPrice.clear();
                              }
                            },
                          ),
                          SizedBox(
                            height: height / 12,
                          ),
                          SearchCubit.get(context).searchResults != null
                              ? state is SuccessSearchResults
                                  ? GridView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: SearchCubit.get(context)
                                          .searchResults!
                                          .data!
                                          .length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: 15 / 30,
                                              mainAxisSpacing: 20,
                                              crossAxisSpacing: 10),
                                      itemBuilder: (context, index) =>
                                          VerticalProductCard(
                                        onclick: () {},
                                        isFavourite: SearchCubit.get(context)
                                                .searchResults
                                                ?.data![index]
                                                .hasFavorites ==
                                            1,
                                        totalRate: SearchCubit.get(context)
                                            .searchResults
                                            ?.data![index]
                                            .reviewRate,
                                        image: SearchCubit.get(context)
                                            .searchResults
                                            ?.data![index]
                                            .image,
                                        currentPrice: SearchCubit.get(context)
                                            .searchResults
                                            ?.data![index]
                                            .currentPrice,
                                        oldPrice: SearchCubit.get(context)
                                            .searchResults
                                            ?.data![index]
                                            .oldPrice,
                                        productName: SearchCubit.get(context)
                                            .searchResults
                                            ?.data![index]
                                            .name,
                                        productId: SearchCubit.get(context)
                                            .searchResults
                                            ?.data![index]
                                            .id,
                                        onFavPressed: () {
                                          if (kToken != null &&
                                              kToken!.isNotEmpty) {
                                            SearchCubit.get(context)
                                                .updateFavorite(
                                                    prodId:
                                                        SearchCubit.get(context)
                                                            .searchResults
                                                            !.data![index]
                                                            .id!);
                                          } else {
                                            showToast(
                                                text: 'pleaseLoginFirst'.tr(),
                                                color: Colors.black);
                                          }
                                        },
                                      ),
                                    )
                                  : state is! SelectItem
                                      ? Center(
                                          child: CircularProgressIndicator(
                                            color: kDarkGoldColor,
                                          ),
                                        )
                                      : SizedBox()
                              : SizedBox()
                        ],
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(
                      color: kDarkGoldColor,
                    ),
                  ),
            // NotificationListener<ScrollNotification>(
            //   // ignore: missing_return
            //   onNotification: (scrollNotification) {
            //     if (scrollNotification.metrics.pixels ==
            //         scrollNotification.metrics.maxScrollExtent) {
            //       // showToast(text: 'no more', color: Colors.red);
            //       if (state is! LoadMoreLoadingState) {
            //         cubit.fetchMore(
            //           catId: cubit.departmentsModel.result
            //               .allDepartments[cubit.currentDepIndex].catId,
            //         );
            //       }
            //     }
            //   },
            //   child: SingleChildScrollView(
            //     child: Padding(
            //       padding: const EdgeInsets.all(20),
            //       child: Column(
            //         children: [
            //           cubit.productsModel == null
            //               ? Center(
            //                   child: Padding(
            //                     padding: const EdgeInsets.all(8.0),
            //                     child: Column(
            //                       mainAxisAlignment: MainAxisAlignment.center,
            //                       children: [
            //                         CircularProgressIndicator(
            //                           color: Colors.black,
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 )
            //               : GridView.builder(
            //                   shrinkWrap: true,
            //                   physics: NeverScrollableScrollPhysics(),
            //                   itemCount:
            //                       cubit.productsModel.result.allProducts.length,
            //                   gridDelegate:
            //                       SliverGridDelegateWithFixedCrossAxisCount(
            //                           crossAxisCount: 2,
            //                           childAspectRatio: 15 / 30,
            //                           mainAxisSpacing: 20,
            //                           crossAxisSpacing: 10),
            //                   itemBuilder: (context, index) =>
            //                       VerticalProductCard(
            //                     // cubit: cubit,
            //                     isFavourite: cubit.favourites[cubit.productsModel
            //                         .result.allProducts[index].prodId],
            //                     totalRate: cubit.productsModel.result
            //                         .allProducts[index].totalRate,
            //                     image: cubit.productsModel.result
            //                         .allProducts[index].productImage,
            //                     discount: cubit.productsModel.result
            //                         .allProducts[index].price,
            //                     price: cubit.productsModel.result
            //                         .allProducts[index].oldPrice,
            //                     productName: cubit.productsModel.result
            //                         .allProducts[index].productName,
            //                     productId: cubit.productsModel.result
            //                         .allProducts[index].prodId,
            //                   ),
            //                 ),
            //           SizedBox(
            //             height: 30,
            //           ),
            //           state is LoadMoreLoadingState
            //               ? Padding(
            //                   padding: const EdgeInsets.symmetric(vertical: 20),
            //                   child: Center(
            //                       child: CircularProgressIndicator(
            //                     color: Colors.black,
            //                   )),
            //                 )
            //               : state is LoadMoreEndState
            //                   ? Center(
            //                       child: Text(
            //                         'No more',
            //                         style: TextStyle(color: Colors.black54),
            //                       ),
            //                     )
            //                   : SizedBox(),
            //           SizedBox(
            //             height: 30,
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          );
        },
      ),
    );
  }
}
