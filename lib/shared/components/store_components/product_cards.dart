import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/screens/product_details_screen.dart';
import 'package:safsofa/shared/defaults.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shimmer/shimmer.dart';
import '../../../models/my_products_details_model.dart';
import '../../constants.dart';
import '../custom_network_image.dart';
import '../custom_rating_bar.dart';

class VerticalProductCard extends StatelessWidget {
  VerticalProductCard({
    this.onFavPressed,
    this.isFavourite= false,
    this.onclick,
    this.productName,
    this.productId,
    this.image,
    this.totalRate,
    this.oldPrice,
    this.currentPrice,
    this.cubit,

  });

   final bool isFavourite;
  final String? productName;
  final int? productId;
  final String? image;
  final String? totalRate;
   final oldPrice;
  final currentPrice;
  var cubit;
  void Function()? onFavPressed;
  VoidCallback? onclick;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: //onclick

          () {
        log("i click it prodect   $productId");
        AppCubit appCubit = AppCubit.get(context);
        appCubit.getProductDetails(productId: productId);
        // cubit.getProductDetails(
        //   productId: productId,
        // );
        navigateTo(context, ProductDetailsScreen());
      },
      child: Card(
        elevation: 0,
        child: Container(
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                      child: Container(
                        child: CachedNetworkImage(
                          imageUrl: "$image",
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          ///=== is dark baseColor = grey[800]! & hightLightColor = grey[850]! ===///
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey.shade400,
                            highlightColor: Colors.grey,
                            child: Container(
                              height: 180,
                              // width: width,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                          height: 180,
                          fit: BoxFit.cover,
                          // width: width,
                        ),
                        // child: CustomNetworkImage(
                        //
                        //   image:"$image",
                        //   // width: 120,
                        //   border:BorderRadius.circular(20),
                        //
                        // ),
                    // decoration: BoxDecoration(
                    //   //    color: kBGColor,
                    //   image: DecorationImage(
                    //       image: NetworkImage("https://taqiviolet.com/public/images/product/jSJuJfaWrMJMgRQn17ld8ciKqTuKiVB81ZVN29iy.pngs")),
                    //   borderRadius: BorderRadius.circular(10),
                    // ),
                  )),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                productName ?? '',
                                maxLines: 2,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  CustomRatingBar(
                                    rating: totalRate!.isNotEmpty
                                        ? double.parse(totalRate!)
                                        : 0.0,
                                    itemSize: 14,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    '$totalRate',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  if (oldPrice != null && oldPrice != 0)
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              currentPrice.toString() ?? '',
                                              style: TextStyle(
                                                  color: Color(0xffFE9C8F),
                                                  fontSize: 16),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "SAR".tr(),
                                              style: TextStyle(
                                                  color: Color(0xffFE9C8F),
                                                  fontSize: 16),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              oldPrice.toString() ?? '',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  fontSize: 14),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "SAR".tr(),
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  fontSize: 14),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  if (oldPrice == null || oldPrice == 0)
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              currentPrice.toString() ?? '',
                                              style: TextStyle(
                                                  color: Color(0xffFE9C8F),
                                                  fontSize: 16),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "SAR".tr(),
                                              style: TextStyle(
                                                  color: Color(0xffFE9C8F),
                                                  fontSize: 16),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  // Padding(
                                  //   padding: const EdgeInsets.symmetric(
                                  //       horizontal: 20.0),
                                  //   child: Container(
                                  //     width: 25,
                                  //     height: 25,
                                  //     decoration: BoxDecoration(
                                  //       color: kDarkGoldColor,
                                  //       borderRadius: BorderRadius.circular(50),
                                  //     ),
                                  //     child: Center(
                                  //       child: Icon(
                                  //         CupertinoIcons.cart,
                                  //         color: Colors.white,
                                  //         size: 15,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                  top: 0,
                  left: 0,
                  child: IconButton(
                    onPressed: onFavPressed,
                    icon: isFavourite
                        ? Icon(
                            Icons.bookmark_add,
                            color: kDarkGoldColor,
                          )
                        : Icon(
                            Icons.bookmark_add_outlined,
                            color: Colors.grey,
                          ),
                  )),
              // Positioned(
              //   top: 0,
              //   right: 0,
              //   child: Container(
              //     width: 35,
              //     height: 35,
              //     margin: EdgeInsets.all(10),
              //     decoration: BoxDecoration(
              //       color: Colors.black,
              //       borderRadius: BorderRadius.circular(50),
              //     ),
              //     child: Center(
              //       child: Text(
              //         '30%',
              //         style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 11,
              //             fontWeight: FontWeight.bold),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

GridView showProductsGrid(int count, bool isFavourite, int id) {
  return GridView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: count,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 15 / 30,
        mainAxisSpacing: 20,
        crossAxisSpacing: 10),
    itemBuilder: (context, index) =>
        VerticalProductCard(productId: id, isFavourite: isFavourite, ),
  );
}

