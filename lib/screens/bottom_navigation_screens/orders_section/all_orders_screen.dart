import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/my_orders_cubit.dart';
import 'package:safsofa/models/my_orders_model.dart';
import 'package:safsofa/screens/bottom_navigation_screens/orders_section/order_details.dart';
import 'package:safsofa/screens/bottom_navigation_screens/orders_section/pending_orders_screen.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';

class AllOrdersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyOrdersCubit, MyOrdersState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MyOrdersCubit.get(context);

        return cubit.clientOrdersModel == null
            ? Center(
          child: CircularProgressIndicator(),
        )
            :
        MyOrdersCubit.get(context).clientOrdersModel!.data!.all!.length==0 ?
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
              return CustomOrder(myOrdersData:cubit.clientOrdersModel!.data!.all![index],);
              // OrderStatusCard(
              //   myOrdersData: cubit.waitingOrders!.data![index]);
            },
            separatorBuilder: (context, index) => SizedBox(
              height: 4,
            ),
            itemCount:
            MyOrdersCubit.get(context).clientOrdersModel!.data!.all!.length);
      },
    );
  }
}


