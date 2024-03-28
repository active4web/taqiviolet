import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/screens/add_review_screen.dart';
import 'package:safsofa/shared/constants.dart';

import '../../../cubits/order_details_cubit.dart';
import '../../../shared/components/custom_app_bar.dart';

class OrderDetailsSCR extends StatelessWidget {
  final int? id;

  OrderDetailsSCR({
    required this.id,
  });

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderDetailsCubit()..getOrderDetails(id!),
      child: BlocConsumer<OrderDetailsCubit, OrderDetailsState>(
        listener: (context, state) {},
        builder: (context, state) {
          OrderDetailsCubit cubit = OrderDetailsCubit.get(context);
          return Scaffold(
            appBar: CustomAppBar(
              title: "OrderDetails".tr(),
            ),
            body: state is! OrderDetailsSuccessState &&
                    cubit.orderDetails == null
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.all(16.0),
                    physics: BouncingScrollPhysics(),
                    children: [
                        Padding(
                          padding:  EdgeInsets.symmetric(vertical: 8.0.h),
                          child: Container(
                            decoration: BoxDecoration(),
                            child: Row(
                                children: [
                              Text(
                                "${"OrderNumber".tr()}: ",
                                style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '#${cubit.orderDetails?.data?.orderDetails?.codeOrder}',
                                style: TextStyle(

                                  decoration: TextDecoration.underline,
                                  fontSize: 13.sp,
                                ),
                              )
                            ]),
                          ),
                        ),
                        Text('بيانات الطلب',style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500
                        ),),
                        ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: cubit.orderDetails!.data!.listProducts!.length,
                          itemBuilder: (context, pos) {
                            return Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade100,
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: Offset(5, 10), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 5.w,),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(8.r),
                                              child: Image(
                                                image: NetworkImage(
                                                  "${cubit.orderDetails?.data?.listProducts![pos].image}",
                                                ),
                                                height: 90.h,
                                                width: 90.w,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${cubit.orderDetails?.data?.listProducts![pos].name}",
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      fontSize: 10.sp,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '${"quantity".tr()}: ',
                                                        style: TextStyle(
                                                            color: kCustomBlack,
                                                            fontSize: 10.sp),
                                                      ),
                                                      Text(
                                                        "${cubit.orderDetails?.data?.listProducts![pos].qty.toString()}",
                                                        style: TextStyle(fontSize: 10.sp),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '${"price".tr()}: ',
                                                        style: TextStyle(
                                                            color: kCustomBlack,
                                                            fontSize: 10.sp),
                                                      ),
                                                      Text(
                                                        '${cubit.orderDetails?.data?.listProducts![pos].price} ${"SAR".tr()}',
                                                        style: TextStyle(fontSize: 10.sp),
                                                      ),
                                                    ],
                                                  ),
                                                  if (cubit
                                                              .orderDetails
                                                              ?.data
                                                              ?.listProducts![pos]
                                                              .productRate ==
                                                          0 &&
                                                      cubit.orderDetails?.data
                                                              ?.orderDetails?.status ==
                                                          "3")
                                                    Align(
                                                      alignment: AlignmentDirectional
                                                          .bottomEnd,
                                                      child: TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .push(MaterialPageRoute(
                                                            builder: (context) =>
                                                                AddReviewScreen(
                                                              // prodId: cubit
                                                              //     .orderDetails
                                                              //     ?.data
                                                              //     ?.listProducts![pos]
                                                              //     .productId,
                                                              orderId: cubit
                                                                  .orderDetails
                                                                  ?.data
                                                                  ?.orderDetails
                                                                  ?.id??0
                                                            ),
                                                          ))
                                                              .then((value) {
                                                            if (value) {
                                                              cubit.getOrderDetails(
                                                                  id!, false);
                                                            }
                                                          });
                                                        },
                                                        child: Text(
                                                          "rate".tr(),
                                                          style: TextStyle(
                                                            color: kDarkGoldColor,
                                                            fontSize: 17,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(height: 10.h,),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      Text("deliveryData".tr(),style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500
                      ),),
                     Padding(padding: EdgeInsets.symmetric(horizontal: 10.w),child:
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text('${'theName'.tr()}: ${cubit.orderDetails?.data?.orderDetails?.username??''}',style: TextStyle(
                               fontSize:  10.sp
                           ),),
                           Divider(
                             thickness: .5,
                           ),
                           Text('${'Phone'.tr()}: ${cubit.orderDetails?.data?.orderDetails?.userphone??''}',style: TextStyle(
                               fontSize: 10.sp
                           ),),
                           if (cubit.orderDetails?.data?.orderDetails?.address !=
                               null)
                             Divider(
                               thickness: .5,
                             ),
                           if (cubit.orderDetails?.data?.orderDetails?.address !=
                               null)
                             Text(
                               "${"Address".tr()}: ${cubit.orderDetails?.data?.orderDetails?.address}",
                               style: TextStyle(fontSize: 10.sp),
                             ),
                           if (cubit.orderDetails?.data?.orderDetails?.address !=
                               null )
                             Divider(
                               thickness: .5,
                             ),
                         ],
                       )

                       ,),
                      Text("orderTotal".tr(),style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500
                      ),),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.w),
                          padding: EdgeInsets.symmetric(vertical:10.r,horizontal: 5.w),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200.withOpacity(0.5)),
                          child: Column(
                            children: [
                              customRow(
                                lab: "price".tr(),
                                val:
                                    '${cubit.orderDetails?.data?.orderDetails?.total?.toStringAsFixed(2)} ${"SAR".tr()}',
                              ),
                              if (cubit.orderDetails?.data?.orderDetails
                                      ?.deliveryType ==
                                  0)
                                customRow(
                                  lab: "deliveryCost".tr(),
                                  val:
                                      '${cubit.orderDetails?.data?.orderDetails?.deliveryCost?.toStringAsFixed(2)} ${"SAR".tr()}',
                                ),
                              if ((cubit.orderDetails?.data?.orderDetails
                                          ?.promoCodeValue)!
                                      .toInt() >
                                  0)
                                customRow(
                                  lab: "discountValue".tr(),
                                  val:
                                      '${cubit.orderDetails?.data?.orderDetails?.promoCodeValue?.toStringAsFixed(2)} ${"%"}',
                                ),
                              Divider(
                                height: 3,
                                color: Colors.black54,
                              ),
                              customRow(
                                lab: "Total".tr(),
                                val:
                                    '${cubit.orderDetails?.data?.orderDetails?.subTotal?.toStringAsFixed(2)} ${"SAR".tr()}',
                              ),
                            ],
                          ),
                        ),
                      ]),
          );
        },
      ),
    );
  }

  Widget customRow({String? lab, String? val}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          "${lab}",
          style: TextStyle(
            fontSize: 10.sp,
          ),
        ),
        Text(
          "$val",
          style: TextStyle(color:kCustomBlack, fontSize: 10.sp),
        ),
      ],
    );
  }
}
