import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/cubits/shopsCubit/shops_cubit.dart';
import 'package:safsofa/shared/components/custom_app_bar_with_search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ShopProfileScreen.dart';

class ShopsScreen extends StatelessWidget {
  const ShopsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopsCubit, ShopsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        ShopsCubit cubit = ShopsCubit.get(context);
        state is ShopsInitial ? cubit.getDataFromShops() : print("mostafa");

        return Scaffold(
          appBar: CustomAppBarWithSearch(
            title: 'Shops'.tr(),
            withFilter: true,
          ),
          body:
          cubit.storeListOfData == null
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )
              :
          Padding(
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
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              cubit.emitAllShops();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ShopProfileScreen(Id: cubit.storeListOfData[index].iD,index: index,),
                                ),
                              );
                            },
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
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
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${cubit.storeListOfData[index].name}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
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
