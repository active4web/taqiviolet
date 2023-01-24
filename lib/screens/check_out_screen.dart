import 'dart:developer';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart ';
import 'package:flutter/material.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/appCubit/app_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/cartCubit/cart_state.dart';
import 'package:safsofa/models/cities_location_model.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/components/custom_drop_down.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safsofa/shared/components/custom_text_form_field.dart';

import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';

import '../cubits/cartCubit/cart_cubit.dart';

int countryId;
int cityId;

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ReceiveMethod receiveMethod = ReceiveMethod.fromHome;
    PaymentMethod paymentMethod = PaymentMethod.onlinePayment;
    TextEditingController nameOfReceiver =
        TextEditingController(text: AppCubit.get(context).userInfo.data.name);
    TextEditingController phoneOfReceiver =
        TextEditingController(text: AppCubit.get(context).userInfo.data.phone);
    TextEditingController addressOfReceiver = TextEditingController(
        text: AppCubit.get(context).userInfo.data.address);
    CartCubit cartCubit = CartCubit.get(context);

    // cartCubit.getAllLocationsOfCities();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          key: cartCubit.scaffoldkey,
          appBar: CustomAppBar(
            title: 'CheckOut'.tr(),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      "deliveryData".tr(),
                      style: TextStyle(
                        color: kDarkGoldColor,
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
                                    onChanged: (ReceiveMethod value) {
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
                                  color: kDarkGoldColor,
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
                                keyboardType: TextInputType.phone,
                              ),
                              SizedBox(height: 10),
                              Label(
                                text: 'ChooseLocation'.tr(),
                                fontColor: kDarkGoldColor,
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
                                        ? Row(
                                            children: [
                                              Expanded(
                                                child: CustomDropDown(
                                                  fillColor:
                                                      Colors.grey.shade500,
                                                  hintColor: Colors.black,
                                                  textColor: Colors.black,
                                                  hintText: "country".tr(),
                                                  items: CartCubit.get(context)
                                                      .allCitiesLocation
                                                      .data
                                                      .countryList
                                                      .map((CountryList
                                                          country) {
                                                    return DropdownMenuItem(
                                                      // alignment:
                                                      //     AlignmentDirectional
                                                      //         .topStart,
                                                      child: Text(country.name),
                                                      value: country,
                                                    );
                                                  }).toList(),
                                                  value: CartCubit.get(context)
                                                      .selectedCountry,
                                                  onChanged:
                                                      (CountryList value) {
                                                    CartCubit.get(context)
                                                        .chooseCountry(value);
                                                    countryId = value.id;
                                                    cityId = null;
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: CustomDropDown(
                                                  fillColor:
                                                      Colors.grey.shade500,
                                                  hintColor: Colors.black,
                                                  textColor: Colors.black,
                                                  hintText: "city".tr(),
                                                  items: CartCubit.get(context)
                                                      .allCities
                                                      .map((ListCites city) {
                                                    return DropdownMenuItem(
                                                      // alignment:
                                                      //     AlignmentDirectional
                                                      //         .topStart,
                                                      child:
                                                          Text(city.nameCity),
                                                      value: city,
                                                    );
                                                  }).toList(),
                                                  value: CartCubit.get(context)
                                                      .selectedCity,
                                                  onChanged: (ListCites value) {
                                                    CartCubit.get(context)
                                                        .chooseCity(value);
                                                    cityId = value.idCity;
                                                  },
                                                ),
                                              )
                                            ],
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
                      color: kDarkGoldColor,
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
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Phone".tr(),
                    style: TextStyle(
                      color: kDarkGoldColor,
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
                  ),
                  SizedBox(
                    height: 20,
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
                                onChanged: (PaymentMethod value) {
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
                      if (addressOfReceiver.text.isEmpty) {
                        showToast(
                            text: "pleaseEnterTheAddress".tr(),
                            color: Colors.red,
                            location: ToastGravity.CENTER);
                      } else if (nameOfReceiver.text.isEmpty) {
                        showToast(
                            text: "pleaseEnterTheName".tr(),
                            color: Colors.red,
                            location: ToastGravity.CENTER);
                      } else if (phoneOfReceiver.text.isEmpty) {
                        showToast(
                            text: "pleaseEnterYourMobileNumber".tr(),
                            color: Colors.red,
                            location: ToastGravity.CENTER);
                      } else if (countryId == null) {
                        showToast(
                            text: "pleaseSelectTheCountry".tr(),
                            color: Colors.red,
                            location: ToastGravity.CENTER);
                      } else if (cityId == null) {
                        showToast(
                            text: "pleaseSelectACity".tr(),
                            color: Colors.red,
                            location: ToastGravity.CENTER);
                      } else {
                        cartCubit.make_order(
                            payment_status:
                                paymentMethod == PaymentMethod.offlinePayment
                                    ? 1
                                    : 0,
                            payment_type:
                                paymentMethod == PaymentMethod.offlinePayment
                                    ? 1
                                    : 0,
                            deliveryType:
                                receiveMethod == ReceiveMethod.fromHome ? 0 : 1,
                            address: addressOfReceiver.text,
                            name: nameOfReceiver.text,
                            phone: phoneOfReceiver.text,
                            orderPrice: cartCubit.total,
                            countryId: countryId,
                            cityId: cityId,
                            context: context);
                      }
                    },
                    height: 50,
                    text: 'CheckOut'.tr(),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class PromoCodeTextField extends StatelessWidget {
  const PromoCodeTextField({
    Key key,
  }) : super(key: key);

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
                          color: Colors.black,
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
                CartCubit.get(context).isCopunValid
                    ? "validCoupon".tr()
                    : "invalidCoupon".tr(),
                style: TextStyle(
                    color: CartCubit.get(context).isCopunValid
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
