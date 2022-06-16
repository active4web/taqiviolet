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
import 'package:safsofa/screens/menu_screens/offers_screen.dart';
import 'package:safsofa/screens/notifications_screen.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:safsofa/shared/components/dialogs.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../cubits/contactsCubit/contacts_cubit.dart';
import '../../cubits/subCategory/sub_cat_cubit.dart';
import '../../cubits/technicalSupportCubit/technical_support_cubit.dart';
import '../searchScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TechnicalSupportCubit contactsCubit=TechnicalSupportCubit.get(context);
    contactsCubit.getContactData();
    AppCubit.get(context).getConstructionData();
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        // YoutubePlayerController videoController = YoutubePlayerController(
        //   initialVideoId: cubit.constructionLink.data.videoLink,
        //   flags: YoutubePlayerFlags(
        //     autoPlay: true,
        //     loop: true,
        //     hideThumbnail: true,
        //   ),
        // );
        // InspirationCubit.get(context).getInspirationData();
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
                      icon: Icon(CupertinoIcons.search,color: Colors.black),
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
                      icon: Icon(CupertinoIcons.bell,color: Colors.black),
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
                    cubit.offerModel == null
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
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
                                      index: 3,
                                      cubit: cubit,
                                      title: cubit.homeMainCatList[3].name,
                                      //cubit.homeMainCatList[1].name.ar,
                                      image: cubit.homeMainCatList[3].image,
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
                                    flex: 120,
                                    child: HomeCard(
                                      image: cubit
                                          .constructionLink.data.offerImage,
                                      title: "OffersAndDiscounts".tr(),
                                      index: 2,
                                      isFeature: true,
                                      onTap: () =>
                                          navigateTo(context, OffersScreen()),
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
                              YoutubePlayer(
                                actionsPadding: EdgeInsets.symmetric(
                                    vertical:
                                        MediaQuery.of(context).size.height /
                                            60),
                                controller:
                                    AppCubit.get(context).videoController,
                                showVideoProgressIndicator: true,
                                // videoProgressIndicatorColor: Colors.amber,
                                progressColors: ProgressBarColors(
                                  playedColor: kDarkGoldColor,
                                  handleColor: kLightGoldColor,
                                ),
                                bottomActions: [
                                  IconButton(
                                    onPressed: () => AppCubit.get(context)
                                        .muteUnmuteVideo(AppCubit.get(context)
                                            .videoController),
                                    icon: Icon(
                                      AppCubit.get(context).videoSound,
                                      color: kDarkGoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Label(
                                text: "OffersAndDiscounts".tr(),
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
                              Label(
                                text: 'OtherServices'.tr(),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  // Expanded(
                                  //   child: HomeCard(
                                  //     title:  "متاجر",
                                  //     image: "https://thumbor.forbes.com/thumbor/fit-in/900x510/https://www.forbes.com/uk/advisor/wp-content/uploads/2020/11/phones-switch-apps.jpg",
                                  //     isFeature: true,
                                  //     onTap: () {
                                  //
                                  //       ShopsCubit.get(context).   getDataFromShops();
                                  //       ShopsCubit.get(context).emitAllShops();
                                  //                                     Navigator.of(context).push(
                                  //                                       MaterialPageRoute(
                                  //                                         builder: (_) => ShopProfileScreen(Id: 37,index: 3,),//ShopProfileScreen(Id: cubit.storeListOfData[index].iD,index: index,),
                                  //                                       ));
                                  //       //                               );  navigateTo(context, ShopProfileScreen(Id: 37,index: 3,));
                                  //     },
                                  //   ),
                                  // ),
                                  // SizedBox(width: 10),
                                  Expanded(
                                    child: HomeCard(
                                      title: cubit.constructionLink.data
                                          .constraction[0].title,
                                      image: cubit.constructionLink.data
                                          .constraction[0].image,
                                      isFeature: true,
                                      onTap: () async {
                                        // String url =
                                        //     await cubit.getconstructionLink();

                                        _launchURLBrowser(cubit.constructionLink
                                            .data.constraction[0].link);
                                        //  navigateTo(context, ConstructorsScreen());
                                      },
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.12,
                        )
                      ],
                    ),
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
                width: MediaQuery.of(context).size.height * 0.30,
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
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    cubit.offerDataList[index].image))),
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
                            cubit.offerDataList[index].title ?? '',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            cubit.offerDataList[index].content,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                          // Container(
                          //   height: 22,
                          //   decoration: BoxDecoration(
                          //       color: Colors.black26,
                          //       borderRadius: BorderRadius.circular(5)),
                          //   child: Center(
                          //     child: Text(
                          //       'ShopNow'.tr(),
                          //       style: TextStyle(
                          //           fontSize: 11, color: Colors.white),
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    )
                  ],
                ),
              ),
          separatorBuilder: (context, index) => SizedBox(
                width: 10,
              ),
          itemCount: cubit.offerDataList.length),
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
    print(cubit.homeMainCatList[index].id.toString());
    print("-" * 100);
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
        height: MediaQuery.of(context).size.height * 0.2,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.black87,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  image ?? 'https://bit.ly/34h4E7D',
                )),
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
