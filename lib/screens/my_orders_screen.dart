import 'dart:developer';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/cubit/getdataprofile_cubit.dart';
import '../cubits/my_orders_cubit.dart';
import '../cubits/order_details_cubit.dart';
import '../models/my_orders_model.dart';

import '../shared/defaults.dart';
import 'order_details.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyOrdersCubit cubit = MyOrdersCubit.get(context);
    log("oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo");
    cubit.getmyOrders();

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Orders'.tr(),
      ),
      body: BlocConsumer<MyOrdersCubit, MyOrdersState>(
        listener: (context, state) {},
        builder: (context, state) {
          return cubit.myOrdersModel == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    children: [
                      Label(
                        text: 'UnderWayOrders'.tr(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // OrderStatusCard(
                      //   status: 1,
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                      Label(
                        text: 'PreviousOrders'.tr(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              log("myOrdersModelmyOrdersModelmyOrdersModel ${cubit.myOrdersModel.data.length}");

                              return InkWell(
                                  onTap: () {
                                    GetdataprofileCubit.get(context)
                                        .getdataprofileCData();
                                    OrderDetailsCubit.get(context)
                                        .getOrderDetails(cubit
                                            .myOrdersModel.data[index].id
                                            .toString());

                                    log("11111111111111111111111111111111111111111");

                                    log(cubit.myOrdersModel.data[index].id
                                        .toString());
                                    OrderDetailsCubit.get(context).total = 0;
                                    navigateTo(
                                        context,
                                        OrderDetailsSCR(cubit
                                            .myOrdersModel.data[index].id));
                                  },
                                  child: OrderStatusCard(
                                      myOrdersData:
                                          cubit.myOrdersModel.data[index]));
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 4,
                                ),
                            itemCount: MyOrdersCubit.get(context)
                                .myOrdersModel
                                .data
                                .length),
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }
}

class OrderStatusCard extends StatelessWidget {
  OrderStatusCard({this.myOrdersData, this.status});
  final MyOrdersData myOrdersData;
  final int status;
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
                      myOrdersData.createdAt,
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
                      myOrdersData.codeOrder,
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
                      myOrdersData.updatedAt,
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
                      onTap: () {},
                      child: Text(
                        'OrderDetails'.tr(),
                        style: TextStyle(
                            fontSize: 12,
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
                title: myOrdersData.status,
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
    Key key,
    this.title,
    this.color,
  }) : super(key: key);

  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 100,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
