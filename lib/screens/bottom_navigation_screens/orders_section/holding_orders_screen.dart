import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/cubits/my_orders_cubit.dart';
import 'package:safsofa/models/my_orders_model.dart';
import 'package:safsofa/screens/bottom_navigation_screens/orders_section/order_details.dart';
import 'package:safsofa/screens/bottom_navigation_screens/orders_section/pending_orders_screen.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';

import '../../../cubits/appCubit/app_cubit.dart';

class HoldingOrdersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var cubit = MyOrdersCubit.get(context);
    cubit.getHoldingOrders();
    return BlocConsumer<MyOrdersCubit, MyOrdersState>(
      listener: (context, state) {},
      builder: (context, state) {
        return /* cubit.holdingOrder == null &&*/ state
        is! MyOrdersSuccessState
            ? Center(
          child: CircularProgressIndicator(),
        )
            :
        MyOrdersCubit.get(context).holdingOrder!.data!.length==0 ?
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
            padding: const EdgeInsets.all(22),
            itemBuilder: (context, index) {
              log("myOrders ${cubit.holdingOrder?.data?.length}");

              return CustomOrder( myOrdersData: cubit.holdingOrder!.data![index],status: 4,);
              // OrderStatusCard(
              //   myOrdersData: cubit.holdingOrder!.data![index]);
            },
            separatorBuilder: (context, index) => SizedBox(
              height: 4,
            ),
            itemCount:
            MyOrdersCubit.get(context).holdingOrder!.data!.length);
      },
    );
  }
}