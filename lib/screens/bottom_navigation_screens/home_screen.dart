import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info/package_info.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/appCubit/app_states.dart';
import 'package:safsofa/screens/add_review_screen.dart';
import 'package:safsofa/screens/display_inspiration_products.dart';
import 'package:safsofa/screens/display_products_screen.dart';
import 'package:safsofa/screens/home_layout.dart';
import 'package:safsofa/screens/menu_screens/offers_products_screen.dart';
import 'package:safsofa/screens/menu_screens/offers_screen.dart';
import 'package:safsofa/screens/new/personel_page/help/toast/toast.dart';
import 'package:safsofa/screens/new/personel_page/help/toast/toast_states.dart';
import 'package:safsofa/screens/notifications_screen.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:safsofa/shared/components/custom_network_image.dart';
import 'package:safsofa/shared/components/custom_text_form_field.dart';
import 'package:safsofa/shared/components/dialogs.dart';
import 'package:safsofa/shared/components/video_server_display.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../cubits/offerCubit/offer_cubit.dart';
import '../../cubits/subCategory/sub_cat_cubit.dart';
import '../../shared/components/store_components/product_cards.dart';
import '../searchScreen.dart';
import 'package:card_swiper/card_swiper.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<RefreshIndicatorState> _globalKey =
      GlobalKey<RefreshIndicatorState>();

  AppUpdateInfo? _updateInfo;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  bool _flexibleUpdateAvailable = false;

  bool isUpdateAvailable=false;
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> checkForUpdate() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageName = packageInfo.packageName;

    String lastVersion="${packageInfo.version.split(".")[2]}.${packageInfo.buildNumber}";
   // packageInfo.version
   //  print("name: ${packageName}");
   //  print("infoo: ${packageInfo.version.split(".")[2]}.${packageInfo.buildNumber}");
    // Replace with the appropriate package name for your app on pub.dev
    String apiUrl = 'http://itunes.apple.com/lookup?bundleId=$packageName';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      // print("myyyyyyyresponse: $response");
      if (response.statusCode == 200) {
        Map<String, dynamic> packageInfo = json.decode(response.body);

        print("request Infoooo: ${packageInfo}");
        String latestVersion = packageInfo["results"][0]['version'];

        print("last version ${packageInfo["results"][0]['version']}");
        if (latestVersion.compareTo(lastVersion) > 0) {
          // There is a new version available
          setState(() {
            isUpdateAvailable=true;
          });
          _showVersionDialog(context);
        } else {
          // The app is up-to-date

        }
      } else {
        throw Exception('Failed to load package information');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  _showVersionDialog(context) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = "New Update Available";
        String message =
            "There is a newer version of app available please update it now.";
        String btnLabel = "Update Now";
        String btnLabelCancel = "Later";
        return Platform.isIOS
            ? new CupertinoAlertDialog(

          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0
              ),
              child: Text(btnLabel),
              onPressed: () => _launchURL(),
            ),
          ],
        )
            : new AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              child: Text(btnLabel),
              onPressed: () => _launchURL(),
            ),
          ],
        );
      },
    );
  }
  _launchURL() async {
    String url="https://apps.apple.com/us/app/taqi-violet-%D8%AA%D8%A7%D9%82%D9%8A-%D9%81%D9%8A%D9%88%D9%84%D8%AA/id1665396042";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }
