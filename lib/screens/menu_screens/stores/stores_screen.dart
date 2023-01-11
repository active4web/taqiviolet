import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/storesCubit/stores_cubit.dart';

import 'package:safsofa/screens/menu_screens/stores/store_categories_screen.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StoresCubit cubit = StoresCubit.get(context);
    cubit.getDataFromShops();
    return BlocConsumer<StoresCubit, StoresState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(title: "stores".tr()),
          body: cubit.storeListOfData == null
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(20),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: cubit.storeListOfData.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 4 / 5,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10),
                    itemBuilder: (context, index) => Container(
                      // height: MediaQuery.of(context).size.height * 0.45,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              cubit.emitAllShops();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => StoreCategoriesScreen(
                                          storeId:
                                              cubit.storeListOfData[index].iD,
                                        )
                                    //    ShopProfileScreen(
                                    //     Id: cubit.storeListOfData[index].iD,
                                    //     index: index,
                                    //   ),
                                    ),
                              );
                            },
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.23,
                                width: MediaQuery.of(context).size.width * 0.37,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(10)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image(
                                    image: NetworkImage(
                                      '${cubit.storeListOfData[index].image}',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: AlignmentDirectional.center,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                '${cubit.storeListOfData[index].name}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
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
