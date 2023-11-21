import 'dart:developer';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/screens/check_out_screen.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';

import '../../cubits/cartCubit/cart_cubit.dart';
import '../../cubits/cartCubit/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../network/local/cache_helper.dart';
import '../../shared/components/custom_text_form_field.dart';
import 'orders_section/select_discount.dart';

class CartScreen extends StatelessWidget {
  var code2 = TextEditingController();
  var code3 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //  if(CartCubit.get(context).state is CartStateInitial) CartCubit.get(context).getCartData();
    CartCubit cubit = CartCubit.get(context);

    // if(CartCubit.get(context).state is CartStateInitial) cubit.getCartData();
    //   cubit.getCartData();
    log("getCartData");
    kToken != null && kToken!.isNotEmpty
        ? cubit.getServerCartData()
        : cubit.getLocalCartData();
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if(state is MakeNewOrderSuccessState){
          cubit.promoCode.clear();
          cubit.cashback.clear();
          navigateTo(
              context,
              CheckOutScreen(
              ));
        }
      },
      builder: (context, state) {
        print(CacheHelper.getData("token"));
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Cart'.tr(),
          ),
          body: Visibility(
            visible: kToken != null && kToken!.isNotEmpty,
            //true >>cart data from server, //false >>cart data loaded locally
            child: cubit.myCartModel != null
                ? cubit.myCartModel!.data!.listItem!.isNotEmpty
                    ? SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 22.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               TextButton(
                                  onPressed: () =>
                                      cubit.emptyCartProductsServer(),
                                  child: Text(
                                    "emptyCart".tr(),
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     // Column(
                              //     //   children: [
                              //     //     Text("coupons".tr()),
                              //     //     Text("${cubit.myCartModel!.data!.totalCoupons}"),
                              //     //   ],
                              //     // ),
                              //     Column(
                              //       children: [
                              //         Text("wallet".tr()),
                              //         Text(
                              //             "${cubit.myCartModel!.data!.totalGft}"),
                              //       ],
                              //     ),
                              //     Column(
                              //       children: [
                              //         Text("cashback".tr()),
                              //         Text(
                              //             "${cubit.myCartModel!.data!.cashback}"),
                              //       ],
                              //     ),
                              //   ],
                              // ),
                                 ListView.separated(
                                   shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) => Container(
                                          height:170.h,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            "${cubit.myCartModel?.data?.listItem![index].image}")),
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                      bottom: 10, top: 20),
                                                  child: Column(

                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            MediaQuery.of(context)
                                                                    .size
                                                                    .width *
                                                                0.45,
                                                        child: Text(
                                                          "${cubit.myCartModel?.data?.listItem![index].name}",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${"numberOfUnit".tr()} ${cubit.myCartModel?.data?.listItem![index].quantity}",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                            FontWeight
                                                                .w500),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),

                                                      // Row(
                                                      //   children: [
                                                      //     Text(
                                                      //       "${cubit.myCartModel?.data?.listItem![index].price.toString()}",
                                                      //       style: TextStyle(
                                                      //           fontSize: 18,
                                                      //           color: Colors
                                                      //               .black54,
                                                      //           fontWeight:
                                                      //               FontWeight
                                                      //                   .w500),
                                                      //     ),
                                                      //     SizedBox(
                                                      //       width: 5,
                                                      //     ),
                                                      //     Text(
                                                      //       "SAR".tr(),
                                                      //       style: TextStyle(
                                                      //           fontSize: 18,
                                                      //           color: Colors
                                                      //               .black54,
                                                      //           fontWeight:
                                                      //               FontWeight
                                                      //                   .w500),
                                                      //     ),
                                                      //   ],
                                                      // ),
                                                      // SizedBox(
                                                      //   width:
                                                      //       MediaQuery.of(context)
                                                      //               .size
                                                      //               .width *
                                                      //           0.45,
                                                      //   child: Text(
                                                      //     "${"unitPrice".tr()} ${cubit.myCartModel?.data?.listItem![index].price} ${"SAR".tr()}",
                                                      //     style: TextStyle(
                                                      //         fontSize: 14,
                                                      //         fontWeight:
                                                      //             FontWeight
                                                      //                 .w500),
                                                      //     maxLines: 2,
                                                      //     overflow: TextOverflow
                                                      //         .ellipsis,
                                                      //   ),
                                                      // ),
                                                      // SizedBox(
                                                      //   width:
                                                      //       MediaQuery.of(context)
                                                      //               .size
                                                      //               .width *
                                                      //           0.45,
                                                      //   child: Text(
                                                      //     "${"numberOfUnit".tr()} ${cubit.myCartModel?.data?.listItem![index].quantity}",
                                                      //     style: TextStyle(
                                                      //         fontSize: 14,
                                                      //         fontWeight:
                                                      //             FontWeight
                                                      //                 .w500),
                                                      //     maxLines: 2,
                                                      //     overflow: TextOverflow
                                                      //         .ellipsis,
                                                      //   ),
                                                      // ),
                                                      // TODO : SMART PRICE
                                                      cubit
                                                                      .myCartModel
                                                                      ?.data
                                                                      ?.listItem![
                                                                          index]
                                                                      .smartPrice !=
                                                                  '' &&
                                                              cubit
                                                                      .myCartModel
                                                                      ?.data
                                                                      ?.listItem![
                                                                          index]
                                                                      .smartPrice !=
                                                                  null
                                                          ? SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.45,
                                                              child: Text(
                                                                "${"smartPrice".tr()} ${cubit.myCartModel?.data?.listItem![index].smartPrice} ${"SAR".tr()}",
                                                                style: TextStyle(
                                                                    fontSize: 14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            )
                                                          : SizedBox(),
                                                      cubit
                                                                      .myCartModel
                                                                      ?.data
                                                                      ?.listItem![
                                                                          index]
                                                                      .smartPrice !=
                                                                  '' &&
                                                              cubit
                                                                      .myCartModel
                                                                      ?.data
                                                                      ?.listItem![
                                                                          index]
                                                                      .smartPrice !=
                                                                  null
                                                          ? SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.45,
                                                              child: Text(
                                                                "${"finalPrice".tr()} ${cubit.myCartModel?.data?.listItem![index].price * cubit.myCartModel?.data?.listItem![index].quantity + double.parse(cubit.myCartModel?.data?.listItem![index].smartPrice) * cubit.myCartModel?.data?.listItem![index].quantity} ${"SAR".tr()}",
                                                                style: TextStyle(
                                                                    fontSize: 14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            )
                                                          : SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.45,
                                                              child: Text(
                                                                "${"finalPrice".tr()} ${cubit.myCartModel?.data?.listItem![index].price * cubit.myCartModel?.data?.listItem![index].quantity} ${"SAR".tr()}",
                                                                style: TextStyle(
                                                                    fontSize: 14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                      cubit
                                                                      .myCartModel
                                                                      ?.data
                                                                      ?.listItem![
                                                                          index]
                                                                      .smartPrice !=
                                                                  '' &&
                                                              cubit
                                                                      .myCartModel
                                                                      ?.data
                                                                      ?.listItem![
                                                                          index]
                                                                      .smartPrice !=
                                                                  null
                                                          ? SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.45,
                                                              child: Text(
                                                                "${"containSmartPrice".tr()}",
                                                                style: TextStyle(
                                                                    fontSize: 14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            )
                                                          : SizedBox(),
                                                      // SizedBox(
                                                      //   height: 5,
                                                      // ),
                                                      // Row(
                                                      //   mainAxisAlignment:
                                                      //       MainAxisAlignment
                                                      //           .spaceBetween,
                                                      //   children: [
                                                      //     Text(
                                                      //       "${cubit.myCartModel?.data?.listItem![index].quantity.toString()}",
                                                      //       style: TextStyle(
                                                      //           fontSize: 12,
                                                      //           fontWeight:
                                                      //               FontWeight
                                                      //                   .w500,
                                                      //           color: Colors
                                                      //               .black54),
                                                      //     ),
                                                      //     Container(
                                                      //       height: 20,
                                                      //       width: 1,
                                                      //       color:
                                                      //           Colors.black26,
                                                      //     ),
                                                      //   ],
                                                      // ),
                                                      SizedBox(height: 10.h,),
                                                      CounterRow(
                                                          quantity: cubit
                                                              .myCartModel!
                                                              .data!
                                                              .listItem![index]
                                                              .quantity
                                                              .toString(),
                                                          onAdd: () {
                                                            // print("999999999999999999");
                                                            // int.parse(cubit.myCartModel.data[index].quantity)+1;
                                                            //
                                                            // print(  int.parse(cubit.myCartModel.data[index].quantity)+1);
                                                            cubit.addquantityServer(
                                                                cart_id: cubit
                                                                    .myCartModel
                                                                    ?.data
                                                                    ?.listItem![
                                                                        index]
                                                                    .cardId,
                                                                product_quantity: (cubit
                                                                            .myCartModel
                                                                            ?.data
                                                                            ?.listItem![
                                                                                index]
                                                                            .quantity)!
                                                                        .toInt() +
                                                                    1);
                                                          },
                                                          onRemove: () {
                                                            if ((cubit
                                                                        .myCartModel
                                                                        ?.data
                                                                        ?.listItem![
                                                                            index]
                                                                        .quantity)!
                                                                    .toInt() >
                                                                1) {
                                                              cubit.addquantityServer(
                                                                  cart_id: cubit
                                                                      .myCartModel
                                                                      ?.data
                                                                      ?.listItem![
                                                                          index]
                                                                      .cardId,
                                                                  product_quantity: (cubit
                                                                              .myCartModel
                                                                              ?.data
                                                                              ?.listItem![index]
                                                                              .quantity)!
                                                                          .toInt() -
                                                                      1);
                                                            }
                                                            print(
                                                                "bbbbaaahhhhrrrrr");
                                                            print(
                                                                "111111111111111111");
                                                          }),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      print(cubit
                                                          .myCartModel!
                                                          .data!
                                                          .listItem![index]
                                                          .cardId!);
                                                      cubit
                                                          .delItemFromCartServer(
                                                        cartId: cubit
                                                            .myCartModel!
                                                            .data!
                                                            .listItem![index]
                                                            .cardId!,
                                                      );
                                                    },
                                                    icon: Icon(
                                                      Icons.close,
                                                      color: Color(0xffFE9C8F),
                                                    ),
                                                  ),
                                                  Spacer()
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                    separatorBuilder: (context, index) =>
                                        Divider(),
                                    itemCount: cubit
                                        .myCartModel!.data!.listItem!.length),
                              Visibility(visible: true, child: Divider()),

                              SelectDiscount(),
                              // PromoCodeTextField(),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // if (cubit.myCartModel!.data!.totalGft != 0) Text('code2'.tr()),
                              // if (cubit.myCartModel!.data!.totalGft!= 0)
                              //   SizedBox(
                              //     height: 10,
                              //   ),
                              // if (cubit.myCartModel!.data!.totalGft!= 0)
                              //   CustomTextFormField(
                              //     controller: code2,
                              //     fillColor: Colors.grey.shade500,
                              //     hintColor: Colors.black,
                              //     textColor: Colors.black,
                              //     cursorColor: kDarkGoldColor,
                              //     keyboardType: TextInputType.phone,
                              //     validate: (value) {},
                              //   ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // if (cubit.myCartModel!.data!.cashback != 0) Text('cashBack'.tr()),
                              // if (cubit.myCartModel!.data!.cashback != 0)
                              //   SizedBox(
                              //     height: 10,
                              //   ),
                              // if (cubit.myCartModel!.data!.cashback != 0)
                              //   CustomTextFormField(
                              //     controller: code3,
                              //     fillColor: Colors.grey.shade500,
                              //     hintColor: Colors.black,
                              //     textColor: Colors.black,
                              //     cursorColor: kDarkGoldColor,
                              //     keyboardType: TextInputType.phone,
                              //     validate: (value) {},
                              //   ),
                              // SizedBox(
                              //   height: 30,
                              // ),
                             // Divider(),

                              // SizedBox(
                              //   height: 20,
                              // ),
                              Divider(),
                              SizedBox(
                                height: 10,
                              ),

                              if (cubit.myCartModel?.data?.cashback != 0 &&
                                  cubit.myCartModel?.data?.cashback != null)
                                SizedBox(
                                  height: 5,
                                ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Label(
                                    text: 'Total'.tr(),
                                  ),
                                  Text(
                                    '${cubit.total} ${"SAR".tr()}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.black54),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(),
                              SizedBox(
                                height: 20,
                              ),
                              CustomButton(
                                height: 50,
                                text: 'Next'.tr(),
                                onTap: () {
                                  cubit.makeNewOrder();
                                  // navigateTo(
                                  //     context,
                                  //     CheckOutScreen(
                                  //       code2: code2,
                                  //       code3: code3,
                                  //       cashInCart: int.parse(
                                  //           "${cubit.myCartModel!.data!.cashback}"),
                                  //       giftInCart: int.parse(
                                  //           "${cubit.myCartModel!.data!.totalGft}"),
                                  //     ));
                                },
                              ),
                              SizedBox(
                                height:
                                    120.h
                              )
                            ],
                          ),
                        ),
                      )
                    : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(
                          height:200.h,
                            image: Image.network("$MBaseUrl"+"${AppCubit.get(context).emptyImages?.data?[0].value??''}").image),
                        Text(AppCubit.get(context).emptyImages?.data?[0].title??'',style: TextStyle(
                          color: Colors.grey,fontSize: 16.sp
                        ),),
                        Row()
                      ],
                    )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
            replacement: state is CartSuccessState //local cart
                ? cubit.myCartlocalModel?.cartProducts != null &&
                        cubit.myCartlocalModel!.cartProducts!.isNotEmpty
                    ? SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(22),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /*      TextButton(
                                  onPressed: () =>
                                      cubit.emptyCartProductsLocally(),
                                  child: Text(
                                    "emptyCart".tr(),
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),*/
                              ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) => Container(
                                        //0.5/2
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.7 /
                                                2,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          children: [
                                            Flexible(
                                              flex: 3,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          "${cubit.myCartlocalModel?.cartProducts![index].productImage}")),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Flexible(
                                              flex: 5,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10, top: 20),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.45,
                                                      child: Text(
                                                        "${cubit.myCartlocalModel?.cartProducts![index].productName}",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),

                                                    ///To:do///
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "${(cubit.myCartlocalModel?.cartProducts![index].onePiecePrice).toString()}",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color: Colors
                                                                  .black54,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          "SAR".tr(),
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color: Colors
                                                                  .black54,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.45,
                                                      child: Text(
                                                        "${"unitPrice".tr()} ${cubit.myCartlocalModel?.cartProducts![index].oneProdctPrice} ${"SAR".tr()}",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.45,
                                                      child: Text(
                                                        "${"numberOfUnit".tr()} ${cubit.myCartlocalModel?.cartProducts![index].quantity}",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),

                                                    cubit
                                                                    .myCartlocalModel
                                                                    ?.cartProducts![
                                                                        index]
                                                                    .withSmartFeature ==
                                                                true &&
                                                            cubit
                                                                    .myCartlocalModel
                                                                    ?.cartProducts![
                                                                        index]
                                                                    .smartPrice !=
                                                                null
                                                        ? SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.45,
                                                            child: Text(
                                                              "${"smartPrice".tr()} ${cubit.myCartlocalModel?.cartProducts![index].smartPrice} ${"SAR".tr()}",
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          )
                                                        : SizedBox(),

                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.45,
                                                      child: Text(
                                                        "${"finalPrice".tr()} ${cubit.myCartlocalModel?.cartProducts![index].onePiecePrice * cubit.myCartlocalModel?.cartProducts![index].quantity} ${"SAR".tr()}",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    cubit
                                                                    .myCartlocalModel
                                                                    ?.cartProducts![
                                                                        index]
                                                                    .withSmartFeature ==
                                                                true &&
                                                            cubit
                                                                    .myCartlocalModel
                                                                    ?.cartProducts![
                                                                        index]
                                                                    .smartPrice !=
                                                                null
                                                        ? SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.45,
                                                            child: Text(
                                                              "${"containSmartPrice".tr()}",
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          )
                                                        : SizedBox(),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "${cubit.myCartlocalModel?.cartProducts![index].quantity.toString()}",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: Colors
                                                                  .black54),
                                                        ),
                                                        Container(
                                                          height: 20,
                                                          width: 1,
                                                          color: Colors.black26,
                                                        ),
                                                      ],
                                                    ),
                                                    CounterRow(
                                                        quantity:
                                                            "${cubit.myCartlocalModel?.cartProducts![index].quantity.toString()}",
                                                        onAdd: () {
                                                          // log("999999999999999999");
                                                          // int.parse(cubit.myCartModel.data[index].quantity)+1;
                                                          //
                                                          // log(  '${int.parse(cubit.myCartModel.data[index].quantity)+1}');

                                                          cubit.addquantityLocally(
                                                              index: index,
                                                              product_id: cubit
                                                                  .myCartlocalModel
                                                                  ?.cartProducts![
                                                                      index]
                                                                  .productId,
                                                              product_quantity: (cubit
                                                                          .myCartlocalModel
                                                                          ?.cartProducts![
                                                                              index]
                                                                          .quantity)!
                                                                      .toInt() +
                                                                  1);
                                                        },
                                                        onRemove: () {
                                                          if ((cubit
                                                                      .myCartlocalModel
                                                                      ?.cartProducts![
                                                                          index]
                                                                      .quantity)!
                                                                  .toInt() >
                                                              1) {
                                                            cubit.addquantityLocally(
                                                                index: index,
                                                                product_id: cubit
                                                                    .myCartlocalModel
                                                                    ?.cartProducts![
                                                                        index]
                                                                    .productId,
                                                                product_quantity: (cubit
                                                                            .myCartlocalModel
                                                                            ?.cartProducts![index]
                                                                            .quantity)!
                                                                        .toInt() -
                                                                    1);
                                                          }

                                                          //  cubit.myCartModel.data[index].quantity-1;
                                                          //   log(   '${cubit.myCartModel.data[index].quantity-1}');
                                                          log("111111111111111111");
                                                        }),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      cubit.delITemFRomCartLocal(
                                                          product_id: cubit
                                                              .myCartlocalModel
                                                              ?.cartProducts![
                                                                  index]
                                                              .productId);
                                                    },
                                                    icon: Icon(
                                                      Icons.close,
                                                      color: Color(0xffFE9C8F),
                                                    ),
                                                  ),
                                                  Spacer()
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                  separatorBuilder: (context, index) =>
                                      Divider(),
                                  itemCount: cubit
                                      .myCartlocalModel!.cartProducts!.length),
                              SizedBox(
                                height: 20,
                              ),
                              Divider(),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Label(
                                    text: 'Total'.tr(),
                                  ),
                                  Text(
                                    cubit.total.toStringAsFixed(2),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.black54),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(),
                              SizedBox(
                                height: 20,
                              ),
                              CustomButton(
                                height: 50,
                                text: 'Next'.tr(),
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "pleaseLoginFirstToCompleteYourOrder"
                                            .tr(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      backgroundColor:
                                          Colors.red.withOpacity(0.6),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                              )
                            ],
                          ),
                        ),
                      )
                    : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                    height:200.h,
                    image: Image.network("$MBaseUrl"+"${AppCubit.get(context).emptyImages?.data?[0].value??''}").image),
                Text(AppCubit.get(context).emptyImages?.data?[0].title??'',style: TextStyle(
                    color: Colors.grey,fontSize: 16.sp
                ),),
                Row()
              ],
            )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        );
      },
    );
  }
}

class CounterRow extends StatelessWidget {
  const CounterRow({
    this.containerSize = 25,
    this.fontSize = 14,
    this.quantity = "",
    this.onAdd,
    this.onRemove,
  });

  final double containerSize;
  final double fontSize;
  final String quantity;
  final Function? onAdd;
  final Function? onRemove;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            onAdd!();
          },
          child: Container(
            width: containerSize,
            height: containerSize,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(50)),
            child: Center(
              child: Icon(
                Icons.add,
                color: Colors.black54,
                size: fontSize,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          width: 35,
          child: Center(
            child: Text(quantity.toString(),
                style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54)),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        GestureDetector(
          onTap: () {
            onRemove!();
          },
          child: Container(
            width: containerSize,
            height: containerSize,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(50)),
            child: Center(
              child: Icon(
                Icons.remove,
                color: Colors.black54,
                size: fontSize,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