bool isPopped=false;
  @override
  void initState() {
    AppCubit.get(context)..getHomeServices();
    var offerCubit = OfferCubit.get(context);
    offerCubit.getOfferData();
    offerCubit.getOfferData2();
    if (kToken != null) {
      AppCubit.get(context).getRecommendedProducts();
    }
     checkForUpdate();
    super.initState();
  }

  @override
  void dispose() {
    _globalKey.currentState?.dispose(); // 👈 dispose the key here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    var offerCubit = OfferCubit.get(context);
    // offerCubit.getOfferData();
    // offerCubit.getOfferData2();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {

            if(cubit.isShowD==false){
              if(isUpdateAvailable==false){
                if (cubit.offer?.data?.keyOffer==1) {
                  cubit.changeShow();
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showDialog(
                        barrierDismissible: false,

                        context: context,
                        builder: (context) {
                          Future.delayed(
                            const Duration(seconds: 30),
                                () {
                              if(isPopped==false){
                                print("End 11111111111111111111111111");
                                print(cubit.offer?.data?.promoCodeName??'');
                                Navigator.pop(context);
                              }

                            },
                          );
                          return AlertDialog(
                            insetPadding: EdgeInsets.all(10),
                            backgroundColor: Colors.transparent,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            content: Stack(
                              alignment: Alignment.center,
                              children: [
                                InkWell(
                                  onTap: ()async{
                                    await Clipboard.setData(ClipboardData(text:cubit.offer?.data?.promoCodeName??'')).then((value) {
                                      ToastConfig.showToast(msg: "تم نسخ الكود بنجاح", toastStates: ToastStates.success);
                                      Navigator.pop(context);
                                      setState(() {
                                        isPopped=true;
                                      });
                                    });

                                  },
                                  child: CustomNetworkImage(
                                    width: MediaQuery.of(context).size.width,
                                    height: 400.h,
                                    isActive: true,
                                    image: cubit.offer?.data?.offerImage??'',
                                    border: BorderRadius.circular(10.r),
                                  ),
                                ),
                                Positioned(
                                    top: 20.h,
                                    left: 38.w,
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.pop(context);
                                        setState(() {
                                          isPopped=true;
                                        });
                                        // if(state is GetConstructionSuccessState){
                                        //   if (cubit.constructionLink?.data?.orderId!=null) {
                                        //     WidgetsBinding.instance.addPostFrameCallback((_) {
                                        //       showDialog(
                                        //           context: context,
                                        //           builder: (context) {
                                        //             return AlertDialog(
                                        //               content: Column(
                                        //                 mainAxisSize: MainAxisSize.min,
                                        //                 children: [
                                        //                   Text(
                                        //                     "pleaseRateYourPreviousOrder".tr(),
                                        //                     textAlign: TextAlign.center,
                                        //                     style: TextStyle(
                                        //                       color: Colors.black,
                                        //                       fontSize: 12,
                                        //                       fontWeight: FontWeight.bold,
                                        //                     ),
                                        //                   ),
                                        //                   SizedBox(
                                        //                     height: 20,
                                        //                   ),
                                        //                   Row(
                                        //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        //                     children: [
                                        //                       InkWell(
                                        //                         onTap: () => Navigator.pop(context),
                                        //                         child: Container(
                                        //                           alignment: AlignmentDirectional.center,
                                        //                           decoration: BoxDecoration(
                                        //                             color:
                                        //                             Colors.grey.shade200.withOpacity(0.6),
                                        //                             borderRadius: BorderRadius.circular(8),
                                        //                           ),
                                        //                           child: Padding(
                                        //                             padding: EdgeInsets.all(12),
                                        //                             child: Text(
                                        //                               "cancel".tr(),
                                        //                               style: TextStyle(
                                        //                                 color: Colors.red,
                                        //                                 fontWeight: FontWeight.w500,
                                        //                               ),
                                        //                             ),
                                        //                           ),
                                        //                         ),
                                        //                       ),
                                        //                       InkWell(
                                        //                         onTap: () => navigateReplacement(
                                        //                             context,
                                        //                             AddReviewScreen(
                                        //                               orderId: cubit.constructionLink?.data?.orderId??0,
                                        //                             )),
                                        //                         child: Container(
                                        //                           alignment: AlignmentDirectional.center,
                                        //                           decoration: BoxDecoration(
                                        //                             color: Colors.green.withOpacity(0.6),
                                        //                             borderRadius: BorderRadius.circular(8),
                                        //                           ),
                                        //                           child: Padding(
                                        //                             padding: EdgeInsets.all(12),
                                        //                             child: Text(
                                        //                               "rate".tr(),
                                        //                               style: TextStyle(
                                        //                                 color: Colors.white,
                                        //                                 fontWeight: FontWeight.w500,
                                        //                               ),
                                        //                             ),
                                        //                           ),
                                        //                         ),
                                        //                       ),
                                        //                     ],
                                        //                   ),
                                        //                 ],
                                        //               ),
                                        //             );
                                        //           });
                                        //     });
                                        //   }
                                        // }
                                      },
                                      child: Icon(Icons.close,color: Colors.white,size: 25.r,),
                                    ))
                              ],
                            ),
                          );
                        });
                  });
                }
                else if (cubit.constructionLink?.data?.orderId!=null) {
                  cubit.changeShow();
                  WidgetsBinding.instance.addPostFrameCallback((_) {

                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "pleaseRateYourPreviousOrder".tr(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: () => Navigator.pop(context),
                                      child: Container(
                                        alignment: AlignmentDirectional.center,
                                        decoration: BoxDecoration(
                                          color:
                                          Colors.grey.shade200.withOpacity(0.6),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(12),
                                          child: Text(
                                            "cancel".tr(),
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => navigateReplacement(
                                          context,
                                          AddReviewScreen(
                                            orderId: cubit.constructionLink?.data?.orderId??0,
                                          )),
                                      child: Container(
                                        alignment: AlignmentDirectional.center,
                                        decoration: BoxDecoration(
                                          color: Colors.green.withOpacity(0.6),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(12),
                                          child: Text(
                                            "rate".tr(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        });
                  });
                }
              }

            }



      },
      builder: (context, state) {
        // state is AppInitial ?? cubit.fetchData();
        return WillPopScope(
          onWillPop: () async {
            displayLogoutDialog(
                context, "closeApplication".tr(), "wantExit".tr());
            return true;
          },
          child:Scaffold(
            appBar:CustomAppBar(title: 'Home'.tr(),
                icon: Row(
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: IconButton(
                        icon:
                        Icon(CupertinoIcons.search, color: kLightGoldColor,size: 18.w,),
                        onPressed: () {
                          navigateTo(context, SearchScreen());
                        },
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        icon: Icon(CupertinoIcons.bell, color: kLightGoldColor,size: 18.w,),
                        onPressed: () {
                          if (kToken == null) {
                            AppCubit.get(context).selectedIndex = 3;
                            navigateAndFinish(context, HomeLayout());
                          } else
                            navigateTo(context, NotificationsScreen());
                        },
                      ),
                    ),
                  ],
                ) ),
            body: cubit.homeScreenMainCatModel == null ||
                cubit.homeScreenMainCatBannerModel == null ||
                cubit.offerModel == null ||
                cubit.constructionLink?.data == null
                ? Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
                : RefreshIndicator(
              key: _globalKey,
              onRefresh: () async {
                return AppCubit.get(context).fetchData();
              },
              child: ListView(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(
                    height: 1,
                  ),
                  Container(
                    height:160.h,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(0xfff6f6f6),
                    ),
                    child: Swiper(
                        autoplay: true,
                        itemCount: cubit.homeBannersList!.length,
                        pagination: const SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          builder: DotSwiperPaginationBuilder(
                            color: Colors.grey,
                            activeColor: kDarkGoldColor,
                          ),
                        ),
                        duration: 600,
                        itemBuilder: (context, index) {
                          return CustomNetworkImage(
                            image:
                            "${cubit.homeBannersList![index].image}",
                            width: 120,
                            border: BorderRadius.circular(20),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    height: 60.h,
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 22.w),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => SizedBox(
                          width: 80.w,
                          child: FeatureItem(
                              image: cubit.servicesModel?.data
                                  ?.details?[index].image ??
                                  '',
                              title: cubit.servicesModel?.data
                                  ?.details?[index].title ??
                                  ''),
                        ),
                        itemCount:
                        cubit.servicesModel?.data?.details?.length ??
                            0),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: HomeCard(
                                  index: 0,
                                  cubit: cubit,
                                  title: "${cubit.homeMainCatList![0].name}",
                                  image: "${cubit.homeMainCatList![0].image}",
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 220,
                              child: HomeCard(
                                onTap: () {},
                                index: 3,
                                cubit: cubit,
                                title:
                                "${cubit.homeMainCatList![3].name}",
                                //cubit.homeMainCatList[1].name.ar,
                                image:
                                "${cubit.homeMainCatList![3].image}",
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
                                title:
                                "${cubit.homeMainCatList![1].name}",
                                //cubit.homeMainCatList[1].name.ar,
                                image:
                                "${cubit.homeMainCatList![1].image}",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: HomeCard(
                                  index: 2,
                                  cubit: cubit,
                                  title: "${cubit.homeMainCatList![2].name}",
                                  image: "${cubit.homeMainCatList![2].image}",
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 150,
                              child: HomeCard(
                                image:
                                "${cubit.constructionLink?.data?.offerImage}",
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
                                  title:
                                  "Inspiration and creativity".tr(),
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
                                  "${cubit.constructionLink?.data?.inspirationImage}"

                                //  cubit.homeMainCatList[2].image
                                //'https://taqiviolet.com/public/images/inspiration/47hFDvRXrgNpYoenB4H8TazwQISSnSpE1ZORkBuN.jpeg',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width / 1.6,
                      child: VideoServerDisplay(
                        videoUrl: AppCubit.get(context)
                            .constructionLink
                            ?.data
                            ?.videoLink,
                      )),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () =>
                              navigateTo(context, OffersScreen()),
                          child: Label(
                            text: "OffersAndDiscounts".tr(),
                          ),
                        ),
                        OffersListView(
                          cubit: cubit,
                        ),
                        if (cubit.constructionLink?.data != null)
                          Label(
                            text: 'latestProducts'.tr(),
                          ),
                        if (cubit.constructionLink?.data != null)
                          state is GetConstructionSuccessState ||
                              cubit.constructionLink?.data != null
                              ? SizedBox(
                            height:
                            MediaQuery.of(context).size.height *
                                0.3,
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
                                        isFavourite: AppCubit.get(
                                            context)
                                            .constructionLink
                                            ?.data
                                            ?.productList![
                                        index]
                                            .hasFavorites ==
                                            1,
                                        image: AppCubit.get(context)
                                            .constructionLink
                                            ?.data
                                            ?.productList![index]
                                            .image,
                                        productId: AppCubit.get(
                                            context)
                                            .constructionLink
                                            ?.data
                                            ?.productList![index]
                                            .id,
                                        productName: AppCubit.get(
                                            context)
                                            .constructionLink
                                            ?.data
                                            ?.productList![index]
                                            .name,
                                        oldPrice: AppCubit.get(
                                            context)
                                            .constructionLink
                                            ?.data
                                            ?.productList![index]
                                            .oldPrice,
                                        currentPrice: AppCubit.get(
                                            context)
                                            .constructionLink
                                            ?.data
                                            ?.productList![index]
                                            .currentPrice,
                                        totalRate: AppCubit.get(
                                            context)
                                            .constructionLink
                                            ?.data
                                            ?.productList![index]
                                            .hasReview,
                                        onFavPressed: () {
                                          if (kToken != '' &&
                                              kToken!.isNotEmpty) {
                                            if (AppCubit.get(
                                                context)
                                                .constructionLink
                                                ?.data
                                                ?.productList![
                                            index]
                                                .hasFavorites ==
                                                1) {
                                              AppCubit.get(context)
                                                  .removeFavoriteHome(
                                                prodId: (AppCubit
                                                    .get(
                                                    context)
                                                    .constructionLink
                                                    ?.data
                                                    ?.productList![
                                                index]
                                                    .id)!,
                                                index: index,
                                              );
                                            } else {
                                              ///////////////////////////////////////////////////

                                              TextEditingController
                                              listName =
                                              TextEditingController();
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder:
                                                      (context) {
                                                    cubit
                                                        .getFavListDataOfHome();
                                                    return BlocConsumer<
                                                        AppCubit,
                                                        AppStates>(
                                                      listener:
                                                          (context,
                                                          state) {},
                                                      builder:
                                                          (context,
                                                          state) {
                                                        return Padding(
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal: MediaQuery.of(context).size.width /
                                                                  60,
                                                              vertical:
                                                              MediaQuery.of(context).size.height / 70),
                                                          child: state
                                                          is GetConstructionSuccessState
                                                              ? Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              Align(
                                                                alignment: AlignmentDirectional.center,
                                                                child: Text(
                                                                  "addToOneOfYourFavoriteLists".tr(),
                                                                  textAlign: TextAlign.center,
                                                                  style: TextStyle(color: kDarkGoldColor, fontSize: 12, fontWeight: FontWeight.w600),
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
                                                                    if (cubit.favListModelOfHome!.data!.isNotEmpty)
                                                                      SizedBox(
                                                                        height: 80,
                                                                        child: ListView.separated(
                                                                          physics: NeverScrollableScrollPhysics(),
                                                                          shrinkWrap: true,
                                                                          scrollDirection: Axis.horizontal,
                                                                          itemCount: cubit.favListModelOfHome!.data!.length,
                                                                          itemBuilder: (context, listIndex) {
                                                                            return InkWell(
                                                                              onTap: () {
                                                                                cubit.addFavProductToFavListHome(listId: (cubit.favListModelOfHome?.data![listIndex].iD)!, productId: (AppCubit.get(context).constructionLink?.data?.productList![index].id)!, index: index, context: context);
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
                                                                                      "${cubit.favListModelOfHome?.data![listIndex].name}",
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
                                                                    if (cubit.favListModelOfHome!.data!.isNotEmpty)
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
                                                                                              cubit.createNewFavListHome(listName: listName.text, context: context, productId: AppCubit.get(context).constructionLink?.data?.productList![index].id, index: index);
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
                                                            mainAxisSize: MainAxisSize.min,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            mainAxisAlignment: MainAxisAlignment.center,
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
                                separatorBuilder:
                                    (context, index) => SizedBox(),
                                itemCount: AppCubit.get(context)
                                    .constructionLink!
                                    .data!
                                    .productList!
                                    .length),
                          )
                              : SizedBox(),
                        SizedBox(
                          height: 10.h,
                        ),
                        if (kToken != null &&
                            cubit.recommended?.data != null)
                          Label(
                            text: 'recommended'.tr(),
                          ),
                        if (kToken != null &&
                            cubit.recommended?.data != null)
                          SizedBox(
                            height:
                            MediaQuery.of(context).size.height * 0.3,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => SizedBox(
                                  height: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.4,
                                  width: MediaQuery.of(context)
                                      .size
                                      .width /
                                      1.95,
                                  child: VerticalProductCard(
                                    isFavourite: AppCubit.get(context)
                                        .recommended
                                        ?.data?[index]
                                        .hasFavorites ==
                                        1,
                                    image: AppCubit.get(context)
                                        .recommended
                                        ?.data![index]
                                        .image,
                                    productId: AppCubit.get(context)
                                        .recommended
                                        ?.data?[index]
                                        .id,
                                    productName: AppCubit.get(context)
                                        .recommended
                                        ?.data?[index]
                                        .name,
                                    oldPrice: AppCubit.get(context)
                                        .recommended
                                        ?.data?[index]
                                        .oldPrice,
                                    currentPrice:
                                    AppCubit.get(context)
                                        .recommended
                                        ?.data?[index]
                                        .currentPrice,
                                    totalRate: AppCubit.get(context)
                                        .recommended
                                        ?.data?[index]
                                        .hasReview,
                                    onFavPressed: () {
                                      if (kToken != '' &&
                                          kToken!.isNotEmpty) {
                                        if (AppCubit.get(context)
                                            .recommended
                                            ?.data?[index]
                                            .hasFavorites ==
                                            1) {
                                          AppCubit.get(context)
                                              .removeFavoriteHome(
                                            prodId:
                                            (AppCubit.get(context)
                                                .recommended
                                                ?.data?[index]
                                                .id)!,
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
                                                  listener: (context,
                                                      state) {},
                                                  builder: (context,
                                                      state) {
                                                    return Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal:
                                                          MediaQuery.of(context).size.width /
                                                              60,
                                                          vertical: MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                              70),
                                                      child: state
                                                      is GetConstructionSuccessState
                                                          ? Column(
                                                        mainAxisSize:
                                                        MainAxisSize.min,
                                                        children: [
                                                          Align(
                                                            alignment:
                                                            AlignmentDirectional.center,
                                                            child:
                                                            Text(
                                                              "addToOneOfYourFavoriteLists".tr(),
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(color: kDarkGoldColor, fontSize: 12, fontWeight: FontWeight.w600),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                            MediaQuery.of(context).size.height / 35,
                                                          ),
                                                          SizedBox(
                                                            height:
                                                            80,
                                                            child:
                                                            ListView(
                                                              scrollDirection: Axis.horizontal,
                                                              children: [
                                                                if (cubit.favListModelOfHome!.data!.isNotEmpty)
                                                                  SizedBox(
                                                                    height: 80,
                                                                    child: ListView.separated(
                                                                      physics: NeverScrollableScrollPhysics(),
                                                                      shrinkWrap: true,
                                                                      scrollDirection: Axis.horizontal,
                                                                      itemCount: cubit.favListModelOfHome!.data!.length,
                                                                      itemBuilder: (context, listIndex) {
                                                                        return InkWell(
                                                                          onTap: () {
                                                                            cubit.addFavProductToFavListHome(listId: (cubit.favListModelOfHome?.data![listIndex].iD)!, productId: (AppCubit.get(context).recommended?.data?[index].id)!, index: index, context: context);
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
                                                                                  "${cubit.favListModelOfHome?.data![listIndex].name}",
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
                                                                if (cubit.favListModelOfHome!.data!.isNotEmpty)
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
                                                                                          cubit.createNewFavListHome(listName: listName.text, context: context, productId: AppCubit.get(context).recommended?.data?[index].id, index: index);
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
                                      }
                                    },
                                  ),
                                ),
                                separatorBuilder: (context, index) =>
                                    SizedBox(),
                                itemCount: AppCubit.get(context)
                                    .recommended!
                                    .data!
                                    .length),
                          )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Center(
                    child: Text(
                      'ourServices'.tr(),
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  SizedBox(
                    height: 230.h,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 80.0.h,right: 10.w,left: 10.w),
                      child: Row(
                        children: [
                          ServicesItem(
                              image: cubit.servicesModel?.data
                                  ?.services?[0].image ??
                                  '',
                              title: cubit.servicesModel?.data
                                  ?.services?[0].title ??
                                  '',
                              subTitle: cubit.servicesModel?.data
                                  ?.services?[0].description ??
                                  ''),
                          SizedBox(
                            width: 20.w,
                          ),
                          ServicesItem(
                              image: cubit.servicesModel?.data
                                  ?.services?[2].image ??
                                  '',
                              title: cubit.servicesModel?.data
                                  ?.services?[2].title ??
                                  '',
                              subTitle: cubit.servicesModel?.data
                                  ?.services?[2].description ??
                                  ''),
                          SizedBox(
                            width: 20.w,
                          ),
                          ServicesItem(
                              image: cubit.servicesModel?.data
                                  ?.services?[3].image ??
                                  '',
                              title: cubit.servicesModel?.data
                                  ?.services?[3].title ??
                                  '',
                              subTitle: cubit.servicesModel?.data
                                  ?.services?[3].description ??
                                  ''),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h,)
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
    this.cubit,
  });

  final AppCubit? cubit;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.3,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width / 1.15,
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 1),
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 1)],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        child: CustomNetworkImage(
                          image: "${cubit?.offerModel?.data![index].image}",
                          width: 110.w,
                          border: BorderRadius.circular(20),
                        ),
                        // width: MediaQuery.of(context).size.width / 1.9,
                        // decoration: BoxDecoration(
                        //     image: DecorationImage(
                        //         fit: BoxFit.cover,
                        //         image: NetworkImage(
                        //             "${cubit?.offerModel?.data![index].image}",
                        //         ),
                        //     ),
                        // ),
                      ),
                    ),

                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            cubit?.offerModel?.data![index].title ?? '',
                            style: TextStyle(fontSize: 13.sp),
                            textAlign: TextAlign.center,
                          ),
                          if(cubit?.offerModel?.data?[index].title2!='')
                            Text(
                            "${cubit?.offerModel?.data![index].title2}",
                            style: TextStyle(
                                fontSize: 13.sp, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                          if(cubit?.offerModel?.data?[index].title3!='')
                          Text(
                            "${cubit?.offerModel?.data![index].title3}",
                            style: TextStyle(
                                fontSize: 13.sp, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                          if(cubit?.offerModel?.data?[index].title3!='')

                            Text(
                            "${cubit?.offerModel?.data![index].title4}",
                            style: TextStyle(
                                fontSize: 13.sp, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                          if(cubit?.offerModel?.data?[index].title5!='')
                            Expanded(
                            child: Text(
                              "${cubit?.offerModel?.data![index].title5}",
                              style: TextStyle(
                                  fontSize: 13.sp, fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
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
          itemCount: cubit!.offerModel!.data!.length),
    );
  }
}

class ShowOffersCard extends StatelessWidget {
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
                      fontSize: 8,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'DiscountsAndOffers'.tr(),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 8,
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
    this.onTap,
    this.title,
    this.image,
    required this.index,
    this.cubit,
    this.isFeature = false,
    this.isActive = true,
  });

  final Function? onTap;
  final String? title;
  final String? image;
  final int index;
  final AppCubit? cubit;
  final bool isFeature;
  final bool isActive;

  Future<void> onPress(BuildContext context) async {
    SubCatCubit.get(context).productFromCatList?.clear();

    // cubit.getAllDepartments(
    //     catId: cubit.homeScreenModel.result.allCategories[index].catId);
    print(cubit!.homeMainCatList![index].id.toString());
    navigateTo(
        context,
        index == 4
            ? DisplayInspirationProducts(
                categoryName: 'Inspiration and creativity'.tr(),
              )
            : DisplayProductsScreen(
                hasDepartments: false,
                categoryName: "${cubit?.homeMainCatList![index].name}",
                category_id: cubit!.homeMainCatList![index].id,
              ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: isFeature
            ? () {
                onTap!();
              }
            : () {
                onPress(context);
              },
        child: Container(
          height: 140.h,
          alignment: AlignmentDirectional.bottomCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: Image.network(image??"").image,
            )
          ),
          // height: 130.h,
          // padding: EdgeInsets.all(20),
          child: Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Container(
              alignment: AlignmentDirectional.bottomCenter,
              width: MediaQuery.of(context).size.width,
              height: 30.h,
              decoration: BoxDecoration(
                //Color(0xff3A4652)
                //Color(0xff5f5c7d)
                  color: Color(0xff393846),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Center(
                  child: Text(
                    "${title}",
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      // fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

class LocalHomeCard extends StatelessWidget {
  final void Function()? onTap;
  final String? image;
  final String? title;

  const LocalHomeCard({this.onTap, this.image, this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.black87,
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage("${image}")),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Text(
              "${title}",
              style: TextStyle(
                color: Colors.white,
                // fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  const FeatureItem({super.key, required this.image, required this.title});

  final String image;
  final String title;

  // final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: Image.network(
          '$MBaseUrl$image',
        )),

        Expanded(
            child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.bold),
        )),
        // Expanded(
        //   child: Text(subTitle,maxLines: 2,overflow:TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(
        //       fontSize: 10.sp
        //   ),),
        // ),
      ],
    );
  }
}

class ServicesItem extends StatelessWidget {
  const ServicesItem(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle});

  final String image;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: CachedNetworkImage(
            imageUrl: '$MBaseUrl$image',
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error),
          )),

          Expanded(
            // flex: 2,
            child: Center(
                child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 3,
              style: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.bold),
            )),
          ),
          // SizedBox(
          //   height: 5.h,
          // ),
          // Expanded(
          //   child: Text(
          //     subTitle,
          //     maxLines: 5,
          //     overflow: TextOverflow.ellipsis,
          //     textAlign: TextAlign.center,
          //     style: TextStyle(fontSize: 10.sp),
          //   ),
          // ),
        ],
      ),
    );
  }
}
