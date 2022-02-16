import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/app_cubit.dart';
import 'package:safsofa/cubits/app_states.dart';
import 'package:safsofa/shared/components/custom_app_bar_with_search.dart';
import 'package:safsofa/shared/components/store_components/product_cards.dart';
import 'package:safsofa/shared/constants.dart';

class DisplayProductsScreen extends StatefulWidget {
  const DisplayProductsScreen({Key key, this.categoryName, this.hasDepartments})
      : super(key: key);

  final String categoryName;
  final bool hasDepartments;

  @override
  State<DisplayProductsScreen> createState() => _DisplayProductsScreenState();
}

class _DisplayProductsScreenState extends State<DisplayProductsScreen> {
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBarWithSearch(
            title: widget.categoryName,
          ),
          body: NotificationListener<ScrollNotification>(
            // ignore: missing_return
            onNotification: (scrollNotification) {
              if (scrollNotification.metrics.pixels ==
                  scrollNotification.metrics.maxScrollExtent) {
                // showToast(text: 'no more', color: Colors.red);
                if (state is! LoadMoreLoadingState) {
                  cubit.fetchMore(
                    catId: cubit.departmentsModel.result
                        .allDepartments[cubit.currentDepIndex].catId,
                  );
                }
                // setState(() {});
              }
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    widget.hasDepartments
                        ? cubit.departmentsModel == null
                            ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            : SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.20,
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                          onTap: () {
                                            cubit.currentDepIndex = index;
                                            cubit.getProducts(
                                              catId: cubit
                                                  .departmentsModel
                                                  .result
                                                  .allDepartments[index]
                                                  .catId,
                                            );
                                            setState(() {});
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
                                                    color: kBGColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                      image: NetworkImage(cubit
                                                          .departmentsModel
                                                          .result
                                                          .allDepartments[index]
                                                          .depImage),
                                                    ),
                                                    border: cubit
                                                                .currentDepIndex ==
                                                            index
                                                        ? Border.all(
                                                            color:
                                                                kDarkGoldColor)
                                                        : Border.all(
                                                            color: Colors
                                                                .transparent)),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                cubit
                                                    .departmentsModel
                                                    .result
                                                    .allDepartments[index]
                                                    .depName,
                                                style: TextStyle(
                                                    color:
                                                        cubit.currentDepIndex ==
                                                                index
                                                            ? kDarkGoldColor
                                                            : Colors.black45,
                                                    fontWeight:
                                                        cubit.currentDepIndex ==
                                                                index
                                                            ? FontWeight.bold
                                                            : FontWeight
                                                                .normal),
                                              )
                                            ],
                                          ),
                                        ),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                          width: 20,
                                        ),
                                    itemCount: cubit.departmentsModel.result
                                        .allDepartments.length),
                              )
                        : SizedBox(),
                    cubit.productsModel == null
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                cubit.productsModel.result.allProducts.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 15 / 30,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 10),
                            itemBuilder: (context, index) =>
                                VerticalProductCard(
                              cubit: cubit,
                              isFavourite: cubit.favourites[cubit.productsModel
                                  .result.allProducts[index].prodId],
                              totalRate: cubit.productsModel.result
                                  .allProducts[index].totalRate,
                              image: cubit.productsModel.result
                                  .allProducts[index].productImage,
                              currentPrice: cubit.productsModel.result
                                  .allProducts[index].price,
                              oldPrice: cubit.productsModel.result
                                  .allProducts[index].oldPrice,
                              productName: cubit.productsModel.result
                                  .allProducts[index].productName,
                              productId: cubit.productsModel.result
                                  .allProducts[index].prodId,
                            ),
                          ),
                    SizedBox(
                      height: 30,
                    ),
                    state is LoadMoreLoadingState
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Center(
                                child: CircularProgressIndicator(
                              color: Colors.black,
                            )),
                          )
                        : state is LoadMoreEndState
                            ? Center(
                                child: Text(
                                  'No more',
                                  style: TextStyle(color: Colors.black54),
                                ),
                              )
                            : SizedBox(),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
