import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/appCubit/app_states.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/components/store_components/product_cards.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Favourites'.tr(),
      ),
      body: BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return cubit.favouritesModel == null
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              cubit.favouritesModel.result.allFavourites.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 15 / 30,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 10),
                          itemBuilder: (context, index) => VerticalProductCard(
                            // cubit: cubit,
                            isFavourite: cubit.favourites[cubit.favouritesModel
                                .result.allFavourites[index].prodId],
                            totalRate: cubit.favouritesModel.result
                                .allFavourites[index].totalRate,
                            image: cubit.favouritesModel.result
                                .allFavourites[index].productImage,
                            discount: cubit.favouritesModel.result
                                .allFavourites[index].price,
                            price: cubit.favouritesModel.result
                                .allFavourites[index].oldPrice,
                            productName: cubit.favouritesModel.result
                                .allFavourites[index].serviceName,
                            productId: cubit.favouritesModel.result
                                .allFavourites[index].prodId,
                          ),
                        )
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
