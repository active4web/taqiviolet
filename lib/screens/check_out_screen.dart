import 'dart:developer';
 import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart ';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/appCubit/app_states.dart';
import 'package:safsofa/cubits/cartCubit/cart_state.dart';
import 'package:safsofa/models/cities_location_model.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/components/custom_drop_down.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:safsofa/shared/components/custom_text_form_field.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';

import '../cubits/cartCubit/cart_cubit.dart';
import '../network/local/cache_helper.dart';
import 'new_details_order_after.dart';

int? countryId;
int? cityId;


class CheckOutScreen extends StatefulWidget {
  final int cashInCart;
  final int giftInCart;
  CheckOutScreen({required this.cashInCart,required this.giftInCart});
  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  var globalKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ReceiveMethod? receiveMethod = ReceiveMethod.fromHome;
    PaymentMethod paymentMethod = PaymentMethod.onlinePayment;
    TextEditingController nameOfReceiver =
        TextEditingController(text: AppCubit.get(context).userInfo?.data?.name);
    TextEditingController phoneOfReceiver =
        TextEditingController(text: AppCubit.get(context).userInfo?.data?.phone);
    TextEditingController addressOfReceiver = TextEditingController(
        text: AppCubit.get(context).userInfo?.data?.address);
    CartCubit cartCubit = CartCubit.get(context);

    var code2 = TextEditingController();
    var code3 = TextEditingController();
    // cartCubit.getAllLocationsOfCities();
    return BlocConsumer<AppCubit, AppStates>(

      listener: (context, state) {},
      builder: (context, state) {
        print(CacheHelper.getData('couponId'));
        return Scaffold(
          key: cartCubit.scaffoldkey,
          appBar: CustomAppBar(
            title: 'reservationConfirmation'.tr(),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: globalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        "deliveryData".tr(),
                        style: TextStyle(
                          color: kCustomBlack,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     navigateTo(context, SendAGiftScreen());
                    //   },
                    //   child: Container(
                    //     height: 50,
                    //     width: double.infinity,
                    //     color: Color(0xfff3f3f3),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Icon(
                    //           Icons.add_circle,
                    //           color: Colors.black54,
                    //         ),
                    //         SizedBox(
                    //           width: 10,
                    //         ),
                    //         Text(
                    //           'sendagift'.tr(),
                    //           style: TextStyle(fontSize: 17),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Visibility(
                      visible: false,
                      child: Label(
                        text: 'SelectReceiveWay'.tr(),
                      ),
                    ),
                    Visibility(
                      visible: false,
                      child: SizedBox(
                        height: 10,
                      ),
                    ),
                    StatefulBuilder(
                      builder: (context, setState) => Column(
                        children: [
                          //this row for choosing reciving way
                          Visibility(
                            visible: false,
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Radio<ReceiveMethod>(
                                      value: ReceiveMethod.fromHome,
                                      groupValue: receiveMethod,
                                      onChanged: (value) {
                                        log('$value');
                                        setState(() {
                                          receiveMethod = value;
                                        });
                                      },
                                      fillColor: MaterialStateProperty.all<Color>(
                                          kDarkGoldColor),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Text('DeliverToHome'.tr()),
                                  ],
                                ),
                                // Row(
                                //   children: [
                                //     Radio<ReceiveMethod>(
                                //       fillColor: MaterialStateProperty.all<Color>(
                                //           kDarkGoldColor),
                                //       value: ReceiveMethod.fromStore,
                                //       groupValue: receiveMethod,
                                //       onChanged: (ReceiveMethod value) {
                                //         setState(() {
                                //           receiveMethod = value;
                                //         });
                                //       },
                                //     ),
                                //     SizedBox(
                                //       width: 16,
                                //     ),
                                //     Text('ReceiveFromStore'.tr()),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: receiveMethod == ReceiveMethod.fromHome,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Address".tr(),
                                  style: TextStyle(
                                    color: kCustomBlack,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                CustomTextFormField(
                                  controller: addressOfReceiver,
                                  fillColor: Colors.grey.shade500,
                                  hintColor: Colors.black,
                                  textColor: Colors.black,
                                  cursorColor: kDarkGoldColor,
                                  keyboardType: TextInputType.streetAddress,
                                  validate: (value){
                                    if(value!.isEmpty){
                                      return "this field is required";
    }
                                  },

                                ),
                                SizedBox(height: 10),
                                Label(
                                  text: 'ChooseLocation'.tr(),
                                  fontColor: kCustomBlack,
                                ),
                                // cubit.address != null
                                //     ? ListTile(
                                //         tileColor: Color(0xfff3f3f3),
                                //         leading: Icon(
                                //           Icons.location_on_outlined,
                                //           color: kDarkGoldColor,
                                //           size: 25,
                                //         ),
                                //         title: Text(
                                //           cubit.address ?? '',
                                //           style: TextStyle(
                                //               fontSize: 15,
                                //               color: Colors.black54),
                                //         ),
                                //         trailing: GestureDetector(
                                //           onTap: () {
                                //             cubit.address = null;
                                //             cubit.emit(PickLocationSuccess());
                                //           },
                                //           child: Icon(
                                //             Icons.remove_circle,
                                //             color: Colors.black54,
                                //           ),
                                //         ),
                                //       )
                                //     : SizedBox(),
                                // SizedBox(
                                //   height: 6,
                                // ),
                                // GestureDetector(
                                //   onTap: () {
                                //     navigateTo(context, LocationPickerScreen());
                                //   },
                                //   child: Container(
                                //     height: 50,
                                //     width: double.infinity,
                                //     color: Color(0xfff3f3f3),
                                //     child: Row(
                                //       mainAxisAlignment: MainAxisAlignment.center,
                                //       children: [
                                //         Icon(
                                //           Icons.add_circle,
                                //           color: Colors.black54,
                                //         ),
                                //         SizedBox(
                                //           width: 10,
                                //         ),
                                //         Text(
                                //           'AddLocation'.tr(),
                                //           style: TextStyle(fontSize: 17),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),

                                BlocProvider(
                                  create: (context) =>
                                      CartCubit()..getAllLocationsOfCities(),
                                  child: BlocConsumer<CartCubit, CartState>(
                                    listener: (context, state) {
                                      // TODO: implement listener
                                    },
                                    builder: (context, state) {
                                      return state is CartSuccessState
                                          ? SizedBox(
                                        height: 120,
                                            child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: CustomDropDown(
                                                      validate: (value){
                                                        if(value==null){
                                                          return "country is required";
                                                        }
                                                      },
                                                      fillColor:
                                                      Colors.grey.shade500,
                                                      hintColor: Colors.black,
                                                      textColor: Colors.black,
                                                      hintText: "country".tr(),
                                                      items: CartCubit.get(context)
                                                          .allCitiesLocation!
                                                          .data!
                                                          .countryList!
                                                          .map((CountryList
                                                              country) {
                                                        return DropdownMenuItem(
                                                          // alignment:
                                                          //     AlignmentDirectional
                                                          //         .topStart,
                                                          child: Text("${country.name}",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                          ),),
                                                          value: country,
                                                        );
                                                      }).toList(),
                                                      value: CartCubit.get(context)
                                                          .selectedCountry,
                                                      onChanged:
                                                          ( value) {
                                                        CartCubit.get(context)
                                                            .chooseCountry(value!);
                                                        countryId = value.id;
                                                        cityId = null;
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 0,
                                                  ),
                                                  Expanded(

                                                    child: CustomDropDown(
                                                      validate: (value){
                                                        if(value==null){
                                                          return "city is required";
                                                        }
                                                      },
                                                      fillColor:
                                                          Colors.grey.shade500,
                                                      hintColor: Colors.black,
                                                      textColor: Colors.black,
                                                      hintText: "city".tr(),
                                                      items: CartCubit.get(context)
                                                          .allCities!
                                                          .map((ListCites city) {
                                                        return DropdownMenuItem(
                                                          // alignment:
                                                          //     AlignmentDirectional
                                                          //         .topStart,
                                                          child:
                                                              Text("${city.nameCity}",style: TextStyle(
                                                                fontSize: 12
                                                              ),maxLines: 2,overflow: TextOverflow.ellipsis,),
                                                          value: city,
                                                        );
                                                      }).toList(),
                                                      value: CartCubit.get(context)
                                                          .selectedCity,
                                                      onChanged: ( value) {
                                                        CartCubit.get(context)
                                                            .chooseCity(value!);
                                                        cityId = value.idCity;
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ),
                                          )
                                          : Center(
                                              child: CircularProgressIndicator(),
                                            );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "FullName".tr(),
                      style: TextStyle(
                        color: kCustomBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    CustomTextFormField(
                      controller: nameOfReceiver,
                      fillColor: Colors.grey.shade500,
                      hintColor: Colors.black,
                      textColor: Colors.black,
                      cursorColor: kDarkGoldColor,
                      validate: (value){
                        if(value!.isEmpty){
                          return "this field is required";
    }
                      },

                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Phone".tr(),
                      style: TextStyle(
                        color: kCustomBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    CustomTextFormField(
                      controller: phoneOfReceiver,
                      fillColor: Colors.grey.shade500,
                      hintColor: Colors.black,
                      textColor: Colors.black,
                      cursorColor: kDarkGoldColor,
                      keyboardType: TextInputType.phone,
                      validate: (value){
                        if(value!.isEmpty){
                          return "this field is required";
                        }
                      },

                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if(CacheHelper.getData('couponValue')!=null && CacheHelper.getData('couponId')!=null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("  لديك كوبون مجانى قيمته  ${CacheHelper.getData('couponValue')} %",
                        style: TextStyle(
                          color: Colors.green,
                        ),),
                        InkWell(
                          onTap: (){
                            showDialog(
                              context: context,
                              builder: (context){
                                return AlertDialog(
                                  title: Text('حذف الكوبون المجانى'),
                                  content:  Text('هل تريد عدم استخدام الكوبون المجانى ؟'),
                                  actions: [
                                    TextButton(
                                      child: Text('الغاء'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('حذف'),
                                      onPressed: () {
                                       setState(() {
                                         CacheHelper.removeData("couponValue");
                                         CacheHelper.removeData("couponId");
                                         CacheHelper.getData("couponId");
                                         CacheHelper.getData("couponId");
                                       });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              }
                            );
                          },
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.red,
                            ),
                            child: Icon(Icons.close,
                            color: Colors.white,
                            size: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: false,
                      child: Label(
                        text: 'ChoosePaymentMethod'.tr(),
                      ),
                    ),
                    Visibility(
                      visible: false,
                      child: SizedBox(
                        height: 10,
                      ),
                    ),
                    Visibility(
                      visible: false,
                      child: StatefulBuilder(
                        builder: (context, setState) => Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Row(
                            //   children: [
                            //     Radio<PaymentMethod>(
                            //       value: PaymentMethod.offlinePayment,
                            //       groupValue: paymentMethod,
                            //       onChanged: (PaymentMethod value) {
                            //         setState(() {
                            //           paymentMethod = value;
                            //         });
                            //       },
                            //       fillColor: MaterialStateProperty.all<Color>(
                            //           kDarkGoldColor),
                            //     ),
                            //     SizedBox(
                            //       width: 16,
                            //     ),
                            //     Text('PayWhenReceive'.tr()),
                            //   ],
                            // ),
                            Row(
                              children: [
                                Radio<PaymentMethod>(
                                  value: PaymentMethod.onlinePayment,
                                  groupValue: paymentMethod,
                                  onChanged: ( value) {
                                    setState(() {
                                      // paymentMethod = value;
                                      // showToast(
                                      //     text:
                                      //         "onlinePaymentServiceIsNotAvailableNow"
                                      //             .tr(),
                                      //     color: Colors.black,
                                      //     location: ToastGravity.CENTER);
                                    });
                                  },
                                  fillColor: MaterialStateProperty.all<Color>(
                                      kDarkGoldColor),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text('PayOnline'.tr()),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: false,
                      child: SizedBox(
                        height: 10,
                      ),
                    ),
                    Visibility(visible: false, child: Divider()),
                    SizedBox(
                      height: 20,
                    ),
                    PromoCodeTextField(),
                    SizedBox(
                      height: 10,
                    ),
                    if(widget.giftInCart!=0)
                    Text('code2'.tr()),
                    if(widget.giftInCart!=0)
                    SizedBox(
                      height: 10,
                    ),
                    if(widget.giftInCart!=0)
                    CustomTextFormField(
                      controller: code2,
                      fillColor: Colors.grey.shade500,
                      hintColor: Colors.black,
                      textColor: Colors.black,
                      cursorColor: kDarkGoldColor,
                      keyboardType: TextInputType.phone,
                      validate: (value){},

                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if(widget.cashInCart!=0)
                    Text('cashBack'.tr()),
                    if(widget.cashInCart!=0)
                    SizedBox(
                      height: 10,
                    ),
                    if(widget.cashInCart!=0)
                    CustomTextFormField(
                      controller: code3,
                      fillColor: Colors.grey.shade500,
                      hintColor: Colors.black,
                      textColor: Colors.black,
                      cursorColor: kDarkGoldColor,
                      keyboardType: TextInputType.phone,
                      validate: (value){},
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Divider(),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Label(
                          text: 'Total'.tr(),
                        ),
                        Text(
                          cartCubit.total.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CustomButton(
                      onTap: () {
                        print("Ss");
                        globalKey.currentState!.validate();
                        if(nameOfReceiver.text.isNotEmpty&&phoneOfReceiver.text.isNotEmpty&&addressOfReceiver.text.isNotEmpty)
                        navigateTo(context, NewDetailsOrderAfter(
                          subTotal: cartCubit.total.toInt(),
                          cityId: cityId!,
                          countryId: countryId!,
                          promoCodeId:CacheHelper.getData('couponId')==null ? 0 : int.parse(CacheHelper.getData('couponId')) ,
                          promoCodeValue:CacheHelper.getData('couponValue')==null ? 0 : int.parse(CacheHelper.getData('couponValue')) ,
                          name: nameOfReceiver.text,
                          phone: phoneOfReceiver.text,
                          address: addressOfReceiver.text,
                          gift: code2.text,
                          cash: code3.text,
                        ));
                        // if (addressOfReceiver.text.isEmpty) {
                        //   showToast(
                        //       text: "pleaseEnterTheAddress".tr(),
                        //       color: Colors.red,
                        //       location: ToastGravity.CENTER);
                        // } else if (nameOfReceiver.text.isEmpty) {
                        //   showToast(
                        //       text: "pleaseEnterTheName".tr(),
                        //       color: Colors.red,
                        //       location: ToastGravity.CENTER);
                        // } else if (phoneOfReceiver.text.isEmpty) {
                        //   showToast(
                        //       text: "pleaseEnterYourMobileNumber".tr(),
                        //       color: Colors.red,
                        //       location: ToastGravity.CENTER);
                        // } else if (countryId == null) {
                        //   showToast(
                        //       text: "pleaseSelectTheCountry".tr(),
                        //       color: Colors.red,
                        //       location: ToastGravity.CENTER);
                        // } else if (cityId == null) {
                        //   showToast(
                        //       text: "pleaseSelectACity".tr(),
                        //       color: Colors.red,
                        //       location: ToastGravity.CENTER);
                        // } else {
                        //   cartCubit.make_order(
                        //       payment_status:
                        //           paymentMethod == PaymentMethod.offlinePayment
                        //               ? 1
                        //               : 0,
                        //       payment_type:
                        //           paymentMethod == PaymentMethod.offlinePayment
                        //               ? 1
                        //               : 0,
                        //       deliveryType:
                        //           receiveMethod == ReceiveMethod.fromHome ? 0 : 1,
                        //       address: addressOfReceiver.text,
                        //       name: nameOfReceiver.text,
                        //       phone: phoneOfReceiver.text,
                        //       orderPrice: cartCubit.total,
                        //       countryId: countryId!,
                        //       cityId: cityId!,
                        //       context: context);
                        // }
                      },
                      height: 50,
                      text: 'Next'.tr(),
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class PromoCodeTextField extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    TextEditingController myCopun = TextEditingController();
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xfff3f3f3),
                border: Border.all(color: Colors.black26, width: 0.3),
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextFormField(
                controller: myCopun,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 22,
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      if (myCopun.text.isNotEmpty) {
                        CartCubit.get(context)
                            .checkCopunStatus(copun: myCopun.text);
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      child: Center(
                        child: Text(
                          'Redeem'.tr(),
                          style: TextStyle(color: kLightGoldColor),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: kCustomBlack,
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30)),
                  fillColor: Color(0xfff3f3f3),
                  hintText: 'EnterPromoCode'.tr(),
                ),
                style: TextStyle(color: Colors.black),
              ),
            ),
            if (CartCubit.get(context).isCopunValid != null)
              Text(
                CartCubit.get(context).isCopunValid!
                    ? "validCoupon".tr()
                    : "invalidCoupon".tr(),
                style: TextStyle(
                    color: CartCubit.get(context).isCopunValid!
                        ? Colors.green
                        : Colors.red),
              ),
          ],
        );
      },
    );
  }
}

enum ReceiveMethod { fromHome, fromStore }

enum PaymentMethod { onlinePayment, offlinePayment }
