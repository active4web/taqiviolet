import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/models/homeModel/main_cat_model.dart';


part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  /// Get Home Main Category Data
  //HomeMainCategoryModel homeMainCategoryModel;
  List<Data>? homeMainCatList;

  // void getHomeData() {
  //   emit(HomeMainCatLoading());
  //   Mhelper.getData(UrlPath: homeMainCatEndPoint).then((value) {
  //     homeMainCategoryModel = HomeMainCategoryModel.fromJson(value.data);
  //     homeMainCatList=homeMainCategoryModel.data;
  //     print(homeMainCatList[0].name);
  //     emit(HomeMainCatSuccess());
  //   }).catchError((err) {
  //     emit(HomeMainCatError());
  //     print("///Home Err:${err.toString()}");
  //   });
  // }
}


// import 'package:easy_localization/src/public_ext.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:safsofa/cubits/appCubit/app_cubit.dart';
// import 'package:safsofa/cubits/appCubit/app_states.dart';
// import 'package:safsofa/screens/display_products_screen.dart';
// import 'package:safsofa/screens/notifications_screen.dart';
// import 'package:safsofa/shared/components/custom_button.dart';
// import 'package:safsofa/shared/components/custom_label.dart';
// import 'package:safsofa/shared/constants.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:carousel_pro/carousel_pro.dart';
// import 'package:safsofa/shared/defaults.dart';
//
// import '../contractors_screen.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AppCubit, AppStates>(
//       builder: (context, state) {
//         AppCubit cubit = AppCubit.get(context);
//         return Scaffold(
//           backgroundColor: Color(0xfff6f6f6),
//           appBar: AppBar(
//             elevation: 0,
//             backgroundColor: Colors.black26,
//             iconTheme: IconThemeData(color: Colors.white),
//             centerTitle: true,
//             actions: [
//               IconButton(
//                 icon: Icon(CupertinoIcons.bell),
//                 onPressed: () {
//                   navigateTo(context, NotificationsScreen());
//                 },
//               )
//             ],
//           ),
//           extendBodyBehindAppBar: true,
//           body: cubit.homeScreenModel == null
//               ? Center(
//             child: CircularProgressIndicator(
//               color: Colors.black,
//             ),
//           )
//               : SingleChildScrollView(
//             child: Column(
//               children: [
//                 Container(
//                   height: MediaQuery
//                       .of(context)
//                       .size
//                       .height * 0.4,
//                   width: MediaQuery
//                       .of(context)
//                       .size
//                       .width,
//                   decoration: BoxDecoration(color: Color(0xfff6f6f6)),
//                   child: Carousel(
//                     images: List.generate(
//                         cubit.homeScreenModel.result.mainOffers.length,
//                             (index) =>
//                             Image(
//                               image: NetworkImage(cubit.homeScreenModel
//                                   .result.mainOffers[index].image),
//                               fit: BoxFit.cover,
//                             )),
//                     dotSize: 10,
//                     dotSpacing: 20.0,
//                     dotColor: kLightGoldColor,
//                     // indicatorBgPadding: 5.0,
//                     dotBgColor: Colors.transparent,
//                     animationCurve: Curves.easeIn,
//                     borderRadius: true,
//                     autoplay: true,
//                     dotIncreaseSize: 1.2,
//                     dotIncreasedColor: kDarkGoldColor,
//                     noRadiusForIndicator: true,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                               child: HomeCard(
//                                 index: 0,
//                                 cubit: cubit,
//                                 title: cubit.homeScreenModel.result
//                                     .allCategories[0].categoryName,
//                                 image: cubit.homeScreenModel.result
//                                     .allCategories[0].categoryImage,
//                               )),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Row(
//                         children: [
//                           Expanded(
//                             flex: 220,
//                             child: HomeCard(
//                               index: 1,
//                               cubit: cubit,
//                               title: cubit.homeScreenModel.result
//                                   .allCategories[1].categoryName,
//                               image: cubit.homeScreenModel.result
//                                   .allCategories[1].categoryImage,
//                             ),
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Expanded(
//                             flex: 120,
//                             child: HomeCard(
//                               index: 2,
//                               cubit: cubit,
//                               title: cubit.homeScreenModel.result
//                                   .allCategories[2].categoryName,
//                               image: cubit.homeScreenModel.result
//                                   .allCategories[2].categoryImage,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Row(
//                         children: [
//                           Expanded(
//                             flex: 120,
//                             child: HomeCard(
//                               index: 3,
//                               cubit: cubit,
//                               title: cubit.homeScreenModel.result
//                                   .allCategories[3].categoryName,
//                               image: cubit.homeScreenModel.result
//                                   .allCategories[3].categoryImage,
//                             ),
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Expanded(
//                             flex: 220,
//                             child: HomeCard(
//                               index: 4,
//                               cubit: cubit,
//                               title: cubit.homeScreenModel.result
//                                   .allCategories[4].categoryName,
//                               image: cubit.homeScreenModel.result
//                                   .allCategories[4].categoryImage,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       ShowOffersCard(
//                         cubit: cubit,
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Label(
//                         text: "OffersAndDiscounts".tr(),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       OffersListView(
//                         cubit: cubit,
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Label(
//                         text: 'OtherServices'.tr(),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: HomeCard(
//                               title: cubit.homeScreenModel.result
//                                   .allFeatures[1].featureCategoryName,
//                               image: cubit.homeScreenModel.result
//                                   .allFeatures[1].featureCategoryImage,
//                               isFeature: true,
//                               onTap: () {},
//                             ),
//                           ),
//                           SizedBox(width: 10),
//                           Expanded(
//                             child: HomeCard(
//                               title: cubit.homeScreenModel.result
//                                   .allFeatures[0].featureCategoryName,
//                               image: cubit.homeScreenModel.result
//                                   .allFeatures[0].featureCategoryImage,
//                               isFeature: true,
//                               onTap: () {
//                                 navigateTo(context, ConstructorsScreen());
//                               },
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: MediaQuery
//                       .of(context)
//                       .size
//                       .height * 0.12,
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// class OffersListView extends StatelessWidget {
//   const OffersListView({
//     Key key,
//     this.cubit,
//   }) : super(key: key);
//
//   final AppCubit cubit;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: MediaQuery
//           .of(context)
//           .size
//           .height * 0.2,
//       child: ListView.separated(
//           scrollDirection: Axis.horizontal,
//           itemBuilder: (context, index) =>
//               Container(
//                 height: MediaQuery
//                     .of(context)
//                     .size
//                     .height * 0.15,
//                 width: MediaQuery
//                     .of(context)
//                     .size
//                     .height * 0.30,
//                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                 margin: EdgeInsets.symmetric(vertical: 10, horizontal: 1),
//                 decoration: BoxDecoration(
//                   boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 1)],
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.white,
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         decoration: BoxDecoration(
//                             image: DecorationImage(
//                                 fit: BoxFit.cover,
//                                 image: NetworkImage(cubit.homeScreenModel.result
//                                     .allOffers[index].categoryImage))),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Expanded(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Text(
//                             cubit.homeScreenModel.result.allOffers[index]
//                                 .smallDesc ??
//                                 '',
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                             textAlign: TextAlign.center,
//                           ),
//                           Text(
//                             cubit.homeScreenModel.result.allOffers[index]
//                                 .offerName,
//                             style: TextStyle(
//                                 fontSize: 12, fontWeight: FontWeight.w500),
//                             textAlign: TextAlign.center,
//                           ),
//                           Container(
//                             height: 22,
//                             decoration: BoxDecoration(
//                                 color: Colors.black26,
//                                 borderRadius: BorderRadius.circular(5)),
//                             child: Center(
//                               child: Text(
//                                 'ShopNow'.tr(),
//                                 style: TextStyle(
//                                     fontSize: 11, color: Colors.white),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//           separatorBuilder: (context, index) =>
//               SizedBox(
//                 width: 10,
//               ),
//           itemCount: cubit.homeScreenModel.result.allOffers.length),
//     );
//   }
// }
//
// class ShowOffersCard extends StatelessWidget {
//   const ShowOffersCard({
//     Key key,
//     this.cubit,
//   }) : super(key: key);
//
//   final AppCubit cubit;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//       height: MediaQuery
//           .of(context)
//           .size
//           .height * 0.2,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             flex: 2,
//             child: Container(
//               decoration: BoxDecoration(
//                   image: DecorationImage(
//                       fit: BoxFit.cover,
//                       image: NetworkImage(
//                           cubit.homeScreenModel.result.mainOffer))),
//             ),
//           ),
//           SizedBox(
//             width: 10,
//           ),
//           Expanded(
//             flex: 3,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Text(
//                   'EnjoyOffersAndDiscounts'.tr(),
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       color: kDarkGoldColor,
//                       fontSize: 13,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   'DiscountsAndOffers'.tr(),
//                   style: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 13,
//                   ),
//                 ),
//                 CustomButton(
//                   text: 'SeeOffers'.tr(),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class HomeCard extends StatelessWidget {
//   const HomeCard({
//     Key key,
//     this.onTap,
//     this.title,
//     this.image,
//     this.index,
//     this.cubit,
//     this.isFeature = false,
//   }) : super(key: key);
//
//   final Function onTap;
//   final String title;
//   final String image;
//   final int index;
//   final AppCubit cubit;
//   final bool isFeature;
//
//   Future<void> onPress(BuildContext context) async {
//     if (cubit.homeScreenModel.result.allCategories[index].totalDepartment > 0) {
//       cubit.getAllDepartments(
//           catId: cubit.homeScreenModel.result.allCategories[index].catId);
//       navigateTo(
//           context,
//           DisplayProductsScreen(
//             hasDepartments: true,
//             categoryName:
//             cubit.homeScreenModel.result.allCategories[index].categoryName,
//           ));
//     } else {
//       print(cubit.homeScreenModel.result.allCategories[index].catId);
//       cubit.getProducts(
//         catId: cubit.homeScreenModel.result.allCategories[index].catId,
//       );
//       navigateTo(
//           context,
//           DisplayProductsScreen(
//             hasDepartments: false,
//             categoryName:
//             cubit.homeScreenModel.result.allCategories[index].categoryName,
//           ));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: isFeature
//           ? onTap
//           : () {
//         onPress(context);
//       },
//       child: Container(
//         height: MediaQuery
//             .of(context)
//             .size
//             .height * 0.2,
//         padding: EdgeInsets.all(20),
//         decoration: BoxDecoration(
//             color: Colors.black87,
//             image: DecorationImage(
//                 fit: BoxFit.cover,
//                 image: NetworkImage(
//                   image ?? 'https://bit.ly/34h4E7D',
//                 )),
//             borderRadius: BorderRadius.circular(20)),
//         child: Column(
//           children: [
//             Text(
//               title,
//               style:
//               TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }