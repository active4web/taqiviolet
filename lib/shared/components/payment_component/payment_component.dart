import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_paytabs_bridge/IOSThemeConfiguration.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkApms.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkTokeniseType.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/cartCubit/cart_cubit.dart';
import 'package:safsofa/models/cities_location_model.dart';
import 'package:safsofa/network/local/cache_helper.dart';
import 'package:safsofa/screens/add_review_screen.dart';
import 'package:safsofa/screens/check_out_screen.dart';
import 'package:safsofa/screens/new/personel_page/help/custom_circular_progress/custom_circular_progress.dart';
import 'package:safsofa/shared/components/payment_component/cubit/payment_cubit.dart';
import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/shared/components/payment_component/cubit/payment_state.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../main.dart';

class PaymentComponent extends StatefulWidget {

  PaymentComponent(
      {super.key,
      required this.phone,
      required this.name,
      required this.address,
      required this.cartId,
      required this.total,
      required this.country,
      required this.city, required this.zipCode, required this.email,
      });

  final String phone;
  final String name;
  final String address;
  final CountryList? country;
  final ListCites? city;
  final String cartId;
  final num total;
  final String zipCode;
  final String email;



  @override
  State<PaymentComponent> createState() => _PaymentComponentState();

}

class _PaymentComponentState extends State<PaymentComponent> {



  Widget applePayButton() {
    if (Platform.isIOS) {
      return TextButton(
        onPressed: () {
          //applePayPressed();
        },
        child: Text("applePay".tr()),
      );
    }
    return SizedBox(height: 0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(),
      child: BlocConsumer<PaymentCubit, PaymentState>(
        listener: (context, state) {
          if (state is PaymentSuccessState) {
            var cubit = PaymentCubit.get(context);
            navigateTo(context, AddReviewScreen(
                orderId:PaymentCubit.get(context).orderId??0
            ));
            showToast(text: "Payment Successfully", color: Colors.green);
            if(kToken != null && kToken!.isNotEmpty){
              CartCubit.get(context)..getServerCartData();
            }else{
              CartCubit.get(context)..getLocalCartData();
            }

          }
        },
        builder: (context, state) {
          var cubit = PaymentCubit.get(context);

          return AnimatedConditionalBuilder(
              condition: true,
              builder: (context) => Column(
                children: [
                  TextButton(
                        onPressed: () {
                          CartCubit.get(context).globalKey.currentState?.validate();
                          print("country: ${widget.country?.refCode}");
                          print("city  : ${widget.city?.nameCity}");
                          if(CartCubit.get(context).globalKey.currentState!.validate()){
                            cubit.payPressed(
                                billingDetailsData: BillingDetails(
                                    widget.name,
                                    widget.email,
                                    widget.phone,
                                    widget.address,
                                    widget.country?.refCode??'',
                                    widget.city?.nameCity??'ca',
                                    widget.city?.nameCity??'ca',
                                    widget.zipCode,widget.city?.idCity??0,widget.country?.id??0,widget.total,widget.cartId),
                                shippingDetailsData: ShippingDetails(
                                    widget.name,
                                    widget.email,
                                    widget.phone,
                                    widget.address,
                                    widget.country?.refCode??'eg',
                                    widget.city?.nameCity??'ca',
                                    widget.city?.nameCity??'ca',
                                    widget.zipCode));
                          }
                        },
                        child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            decoration: BoxDecoration(
                                color: kCustomBlack,
                                borderRadius: BorderRadius.circular(20.r)),
                            child: Center(
                              child:state is PaymentLoadingState? CustomCircularProgress():Text(
                                'orderNow'.tr(),
                                style: TextStyle(color: kDarkGoldColor,fontSize: 11.sp),
                              ),
                            )),
                      ),
                  TextButton(
                        onPressed: () {
                          CartCubit.get(context).globalKey.currentState?.validate();
                          print("country: ${widget.country?.refCode}");
                          print("city  : ${widget.city?.nameCity}");
                          print("phone  : ${ widget.phone}");
                          if(CartCubit.get(context).globalKey.currentState!.validate()){
                            cubit.apmsPayPressed(
                                billingDetailsData: BillingDetails(
                                    widget.name,
                                    widget.email,
                                   "0540402971",
                                    widget.address,
                                    widget.country?.refCode??'',
                                    widget.city?.nameCity??'ca',
                                    widget.city?.nameCity??'ca',
                                    widget.zipCode,widget.city?.idCity??0,widget.country?.id??0,widget.total,widget.cartId),
                                shippingDetailsData: ShippingDetails(
                                    widget.name,
                                    widget.email,
                                    "0540402971",
                                    widget.address,
                                    widget.country?.refCode??'eg',
                                    widget.city?.nameCity??'ca',
                                    widget.city?.nameCity??'ca',
                                    widget.zipCode));
                          }
                        },
                        child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            decoration: BoxDecoration(
                                color: kCustomBlack,
                                borderRadius: BorderRadius.circular(20.r)),
                            child: Center(
                              child:state is PaymentLoadingState? CustomCircularProgress():Text(
                                'applePay'.tr(),
                                style: TextStyle(color: kDarkGoldColor,fontSize: 11.sp),
                              ),
                            )),
                      ),
                  // TextButton(
                  //       onPressed: () {
                  //         CartCubit.get(context).globalKey.currentState?.validate();
                  //         print("country: ${widget.country?.refCode}");
                  //         print("city  : ${widget.city?.nameCity}");
                  //         print("phone  : ${ widget.phone}");
                  //         if(CartCubit.get(context).globalKey.currentState!.validate()){
                  //           cubit.payWithTabby(
                  //               billingDetailsData: BillingDetails(
                  //                   widget.name,
                  //                   widget.email,
                  //                  "0540402971",
                  //                   widget.address,
                  //                   widget.country?.refCode??'',
                  //                   widget.city?.nameCity??'ca',
                  //                   widget.city?.nameCity??'ca',
                  //                   widget.zipCode,widget.city?.idCity??0,widget.country?.id??0,widget.total,widget.cartId),
                  //               shippingDetailsData: ShippingDetails(
                  //                   widget.name,
                  //                   widget.email,
                  //                   "0540402971",
                  //                   widget.address,
                  //                   widget.country?.refCode??'eg',
                  //                   widget.city?.nameCity??'ca',
                  //                   widget.city?.nameCity??'ca',
                  //                   widget.zipCode));
                  //         }
                  //       },
                  //       child: Container(
                  //           width: double.infinity,
                  //           padding: EdgeInsets.symmetric(vertical: 10.h),
                  //           decoration: BoxDecoration(
                  //               color: kCustomBlack,
                  //               borderRadius: BorderRadius.circular(20.r)),
                  //           child: Center(
                  //             child:state is PaymentLoadingState? CustomCircularProgress():Text(
                  //               'tabby'.tr(),
                  //               style: TextStyle(color: kDarkGoldColor,fontSize: 11.sp),
                  //             ),
                  //           )),
                  //     ),

                ],
              ),
              fallback: (context) => TextButton(
                    onPressed: () {},
                    child: Text("Cancel Payment"),
                  ));
        },
      ),
    );
  }
}
