import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/cubits/cartCubit/cart_cubit.dart';
import 'package:safsofa/cubits/order/order_cubit.dart';
import 'package:safsofa/screens/bottom_navigation_screens/orders_section/cashback.dart';
import 'package:safsofa/screens/searchScreen.dart';

import '../../../cubits/cartCubit/cart_state.dart';
import '../../check_out_screen.dart';

class SelectDiscount extends StatelessWidget {
  const SelectDiscount({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        var cubit=CartCubit.get(context);
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SortItem(title: 'كود الخصم', isActive: cubit.promo,onTap: (){
                    cubit.promoActive();
                    cubit.promoCode.clear();
                  },),
                ),
                Expanded(
                  child: SortItem(title: 'الكاش باك', isActive: cubit.cache,onTap: (){
                    cubit.cacheActive();
                    cubit.cashback.clear();
                  },),
                ),
              ],
              // children: [
              //   SizedBox(
              //     height: 30.h,
              //     child: ListTile(
              //       horizontalTitleGap: 0,
              //       title:  Text('كود الخصم',style: TextStyle(
              //           fontSize: 16.sp,
              //           fontWeight: FontWeight.bold
              //       ),),
              //       leading: Radio(
              //         value:cubit.promo? 0:1,
              //         groupValue: 0,
              //         onChanged: (value) {
              //           print(value);
              //           cubit.promoActive();
              //         },
              //       ),
              //     ),
              //   ),
              //
              //   SizedBox(
              //     height: 30.h,
              //     child: ListTile(
              //       minVerticalPadding: 0,
              //       horizontalTitleGap: 0,
              //       title:  Text('الكاش باك',style: TextStyle(
              //           fontSize: 16.sp,
              //           fontWeight: FontWeight.bold
              //       ),),
              //       leading: Radio(
              //         value: cubit.cache?0:1,
              //         groupValue: 0,
              //         onChanged: (value) {
              //           cubit.cacheActive();
              //         },
              //       ),
              //     ),
              //   ),
              //
              //   SizedBox(
              //     height: 30.h,
              //     child: ListTile(
              //       horizontalTitleGap: 0,
              //       title:  Text('كروت الهدايا',style: TextStyle(
              //           fontSize: 16.sp,
              //           fontWeight: FontWeight.bold
              //       ),),
              //       leading: Radio(
              //         value: cubit.gift?0:1,
              //         groupValue: 0,
              //         onChanged: (value) {
              //           cubit.giftActive();
              //         },
              //       ),
              //     ),
              //   ),
              // ],
            ),
            if(cubit.promo)
              SizedBox(height: 20.h,),
            if(cubit.promo)
              PromoCodeTextField(),
            if(cubit.cache)
              CashBack(),
          ],
        );
      },
    );
  }
}
