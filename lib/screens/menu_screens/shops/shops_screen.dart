import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safsofa/cubits/shopsCubit/shops_cubit.dart';
import 'package:safsofa/shared/components/custom_app_bar_with_search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/custom_search_bar.dart';
import '../../../shared/defaults.dart';
import '../../notifications_screen.dart';
import '../../searchScreen.dart';
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
          appBar:
          AppBar(title: Text('Shops'.tr()),
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark),
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.white),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  height: 20,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: IconButton(
                    icon: Icon(CupertinoIcons.search),
                    onPressed: () {
                      navigateTo(context, SearchScreen());
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  height: 20,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: IconButton(
                    icon: Icon(CupertinoIcons.bell),
                    onPressed: () {
                      navigateTo(context, NotificationsScreen());
                    },
                  ),
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  children: [
                   Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color:  Colors.black,//Colors.grey,
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(
                          CupertinoIcons.line_horizontal_3_decrease,
                          color:Colors.white// Colors.white,
                      ),
                    )
                    ,
                    SizedBox(
                      width:  10  ,
                    ),
                    Expanded(child: CustomSearchBar(Colors.black)),
                  ],
                ),
              ),
            ),  ),
          // CustomAppBarWithSearch(colorIcon: Colors.black,
          //     title: 'Shops'.tr(),colorAB: Colors.white
          // ),
          // CustomAppBarWithSearch(
          //   title: 'Shops'.tr(),
          //   withFilter: true,
          // ),
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
                     // height: MediaQuery.of(context).size.height * 0.45,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              cubit.emitAllShops();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) =>  ShopProfileScreen(Id: cubit.storeListOfData[index].iD,index: index,),
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