class HorizontalProductCard extends StatelessWidget {
  RelatedProducts relatedProducts;
  HorizontalProductCard({required this.relatedProducts});

  @override
  Widget build(BuildContext context) {
    AppCubit appCubit = AppCubit.get(context);
    return GestureDetector(
      onTap: () {
        log("99999999999999999999999999999999999999999999");
        log("99999999999999999999999999999999999999999999     ${relatedProducts.id}");
        appCubit.getProductDetails(
          productId: relatedProducts.id,
        );
        navigateTo(context, ProductDetailsScreen());
      },
      child: Container(
        // height: MediaQuery.of(context).size.height * 0.22,
        margin: EdgeInsets.symmetric(vertical: 2, horizontal: 1),
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 0.5)],
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Flexible(
              flex: 3,
              child: Container(
                width: 100,
                child: CachedNetworkImage(
                  imageUrl: "${relatedProducts.image}",
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey.shade400,
                    highlightColor: Colors.grey,
                    child: Container(
                      height: 180,
                      // width: width,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  height: 180,
                  fit: BoxFit.cover,
                  // width: width,
                ),
                // child: CustomNetworkImage(
                //
                //   image:"${relatedProducts.image}",
                //   height: 100,
                //   width: 100,
                //
                //   border:BorderRadius.circular(20),
                // ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  // image: DecorationImage(
                  //     image: NetworkImage("${relatedProducts.image}")),
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Flexible(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Text(
                        "${relatedProducts.name}",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          relatedProducts.currentPrice.toString(),
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        if(relatedProducts.oldPrice!=0)
                        Text(
                          relatedProducts.oldPrice.toString(),
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough ,
                              fontSize: 12,
                          ),
                        ),
                        // Text(
                        //   relatedProducts.,
                        //   style: TextStyle(
                        //     fontSize: 15,
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        CustomRatingBar(
                          rating: 3,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Flexible(
            //   flex: 1,
            //   child: Column(
            //     children: [
            //       SizedBox(
            //         height: 20,
            //       ),
            //       relatedProducts.hasFavorites == 1
            //           ? InkWell(
            //               onTap: () {
            //                 if (kToken != null && kToken.isNotEmpty) {
            //                   appCubit.removeRelatedProductsFavorite(
            //                       prodId: relatedProducts.id);
            //                 }
            //               },
            //               child: Icon(
            //                 Icons.favorite_rounded,
            //                 color: kDarkGoldColor,
            //               ),
            //             )
            //           : InkWell(
            //               onTap: () {
            //                 if (kToken != null && kToken.isNotEmpty) {
            //                   appCubit.removeRelatedProductsFavorite(
            //                       prodId: relatedProducts.id);
            //                 }
            //               },
            //               child: Icon(
            //                 Icons.favorite_border_rounded,
            //                 color: Colors.black26,
            //               ),
            //             ),
            //     ],
            //   ),
            // ),
            SizedBox()
          ],
        ),
      ),
    );
  }
}
