import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/appCubit/app_states.dart';
import 'package:safsofa/cubits/gify_cubit/gift_cubit.dart';

import 'package:safsofa/screens/bottom_navigation_screens/orders_section/my_orders_screen.dart';
import 'package:safsofa/screens/bottom_navigation_screens/orders_section/order_details.dart';
import 'package:safsofa/screens/header_my_account/check_balance_gift_card.dart';
import 'package:safsofa/screens/header_my_account/coupones.dart';
import 'package:safsofa/screens/header_my_account/gift_card.dart';
import 'package:safsofa/screens/my_profile_screen.dart';
import 'package:safsofa/screens/register_screens/login_screen.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:safsofa/shared/components/custom_text_form_field.dart';
import 'package:safsofa/shared/components/dialogs.dart';
import 'package:safsofa/shared/components/store_components/product_cards.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';
import 'package:share_plus/share_plus.dart';

import '../../network/local/cache_helper.dart';
import '../new/partner_screen.dart';

class MyAccountScreen extends StatefulWidget {
  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {

  @override
  void initState() {
    GiftCubit.get(context).showCouponsData();
    AppCubit.get(context).getUserAccountData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        return kToken == null
            ? LoginScreen()
            : state is GetAccountDataSuccessState ||
                    state is GetFavoritesListLoading
                ? WillPopScope(
                    onWillPop: () async {
                      displayLogoutDialog(
                          context, "closeApplication".tr(), "wantExit".tr());
                      return true;
                    },
                    child: Scaffold(
                      appBar: PreferredSize(
                        preferredSize: Size.fromHeight(70),
                        child: AppBar(
                          // title: Text("${title}"),
                          backgroundColor: Color(0xff393846),
                          systemOverlayStyle: SystemUiOverlayStyle(
                              statusBarColor: Color(0xff393846),
                              statusBarIconBrightness: Brightness.light),

                          ///Color(),// Colors.white,
                          elevation: 0,
                          titleTextStyle: TextStyle(
                              color: kLightGoldColor,
                              fontFamily: 'Tajawal',
                              fontSize: 17),
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(60),
                              bottomLeft: Radius.circular(60),
                            ),
                          ),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${cubit.myAccountData?.data?.userProfile?.name}",
                                style: TextStyle(
                                    color: kLightGoldColor, fontSize: 17),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              cubit.myAccountData?.data?.userProfile?.email !=
                                      null
                                  ? Text(
                                      "${cubit.myAccountData?.data?.userProfile?.email}",
                                      style: TextStyle(
                                          color: kLightGoldColor, fontSize: 12),
                                    )
                                  : Text(
                                      cubit.myAccountData?.data?.userProfile
                                          ?.phone,
                                      style: TextStyle(
                                          color: kLightGoldColor, fontSize: 12),
                                    ),
                              /*      Row(
                                children: [
                                  Text(
                                    "${cubit.myAccountData?.data?.userProfile?.email}" ??
                                        '',
                                    style: TextStyle(
                                        color: kLightGoldColor,
                                        fontSize: 12),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Text(
                                    cubit.myAccountData?.data
                                        ?.userProfile?.phone ??
                                        '',
                                    style: TextStyle(
                                        color: kLightGoldColor,
                                        fontSize: 12),
                                  ),
                                ],
                              )*/
                            ],
                          ),
                          iconTheme: IconThemeData(color: kLightGoldColor),
                          actions: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Image(
                                image:
                                    AssetImage('assets/images/logoheader.png'),
                              ),
                            )
                          ],
                        ),
                      ),
                      body: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 22.w,vertical: 5.h),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: (){
                                        navigateTo(
                                            context, CouponesScreen());
                                      },
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          SizedBox(height: 5,),
                                          Text(GiftCubit.get(context).couponsModel?.data?.couponLists!.length.toString()??'0',
                                              style: TextStyle(fontSize: 17)),
                                          SizedBox(height: 5,),
                                          Text('coupons'.tr(),
                                              style: TextStyle(fontSize: 17)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: (){
                                        // navigateTo(
                                        //     context, MyCouponsScreen());
                                      },
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                              '${cubit.myAccountData?.data?.bonus=="" ? 0 : cubit.myAccountData?.data?.bonus} ${ "rial".tr()}',
                                              style: TextStyle(fontSize: 17)),
                                          Text('cashback'.tr(),
                                              style: TextStyle(fontSize: 17)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Expanded(
                                  //   child: InkWell(
                                  //     onTap: () {
                                  //       navigateTo(context,
                                  //           CheckBalanceGiftCardScreen());
                                  //     },
                                  //     child: Column(
                                  //       children: [
                                  //         Icon(Icons.card_giftcard),
                                  //         SizedBox(
                                  //           height: 5,
                                  //         ),
                                  //         Text(
                                  //           'giftCard'.tr(),
                                  //           style: TextStyle(fontSize: 15),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        navigateTo(
                                            context, GiftBalanceScreen());
                                      },
                                      child: Column(
                                        children: [
                                          Icon(Icons.credit_card),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'wallet'.tr(),
                                            style: TextStyle(fontSize: 16),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              /*    Center(
                                child: ClipRRect(
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
                                      image: NetworkImage(
                                          "${cubit.myAccountData?.data?.userProfile?.image}"),
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
                              ),*/
                              Row(
                                children: [
                                  Expanded(
                                    child: TextChip(
                                      text:
                                          '${'Orders'.tr()} (${cubit.myAccountData?.data?.myOrder})',
                                      onTap: () {
                                        navigateTo(context, MyOrdersScreen());
                                      },
                                    ),
                                  ),

                       /*           Expanded(
                                    child: TextChip(
                                      text: 'Favourites'.tr(),
                                      onTap: () {
                                        navigateTo(context, FavouritesScreen());
                                      },
                                    ),
                                  ),*/
                            /*      Expanded(
                                    child: TextChip(
                                      text:
                                          '${'myList'.tr()} (${cubit.myAccountData?.data?.myList?.length})',
                                      onTap: () {
                                        // navigateTo(context, MyLists());
                                      },
                                    ),
                                  ),*/
                                ],
                              ),
                              SizedBox(
                                height: 5.h,
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
                                                      MyProfileScreen()));
                                          /*  cubit.getUserAccountData(
                                              loading: false);*/
                                        }),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: TextChip(
                                      text: 'ShareApp'.tr(),
                                      onTap: () {
                                        Share.share(
                                            'https://play.google.com/store/apps/details?id=active4web.com.taqi');
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              if(CacheHelper.getData('type')==0)
                              Row(
                                children: [

                                  Expanded(
                                    child: TextChip(
                                        text: 'reports'.tr(),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PartnerScreen()));
                                          /*  cubit.getUserAccountData(
                                              loading: false);*/
                                        }),
                                  ),
                                ],
                              ),
                              // Padding(
                              //   padding: EdgeInsets.symmetric(
                              //       horizontal:
                              //           MediaQuery.of(context).size.width /
                              //               4.5),
                              //   child: InkWell(
                              //     onTap: () {
                              //       cubit.deleteUserAccount(context: context);
                              //     },
                              //     child: Container(
                              //       height: 50,
                              //       alignment: Alignment.center,
                              //       decoration: BoxDecoration(
                              //         color: Colors.red.withOpacity(0.9),
                              //         shape: BoxShape.rectangle,
                              //         borderRadius: BorderRadius.circular(35),
                              //       ),
                              //       child: Padding(
                              //         padding: const EdgeInsets.all(8.0),
                              //         child: Text(
                              //           "deleteAccount".tr(),
                              //           style: TextStyle(
                              //             color: Colors.white,
                              //             fontSize: 18,
                              //             fontWeight: FontWeight.bold,
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
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
                              cubit.myAccountData?.data?.myOrder != 0 &&
                                      cubit.myAccountData?.data?.lastOrder
                                              .toString() !=
                                          null
                                  ? Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Label(
                                          text: 'UnderWayOrders'.tr(),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          decoration: BoxDecoration(
                                              color: Color(0xfff4f4f4),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  cubit
                                                              .myAccountData
                                                              ?.data
                                                              ?.lastOrder
                                                              ?.createdAt !=
                                                          null
                                                      ? Text(
                                                          '${cubit.myAccountData?.data?.lastOrder?.createdAt.toString().substring(0, 10)}')
                                                      : SizedBox(),
                                                  //TODO : NAVIGATOR TO DETAILS
                                                  InkWell(
                                                    onTap: () {
                                                      print("object");
                                                      navigateTo(
                                                          context,
                                                          OrderDetailsSCR(
                                                            id: cubit
                                                                .myAccountData
                                                                ?.data
                                                                ?.lastOrder
                                                                ?.id,
                                                          ));
                                                    },
                                                    child: Container(
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          color: kCustomBlack,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                      child: Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20),
                                                          child: Text(
                                                            'Details'.tr(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              cubit
                                                          .myAccountData
                                                          ?.data
                                                          ?.lastOrder
                                                          ?.codeOrder !=
                                                      null
                                                  ? Row(
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.35,
                                                          child: Text(
                                                            'OrderNumber'.tr(),
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                        Text(
                                                          '#${cubit.myAccountData?.data?.lastOrder?.codeOrder}',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 12),
                                                        )
                                                      ],
                                                    )
                                                  : SizedBox(),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              cubit
                                                          .myAccountData
                                                          ?.data
                                                          ?.lastOrder
                                                          ?.deliveryDate !=
                                                      null
                                                  ? Row(
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.35,
                                                          child: Text(
                                                            'DeliveryTime'.tr(),
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                        Text(
                                                          '${cubit.myAccountData?.data?.lastOrder?.deliveryDate}',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 12),
                                                        )
                                                      ],
                                                    )
                                                  : SizedBox(),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Divider(),
                                      ],
                                    )
                                  : SizedBox(),
                              // SizedBox(
                              //   height: 16,
                              // ),
                              // Label(
                              //   text: 'CreditBalance'.tr(),
                              // ),
                              /*   SizedBox(
                                height: 10,
                              ),
                              //ToDo : The First
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              ),*/
                              if (cubit
                                  .myAccountData!.data!.suggestion!.isNotEmpty)
                                SizedBox(
                                  height: 10,
                                ),
                              if (cubit
                                  .myAccountData!.data!.suggestion!.isNotEmpty)
                                Label(
                                  text: 'Suggestions'.tr(),
                                ),
                              if (cubit
                                  .myAccountData!.data!.suggestion!.isNotEmpty)
                                SizedBox(
                                  height: 10,
                                ),
                              if (cubit
                                  .myAccountData!.data!.suggestion!.isNotEmpty)
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) => SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      width: MediaQuery.of(context).size.width /
                                          1.95,
                                      child: VerticalProductCard(
                                        isFavourite: cubit
                                                .myAccountData
                                                ?.data
                                                ?.suggestion![index]
                                                .hasFavorites ==
                                            1,
                                        image: cubit.myAccountData?.data
                                            ?.suggestion![index].image,
                                        productId: cubit.myAccountData?.data
                                            ?.suggestion![index].id,
                                        productName: cubit.myAccountData?.data
                                            ?.suggestion![index].name,
                                        oldPrice: cubit.myAccountData?.data
                                            ?.suggestion![index].oldPrice,
                                        currentPrice: cubit.myAccountData?.data
                                            ?.suggestion![index].currentPrice,
                                        totalRate: cubit.myAccountData?.data
                                            ?.suggestion![index].hasReviews,
                                        onFavPressed: () {
                                          if (kToken != null &&
                                              kToken!.isNotEmpty) {
                                            if (cubit
                                                    .myAccountData
                                                    ?.data
                                                    ?.suggestion![index]
                                                    .hasFavorites ==
                                                1) {
                                              cubit.removeFavoriteSuugestion(
                                                  prodId: (cubit
                                                      .myAccountData
                                                      ?.data
                                                      ?.suggestion![index]
                                                      .id)!,
                                                  index: index);
                                            } else {
                                              TextEditingController listName =
                                                  TextEditingController();
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder: (context) {
                                                    cubit
                                                        .getFavListDataSuggestion();
                                                    return BlocConsumer<
                                                        AppCubit, AppStates>(
                                                      listener:
                                                          (context, state) {},
                                                      builder:
                                                          (context, state) {
                                                        return Padding(
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal:
                                                                  MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      60,
                                                              vertical: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  70),
                                                          child: state
                                                                  is GetAccountDataSuccessState
                                                              ? Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional
                                                                              .center,
                                                                      child:
                                                                          Text(
                                                                        "addToOneOfYourFavoriteLists"
                                                                            .tr(),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            color:
                                                                                kDarkGoldColor,
                                                                            fontSize:
                                                                                22,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height /
                                                                          35,
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          80,
                                                                      child:
                                                                          ListView(
                                                                        scrollDirection:
                                                                            Axis.horizontal,
                                                                        children: [
                                                                          if (cubit
                                                                              .favListModelOfSuggestion!
                                                                              .data!
                                                                              .isNotEmpty)
                                                                            SizedBox(
                                                                              height: 80,
                                                                              child: ListView.separated(
                                                                                physics: NeverScrollableScrollPhysics(),
                                                                                shrinkWrap: true,
                                                                                scrollDirection: Axis.horizontal,
                                                                                itemCount: cubit.favListModelOfSuggestion!.data!.length,
                                                                                itemBuilder: (context, listIndex) {
                                                                                  return InkWell(
                                                                                    onTap: () {
                                                                                      cubit.addFavProductToFavListSuggestion(listId: (cubit.favListModelOfSuggestion?.data![listIndex].iD)!, productId: (cubit.myAccountData?.data?.suggestion![index].id)!, index: index, context: context);
                                                                                    },
                                                                                    child: Wrap(
                                                                                      direction: Axis.vertical,
                                                                                      crossAxisAlignment: WrapCrossAlignment.center,
                                                                                      children: [
                                                                                        Container(
                                                                                          width: 60,
                                                                                          height: 60,
                                                                                          alignment: Alignment.center,
                                                                                          decoration: BoxDecoration(
                                                                                            shape: BoxShape.rectangle,
                                                                                            borderRadius: BorderRadius.circular(16),
                                                                                            color: Colors.grey.shade200,
                                                                                          ),
                                                                                          child: Icon(
                                                                                            CupertinoIcons.heart_circle_fill,
                                                                                            color: Colors.red,
                                                                                          ),
                                                                                        ),
                                                                                        ConstrainedBox(
                                                                                          constraints: BoxConstraints(
                                                                                            maxWidth: 70,
                                                                                          ),
                                                                                          child: Text(
                                                                                            "${cubit.favListModelOfSuggestion?.data![listIndex].name}",
                                                                                            style: TextStyle(
                                                                                              color: kDarkGoldColor,
                                                                                              fontWeight: FontWeight.w400,
                                                                                            ),
                                                                                            textAlign: TextAlign.center,
                                                                                            maxLines: 1,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                          ),
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                  );
                                                                                },
                                                                                separatorBuilder: (context, listIndex) => SizedBox(
                                                                                  width: MediaQuery.of(context).size.width / 60,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          if (cubit
                                                                              .favListModelOfSuggestion!
                                                                              .data!
                                                                              .isNotEmpty)
                                                                            SizedBox(
                                                                              width: MediaQuery.of(context).size.width / 60,
                                                                            ),
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              showDialog(
                                                                                context: context,
                                                                                builder: (context) {
                                                                                  return AlertDialog(
                                                                                    content: BlocConsumer<AppCubit, AppStates>(
                                                                                      listener: (context, state) {},
                                                                                      builder: (context, state) {
                                                                                        return Column(
                                                                                          mainAxisSize: MainAxisSize.min,
                                                                                          children: [
                                                                                            CustomTextFormField(
                                                                                              hintText: "theNameOfYourFavoriteList".tr(),
                                                                                              controller: listName,
                                                                                              fillColor: Colors.grey,
                                                                                              hintColor: Colors.black87,
                                                                                              textColor: kDarkGoldColor,
                                                                                              validate: (value) {},
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: MediaQuery.of(context).size.height / 50,
                                                                                            ),
                                                                                            Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                              children: [
                                                                                                InkWell(
                                                                                                  onTap: () {
                                                                                                    Navigator.pop(context);
                                                                                                    cubit.createNewFavListSuggestion(listName: listName.text, context: context, productId: cubit.myAccountData?.data?.suggestion![index].id, index: index);
                                                                                                  },
                                                                                                  child: Container(
                                                                                                    alignment: Alignment.center,
                                                                                                    width: 70,
                                                                                                    height: 40,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: Colors.green,
                                                                                                      shape: BoxShape.rectangle,
                                                                                                      borderRadius: BorderRadius.circular(14),
                                                                                                    ),
                                                                                                    child: Text(
                                                                                                      "create".tr(),
                                                                                                      style: TextStyle(
                                                                                                        color: Colors.white,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                InkWell(
                                                                                                  onTap: () => Navigator.of(context).pop(),
                                                                                                  child: Container(
                                                                                                    alignment: Alignment.center,
                                                                                                    width: 70,
                                                                                                    height: 40,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: Colors.grey,
                                                                                                      shape: BoxShape.rectangle,
                                                                                                      borderRadius: BorderRadius.circular(14),
                                                                                                    ),
                                                                                                    child: Text(
                                                                                                      "cancel".tr(),
                                                                                                      style: TextStyle(
                                                                                                        color: Colors.red,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                          ],
                                                                                        );
                                                                                      },
                                                                                    ),
                                                                                  );
                                                                                },
                                                                              );
                                                                            },
                                                                            child:
                                                                                Wrap(
                                                                              direction: Axis.vertical,
                                                                              crossAxisAlignment: WrapCrossAlignment.center,
                                                                              children: [
                                                                                Container(
                                                                                  width: 60,
                                                                                  height: 60,
                                                                                  alignment: Alignment.center,
                                                                                  decoration: BoxDecoration(
                                                                                    shape: BoxShape.rectangle,
                                                                                    borderRadius: BorderRadius.circular(16),
                                                                                    color: Colors.grey.shade200,
                                                                                  ),
                                                                                  child: Icon(
                                                                                    CupertinoIcons.add_circled,
                                                                                    color: Colors.black,
                                                                                  ),
                                                                                ),
                                                                                ConstrainedBox(
                                                                                  constraints: BoxConstraints(
                                                                                    maxWidth: 70,
                                                                                  ),
                                                                                  child: Text(
                                                                                    "createList".tr(),
                                                                                    style: TextStyle(
                                                                                      color: Colors.grey,
                                                                                      fontWeight: FontWeight.w400,
                                                                                    ),
                                                                                    textAlign: TextAlign.center,
                                                                                    maxLines: 1,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              : Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Center(
                                                                      child:
                                                                          CircularProgressIndicator(),
                                                                    ),
                                                                  ],
                                                                ),
                                                        );
                                                      },
                                                    );
                                                  });
                                            }
                                            // AppCubit.get(context).removeFavorite(
                                            //     prodId: cubit.myAccountData.data
                                            //         .suggestion[index].id);
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
                                    itemCount: cubit.myAccountData!.data!
                                        .suggestion!.length,
                                  ),
                                ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 8,
                              ),
                            ],
                          ),
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

// class OrderInfoCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

class TextChip extends StatelessWidget {
  const TextChip({
    this.text,
    this.onTap,
  });

  final String? text;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          color: Color(0xfffafafa),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Color(0xffCED8DC)),
        ),
        child: Center(
          child: Text(
            "${text}",
            style: TextStyle(fontSize: 15.sp),
          ),
        ),
      ),
    );
  }
}
