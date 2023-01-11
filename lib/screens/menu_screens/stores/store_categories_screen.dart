import 'package:flutter/material.dart';
import 'package:safsofa/cubits/storesCubit/stores_cubit.dart';
import 'package:safsofa/screens/display_products_screen.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';

class StoreCategoriesScreen extends StatelessWidget {
  final int storeId;
  const StoreCategoriesScreen({Key key, @required this.storeId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        title: "categories".tr(),
      ),
      body: BlocProvider(
        create: (context) =>
            StoresCubit()..getStoreCategories(storeId: storeId),
        child: BlocConsumer<StoresCubit, StoresState>(
          listener: (context, state) {},
          builder: (context, state) {
            return state is StoreCategorySuccessState
                ? GridView.builder(
                    padding: EdgeInsets.symmetric(
                        horizontal: width / 40, vertical: height / 60),
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 4 / 5,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 10),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () => navigateTo(
                          context,
                          DisplayProductsScreen(
                            hasDepartments: StoresCubit.get(context)
                                        .storeCats
                                        .data[index]
                                        .hasSubCategories ==
                                    1
                                ? true
                                : false,
                            categoryName: StoresCubit.get(context)
                                .storeCats
                                .data[index]
                                .name,
                            category_id: StoresCubit.get(context)
                                .storeCats
                                .data[index]
                                .id
                                .toString(),
                          )),
                      child: Column(
                        children: [
                          Container(
                              height: MediaQuery.of(context).size.height * 0.23,
                              width: MediaQuery.of(context).size.width * 0.37,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(10)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image(
                                  image: NetworkImage(
                                    StoresCubit.get(context)
                                        .storeCats
                                        .data[index]
                                        .image,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional.center,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Text(
                                  StoresCubit.get(context)
                                      .storeCats
                                      .data[index]
                                      .name,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 209, 161, 15),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    itemCount: StoresCubit.get(context).storeCats.data.length,
                  )
                : Center(
                    child: CircularProgressIndicator(color: kDarkGoldColor),
                  );
          },
        ),
      ),
    );
  }
}
