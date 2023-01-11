import 'dart:developer';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/appCubit/app_states.dart';
import 'package:safsofa/screens/favourites_screen.dart';
import 'package:safsofa/screens/my_orders_screen.dart';
import 'package:safsofa/screens/my_profile_screen.dart';
import 'package:safsofa/screens/register_screens/login_screen.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:safsofa/shared/components/store_components/product_cards.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';
import 'package:share_plus/share_plus.dart';

import '../Lists.dart';
import '../orderReceived.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key key}) : super(key: key);

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  @override
  void initState() {
    AppCubit.get(context).getUserAccountData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        // log("Data:${cubit.userInfo.data.name}");

        return kToken == null
            ? LoginScreen()
            : state is GetAccountDataSuccessState
                ? Scaffold(
                    appBar: PreferredSize(
                      preferredSize: Size.fromHeight(
                          MediaQuery.of(context).size.height * 0.2),
                      child: AppBar(
                        iconTheme: IconThemeData(color: kLightGoldColor),
                        elevation: 0,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(100),
                          ),
                        ),
                        flexibleSpace: Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      height:
                                          MediaQuery.of(context).size.width / 4,
                                      decoration: BoxDecoration(
                                        // color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Image(
                                        image: NetworkImage(cubit.myAccountData
                                            .data.userProfile.image),
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Center(
                                            child: Icon(
                                              CupertinoIcons.profile_circled,
                                              color: kLightGoldColor,
                                              size: 50,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cubit.myAccountData.data.userProfile
                                            .name,
                                        style: TextStyle(
                                            color: kLightGoldColor,
                                            fontSize: 17),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            cubit.myAccountData.data.userProfile
                                                    .email ??
                                                '',
                                            style: TextStyle(
                                                color: kLightGoldColor,
                                                fontSize: 12),
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Text(
                                            cubit.myAccountData.data.userProfile
                                                    .phone ??
                                                '',
                                            style: TextStyle(
                                                color: kLightGoldColor,
                                                fontSize: 12),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        backgroundColor: Colors.black,
                        title: Container(
                            decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/mainlogoheadericon.png'),
                          ),
                        )),
                      ),
                    ),
                    body: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(22),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextChip(
                                    text:
                                        '${'Orders'.tr()} (${cubit.myAccountData.data.myOrder})',
                                    onTap: () {
                                      navigateTo(context, MyOrdersScreen());
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                // Expanded(
                                //   child: TextChip(
                                //     text: 'Favourites'.tr(),
                                //     onTap: () {
                                //       navigateTo(context, FavouritesScreen());
                                //     },
                                //   ),
                                // ),
                                Expanded(
                                  child: TextChip(
                                    text:
                                        '${'MyLists'.tr()} (${cubit.myAccountData.data.myList.length})',
                                    onTap: () {
                                      navigateTo(context, MyLists());
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextChip(
                                    text: 'MyProfile'.tr(),
                                    onTap: () {
                                      Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MyProfileScreen()))
                                          .then((value) {
                                        if (value) {
                                          cubit.getUserAccountData(loading:false);
                                        }
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextChip(
                                    text: 'ShareApp'.tr(),
                                    onTap: () {
                                      Share.share(
                                          'https://play.google.com/store/apps/details?id=active4web.com.safsofa');
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: TextChip(
                            //         text: 'MyLists'.tr(),
                            //         onTap: () {
                            //           navigateTo(context, MyLists());
                            //         },
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       width: 10,
                            //     ),
                            //     Expanded(
                            //       child: TextChip(
                            //         text: "reorderAPurchase".tr(),
                            //         onTap: () {
                            //           navigateTo(context, OrderReceived());
                            //           log("oooooooooooooooo");
                            //         },
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(
                            //   height: 20,
                            // ),
                            Divider(),
                            SizedBox(
                              height: 16,
                            ),
                            Label(
                              text: 'UnderWayOrders'.tr(),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            OrderInfoCard(),
                            SizedBox(
                              height: 20,
                            ),
                            Divider(),
                            SizedBox(
                              height: 16,
                            ),
                            Label(
                              text: 'CreditBalance'.tr(),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '1,3335',
                                      style: TextStyle(fontSize: 24),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Points'.tr(),
                                      style: TextStyle(fontSize: 17),
                                    )
                                  ],
                                ),
                                Container(
                                  height: 35,
                                  width: 1,
                                  color: Colors.black26,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '1,3335',
                                      style: TextStyle(fontSize: 24),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Points'.tr(),
                                      style: TextStyle(fontSize: 17),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            if (cubit.myAccountData.data.suggestion.isNotEmpty)
                              SizedBox(
                                height: 40,
                              ),
                            if (cubit.myAccountData.data.suggestion.isNotEmpty)
                              Label(
                                text: 'Suggestions'.tr(),
                              ),
                            if (cubit.myAccountData.data.suggestion.isNotEmpty)
                              SizedBox(
                                height: 10,
                              ),
                            if (cubit.myAccountData.data.suggestion.isNotEmpty)
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.4,
                                    width: MediaQuery.of(context).size.width /
                                        1.95,
                                    child: VerticalProductCard(
                                      isFavourite: cubit.myAccountData.data
                                              .suggestion[index].hasFavorites ==
                                          1,
                                      image: cubit.myAccountData.data
                                          .suggestion[index].image,
                                      productId: cubit.myAccountData.data
                                          .suggestion[index].id,
                                      productName: cubit.myAccountData.data
                                          .suggestion[index].name,
                                      oldPrice: cubit.myAccountData.data
                                          .suggestion[index].oldPrice,
                                      currentPrice: cubit.myAccountData.data
                                          .suggestion[index].currentPrice,
                                      totalRate: cubit.myAccountData.data
                                          .suggestion[index].hasReviews,
                                      onFavPressed: () {
                                        if (kToken != null &&
                                            kToken.isNotEmpty) {
                                          AppCubit.get(context).updateFavorite(
                                              prodId: cubit.myAccountData.data
                                                  .suggestion[index].id);
                                        } else {
                                          showToast(
                                              text: 'pleaseLoginFirst'.tr(),
                                              color: Colors.black);
                                        }
                                      },
                                    ),
                                  ),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    width: 20,
                                  ),
                                  itemCount: cubit
                                      .myAccountData.data.suggestion.length,
                                ),
                              ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 8,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(
                        color: kDarkGoldColor,
                      ),
                    ),
                  );
      },
    );
  }
}

// class MoveToLoginScreen extends StatelessWidget {
//   const MoveToLoginScreen({
//     Key key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CustomButton(
//                 text: 'Login'.tr(),
//                 height: 50,
//                 onTap: () {
//                   navigateTo(context, LoginScreen());
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class OrderInfoCard extends StatelessWidget {
  const OrderInfoCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: Color(0xfff4f4f4), borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('1-12-2021'),
              Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Details'.tr(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: Text(
                  'OrderNumber'.tr(),
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
              Text(
                '#1893',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: Text(
                  'DeliveryTime'.tr(),
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
              Text(
                '12-12-2021',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              )
            ],
          )
        ],
      ),
    );
  }
}

class TextChip extends StatelessWidget {
  const TextChip({
    Key key,
    this.text,
    this.onTap,
  }) : super(key: key);

  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xfffafafa),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Color(0xffCED8DC)),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 17),
          ),
        ),
      ),
    );
  }
}
