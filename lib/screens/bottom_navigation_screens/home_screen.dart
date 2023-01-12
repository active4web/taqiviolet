import 'dart:developer';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/appCubit/app_states.dart';
import 'package:safsofa/screens/display_inspiration_products.dart';
import 'package:safsofa/screens/display_products_screen.dart';
import 'package:safsofa/screens/menu_screens/offers_products_screen.dart';
import 'package:safsofa/screens/menu_screens/offers_screen.dart';
import 'package:safsofa/screens/notifications_screen.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:safsofa/shared/components/custom_text_form_field.dart';
import 'package:safsofa/shared/components/dialogs.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../../cubits/subCategory/sub_cat_cubit.dart';
import '../../cubits/technicalSupportCubit/technical_support_cubit.dart';
import '../../shared/components/store_components/product_cards.dart';
import '../../shared/video_server_display.dart';
import '../searchScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TechnicalSupportCubit contactsCubit = TechnicalSupportCubit.get(context);
    contactsCubit.getContactData();
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        state is AppInitial ?? cubit.fetchData();
        return WillPopScope(
          onWillPop: () => displayLogoutDialog(
              context, "closeApplication".tr(), "wantExit".tr()),
          child: Scaffold(
            backgroundColor: Color(0xfff6f6f6),
            appBar: AppBar(
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
                      color: Colors.grey.withOpacity(.4),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: IconButton(
                      icon: Icon(CupertinoIcons.search, color: Colors.black),
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
                      color: Colors.grey.withOpacity(.4),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: IconButton(
                      icon: Icon(CupertinoIcons.bell, color: Colors.black),
                      onPressed: () {
                        navigateTo(context, NotificationsScreen());
                      },
                    ),
                  ),
                ),
              ],
            ),
            extendBodyBehindAppBar: true,
            body: cubit.homeScreenMainCatModel == null ||
                    cubit.homeScreenMainCatBannerModel == null ||
                    cubit.offerModel == null ||
                    cubit.constructionLink.data == null
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  )
                : ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: Color(0xfff6f6f6)),
                        child: Carousel(
                          images: List.generate(
                              cubit.homeBannersList.length,
                              (index) => Image(
                                    image: NetworkImage(
                                        cubit.homeBannersList[index].image),
                                    fit: BoxFit.cover,
                                  )),
                          dotSize: 10,
                          dotSpacing: 20.0,
                          dotColor: kLightGoldColor,
                          dotBgColor: Colors.transparent,
                          animationCurve: Curves.easeIn,
                          borderRadius: true,
                          autoplay: true,
                          dotIncreaseSize: 1.2,
                          dotIncreasedColor: kDarkGoldColor,
                          noRadiusForIndicator: true,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: HomeCard(
                                  index: 0,
                                  cubit: cubit,
                                  title: cubit.homeMainCatList[0].name,
                                  image: cubit.homeMainCatList[0].image,
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 220,
                                  child: HomeCard(
                                    index: 2,
                                    cubit: cubit,
                                    title: cubit.homeMainCatList[2].name,
                                    //cubit.homeMainCatList[1].name.ar,
                                    image: cubit.homeMainCatList[2].image,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 120,
                                  child: HomeCard(
                                    index: 1,
                                    cubit: cubit,
                                    title: cubit.homeMainCatList[1].name,
                                    //cubit.homeMainCatList[1].name.ar,
                                    image: cubit.homeMainCatList[1].image,
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
                                    child: HomeCard(
                                  index: 3,
                                  cubit: cubit,
                                  title: cubit.homeMainCatList[3].name,
                                  image: cubit.homeMainCatList[3].image,
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 150,
                                  child: HomeCard(
                                    image:
                                        cubit.constructionLink.data.offerImage,
                                    title: "OffersAndDiscounts".tr(),
                                    index: 2,
                                    isFeature: true,
                                    onTap: () => navigateTo(
                                        context, OffersProductsScreen()),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 220,
                                  child: HomeCard(
                                      index: 4,
                                      isFeature: true,
                                      // cubit: cubit,
                                      title: "Inspiration and creativity".tr(),
                                      onTap: () {
                                        navigateTo(
                                            context,
                                            DisplayInspirationProducts(
                                              categoryName:
                                                  'Inspiration and creativity'
                                                      .tr(),
                                            ));
                                      },
                                      //cubit.homeMainCatList[1].name.ar,
                                      //  jhdudhfiurhfirci
                                      image:
                                          contactsCubit.contactsData.data.image

                                      //  cubit.homeMainCatList[2].image
                                      //'https://taqiviolet.com/public/images/inspiration/47hFDvRXrgNpYoenB4H8TazwQISSnSpE1ZORkBuN.jpeg',
                                      ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),

                            // YoutubePlayer(
                            //   actionsPadding: EdgeInsets.symmetric(
                            //       vertical:
                            //           MediaQuery.of(context).size.height / 60),
                            //   controller: AppCubit.get(context).videoController,
                            //   showVideoProgressIndicator: true,
                            //   // videoProgressIndicatorColor: Colors.amber,
                            //   progressColors: ProgressBarColors(
                            //     playedColor: kDarkGoldColor,
                            //     handleColor: kLightGoldColor,
                            //   ),
                            //   bottomActions: [
                            //     IconButton(
                            //       onPressed: () => AppCubit.get(context)
                            //           .muteUnmuteVideo(AppCubit.get(context)
                            //               .videoController),
                            //       icon: Icon(
                            //         AppCubit.get(context).videoSound,
                            //         color: kDarkGoldColor,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width / 1.6,
                        child: VideoServerDisplay(
                          videoPlayerController: VideoPlayerController.network(
                            AppCubit.get(context)
                                .constructionLink
                                .data
                                .videoLink,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () => navigateTo(context, OffersScreen()),
                              child: Label(
                                text: "OffersAndDiscounts".tr(),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            OffersListView(
                              cubit: cubit,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            if (cubit.constructionLink.data != null)
                              Label(
                                text: 'latestProducts'.tr(),
                              ),
                            if (cubit.constructionLink.data != null)
                              SizedBox(
                                height: 20,
                              ),
                            state is GetConstructionSuccessState ||
                                    cubit.constructionLink.data != null
                                ? SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.4,
                                    child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) =>
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.4,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.95,
                                              child: VerticalProductCard(
                                                isFavourite:
                                                    AppCubit.get(context)
                                                            .constructionLink
                                                            .data
                                                            .productList[index]
                                                            .hasFavorites ==
                                                        1,
                                                image: AppCubit.get(context)
                                                    .constructionLink
                                                    .data
                                                    .productList[index]
                                                    .image,
                                                productId: AppCubit.get(context)
                                                    .constructionLink
                                                    .data
                                                    .productList[index]
                                                    .id,
                                                productName:
                                                    AppCubit.get(context)
                                                        .constructionLink
                                                        .data
                                                        .productList[index]
                                                        .name,
                                                oldPrice: AppCubit.get(context)
                                                    .constructionLink
                                                    .data
                                                    .productList[index]
                                                    .oldPrice,
                                                currentPrice:
                                                    AppCubit.get(context)
                                                        .constructionLink
                                                        .data
                                                        .productList[index]
                                                        .currentPrice,
                                                totalRate: AppCubit.get(context)
                                                    .constructionLink
                                                    .data
                                                    .productList[index]
                                                    .hasReview,
                                                onFavPressed: () {
                                                  if (kToken != null &&
                                                      kToken.isNotEmpty) {
                                                    if (AppCubit.get(context)
                                                            .constructionLink
                                                            .data
                                                            .productList[index]
                                                            .hasFavorites ==
                                                        1) {
                                                      AppCubit.get(context)
                                                          .removeFavoriteHome(
                                                        prodId: AppCubit.get(
                                                                context)
                                                            .constructionLink
                                                            .data
                                                            .productList[index]
                                                            .id,
                                                        index: index,
                                                      );
                                                    } else {
                                                      ///////////////////////////////////////////////////

                                                      TextEditingController
                                                          listName =
                                                          TextEditingController();
                                                      showModalBottomSheet(
                                                          context: context,
                                                          builder: (context) {
                                                            cubit
                                                                .getFavListDataOfHome();
                                                            return BlocConsumer<
                                                                AppCubit,
                                                                AppStates>(
                                                              listener:
                                                                  (context,
                                                                      state) {},
                                                              builder: (context,
                                                                  state) {
                                                                return Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          MediaQuery.of(context).size.width /
                                                                              60,
                                                                      vertical:
                                                                          MediaQuery.of(context).size.height /
                                                                              70),
                                                                  child: state
                                                                          is GetConstructionSuccessState
                                                                      ? Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          children: [
                                                                            Align(
                                                                              alignment: AlignmentDirectional.center,
                                                                              child: Text(
                                                                                "addToOneOfYourFavoriteLists".tr(),
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(color: kDarkGoldColor, fontSize: 22, fontWeight: FontWeight.w600),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: MediaQuery.of(context).size.height / 35,
                                                                            ),
                                                                            SizedBox(
                                                                              height: 80,
                                                                              child: ListView(
                                                                                scrollDirection: Axis.horizontal,
                                                                                children: [
                                                                                  if (cubit.favListModelOfHome.data.isNotEmpty)
                                                                                    SizedBox(
                                                                                      height: 80,
                                                                                      child: ListView.separated(
                                                                                        physics: NeverScrollableScrollPhysics(),
                                                                                        shrinkWrap: true,
                                                                                        scrollDirection: Axis.horizontal,
                                                                                        itemCount: cubit.favListModelOfHome.data.length,
                                                                                        itemBuilder: (context, listIndex) {
                                                                                          return InkWell(
                                                                                            onTap: () {
                                                                                              cubit.addFavProductToFavListHome(listId: cubit.favListModelOfHome.data[listIndex].id, productId: AppCubit.get(context).constructionLink.data.productList[index].id, index: index, context: context);
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
                                                                                                    cubit.favListModelOfHome.data[listIndex].name,
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
                                                                                  if (cubit.favListModelOfHome.data.isNotEmpty)
                                                                                    SizedBox(
                                                                                      width: MediaQuery.of(context).size.width / 60,
                                                                                    ),
                                                                                  InkWell(
                                                                                    onTap: () {
                                                                                      showDialog(
                                                                                        context: context,
                                                                                        builder: (context) {
                                                                                          return AlertDialog(
                                                                                            content: BlocConsumer<SubCatCubit, SubCatState>(
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
                                                                                                            cubit.createNewFavListHome(listName: listName.text, context: context, productId: AppCubit.get(context).constructionLink.data.productList[index].id, index: index);
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
                                                                            // Container(
                                                                            //   width: 60,
                                                                            //   height: 60,
                                                                            //   alignment: Alignment.center,
                                                                            //   decoration: BoxDecoration(
                                                                            //     shape: BoxShape.rectangle,
                                                                            //     borderRadius: BorderRadius.circular(16),
                                                                            //     color: Colors.grey.shade200,
                                                                            //   ),
                                                                            //   child: Icon(
                                                                            //     CupertinoIcons.add_circled,
                                                                            //     color: Colors.black,
                                                                            //   ),
                                                                            // ),
                                                                          ],
                                                                        )
                                                                      : Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Center(
                                                                              child: CircularProgressIndicator(),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                );
                                                              },
                                                            );
                                                          });
                                                    }
                                                  }
                                                },
                                              ),
                                            ),
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                              width: 20,
                                            ),
                                        itemCount: AppCubit.get(context)
                                            .constructionLink
                                            .data
                                            .productList
                                            .length),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.12,
                      )
                    ],
                  ),
          ),
        );
      },
    );
  }

  _launchURLBrowser(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class OffersListView extends StatelessWidget {
  const OffersListView({
    Key key,
    this.cubit,
  }) : super(key: key);

  final AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width / 1.15,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 1),
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 1)],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        // width: MediaQuery.of(context).size.width / 1.9,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    cubit.offerModel.data[index].image))),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            cubit.offerModel.data[index].title ?? '',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            cubit.offerModel.data[index].content,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
          separatorBuilder: (context, index) => SizedBox(
                width: 10,
              ),
          itemCount: cubit.offerModel.data.length),
    );
  }
}

class ShowOffersCard extends StatelessWidget {
  const ShowOffersCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/chair1.png"),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'EnjoyOffersAndDiscounts'.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kDarkGoldColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'DiscountsAndOffers'.tr(),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
                CustomButton(
                  text: 'SeeOffers'.tr(),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => OffersScreen(),
                      ),
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({
    Key key,
    this.onTap,
    this.title,
    this.image,
    this.index,
    this.cubit,
    this.isFeature = false,
  }) : super(key: key);

  final Function onTap;
  final String title;
  final String image;
  final int index;
  final AppCubit cubit;
  final bool isFeature;

  Future<void> onPress(BuildContext context) async {
    SubCatCubit.get(context).productFromCatList?.clear();

    // cubit.getAllDepartments(
    //     catId: cubit.homeScreenModel.result.allCategories[index].catId);
    log('${cubit.homeMainCatList[index].id.toString()}');
    log("-" * 100);
    navigateTo(
        context,
        index == 4
            ? DisplayInspirationProducts(
                categoryName: 'Inspiration and creativity'.tr(),
              )
            : DisplayProductsScreen(
                hasDepartments:
                    cubit.homeMainCatList[index].hasSubCategories == 1
                        ? true
                        : false,
                categoryName: cubit.homeMainCatList[index].name,
                category_id: cubit.homeMainCatList[index].id.toString(),
              ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isFeature
          ? onTap
          : () {
              onPress(context);
            },
      child: Container(
        alignment: AlignmentDirectional.bottomCenter,
        height: MediaQuery.of(context).size.height * 0.2,
        // padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.black87,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  image ?? 'https://bit.ly/34h4E7D',
                )),
            borderRadius: BorderRadius.circular(20)),
        child: Container(
          alignment: AlignmentDirectional.bottomCenter,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 25,
          decoration: BoxDecoration(
              //3A4652
              color: Color(0xff5f5c7d),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              title,
              maxLines: 1,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LocalHomeCard extends StatelessWidget {
  final void Function() onTap;
  final String image;
  final String title;

  const LocalHomeCard({Key key, this.onTap, this.image, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.black87,
            image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image)),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Text(
              title,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
