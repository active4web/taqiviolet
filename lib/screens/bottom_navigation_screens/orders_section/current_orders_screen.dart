import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/my_orders_cubit.dart';
import 'package:safsofa/models/my_orders_model.dart';
import 'package:safsofa/screens/bottom_navigation_screens/orders_section/order_details.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';

class CurrentOrdersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var cubit = MyOrdersCubit.get(context);
    cubit.getMyCurrentOrders();
    return BlocConsumer<MyOrdersCubit, MyOrdersState>(
      listener: (context, state) {},
      builder: (context, state) {
        return /* cubit.currentOrders == null &&*/ state
                is! MyOrdersSuccessState
            ? Center(
                child: CircularProgressIndicator(),
              )
            :
        MyOrdersCubit.get(context).currentOrders!.data!.length==0 ?
        Center(
          child: Image(
            image:
            AssetImage('assets/images/empty_cart.png'),
          ),
        ):
        ListView.separated(
                padding: const EdgeInsets.all(22),
                itemBuilder: (context, index) {
                  log("myOrders ${cubit.currentOrders?.data?.length}");

                  return OrderStatusCard(
                      myOrdersData: cubit.currentOrders!.data![index]);
                },
                separatorBuilder: (context, index) => SizedBox(
                      height: 4,
                    ),
                itemCount:
                    MyOrdersCubit.get(context).currentOrders!.data!.length);
      },
    );
  }
}

class OrderStatusCard extends StatelessWidget {
  OrderStatusCard({this.myOrdersData, this.status});

  final MyOrdersData? myOrdersData;
  final int? status;

  // 1 = underway , 2 = done , 3 = canceled

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
                    Text(
                      '${myOrdersData?.orderDate}',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
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
                ),
                SizedBox(
                  height: 10,
                ),
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
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        navigateTo(
                            context,
                            OrderDetailsSCR(
                              id: myOrdersData?.id,
                            ));
                      },
                      child: Text(
                        'OrderDetails'.tr(),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: kDarkGoldColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              StatusChip(
                title: "${myOrdersData?.status}",
                color: kDarkGoldColor,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class StatusChip extends StatelessWidget {
  const StatusChip({
    this.title,
    this.color,
  });

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
