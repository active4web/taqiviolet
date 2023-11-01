import 'dart:developer';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/policiesCubit/policies_cubit.dart';
import 'package:safsofa/screens/menu_screens/policies_screens/policies_details_screen.dart';

import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';

class PoliciesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var cubit = PoliciesCubit.get(context);
    cubit.getPoliciesData();
    return BlocConsumer<PoliciesCubit, PoliciesState>(
      listener: (context, state) {},
      builder: (context, state) {
        // state is PoliciesInitial
        //     ? cubit.getPoliciesData()
        //     : log("Blog Screen}");
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Policies'.tr(),
          ),
          body: state is! GetPoliciesSuccessState
              ? Center(
                  child: CircularProgressIndicator(
                  color: kDarkGoldColor,
                ))
              : Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              navigateTo(
                                  context,
                                  PoliciesDetailsScreen(
                                    title: cubit.policies![index].title,
                                    id: (cubit.policies![index].id)!,
                                  ));
                            },
                            child: Card(
                              color: Colors.grey.shade200,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Image(
                                        image: NetworkImage(
                                            "${cubit.policies![index].image}"),
                                        fit: BoxFit.cover),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "${cubit.policies![index].title}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: kCustomBlack,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 20,
                          ),
                      itemCount: cubit.policies!.length),

                  // GridView.builder(
                  //   padding: EdgeInsets.zero,
                  //   shrinkWrap: true,
                  //   physics: const ScrollPhysics(),
                  //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: 2,
                  //     mainAxisSpacing: 20,
                  //     crossAxisSpacing: 10,
                  //     childAspectRatio: 0.89,
                  //   ),
                  //   itemBuilder: (context, index) => InkWell(
                  //     onTap: () {
                  //       navigateTo(
                  //           context,
                  //           PoliciesDetailsScreen(
                  //             title: cubit.policies[index].title,
                  //             content: cubit.policies[index].content,
                  //           ));
                  //       ;
                  //     },
                  //     child: Card(
                  //       color: Colors.grey.shade200,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(20),
                  //       ),
                  //       child: Column(
                  //         children: [
                  //           Expanded(
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                   color: Colors.black,
                  //                   borderRadius: BorderRadius.only(
                  //                     topLeft: Radius.circular(20),
                  //                     topRight: Radius.circular(20),
                  //                   )),
                  //               child: Image(
                  //                   image: AssetImage('assets/images/logo.png'),
                  //                   fit: BoxFit.cover),
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             height: 15,
                  //           ),
                  //           Text(
                  //             cubit.policies[index].title,
                  //             textAlign: TextAlign.center,
                  //             style: TextStyle(
                  //               color: kDarkGoldColor,
                  //               fontWeight: FontWeight.w500,
                  //               fontSize: 14,
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             height: 10,
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  //   itemCount: cubit.policies.length,
                  // ),
                ),

          // ListView.separated(
          //     itemBuilder: (context, index) {
          //       return Column(
          //         children: [
          //           Row(
          //             children: [
          //               Expanded(
          //                 child: Text(
          //                   cubit.policies[index].title,
          //                   style: TextStyle(
          //                       fontWeight: FontWeight.w500,
          //                       fontSize: 18,
          //                       color: kDarkGoldColor),
          //                 ),
          //               ),
          //             ],
          //           ),
          //           SizedBox(
          //             height: 10,
          //           ),
          //           SizedBox(
          //             height: 10,
          //           ),
          //           SizedBox(
          //             height: 20,
          //           ),
          //           Text(
          //             cubit.policies[index].content,
          //             style: TextStyle(fontSize: 15, height: 2),
          //           ),
          //         ],
          //       );
          //     },
          //     separatorBuilder: (context, index) => Padding(
          //       padding: const EdgeInsets.symmetric(vertical: 20),
          //       child: Divider(),
          //     ),
          //     itemCount: cubit.policies.length),

          // Padding(
          //         padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          //         child: ListView(
          //           children: [
          //             Label(text: 'LatestArticles'.tr()),
          //             SizedBox(
          //               height: 20,
          //             ),
          //             Container(
          //               height: MediaQuery.of(context).size.height * 0.3,
          //               width: MediaQuery.of(context).size.width,
          //               decoration: BoxDecoration(color: Color(0xfff6f6f6)),
          //               child: (ListView.builder(
          //                 scrollDirection: Axis.horizontal,
          //                 shrinkWrap: true,
          //                 padding: EdgeInsets.zero,
          //                 itemCount: cubit.lastblog.length,
          //                 itemBuilder: (context, index) => Padding(
          //                   padding:
          //                       const EdgeInsets.symmetric(horizontal: 8.0),
          //                   child: Container(
          //                     width: 175,
          //                     child: Directionality(
          //                       textDirection: TextDirection.rtl,
          //                       child: ArticleCard(
          //                         index: index.toString() + "a",
          //                         title: cubit.lastblog[index].title,
          //                         time: cubit.lastblog[index].time,
          //                         image: cubit.lastblog[index].image,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               )),
          //             ),
          //             SizedBox(
          //               height: 30,
          //             ),
          //             Label(text: 'Articles'.tr()),
          //             SizedBox(
          //               height: 20,
          //             ),
          //             GridView.builder(
          //               shrinkWrap: true,
          //               physics: NeverScrollableScrollPhysics(),
          //               scrollDirection: Axis.vertical,
          //               padding: EdgeInsets.zero,
          //               itemCount: cubit.blogs.length,
          //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //                   childAspectRatio: 6 / 9,
          //                   mainAxisSpacing: 10,
          //                   crossAxisCount: 2,
          //                   crossAxisSpacing: 10),
          //               itemBuilder: (context, index) => Directionality(
          //                 textDirection: TextDirection.rtl,
          //                 child: ArticleCard(
          //                   index: index.toString(),
          //                   title: cubit.blogs[index].title,
          //                   time: cubit.blogs[index].time,
          //                   image: cubit.blogs[index].image,
          //                 ),
          //               ),
          //             )
          //           ],
          //         ),
          //       ),
        );
      },
    );
  }
}

// class ArticleCard extends StatelessWidget {
//   String title;
//   String time;
//   String image;
//   var index;
//
//   ArticleCard(
//       {@required this.title,
//       @required this.time,
//       @required this.image,
//       @required this.index});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         navigateTo(
//             context,
//             BlogDetailsScreen(
//               indexSt: index,
//             ));
//       },
//       child: Stack(
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height * 0.4,
//             decoration: BoxDecoration(
//                 color: Colors.grey.shade300,
//                 borderRadius: BorderRadius.circular(25)),
//             child: ClipRRect(
//                 borderRadius: BorderRadius.circular(25),
//                 child: Image(
//                   image: NetworkImage("$image"),
//                   fit: BoxFit.cover,
//                 )),
//           ),
//           Positioned(
//             bottom: 0,
//             right: 0,
//             left: 0,
//             child: Container(
//               padding: EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 borderRadius:
//                     BorderRadius.vertical(bottom: Radius.circular(25)),
//                 color: Colors.black54,
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           "$title",
//                           style: TextStyle(color: Colors.white, fontSize: 11),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         '$time',
//                         style: TextStyle(color: Colors.white, fontSize: 8),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
