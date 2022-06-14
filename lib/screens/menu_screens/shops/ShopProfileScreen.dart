import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/shopsCubit/shops_cubit.dart';
import 'package:safsofa/shared/components/custom_rating_bar.dart';
import 'package:safsofa/shared/components/store_components/product_cards.dart';
import 'package:safsofa/shared/constants.dart';

import '../../../cubits/mobile_cubit.dart';

class ShopProfileScreen extends StatefulWidget {
  int Id;
  int index;

  ShopProfileScreen({@required this.Id, @required this.index});

  @override
  State<ShopProfileScreen> createState() => _ShopProfileScreenState();
}

class _ShopProfileScreenState extends State<ShopProfileScreen> {
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopsCubit, ShopsState>(
      listener: (context, state) {},
      builder: (context, state) {
        MobileCubit mobileCubit = MobileCubit.get(context);
        ShopsCubit cubit = ShopsCubit.get(context);
        print("state      $state");
        state is AllShopsInitial
            ? cubit.getDataFromAllShops(Id: widget.Id.toString())
            : print(
                "8989797778885874598754      ========   id=${widget.Id}  ====== index=${widget.index}");

        return Scaffold(
          body: state is! AllShopsSuccess
              ? InkWell(
                  onTap: () => print(cubit.AllCat.length),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      expandedHeight: MediaQuery.of(context).size.height * 0.5,
                      backgroundColor: Colors.transparent,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Column(
                          children: [
                            Image(
                              image: NetworkImage(
                                  "${cubit.storeListOfData[widget.index].image}"),
                              fit: BoxFit.cover,
                              height: MediaQuery.of(context).size.height * 0.4,
                              width: double.infinity,
                            ),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.13,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "التقيم : ",
                                            style: TextStyle(
                                              color: ColorManager.Golden,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          CustomRatingBar(
                                            rating: double.parse(0.toString()),
                                            itemSize: 15,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            double.parse(0.toString())
                                                .toString(),
                                            style: TextStyle(fontSize: 11),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "اسم المتجر : ",
                                            style: TextStyle(
                                              color: ColorManager.Golden,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            "${cubit.storeListOfData[widget.index].name}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "رقم الموبايل : ",
                                            style: TextStyle(
                                              color: ColorManager.Golden,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            "${cubit.storeListOfData[widget.index].phone}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        height: 50,
                        child: Wrap(
                          children: List<Widget>.generate(
                            cubit.AllCat.length,
                            (int index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: ChoiceChip(
                                  label: Text('${cubit.AllCat[index].name}'),
                                  selected: _value == index,
                                  onSelected: (bool selected) {
                                    cubit.getDetectedProduct(
                                        SubCatindex: index);
                                    setState(() {
                                      if (selected) {
                                        cubit.SubCatindex = index;
                                        cubit.getDataFromAllShops(
                                            Id: widget.Id.toString());
                                        _value = index;
                                      } else {
                                        _value = null;
                                      }
                                    });
                                  },
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ),
                    cubit.DetectedProduct.length == 0 ||
                            cubit.DetectedProduct.length == null
                        ? SliverToBoxAdapter(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: Center(
                                child: Text("No Data"),
                              ),
                            ),
                          )
                        : SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) => VerticalProductCard(
                                cubit: cubit,
                                // isFavourite: cubit.favourites[cubit
                                //     .productsModel.result.allProducts[index].prodId],
                                // totalRate: cubit
                                //     .productsModel.result.allProducts[index].totalRate,
                                image: cubit.DetectedProduct[index].images,
                                discount: cubit.DetectedProduct[index].price,
                                // oldPrice: cubit
                                //     .productsModel.result.allProducts[index].oldPrice,
                                productName: cubit.DetectedProduct[index].name,
                                productId: cubit.DetectedProduct[index].id,
                              ),
                              childCount: cubit.DetectedProduct.length,
                            ),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 15 / 30,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 10),
                          ),
                  ],
                ),
        );
      },
    );
  }
}
