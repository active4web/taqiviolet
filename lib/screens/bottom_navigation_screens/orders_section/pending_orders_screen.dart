import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/my_orders_cubit.dart';
import 'package:safsofa/models/my_orders_model.dart';
import 'package:safsofa/screens/bottom_navigation_screens/orders_section/order_details.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';

class PendingOrdersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var cubit = MyOrdersCubit.get(context);
    cubit.getMyWaitingOrders();
    return BlocConsumer<MyOrdersCubit, MyOrdersState>(
      listener: (context, state) {},
      builder: (context, state) {
        return cubit.waitingOrders == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            :
        MyOrdersCubit.get(context).waitingOrders!.data!.length==0 ?
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              height: 200.h,
                image:
                NetworkImage("$MBaseUrl"+"${AppCubit.get(context).emptyImages?.data?[2].value??''}"),

            ),
            Text(AppCubit.get(context).emptyImages?.data?[2].title??'',style: TextStyle(
                color: Colors.grey,fontSize: 16.sp
            ),),
            SizedBox(height: 50.h,)
          ],
        ):
        ListView.separated(
          shrinkWrap: true,
                padding: const EdgeInsets.all(22),
                itemBuilder: (context, index) {
                  return CustomOrder(myOrdersData:cubit.waitingOrders!.data![index],);
                    // OrderStatusCard(
                    //   myOrdersData: cubit.waitingOrders!.data![index]);
                },
                separatorBuilder: (context, index) => SizedBox(
                      height: 4,
                    ),
                itemCount:
                    MyOrdersCubit.get(context).waitingOrders!.data!.length);
      },
    );
  }
}

class OrderStatusCard extends StatelessWidget {
  OrderStatusCard({this.myOrdersData, this.status});
  final MyOrdersData? myOrdersData;
  final int? status;

  @override
  Widget build(BuildContext context) {
    // log('${myOrdersData.toJson()}');
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: Color(0xfff4f4f4), borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    myOrdersData?.orderDate != null ?
                    Text(
                      '${myOrdersData?.orderDate}',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ): SizedBox(),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                myOrdersData?.codeOrder != null ?
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Text(
                        'OrderNumber'.tr(),
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                    Text(
                      "${myOrdersData?.codeOrder}",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    )
                  ],
                ):SizedBox(),
                SizedBox(
                  height: 10,
                ),
                myOrdersData?.orderDeliveryDate != null ?
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Text(
                        'DeliveryTime'.tr(),
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                    Text(
                      '${myOrdersData?.orderDeliveryDate}',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    )
                  ],
                ):SizedBox(),
                SizedBox(
                  height: 10,
                ),
                //TODO: PRODUCT DETAILS
                InkWell(
                  onTap: (){
                    navigateTo(
                        context,
                        OrderDetailsSCR(
                          id: myOrdersData?.id,
                        ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'OrderDetails'.tr(),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: kCustomBlack),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              StatusChip(
                title: "${myOrdersData?.status}",
                color: kCustomBlack,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StatusChip extends StatelessWidget {
  const StatusChip({
    this.title,
    this.color,
  }) ;

  final String? title;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,

      // width: 100,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          handleOrderStatusMessage(statusVal: "${title}"),
          style: TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class CustomOrder extends StatelessWidget {
  const CustomOrder({super.key, this.myOrdersData, this.status});
  final MyOrdersData? myOrdersData;
  final int? status;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('${'OrderNumber'.tr()}: ',style: TextStyle(
                      fontSize: 11.sp,
                        fontWeight: FontWeight.bold
                    ),),
                    Text(myOrdersData?.codeOrder??'',style: TextStyle(
                      fontSize: 11.sp
                    ),),
                  ],
                ),
                Row(
                  children: [
                    Text('${'orderTotal'.tr()}: ',style: TextStyle(
                        fontWeight: FontWeight.bold,
                      fontSize: 11.sp
                    ),),
                    Expanded(child: Text(myOrdersData?.total.toString()??'',style: TextStyle(
                        fontSize: 11.sp
                    ),)),
                  ],
                ),
                Row(
                  children: [
                    Text('${"productsNumber".tr()}: ',style: TextStyle(
                        fontWeight: FontWeight.bold,
                      fontSize: 11.sp
                    ),),
                    Text(myOrdersData?.itemCount.toString()??'',style: TextStyle(
                        fontSize: 11.sp
                    ),),
                  ],
                ),
                Row(
                  children: [
                    Text('${'orderDate'.tr()}: ',style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11.sp
                    ),),
                    Expanded(child: Text(myOrdersData?.date!=null?myOrdersData?.date??'':myOrdersData?.orderDate??'',maxLines: 1,overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 11.sp
                    ),)),
                  ],
                ),
              ],
            ),
          ),

          Column(
            children: [
              InkWell(
                onTap: (){
                },
                child: Container(
                  padding: EdgeInsets.all(5.r),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color: kCustomBlack),
                  child: Text(
                   status==1?'جاري تجهيزه' :status==2?'تم توصيله':status==4?"معلق":'preparing'.tr(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              TextButton(onPressed: (){
                navigateTo(context, OrderDetailsSCR(
                  id: int.parse(myOrdersData?.id.toString()??''),
                ));
              }, child: Text(
                'OrderDetails'.tr(),style: TextStyle(
                  color: kCustomBlack,fontWeight: FontWeight.bold,
                  fontSize: 11.sp
              ),
              ))
            ],
          )
        ],
      ),
    );
  }
}
