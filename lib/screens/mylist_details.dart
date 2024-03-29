import 'package:flutter/material.dart%20';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/listsCubit/lists_cubit.dart';
import 'package:safsofa/screens/product_details_screen.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/components/custom_network_image.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/shared/defaults.dart';

class MyListDetailsScreen extends StatelessWidget {
  const MyListDetailsScreen({
    Key? key,
    required this.nameList,
  }) : super(key: key);
  final String nameList;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListsCubit, ListsState>(
      listener: (context, state) {},
      builder: (context, state) {
        ListsCubit cubit = ListsCubit.get(context);
        return Scaffold(
          appBar: CustomAppBar(
            title: nameList,
          ),
          body: ConditionalBuilder(
                  condition: state is! DetailsListLoadingState,
                  builder: (context) =>
                      cubit.detailsMyListModel!.data!.listProducts!.isNotEmpty ?
                      ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount:
                          cubit.detailsMyListModel?.data?.listProducts!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomNetworkImage(
                                          image: cubit.detailsMyListModel!.data!
                                              .listProducts![index].image,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              6,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          border: BorderRadius.circular(10),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "${cubit.detailsMyListModel!.data!.listProducts![index].name}"),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              cubit
                                                          .detailsMyListModel!
                                                          .data!
                                                          .listProducts![index]
                                                          .oldPrice !=
                                                      null
                                                  ? Text(
                                                      '${cubit.detailsMyListModel!.data!.listProducts![index].oldPrice} ${"rS".tr()}',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 15,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                      ),
                                                    )
                                                  : SizedBox(),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                '${cubit.detailsMyListModel!.data!.listProducts![index].currentPrice} ${"rS".tr()}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              //TODO : SMART PRICE
                                              cubit
                                                          .detailsMyListModel!
                                                          .data!
                                                          .listProducts![index]
                                                          .smartPrice !=
                                                      null
                                                  ? Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  "${"priceSmartControlFeature".tr()}${cubit.detailsMyListModel!.data!.listProducts![index].smartPrice} ${"SAR".tr()}",
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xffFE9C8F),
                                                                      fontSize:
                                                                          14),
                                                                  // maxLines: 1,
                                                                  // overflow: TextOverflow.ellipsis,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        /*       SizedBox(
                                                width: 10,
                                              ),
                                              Row(
                                                  children: [
                                                    Text(
                                                      */ /*cubit.productDetailsModel!.data!
                                                          .productDetails![0].oldPrice
                                                          .toString()*/ /*'nkjhn',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          decoration:
                                                          TextDecoration.lineThrough,
                                                          fontSize: 17),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "SAR".tr(),
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          decoration:
                                                          TextDecoration.lineThrough,
                                                          fontSize: 17),
                                                    )
                                                  ],
                                                ),*/
                                                      ],
                                                    )
                                                  : Container(),
                                              cubit
                                                          .detailsMyListModel!
                                                          .data!
                                                          .listProducts![index]
                                                          .quantity ==
                                                      0
                                                  ? Text(
                                                      'outOfStock'.tr(),
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    )
                                                  : SizedBox(),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Row(
                                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                                  // mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () {
                                                        cubit.deleteProductList(
                                                            id: cubit
                                                                .detailsMyListModel!
                                                                .data!
                                                                .listProducts![
                                                                    index]
                                                                .id);
                                                      },
                                                      child: Text('delete'.tr(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 16)),
                                                    ),
                                                    Spacer(),
                                                    TextButton(
                                                      onPressed: () {
                                                        AppCubit.get(context)
                                                            .getProductDetails(
                                                          productId: cubit
                                                              .detailsMyListModel!
                                                              .data!
                                                              .listProducts![
                                                                  index]
                                                              .id,
                                                        );
                                                        navigateTo(context,
                                                            ProductDetailsScreen());
                                                      },
                                                      child: Text(
                                                          'AddToCart'.tr(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              fontSize: 16)),
                                                    ),
                                                  ]),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                            ),
                          ),
                        );
                      }) : Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.bookmark_add_outlined,
                              color: Colors.grey,
                              size: MediaQuery.of(context).size.width / 5,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 40,
                            ),
                            Text(
                              "youDontHaveLists".tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: MediaQuery.of(context).size.width / 22,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                  fallback: (context) =>
                      Center(child: RefreshProgressIndicator()),
                )
        );
      },
    );
  }
}
