import 'dart:developer';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/offerCubit/offer_cubit.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';

import '../../cubits/appCubit/app_cubit.dart';
import '../../cubits/subCategory/sub_cat_cubit.dart';
import '../../shared/components/custom_button.dart';
import '../../shared/components/custom_network_image.dart';
import '../../shared/components/custom_text_form_field.dart';
import '../../shared/components/store_components/product_cards.dart';
import '../../shared/constants.dart';
import '../../shared/defaults.dart';
import '../product_details_screen.dart';

class OffersScreen extends StatelessWidget {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var cubit = OfferCubit.get(context);
    AppCubit appCubit = AppCubit.get(context);
    SubCatCubit subCatCubit = SubCatCubit.get(context);
    cubit.getOfferData2();
    return BlocConsumer<OfferCubit, OfferState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Offers'.tr(),
          ),
          body:
          cubit.allOfferNew == null && cubit.newOfferModel == null
              ? Center(
            child: CircularProgressIndicator(),
          )
              : SingleChildScrollView(
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  cubit.allOfferNew == null &&
                      state != GetOfferSuccessState
                      ? Center(
                      child: CircularProgressIndicator(
                        color: kDarkGoldColor,
                      ))
                      :cubit.allOfferNew?.isEmpty??cubit.allOfferNew==[]?Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height/2.5,),
                      Center(
                        child: Text('noOffer'.tr()),
                      )
                    ],
                  ) :GridView.builder(
                    shrinkWrap: true,
                    physics:
                    NeverScrollableScrollPhysics(),
                    itemCount: cubit
                        .allOfferNew!.length,
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

                            log("000000000000000000000000  ${cubit.allOfferNew![index].id}");
                            appCubit.getProductDetails(
                              productId: cubit.allOfferNew![index].id,
                            );
                            navigateTo(context,
                                ProductDetailsScreen());
                          },
                          cubit: cubit,
                          isFavourite: cubit
                              .allOfferNew![
                          index]
                              .hasFavorites ==
                              1,
                          totalRate: cubit
                              .allOfferNew![index]
                              .hasReviews,
                          image: cubit
                              .allOfferNew![index]
                              .image,
                          currentPrice: cubit
                              .allOfferNew![index]
                              .currentPrice,
                          oldPrice: cubit
                              .allOfferNew![index]
                              .oldPrice,
                          // oldPrice: cubit
                          //     .productsModel.result.allProducts[index].oldPrice,
                          productName: cubit
                              .allOfferNew![index]
                              .name,
                          productId: cubit
                              .allOfferNew![index]
                              .id,
                          onFavPressed: () {
                            if (kToken != null &&
                                kToken!.isNotEmpty) {
                              if (cubit
                                  .allOfferNew![
                              index]
                                  .hasFavorites ==
                                  1) {
                                subCatCubit.removeFavorite(
                                    prodId: cubit
                                        .allOfferNew![
                                    index]
                                        .id!);
                              } else {
                                ///////////////////////////////////////////////////

                                TextEditingController
                                listName =
                                TextEditingController();
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      subCatCubit
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
                                                Row(
                                                  children: [
                                                    Text(
                                                      "addToOneOfYourFavoriteLists".tr(),
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(color: kDarkGoldColor, fontSize: 22, fontWeight: FontWeight.w600),
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
                                                  height:
                                                  MediaQuery.of(context).size.height / 35,
                                                ),
                                                Align(
                                                  alignment:
                                                  AlignmentDirectional.center,
                                                  child:
                                                  Text(
                                                    "addToOneOfYourFavoriteListsVlate".tr(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 20,
                                                    ),
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
                                                      if (subCatCubit.favListModel!.data!.isNotEmpty)
                                                        SizedBox(
                                                          height: 80,
                                                          child: ListView.separated(
                                                            physics: NeverScrollableScrollPhysics(),
                                                            shrinkWrap: true,
                                                            scrollDirection: Axis.horizontal,
                                                            itemCount: subCatCubit.favListModel!.data!.length,
                                                            itemBuilder: (context, index) {
                                                              return InkWell(
                                                                onTap: () {
                                                                  subCatCubit.addFavProductToFavList(
                                                                    listId: subCatCubit.favListModel!.data![index].iD!,
                                                                    productId: subCatCubit.productFromCatList![index].id!,
                                                                    index: index,
                                                                    context: context,
                                                                  );
                                                                },
                                                                child: Wrap(
                                                                  direction: Axis.vertical,
                                                                  crossAxisAlignment: WrapCrossAlignment.center,
                                                                  children: [
                                                                    CustomNetworkImage(
                                                                      image: '${subCatCubit.favListModel?.data![index].image}',
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
                                                                        "${subCatCubit.favListModel?.data![index].name}",
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
                                                      if (subCatCubit.favListModel!.data!.isNotEmpty)
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
                                                                      key:_formKey ,
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
                                                                                    style: TextStyle(color: kDarkGoldColor, fontSize: 22, fontWeight: FontWeight.w600),
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
                                                                                    fontSize: 20,
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
                                                                                    fontSize: 20,
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
                                                                                textColor: kDarkGoldColor,
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
                                                                                  if(_formKey.currentState!.validate()){
                                                                                    Navigator.pop(context);
                                                                                    subCatCubit.createNewFavList(
                                                                                      listName: listName.text,
                                                                                      context: context,
                                                                                      productId: subCatCubit.productFromCatList![index].id,
                                                                                      index: index,
                                                                                    );
                                                                                  }else{

                                                                                  }

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
                                                  height:
                                                  MediaQuery.of(context).size.height / 35,
                                                ),
                                                CustomButton(
                                                  onTap:
                                                      () {
                                                    Navigator.pop(context);
                                                  },
                                                  height:
                                                  50,
                                                  text:
                                                  "Done".tr(),
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
          ),
          // body: state is! GetOfferSuccessState
          //     ? Center(
          //         child: CircularProgressIndicator(
          //           color: Colors.black,
          //         ),
          //       )
          //     : Padding(
          //         padding: const EdgeInsets.all(20),
          //         child: ListView.builder(
          //           physics: BouncingScrollPhysics(),
          //           shrinkWrap: true,
          //           itemCount: cubit.allOfferNew!.length,
          //           itemBuilder: (context, index) {
          //             return Padding(
          //               padding: const EdgeInsets.symmetric(vertical: 10.0),
          //               child: BigOfferCard(
          //                 title: "${cubit.allOffer![index].title}",
          //                 discountValue:
          //                     cubit.allOffer![index].discount.toString(),
          //                 OfferImage: "${cubit.allOffer![index].image}",
          //               ),
          //             );
          //           },
          //         ),
          //       ),
        );
      },
    );
  }
}

class BigOfferCard extends StatelessWidget {
  String? discountValue;
  String? OfferImage;
  String? title;

  BigOfferCard({
    @required this.discountValue,
    @required this.title,
    @required this.OfferImage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 1)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: NetworkImage("${OfferImage}"), fit: BoxFit.cover)),
                child: Column(
                  children: [
                    Text(
                      '$title',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      ' ${title} علي $discountValue ',
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20)),
              color: Colors.white,
            ),
            child: Text(
              '$discountValue احصل علي خصم ',
              style: TextStyle(fontSize: 12),
            ),
          ),
        )
      ],
    );
  }
}
