import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/cubits/search_cubit/search_cubit.dart';
import 'package:safsofa/cubits/search_cubit/search_state.dart';
import 'package:safsofa/screens/new/personel_page/help/custom_circular_progress/custom_circular_progress.dart';
import 'package:safsofa/shared/components/store_components/product_cards.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';

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
              title: 'filter'.tr(),
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
                          // Text(
                          //   'PleaseChooseTheDepartment'.tr(),
                          //   textAlign: TextAlign.start,
                          //   style: TextStyle(fontSize: width / 22),
                          // ),

                          // Text(
                          //   'price'.tr(),
                          //   textAlign: TextAlign.start,
                          //   style: TextStyle(fontSize: width / 22),
                          // ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                flex: 6,
                                child: Form(
                                    key: SearchCubit.get(context).validationKey,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsDirectional.only(
                                              start: width / 60),
                                          child: Text(
                                            'productName'.tr(),
                                            style: TextStyle(
                                              color: const Color(0xFF707070),
                                              fontSize: width / 22,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 30.h,
                                          child: TextFormField(
                                            textAlignVertical: TextAlignVertical.center,
                                            controller: productName,
                                            keyboardType: TextInputType.text,
                                            style: TextStyle(
                                              fontSize: width / 22,
                                              color: const Color(0xff9692A5),
                                            ),
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 0.0),
                                              fillColor: Colors.white,
                                              filled: true,
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: kCustomBlack,
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
                                        ),
                                      ],
                                    )
                                  // Container(
                                  //   height: 30.h,
                                  //   child: DropdownButtonFormField<Data>(
                                  //     autovalidateMode:
                                  //         AutovalidateMode.onUserInteraction,
                                  //     validator: (value) {
                                  //       if (value == null) {
                                  //         return "YouMustChooseTheDepartment".tr();
                                  //       } else {
                                  //         return null;
                                  //       }
                                  //     },
                                  //     style: TextStyle(
                                  //         fontSize: width / 22, color: Colors.black),
                                  //     hint: Text(
                                  //       "chooseDepartment".tr(),
                                  //       style: TextStyle(fontSize: width / 22),
                                  //     ),
                                  //     value: SearchCubit.get(context).selectedValue,
                                  //     decoration: InputDecoration(
                                  //         contentPadding: EdgeInsets.symmetric(
                                  //             horizontal: 15),
                                  //         border: OutlineInputBorder(
                                  //       borderRadius: BorderRadius.circular(width / 18),
                                  //     )),
                                  //     items: SearchCubit.get(context)
                                  //         .categories
                                  //         .map(
                                  //           (item) => DropdownMenuItem<Data>(
                                  //             value: item,
                                  //             child: Text(
                                  //               "${item.name}",
                                  //               style: TextStyle(fontSize: 12),
                                  //             ),
                                  //           ),
                                  //         )
                                  //         .toList(),
                                  //     isExpanded: true,
                                  //     onChanged: (value) {
                                  //       SearchCubit.get(context)
                                  //           .dropDownChoiceSelection(value!);
                                  //     },
                                  //     // onSaved: (String val) => SearchCubit.get(context)
                                  //     //     .dropDownChoiceSelection(val),
                                  //     // validator: (value) {
                                  //     //   if (value != null) {
                                  //     //     return "can't empty";
                                  //     //   } else {
                                  //     //     return null;
                                  //     //   }
                                  //     // }
                                  //   ),
                                  // ),
                                ),
                              ),
                              // SizedBox(width: 5.w,),
                              // Flexible(
                              //   flex: 4,
                              //   child:
                              //   Container(
                              //     height: 30.h,
                              //     child: DropdownButtonFormField<Data>(
                              //       style: TextStyle(
                              //           fontSize: width / 22, color: Colors.black),
                              //       hint: Text(
                              //         "chooseDepartment".tr(),
                              //         style: TextStyle(fontSize: width / 22),
                              //       ),
                              //       value: SearchCubit.get(context).selectedValue,
                              //
                              //       decoration: InputDecoration(
                              //         enabledBorder: OutlineInputBorder(
                              //           borderRadius: BorderRadius.circular(width / 18),
                              //           borderSide: BorderSide(color: kDarkGoldColor)
                              //         ),
                              //           contentPadding: EdgeInsets.symmetric(
                              //               horizontal: 15),
                              //           border: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(width / 18),
                              //       )),
                              //       items: SearchCubit.get(context)
                              //           .categories
                              //           .map(
                              //             (item) => DropdownMenuItem<Data>(
                              //               value: item,
                              //               child: Text(
                              //                 "${item.name}",
                              //                 style: TextStyle(fontSize: 12),
                              //               ),
                              //             ),
                              //           )
                              //           .toList(),
                              //       isExpanded: true,
                              //       onChanged: (value) {
                              //         SearchCubit.get(context)
                              //             .dropDownChoiceSelection(value!);
                              //       },
                              //       // onSaved: (String val) => SearchCubit.get(context)
                              //       //     .dropDownChoiceSelection(val),
                              //       // validator: (value) {
                              //       //   if (value != null) {
                              //       //     return "can't empty";
                              //       //   } else {
                              //       //     return null;
                              //       //   }
                              //       // }
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(
                              //   width: width / 80,
                              // ),
                              // Flexible(
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Padding(
                              //         padding: EdgeInsetsDirectional.only(
                              //             start: width / 60),
                              //         child: Text(
                              //           "from".tr(),
                              //           style: TextStyle(
                              //             color: const Color(0xFF707070),
                              //             fontSize: width / 22,
                              //             fontWeight: FontWeight.w500,
                              //           ),
                              //         ),
                              //       ),
                              //       Container(
                              //         height: 30.h,
                              //         child: TextFormField(
                              //           textAlignVertical: TextAlignVertical.center,
                              //           controller: fromPrice,
                              //           keyboardType: TextInputType.number,
                              //           style: TextStyle(
                              //             fontSize: width / 22,
                              //             color: const Color(0xff9692A5),
                              //           ),
                              //           decoration: InputDecoration(
                              //             contentPadding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 0.0),
                              //             fillColor: Colors.white,
                              //             filled: true,
                              //             enabledBorder: OutlineInputBorder(
                              //               borderSide: const BorderSide(
                              //                 color: kDarkGoldColor,
                              //               ),
                              //               borderRadius: BorderRadius.all(
                              //                 Radius.circular(width / 25),
                              //               ),
                              //             ),
                              //             border: OutlineInputBorder(
                              //               borderRadius: BorderRadius.all(
                              //                 Radius.circular(width / 25),
                              //               ),
                              //               borderSide: const BorderSide(
                              //                 color: kDarkGoldColor,
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // SizedBox(
                              //   width: width / 80,
                              // ),
                              // Flexible(
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Padding(
                              //         padding: EdgeInsetsDirectional.only(
                              //             start: width / 60),
                              //         child: Text(
                              //           "to".tr(),
                              //           style: TextStyle(
                              //             color: const Color(0xFF707070),
                              //             fontSize: width / 22,
                              //             fontWeight: FontWeight.w500,
                              //           ),
                              //         ),
                              //       ),
                              //       Container(
                              //         height: 30.h,
                              //         child: TextFormField(
                              //           textAlignVertical: TextAlignVertical.center,
                              //           controller: toPrice,
                              //           keyboardType: TextInputType.number,
                              //           style: TextStyle(
                              //             fontSize: width / 22,
                              //             color: const Color(0xff9692A5),
                              //           ),
                              //           decoration: InputDecoration(
                              //             contentPadding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 0.0),
                              //             fillColor: Colors.white,
                              //             filled: true,
                              //             enabledBorder: OutlineInputBorder(
                              //               borderSide: const BorderSide(
                              //                 color: kDarkGoldColor,
                              //               ),
                              //               borderRadius: BorderRadius.all(
                              //                 Radius.circular(width / 25),
                              //               ),
                              //             ),
                              //             border: OutlineInputBorder(
                              //               borderRadius: BorderRadius.all(
                              //                 Radius.circular(width / 25),
                              //               ),
                              //               borderSide: const BorderSide(
                              //                 color: kDarkGoldColor,
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(height: 2.h,),
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                                start: width / 60),
                            child: Text(
                              "chooseDepartment".tr(),
                              style: TextStyle(
                                color: const Color(0xFF707070),
                                fontSize: width / 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SearchCubit.get(context).categories.isEmpty? Center(child: LinearProgressIndicator()):GridView.builder(
                            shrinkWrap: true,
                              itemCount: SearchCubit.get(context).categories.length,
                              itemBuilder: (context,index)=>SortItem(title: SearchCubit.get(context).categories[index].name??'', isActive: SearchCubit.get(context).activeCatIndex==index,
                          onTap: (){
                            SearchCubit.get(context).changeCatIndex(index: index);
                            SearchCubit.get(context)
                                .dropDownChoiceSelection(SearchCubit.get(context).categories[index]);
                          },
                          ), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3.5,
                            crossAxisSpacing: 3,
                            mainAxisSpacing: 3
                          ), ),
                          SizedBox(height: 10.h,),
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                                start: width / 60),
                            child: Text(
                              'price'.tr(),
                              style: TextStyle(
                                color: const Color(0xFF707070),
                                fontSize: width / 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25.h,
                            child: RangeSlider(
                                divisions: 80,
                              activeColor: kCustomBlack,
                              labels: RangeLabels(SearchCubit.get(context).startValue.toString(),SearchCubit.get(context).endValue.toString()),
                                min: SearchCubit.get(context).homeScreenMainCatModel?.msg?.minPrice?.toDouble()??1,
                                max: SearchCubit.get(context).homeScreenMainCatModel?.msg?.maxPrice?.toDouble()??5,
                                values: RangeValues(SearchCubit.get(context).startValue??1,SearchCubit.get(context).endValue??5), onChanged: (value){
                                SearchCubit.get(context).changeSliderValue(value.start, value.end);

                            }),
                          ),
                          // SizedBox(
                          //   height: 10.h,
                          // ),
                          // Text(
                          //   'productName'.tr(),
                          //   textAlign: TextAlign.start,
                          //   style: TextStyle(fontSize: width / 22),
                          // ),
                          // SizedBox(
                          //   height: 10.h,
                          // ),
                          // Container(
                          //   height: 30.h,
                          //   child: CustomFormField(
                          //     controller: productName,
                          //     minLines: 1,
                          //       validate: (va){}
                          //   ),
                          // ),
                          SizedBox(height: 5.h
                            ,),
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                                start: width / 60),
                            child: Text(
                              'sort'.tr(),
                              style: TextStyle(
                                color: const Color(0xFF707070),
                                fontSize: width / 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
          SizedBox(height: 5.h),
                          Row(
                            children: [
                              Expanded(
                                child: SortItem(title: 'maxP'.tr(),isActive: SearchCubit.get(context).index==1,onTap: (){
                                  SearchCubit.get(context).changeIndex(value: 1);
                                },),
                              ),
                              SizedBox(width: 5.w,),
                              Expanded(
                                child: SortItem(title: 'minP'.tr(),isActive: SearchCubit.get(context).index==2,onTap: (){
                                  SearchCubit.get(context).changeIndex(value: 2);
                                },),
                              ),
                              SizedBox(width: 5.w,),
                              Expanded(
                                child: SortItem(title: 'newest'.tr(),isActive: SearchCubit.get(context).index==3,onTap: (){
                                  SearchCubit.get(context).changeIndex(value: 3);
                                },),
                              ),
                              SizedBox(width: 5.w,),
                              Expanded(
                                child: SortItem(title: 'oldest'.tr(),isActive: SearchCubit.get(context).index==4,onTap: (){
                                  SearchCubit.get(context).changeIndex(value: 4);
                                },),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.h,),
                          Row(
                            children: [
                              Expanded(
                                child: SortItem(title:kLanguage=='en'? "best rated":'الاعلى تقييم',isActive: SearchCubit.get(context).index==6,onTap: (){
                                  SearchCubit.get(context).changeIndex(value: 6);
                                },),
                              ),
                              SizedBox(width: 5.w,),
                              Expanded(
                                child: SortItem(title:kLanguage=='en'?'best selling': 'الاكثر طلب',isActive: SearchCubit.get(context).index==5,onTap: (){
                                  SearchCubit.get(context).changeIndex(value: 5);
                                },),
                              ),
                              SizedBox(width: 5.w,),
                              Expanded(
                                child: SortItem(title:kLanguage=='en'?'offers' :'العروض',isActive: SearchCubit.get(context).index==7,onTap: (){
                                  SearchCubit.get(context).changeIndex(value: 7);
                                },),
                              ),

                            ],
                          ),

                          SizedBox(
                            height: height / 35,
                          ),
                          state is LoadingSearchResults?Center(
                            child: CircularProgressIndicator.adaptive(
                              backgroundColor: kCustomBlack,
                            ),
                          ):
                          CustomButton(
                            height: height / 18,
                            text: "Search".tr(),
                            onTap: () {
                              // if (SearchCubit.get(context)
                              //     .validationKey
                              //     .currentState!
                              //     .validate()) {
                              FocusScope.of(context).requestFocus(FocusNode());
                                SearchCubit.get(context).getSearchData(
                                    categoryId: SearchCubit.get(context).selectedValue?.id,
                                    productName: productName.text);
                                // productName.clear();
                                // fromPrice.clear();
                                // toPrice.clear();

                            },
                          ),

                          SizedBox(
                            height: height / 12,
                          ),
                          SearchCubit.get(context).searchResults != null
                              ? state is SuccessSearchResults
                                  ?SearchCubit.get(context).searchResults!.data!.isEmpty ?Center(child: Text("No Products Found")) :GridView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: SearchCubit.get(context)
                                          .searchResults?.data?.length??0,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: 15 / 20,
                                              mainAxisSpacing: 10,
                                              crossAxisSpacing: 10),
                                      itemBuilder: (context, index) =>
                                          VerticalProductCard(
                                        onclick: () {},
                                        isFavourite: SearchCubit.get(context)
                                                .searchResults
                                                ?.data?[index]
                                                .hasFavorites ==
                                            1,
                                        totalRate: SearchCubit.get(context)
                                            .searchResults
                                            ?.data?[index]
                                            .reviewRate??'',
                                        image: SearchCubit.get(context)
                                            .searchResults
                                            ?.data?[index]
                                            .image,
                                        currentPrice: SearchCubit.get(context)
                                            .searchResults
                                            ?.data?[index]
                                            .currentPrice,
                                        oldPrice: SearchCubit.get(context)
                                            .searchResults
                                            ?.data?[index]
                                            .oldPrice,
                                        productName: SearchCubit.get(context)
                                            .searchResults
                                            ?.data?[index]
                                            .name,
                                        productId: SearchCubit.get(context)
                                            .searchResults
                                            ?.data?[index]
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
                                          child: SizedBox.shrink(),
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



class SortItem extends StatelessWidget {
  const SortItem({super.key, required this.title, required this.isActive, this.onTap});
  final String title;
  final bool isActive;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap ,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 3.h),
        decoration: BoxDecoration(
            color: isActive?kCustomBlack:Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1.w,color: kCustomBlack)
        ),
        child: Center(
          child: Text(title,style: TextStyle(
            color: isActive?Colors.white:kCustomBlack,
            fontSize: 14.sp
          ),),
        ),
      ),
    );
  }
}

