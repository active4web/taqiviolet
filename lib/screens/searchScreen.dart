import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/appCubit/app_states.dart';
import 'package:safsofa/shared/components/custom_app_bar_with_search.dart';
import 'package:safsofa/shared/components/store_components/product_cards.dart';

class SearchScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        cubit.getProducts();
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBarWithSearch(
            title: 'Search'.tr(),
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
              }
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    cubit.productsModel == null
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                                ],
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
                              // cubit: cubit,
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
