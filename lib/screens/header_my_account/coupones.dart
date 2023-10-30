import 'package:flutter/material.dart';
import 'package:safsofa/cubits/coupones_cubit/coupones_cubit.dart';
import 'package:safsofa/cubits/coupones_cubit/coupones_states.dart';
import 'package:safsofa/cubits/gify_cubit/gift_cubit.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:safsofa/shared/defaults.dart';

import '../../network/local/cache_helper.dart';
import '../../shared/constants.dart';
import '../new_all_products_screen.dart';

class CouponesScreen extends StatefulWidget {
  const CouponesScreen({Key? key}) : super(key: key);

  @override
  State<CouponesScreen> createState() => _CouponesScreenState();
}

class _CouponesScreenState extends State<CouponesScreen> {
  @override
  void initState() {
    GiftCubit.get(context).showCouponsData();
    GiftCubit.get(context).showOldCouponsData();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(CacheHelper.getData('token'));
    return BlocConsumer<GiftCubit,GiftState>(
      listener: (context,state){},
      builder:  (context,state){
        var cubit = GiftCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            title: 'coupons'.tr(),
          ),
          body: Column(
            children: [
            Padding(padding: EdgeInsets.all(10),
            child:   Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){
                      cubit.changePageIndex(cubit.index=1);
                    },
                    child: Container(
                      height: 50,
                      color: cubit.index==1 ? kCustomBlack : Colors.transparent,
                      child: Center(
                        child: Text("قسائم غير مستخدمة",
                          style: TextStyle(
                            color: cubit.index==1 ? Colors.white : Colors.black87,
                          ),),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){
                      cubit.changePageIndex(cubit.index=2);
                    },
                    child: Container(
                      height: 50,
                      color: cubit.index==2 ? kCustomBlack : Colors.transparent,
                      child: Center(
                        child: Text("قسائم مستخدمة",
                          style: TextStyle(
                            color: cubit.index==2 ? Colors.white : Colors.black87,
                          ),),
                      ),
                    ),
                  ),
                ),

                // ,
                // Text("القديم"),
              ],
            ),
            ),
              if(cubit.index==1)
              Expanded(
                child: ConditionalBuilder(
                  condition: state is! ShowCouponsDataLoading && state is ! ShowOldCouponsDataLoading,
                  builder: (context) =>
                  cubit.couponsModel?.data?.couponLists?.length==0 ?
                  Center(child: Text(" لا يوجد كوبونات حاليا",
                    style: TextStyle(
                      fontSize: 25,
                    ),),):
                      ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child:
                          Card(
                            // elevation: 8,
                            color:
                            // cubit.couponsModel!.data!.couponLists![index].status =='1'? Colors.white :
                            Colors.grey[300],
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                '- ${cubit.couponsModel?.data?.couponLists![index].value}%',
                                                // '- value %',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                )),
                                            InkWell(
                                              onTap: (){
                                                CacheHelper.setData(key: "couponId" , value: "${cubit.couponsModel!.data!.couponLists![index].id}");
                                                CacheHelper.setData(key: "couponValue" , value: "${cubit.couponsModel!.data!.couponLists![index].value}");
                                                navigateTo(context, NewAllProductsScreen());
                                                print("${cubit.couponsModel!.data!.couponLists![index].id}");
                                                print("${cubit.couponsModel!.data!.couponLists![index].value}");
                                              },
                                              child: Container(
                                                height: 30,
                                                width: 80,
                                                color: Color(0xff393846),
                                                child: Center(
                                                  child: Text("تقديم",
                                                  style: TextStyle(
                                                    color: Colors.white
                                                  ),),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text("code".tr(),
                                                style: TextStyle(
                                                  fontSize: 16,
                                                )),
                                            Text(
                                                "${cubit.couponsModel?.data?.couponLists![index].coupon}",
                                                // "coupon",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              size: 8,
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                                '${cubit.couponsModel?.data?.couponLists![index].startDate} ~',
                                                // ' startDate ~',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                )),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(''
                                                '${cubit.couponsModel?.data?.couponLists![index].endDate} ',
                                                // 'endDate',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                )),
                                          ],
                                        ),

                                      ]),
                                  // Container(
                                  //   decoration: BoxDecoration(
                                  //       shape: BoxShape.rectangle,
                                  //       border: Border.all(
                                  //         color: Colors.black,
                                  //       )),
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.symmetric(
                                  //         horizontal: 2),
                                  //     child: Text(
                                  //       'expired'.tr(),
                                  //       style: TextStyle(
                                  //         fontSize: 15,
                                  //         fontWeight: FontWeight.w300,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // )

                                ],
                              ),
                            ),
                          ),
                        );
                    },
                    separatorBuilder: (context, index) =>
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Container(
                            height: 3,
                            width: double.infinity,
                            color: Color(0xff393846),
                          ),
                        ),
                    itemCount: cubit.couponsModel!.data!.couponLists!.length,
                  ),
                  fallback: (context) => Center(child: RefreshProgressIndicator()),
                ),
              ),
              if(cubit.index==2)
              Expanded(
                child: ConditionalBuilder(
                  condition: state is! ShowCouponsDataLoading && state is ! ShowOldCouponsDataLoading,
                  builder: (context) =>
                  cubit.oldCouponsModel!.data!.couponLists!.length==0 ?
                  Center(child: Text(" لا يوجد كوبونات حاليا",
                    style: TextStyle(
                      fontSize: 25,
                    ),),):
                      ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return  cubit.oldCouponsModel!.data!.couponLists!.length==0 ?
                      Center(child: Text(" لا يوجد كوبونات مستخدمه حاليا",
                        style: TextStyle(
                          fontSize: 25,
                        ),),):
                        // cubit.couponsModel!.data!.couponLists!.length==0 ?
                        // Center(
                        //     child: Image(
                        //         image:
                        //         AssetImage('assets/images/empty_cart.png')))
                        //     :
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 8,
                            color:
                            // cubit.oldCouponsModel!.data!.couponLists![index].status =='1'? Colors.white :
                            Colors.grey[300],
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Stack(
                                alignment: AlignmentDirectional.topEnd,

                                children: [
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            '- ${cubit.oldCouponsModel?.data?.couponLists![index].value}%',
                                            // '- value %',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            )),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text("code".tr(),
                                                style: TextStyle(
                                                  fontSize: 16,
                                                )),
                                            Text(
                                                "${cubit.oldCouponsModel?.data?.couponLists![index].coupon}",
                                                // "coupon",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              size: 8,
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                                '${cubit.oldCouponsModel?.data?.couponLists![index].startDate} ~',
                                                // ' startDate ~',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                )),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(''
                                                '${cubit.oldCouponsModel?.data?.couponLists![index].endDate} ',
                                                // 'endDate',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                )),
                                          ],
                                        ),

                                      ]),
                                  // Container(
                                  //   decoration: BoxDecoration(
                                  //       shape: BoxShape.rectangle,
                                  //       border: Border.all(
                                  //         color: Colors.black,
                                  //       )),
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.symmetric(
                                  //         horizontal: 2),
                                  //     child: Text(
                                  //       'expired'.tr(),
                                  //       style: TextStyle(
                                  //         fontSize: 15,
                                  //         fontWeight: FontWeight.w300,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // )

                                ],
                              ),
                            ),
                          ),
                        );
                    },
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 10,),
                    itemCount: cubit.oldCouponsModel!.data!.couponLists!.length,
                  ),
                  fallback: (context) => Center(child: RefreshProgressIndicator()),
                ),
              ),
            ],
          ),
          // body: BlocConsumer<GiftCubit, GiftState>(
          //   listener: (context, state) {},
          //   builder: (context, state) {
          //     GiftCubit cubit = GiftCubit.get(context);
          //     return ConditionalBuilder(
          //       condition: state is! ShowCouponsDataLoading,
          //       builder: (context) => ListView.separated(
          //         physics: BouncingScrollPhysics(),
          //         itemBuilder: (context, index) {
          //           return
          //             cubit.couponsModel!.data!.couponLists!.length==0 ?
          //             Center(
          //                 child: Image(
          //                     image:
          //                     AssetImage('assets/images/empty_cart.png')))
          //                 :
          //             Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: Card(
          //                 elevation: 8,
          //                 color: cubit.couponsModel!.data!.couponLists![index].status =='1'? Colors.white : Colors.grey[300],
          //                 child: Padding(
          //                   padding: const EdgeInsets.all(10),
          //                   child: Stack(
          //                     alignment: AlignmentDirectional.topEnd,
          //
          //                     children: [
          //                       Column(
          //                           crossAxisAlignment: CrossAxisAlignment.start,
          //                           children: [
          //                             Text(
          //                                 '- ${cubit.couponsModel?.data?.couponLists![index].value}%',
          //                                 style: TextStyle(
          //                                   fontSize: 16,
          //                                   fontWeight: FontWeight.w600,
          //                                 )),
          //                             /*    SizedBox(
          //                           height: 5,
          //                         ),
          //                         Row(
          //                           children: [
          //                             Text("forOrdersMoreThan".tr(),
          //                                 style: TextStyle(
          //                                   fontSize: 16,
          //                                 )),
          //                             Text("99,0 ${"rS".tr()}",
          //                                 style: TextStyle(
          //                                   fontSize: 16,
          //                                 )),
          //                           ],
          //                         ),*/
          //                             SizedBox(
          //                               height: 5,
          //                             ),
          //                             Row(
          //                               children: [
          //                                 Text("code".tr(),
          //                                     style: TextStyle(
          //                                       fontSize: 16,
          //                                     )),
          //                                 Text("${cubit.couponsModel?.data?.couponLists![index].coupon}",
          //                                     style: TextStyle(
          //                                       fontSize: 16,
          //                                     )),
          //                               ],
          //                             ),
          //                             SizedBox(
          //                               height: 5,
          //                             ),
          //                             Row(
          //                               crossAxisAlignment: CrossAxisAlignment.center,
          //                               children: [
          //                                 Icon(
          //                                   Icons.circle,
          //                                   size: 8,
          //                                 ),
          //                                 SizedBox(
          //                                   width: 2,
          //                                 ),
          //                                 Text('${cubit.couponsModel?.data?.couponLists![index].startDate} ~',
          //                                     style: TextStyle(
          //                                       fontSize: 16,
          //                                     )),
          //                                 SizedBox(
          //                                   width: 2,
          //                                 ),
          //                                 Text('${cubit.couponsModel?.data?.couponLists![index].endDate} ',
          //                                     style: TextStyle(
          //                                       fontSize: 16,
          //                                     )),
          //                               ],
          //                             ),
          //                             /*    SizedBox(
          //                           height: 5,
          //                         ),
          //                         Row(
          //                           crossAxisAlignment: CrossAxisAlignment.center,
          //                           children: [
          //                             Icon(
          //                               Icons.circle,
          //                               size: 8,
          //                             ),
          //                             SizedBox(
          //                               width: 2,
          //                             ),
          //                             Text('forSelectedItems'.tr(),
          //                                 style: TextStyle(fontSize: 16)),
          //                           ],
          //                         ),*/
          //                           ]),
          //                       cubit.couponsModel!.data!.couponLists![index].status !='1'?
          //                       Container(
          //                         decoration: BoxDecoration(
          //                             shape: BoxShape.rectangle,
          //                             border: Border.all(
          //                               color: Colors.black,
          //                             )),
          //                         child: Padding(
          //                           padding: const EdgeInsets.symmetric(
          //                               horizontal: 2),
          //                           child: Text(
          //                             'expired'.tr(),
          //                             style: TextStyle(
          //                               fontSize: 15,
          //                               fontWeight: FontWeight.w300,
          //                             ),
          //                           ),
          //                         ),
          //                       ):SizedBox(),
          //
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //             );
          //         },
          //         separatorBuilder: (context, index) => SizedBox(
          //           height: 10,
          //         ),
          //         itemCount: cubit.couponsModel!.data!.couponLists!.length,
          //       ),
          //       fallback: (context) => Center(child: RefreshProgressIndicator()),
          //     );
          //   },
          // ),
        );
      },

    );
  }
}
