import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/appCubit/app_states.dart';
import 'package:safsofa/cubits/subCategory/sub_cat_cubit.dart';
import 'package:safsofa/screens/product_details_screen.dart';
import 'package:safsofa/shared/defaults.dart';

import '../../constants.dart';
import '../custom_rating_bar.dart';

class VerticalProductCard extends StatelessWidget {
  VerticalProductCard({
    Key key,
    this.isFavourite = false,
    this.productName,
    this.productId,
    this.image,
    this.totalRate,
    this.oldPrice,
    this.currentPrice,
    this.cubit,
  }) : super(key: key);

  bool isFavourite;
  final String productName;
  final int productId;
  final String image;
  final totalRate;
  final oldPrice;
  final currentPrice;
   var cubit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // cubit.getProductDetails(
        //   productId: productId,
        // );
        // navigateTo(context, ProductDetailsScreen());
      },
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  color: kBGColor,
                  image: DecorationImage(image: NetworkImage(image)),
                  borderRadius: BorderRadius.circular(10),
                ),
              )),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        productName ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          CustomRatingBar(
                            rating: double.parse(totalRate ?? 0.toString()),
                            itemSize: 11,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            double.parse(totalRate ?? 0.toString())
                                .toString(),
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    oldPrice ?? '',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        decoration:
                                            TextDecoration.lineThrough,
                                        fontSize: 9),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'ريال',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        decoration:
                                            TextDecoration.lineThrough,
                                        fontSize: 9),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    currentPrice ?? '',
                                    style: TextStyle(
                                        color: Color(0xffFE9C8F),
                                        fontSize: 12),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'ريال',
                                    style: TextStyle(
                                        color: Color(0xffFE9C8F),
                                        fontSize: 12),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                color: kDarkGoldColor,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Icon(
                                  CupertinoIcons.cart,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
          Positioned(
              top: 0,
              left: 0,
              child: IconButton(
                onPressed: () {
                  // isFavourite = !isFavourite;
                  // print(productId.toString() + "DDDDD");
                  // cubit.updateFavourite(
                  //     isFav: isFavourite, prodId: productId);
                  // cubit.emit(ChangeIconColor());
                },
                icon: isFavourite
                    ? Icon(
                        Icons.favorite_rounded,
                        color: Color(0xffFE9C8F),
                      )
                    : Icon(
                        Icons.favorite_border_rounded,
                        color: Colors.grey,
                      ),
              )),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 35,
              height: 35,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text(
                  '30%',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

GridView showProductsGrid(int count, bool isFavourite) {
  return GridView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: count,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 15 / 30,
        mainAxisSpacing: 20,
        crossAxisSpacing: 10),
    itemBuilder: (context, index) => VerticalProductCard(
      isFavourite: isFavourite,
    ),
  );
}

class HorizontalProductCard extends StatelessWidget {
  const HorizontalProductCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(context, ProductDetailsScreen());
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.20,
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
                decoration: BoxDecoration(
                  color: Color(0xfff4f4f4),
                  image: DecorationImage(
                      image: AssetImage('assets/images/chair1.png')),
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
                        'كرسي ظهر دائري ',
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
                          '144.00',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'ريال',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
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
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Icon(
                    Icons.favorite_border_rounded,
                    color: Colors.black26,
                  ),
                ],
              ),
            ),
            SizedBox()
          ],
        ),
      ),
    );
  }
}
