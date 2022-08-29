import 'package:conditional_builder/conditional_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:safsofa/cubits/inspirationCubit/inspiration_cubit.dart';
import 'package:safsofa/models/inspiration_model.dart';
import 'package:safsofa/screens/product_details_screen.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cubits/appCubit/app_cubit.dart';
import '../cubits/inspirationCubit/inspiration_state.dart';
import '../shared/components/custom_app_bar_with_search.dart';
import '../shared/defaults.dart';

TextEditingController searchController = TextEditingController();

class DisplayInspirationProducts extends StatefulWidget {
  DisplayInspirationProducts({
    Key key,
    this.categoryName,
  }) : super(key: key);

  final String categoryName;

  @override
  State<DisplayInspirationProducts> createState() =>
      _DisplayInspirationProductsState();
}

class _DisplayInspirationProductsState
    extends State<DisplayInspirationProducts> {
  List<Data> inspirationSearchResult = [];
  @override
  Widget build(BuildContext context) {
    InspirationCubit cubit = InspirationCubit.get(context);
    cubit.getInspirationData();
    // cubit.getInspirationData();
    return BlocConsumer<InspirationCubit, InspirationStates>(
      listener: (context, state) {
        print("get dataحخهحخهعخهحخهخخحهحخ");
      },
      builder: (context, state) {
        // print('<' * 10 + cubit.inspirationModel.data[0].image + '>' * 10);CustomAppBar(title: this.categoryName.tr()),
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomAppBarWithSearch(
              title: widget.categoryName.tr(),
              controller: searchController,
              onChange: (String val) {
                setState(() {
                  searchController.text = val;
                  searchController.selection = TextSelection.fromPosition(
                      TextPosition(offset: searchController.text.length));
                });
                inspirationSearchResult.clear();
                cubit.inspirationData.forEach((element) {
                  if (element.productName.contains(searchController.text)) {
                    inspirationSearchResult.add(element);
                    print(element.image);
                  }
                });
                print('=' * 50 +
                    ' ${inspirationSearchResult.length} ' +
                    '=' * 50);
                setState(() {});
                print(val);
                // cubit.searchInspirationData(searchQuery: searchController.text);
              },
            ),
            body: ConditionalBuilder(
              condition: (cubit.inspirationData.isNotEmpty ||
                      state is GetInspirationSuccessState) ||
                  state is SearchInspirationSuccessState,
              builder: (context) => inspirationSearchResult.isEmpty
                  ? MasonryGridView.count(
                      itemCount: cubit.inspirationData.length,
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 4,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            AppCubit appCubit = AppCubit.get(context);
                            appCubit.getProductDetails(
                                productId: cubit.inspirationData[index].iD);
                            navigateTo(context, ProductDetailsScreen());

                            // _launchURLBrowser(
                            //     cubit.inspirationData[index].urlLink);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image(
                              image: NetworkImage(
                                cubit.inspirationData[index].image,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    )
                  : MasonryGridView.count(
                      itemCount: inspirationSearchResult.length,
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 4,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            AppCubit appCubit = AppCubit.get(context);
                            appCubit.getProductDetails(
                                productId: cubit.inspirationData[index].iD);
                            navigateTo(context, ProductDetailsScreen());

                            // _launchURLBrowser(
                            //     cubit.inspirationData[index].urlLink);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image(
                              image: NetworkImage(
                                inspirationSearchResult[index].image,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
              fallback: (context) => Center(
                child: CircularProgressIndicator(
                  color: kDarkGoldColor,
                ),
              ),
            ));
      },
    );
  }
}

_launchURLBrowser(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
