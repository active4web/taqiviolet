import 'dart:developer';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/appCubit/app_states.dart';
import 'package:safsofa/cubits/cartCubit/cart_state.dart';
import 'package:safsofa/models/cities_location_model.dart';
import 'package:safsofa/screens/new/personel_page/help/custom_circular_progress/custom_circular_progress.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/components/custom_drop_down.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:safsofa/shared/components/custom_text_form_field.dart';
import 'package:safsofa/shared/components/payment_component/cubit/payment_cubit.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../cubits/cartCubit/cart_cubit.dart';
import '../network/local/cache_helper.dart';
import '../shared/components/payment_component/payment_component.dart';
import 'new_details_order_after.dart';

int? countryId;
int? cityId;

TextEditingController textEditingController = TextEditingController();

class CheckOutScreen extends StatefulWidget {
  CheckOutScreen();

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  void initState() {
    CartCubit.get(context)..getAllLocationsOfCities();
    // CartCubit.get(context).email.text = AppCubit.get(context).userInfo?.data?.email ?? '';
    // CartCubit.get(context).phoneOfReceiver.text =
    //     AppCubit.get(context).userInfo?.data?.phone ?? '';
    // CartCubit.get(context).addressOfReceiver.text =
    //     AppCubit.get(context).userInfo?.data?.address ?? '';
    // CartCubit.get(context).nameOfReceiver.text =
    //     AppCubit.get(context).userInfo?.data?.name ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ReceiveMethod? receiveMethod = ReceiveMethod.fromHome;
    PaymentMethod paymentMethod = PaymentMethod.onlinePayment;

    CartCubit cartCubit = CartCubit.get(context);

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
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
              child: Form(
                key: cartCubit.globalKey,
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
                          fontSize: 16.sp,
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
                        height: 10.h,
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
                                      fillColor:
                                          MaterialStateProperty.all<Color>(
                                              kDarkGoldColor),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Text('DeliverToHome'.tr(),style: TextStyle(
                                      fontSize: 10.sp
                                    ),),
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
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                CustomTextFormField(
                                  // fontSize: 12.sp,
                                  controller: cartCubit.addressOfReceiver,
                                  fillColor: Colors.grey.shade500,
                                  hintColor: Colors.black,
                                  textColor: Colors.black,
                                  cursorColor: kDarkGoldColor,
                                  keyboardType: TextInputType.streetAddress,
                                  onChanged: (value){
                                    setState((){});
                                  },
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return "this field is required";
                                    }
                                  },
                                ),
                                SizedBox(height: 0),
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

                                BlocConsumer<CartCubit, CartState>(
                                  listener: (context, state) {
                                    // TODO: implement listener
                                  },
                                  builder: (context, state) {
                                    return cartCubit.allCitiesLocation != null
                                        ? Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              flex: 6,
                                              child:DropdownButtonFormField2<CountryList>(
                                                validator: (value){
                                                  if(value==null&& CartCubit.get(context).selectedCountry==null){
                                                    return 'this filed is required';
                                                  }
                                                },
                                                isExpanded: true,
                                                  onChanged: (value){
                                                    cartCubit.chooseCountry(
                                                                  value!);
                                                              countryId = value.id;
                                                              print(cartCubit
                                                                  .selectedCountry
                                                                  ?.refCode);
                                                              cityId = null;
                                                  },
                                                  dropdownSearchData:   DropdownSearchData(
                                                    searchController:
                                                    textEditingController,
                                                    searchInnerWidgetHeight:
                                                    50,
                                                    searchInnerWidget:
                                                    Container(
                                                      height: 50,
                                                      padding:
                                                      const EdgeInsets
                                                          .only(
                                                        top: 8,
                                                        bottom: 4,
                                                        right: 8,
                                                        left: 8,
                                                      ),
                                                      child: TextFormField(
                                                        expands: true,
                                                        maxLines: null,
                                                        controller:
                                                        textEditingController,
                                                        decoration:
                                                        InputDecoration(
                                                          isDense: true,
                                                          contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                            horizontal: 10,
                                                            vertical: 8,
                                                          ),
                                                          hintText:
                                                          'searchCountry'.tr(),
                                                          hintStyle:
                                                          const TextStyle(
                                                              fontSize:
                                                              12),
                                                          border:
                                                          OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                8),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    searchMatchFn: (item,
                                                        searchValue) {
                                                      return item
                                                          .value!.name
                                                          .toString()
                                                          .contains(
                                                          searchValue);
                                                    },
                                                  ),
                                                onMenuStateChange:
                                                    (isOpen){
                                                  if(!isOpen){
                                                    textEditingController.clear();
                                                  }
                                                },
                                                  hint:  Text(
                                                         cartCubit.selectedCountry?.name??"country".tr(),
                                                          style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Theme.of(context)
                                                                    .hintColor,
                                                          ),
                                                        ),
                                                  decoration: InputDecoration(
                                                    contentPadding: EdgeInsets.zero,
                                                    filled: true,
                                                    fillColor: Colors.grey.withOpacity(0.22),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(15.r),
                                                      borderSide: BorderSide(color:Colors.grey.withOpacity(0.2)),

                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(15.r),
                                                      borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),

                                                    ),
                                                    errorBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(15.r),
                                                      borderSide: BorderSide(color:Colors.grey.withOpacity(0.2)),

                                                    ),
                                                    border:  OutlineInputBorder(

                                                      borderRadius: BorderRadius.circular(15.r),
                                                      borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),

                                                    ),
                                                  ),
                                                  buttonStyleData:
                                                           ButtonStyleData(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 16.w),
                                                        height: 40.h,
                                                        width: 200.w,
                                                      ),
                                                      dropdownStyleData:
                                                           DropdownStyleData(
                                                        maxHeight: 200.h,
                                                      ),
                                                      menuItemStyleData:
                                                           MenuItemStyleData(
                                                        height: 30.h,
                                                      ),
                                                  items:  cartCubit
                                                        .allCitiesLocation!
                                                        .data!
                                                        .countryList!
                                                        .map((country) {
                                                      return DropdownMenuItem(
                                                        // alignment:
                                                        //     AlignmentDirectional
                                                        //         .topStart,
                                                        child: Text(
                                                          "${country.name}",
                                                          style: TextStyle(
                                                            fontSize: 14.sp,
                                                          ),
                                                        ),
                                                        value: country,
                                                      );
                                                    }).toList(),
                                              )


                                              //     DropdownButtonHideUnderline(
                                              //   child: DropdownButton2<
                                              //       CountryList>(
                                              //     isExpanded: true,
                                              //     hint: Text(
                                              //       "country".tr(),
                                              //       style: TextStyle(
                                              //         fontSize: 14,
                                              //         fontWeight:
                                              //             FontWeight.bold,
                                              //         color:
                                              //             Theme.of(context)
                                              //                 .hintColor,
                                              //       ),
                                              //     ),
                                              //     items: cartCubit
                                              //         .allCitiesLocation!
                                              //         .data!
                                              //         .countryList!
                                              //         .map((country) {
                                              //       return DropdownMenuItem(
                                              //         // alignment:
                                              //         //     AlignmentDirectional
                                              //         //         .topStart,
                                              //         child: Text(
                                              //           "${country.name}",
                                              //           style: TextStyle(
                                              //             fontSize: 14.sp,
                                              //           ),
                                              //         ),
                                              //         value: country,
                                              //       );
                                              //     }).toList(),
                                              //
                                              //     value: cartCubit
                                              //         .selectedCountry,
                                              //     onChanged:
                                              //         (CountryList? value) {
                                              //       cartCubit.chooseCountry(
                                              //           value!);
                                              //       countryId = value.id;
                                              //       print(cartCubit
                                              //           .selectedCountry
                                              //           ?.refCode);
                                              //       cityId = null;
                                              //     },
                                              //     buttonStyleData:
                                              //         const ButtonStyleData(
                                              //       padding: EdgeInsets
                                              //           .symmetric(
                                              //               horizontal: 16),
                                              //       height: 40,
                                              //       width: 200,
                                              //     ),
                                              //     dropdownStyleData:
                                              //         const DropdownStyleData(
                                              //       maxHeight: 200,
                                              //     ),
                                              //     menuItemStyleData:
                                              //         const MenuItemStyleData(
                                              //       height: 30,
                                              //     ),
                                              //     dropdownSearchData:
                                              //         DropdownSearchData(
                                              //       searchController:
                                              //           textEditingController,
                                              //       searchInnerWidgetHeight:
                                              //           50,
                                              //       searchInnerWidget:
                                              //           Container(
                                              //         height: 50,
                                              //         padding:
                                              //             const EdgeInsets
                                              //                 .only(
                                              //           top: 8,
                                              //           bottom: 4,
                                              //           right: 8,
                                              //           left: 8,
                                              //         ),
                                              //         child: TextFormField(
                                              //           expands: true,
                                              //           maxLines: null,
                                              //           controller:
                                              //               textEditingController,
                                              //           decoration:
                                              //               InputDecoration(
                                              //             isDense: true,
                                              //             contentPadding:
                                              //                 const EdgeInsets
                                              //                     .symmetric(
                                              //               horizontal: 10,
                                              //               vertical: 8,
                                              //             ),
                                              //             hintText:
                                              //                 'البحث عن الدولة....',
                                              //             hintStyle:
                                              //                 const TextStyle(
                                              //                     fontSize:
                                              //                         12),
                                              //             border:
                                              //                 OutlineInputBorder(
                                              //               borderRadius:
                                              //                   BorderRadius
                                              //                       .circular(
                                              //                           8),
                                              //             ),
                                              //           ),
                                              //         ),
                                              //       ),
                                              //       searchMatchFn: (item,
                                              //           searchValue) {
                                              //         return item
                                              //             .value!.name
                                              //             .toString()
                                              //             .contains(
                                              //                 searchValue);
                                              //       },
                                              //     ),
                                              //     //This to clear the search value when you close the menu
                                              //     onMenuStateChange:
                                              //         (isOpen) {
                                              //       if (!isOpen) {
                                              //         textEditingController
                                              //             .clear();
                                              //       }
                                              //     },
                                              //   ),
                                              // ),
                                              // CustomDropDown(
                                              //   validate: (value){
                                              //     if(value==null){
                                              //       return "country is required";
                                              //     }
                                              //   },
                                              //   fillColor:
                                              //   Colors.grey.shade500,
                                              //   hintColor: Colors.black,
                                              //   textColor: Colors.black,
                                              //   hintText: "country".tr(),
                                              //   items: CartCubit.get(context)
                                              //       .allCitiesLocation!
                                              //       .data!
                                              //       .countryList!
                                              //       .map((CountryList
                                              //           country) {
                                              //     return DropdownMenuItem(
                                              //       // alignment:
                                              //       //     AlignmentDirectional
                                              //       //         .topStart,
                                              //       child: Text("${country.name}",
                                              //       style: TextStyle(
                                              //         fontSize: 16.sp,
                                              //       ),),
                                              //       value: country,
                                              //     );
                                              //   }).toList(),
                                              //   value: CartCubit.get(context)
                                              //       .selectedCountry,
                                              //   onChanged:
                                              //       ( value) {
                                              //     CartCubit.get(context)
                                              //         .chooseCountry(value!);
                                              //     countryId = value.id;
                                              //     cityId = null;
                                              //   },
                                              // ),
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Expanded(
                                                flex: 4,
                                                child:DropdownButtonFormField2<ListCites>(
                                                  validator: (value){
                                                    if(value==null&& CartCubit.get(context).selectedCity==null){
                                                      return 'this filed is required';
                                                    }
                                                  },
                                                  isDense:true,
                                                  isExpanded: true,
                                                  onChanged: (value){
                                                    cartCubit.chooseCity(
                                                                  value!);
                                                              cityId = value.idCity;
                                                              print(cartCubit
                                                                  .selectedCity
                                                                  ?.nameCity);
                                                  },
                                                  dropdownSearchData:   DropdownSearchData(
                                                    searchController:
                                                    textEditingController,
                                                    searchInnerWidgetHeight:
                                                    45,
                                                    searchInnerWidget:
                                                    Container(
                                                      height: 50.h,
                                                      padding:
                                                       EdgeInsets
                                                          .only(
                                                        top: 8.r,
                                                        bottom: 4.r,
                                                        right: 8.r,
                                                        left: 8.r,
                                                      ),
                                                      child:
                                                      TextFormField(
                                                        expands: true,
                                                        maxLines: null,
                                                        controller:
                                                        textEditingController,
                                                        decoration:
                                                        InputDecoration(
                                                          isDense: true,
                                                          contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                            horizontal:
                                                            10,
                                                            vertical: 8,
                                                          ),
                                                          hintText:
                                                          'searchCity'.tr(),
                                                          hintStyle:
                                                          const TextStyle(
                                                              fontSize:
                                                              12),
                                                          border:
                                                          OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                8),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    searchMatchFn: (item,
                                                        searchValue) {
                                                      return item
                                                          .value!.nameCity
                                                          .toString()
                                                          .contains(
                                                          searchValue);
                                                    },
                                                  ),
                                                  onMenuStateChange:
                                                      (isOpen){
                                                    if(!isOpen){
                                                      textEditingController.clear();
                                                    }
                                                  },
                                                  // value: cartCubit.selectedCity,
                                                  hint:  Text(
                                                         cartCubit.selectedCity?.nameCity?? "city".tr(),
                                                          style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Theme.of(
                                                                    context)
                                                                .hintColor,
                                                          ),
                                                        ),
                                                  decoration: InputDecoration(
                                                    contentPadding: EdgeInsets.zero,
                                                    filled: true,
                                                    fillColor: Colors.grey.withOpacity(0.22),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(15.r),
                                                      borderSide: BorderSide(color:Colors.grey.withOpacity(0.2)),

                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(15.r),
                                                      borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),

                                                    ),
                                                    errorBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(15.r),
                                                      borderSide: BorderSide(color:Colors.grey.withOpacity(0.2)),

                                                    ),
                                                    border:  OutlineInputBorder(

                                                      borderRadius: BorderRadius.circular(15.r),
                                                      borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),

                                                    ),
                                                  ),
                                                    buttonStyleData:
                                                             ButtonStyleData(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      16.w),
                                                          height: 40.h,
                                                          width: 200.w,
                                                        ),
                                                        dropdownStyleData:
                                                        DropdownStyleData(
                                                          maxHeight: 200.h,
                                                        ),
                                                        menuItemStyleData:
                                                             MenuItemStyleData(
                                                          height: 40.h,
                                                        ),
                                                  items:  cartCubit
                                                          .allCities!
                                                          .map((country) {
                                                        return DropdownMenuItem(
                                                          // alignment:
                                                          //     AlignmentDirectional
                                                          //         .topStart,
                                                          child: Text(
                                                            "${country.nameCity}",
                                                            style: TextStyle(
                                                              fontSize: 14.sp,
                                                            ),
                                                          ),
                                                          value: country,
                                                        );
                                                      }).toList(),
                                                )
                                                //     DropdownButtonHideUnderline(
                                                //   child: DropdownButton2<
                                                //       ListCites>(
                                                //     isExpanded: true,
                                                //     hint: Text(
                                                //       "city".tr(),
                                                //       style: TextStyle(
                                                //         fontSize: 14,
                                                //         fontWeight:
                                                //             FontWeight.bold,
                                                //         color: Theme.of(
                                                //                 context)
                                                //             .hintColor,
                                                //       ),
                                                //     ),
                                                //     items: cartCubit
                                                //         .allCities!
                                                //         .map((country) {
                                                //       return DropdownMenuItem(
                                                //         // alignment:
                                                //         //     AlignmentDirectional
                                                //         //         .topStart,
                                                //         child: Text(
                                                //           "${country.nameCity}",
                                                //           style: TextStyle(
                                                //             fontSize: 14.sp,
                                                //           ),
                                                //         ),
                                                //         value: country,
                                                //       );
                                                //     }).toList(),
                                                //
                                                //     value: cartCubit
                                                //         .selectedCity,
                                                //     onChanged:
                                                //         (ListCites? value) {
                                                //       cartCubit.chooseCity(
                                                //           value!);
                                                //       cityId = value.idCity;
                                                //       print(cartCubit
                                                //           .selectedCity
                                                //           ?.nameCity);
                                                //     },
                                                //     buttonStyleData:
                                                //         const ButtonStyleData(
                                                //       padding: EdgeInsets
                                                //           .symmetric(
                                                //               horizontal:
                                                //                   16),
                                                //       height: 40,
                                                //       width: 200,
                                                //     ),
                                                //     dropdownStyleData:
                                                //         const DropdownStyleData(
                                                //       maxHeight: 200,
                                                //     ),
                                                //     menuItemStyleData:
                                                //         const MenuItemStyleData(
                                                //       height: 30,
                                                //     ),
                                                //     dropdownSearchData:
                                                //         DropdownSearchData(
                                                //       searchController:
                                                //           textEditingController,
                                                //       searchInnerWidgetHeight:
                                                //           50,
                                                //       searchInnerWidget:
                                                //           Container(
                                                //         height: 50,
                                                //         padding:
                                                //             const EdgeInsets
                                                //                 .only(
                                                //           top: 8,
                                                //           bottom: 4,
                                                //           right: 8,
                                                //           left: 8,
                                                //         ),
                                                //         child:
                                                //             TextFormField(
                                                //           expands: true,
                                                //           maxLines: null,
                                                //           controller:
                                                //               textEditingController,
                                                //           decoration:
                                                //               InputDecoration(
                                                //             isDense: true,
                                                //             contentPadding:
                                                //                 const EdgeInsets
                                                //                     .symmetric(
                                                //               horizontal:
                                                //                   10,
                                                //               vertical: 8,
                                                //             ),
                                                //             hintText:
                                                //                 'البحث عن المدينه...',
                                                //             hintStyle:
                                                //                 const TextStyle(
                                                //                     fontSize:
                                                //                         12),
                                                //             border:
                                                //                 OutlineInputBorder(
                                                //               borderRadius:
                                                //                   BorderRadius
                                                //                       .circular(
                                                //                           8),
                                                //             ),
                                                //           ),
                                                //         ),
                                                //       ),
                                                //       searchMatchFn: (item,
                                                //           searchValue) {
                                                //         return item
                                                //             .value!.nameCity
                                                //             .toString()
                                                //             .contains(
                                                //                 searchValue);
                                                //       },
                                                //     ),
                                                //     //This to clear the search value when you close the menu
                                                //     onMenuStateChange:
                                                //         (isOpen) {
                                                //       if (!isOpen) {
                                                //         textEditingController
                                                //             .clear();
                                                //       }
                                                //     },
                                                //   ),
                                                // )
                                                // CustomDropDown(
                                                //   validate: (value) {
                                                //     if (value == null) {
                                                //       return "city is required";
                                                //     }
                                                //   },
                                                //   fillColor:
                                                //       Colors.grey.shade500,
                                                //   hintColor: Colors.black,
                                                //   textColor: Colors.black,
                                                //   hintText: "city".tr(),
                                                //   items: CartCubit.get(
                                                //           context)
                                                //       .allCities!
                                                //       .map(
                                                //           (ListCites city) {
                                                //     return DropdownMenuItem(
                                                //       // alignment:
                                                //       //     AlignmentDirectional
                                                //       //         .topStart,
                                                //       child: Text(
                                                //         "${city.nameCity}",
                                                //         style: TextStyle(
                                                //             fontSize:
                                                //                 16.sp),
                                                //         maxLines: 2,
                                                //         overflow:
                                                //             TextOverflow
                                                //                 .ellipsis,
                                                //       ),
                                                //       value: city,
                                                //     );
                                                //   }).toList(),
                                                //   value:
                                                //       CartCubit.get(context)
                                                //           .selectedCity,
                                                //   onChanged: (value) {
                                                //     CartCubit.get(context)
                                                //         .chooseCity(value!);
                                                //     cityId = value.idCity;
                                                //   },
                                                // ),
                                                )
                                          ],
                                        )
                                        : Center(
                                            child: CircularProgressIndicator(),
                                          );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Text(
                      "FullName".tr(),
                      style: TextStyle(
                        color: kCustomBlack,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    CustomTextFormField(
                      controller: cartCubit.nameOfReceiver,
                      fillColor: Colors.grey.shade500,
                      hintColor: Colors.black,
                      textColor: Colors.black,
                      onChanged: (value){
                        setState((){});
                      },
                      cursorColor: kDarkGoldColor,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return ;
                        }
                      },
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    Text(
                      "Email".tr(),
                      style: TextStyle(
                        color: kCustomBlack,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    CustomTextFormField(
                      controller: cartCubit.email,
                      onChanged: (value){
                        setState(() {

                        });
                      },
                      fillColor: Colors.grey.shade500,
                      hintColor: Colors.black,
                      textColor: Colors.black,
                      cursorColor: kDarkGoldColor,
                      keyboardType: TextInputType.emailAddress,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "thisFieldIsRequired".tr();
                        }
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "postNumber".tr(),
                                style: TextStyle(
                                  color: kCustomBlack,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              CustomTextFormField(
                                controller: cartCubit.zibCode,
                                fillColor: Colors.grey.shade500,
                                hintColor: Colors.black,
                                textColor: Colors.black,
                                onChanged: (value){
                                  setState((){});
                                },
                                cursorColor: kDarkGoldColor,
                                keyboardType: TextInputType.phone,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return "thisFieldIsRequired".tr();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 5.w,),
                        Expanded(
                          flex: 2,
                          child:
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 0.h,),
                              Text(
                                "Phone".tr(),
                                style: TextStyle(
                                  color: kCustomBlack,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              IntlPhoneField(
                                showDropdownIcon: false,
                                controller: cartCubit.phoneOfReceiver,
                                textAlign: TextAlign.end,
                                keyboardType: TextInputType.phone,
                                disableLengthCheck: false,
                                flagsButtonPadding: EdgeInsets.symmetric(
                                    vertical: 10.h,
                                    horizontal:
                                    8.w),
                                style: TextStyle(
                                    color: kCustomBlack, fontFamily: 'Tajawal'),
                                dropdownDecoration: BoxDecoration(
                                  color: const Color(0xffE8E8E8),
                                  borderRadius: kLanguage != 'ar'
                                      ? BorderRadius.only(
                                    topLeft: Radius.circular(34),
                                    bottomLeft: Radius.circular(34),
                                  )
                                      : BorderRadius.only(
                                    topRight: Radius.circular(34),
                                    bottomRight: Radius.circular(34),
                                  ),
                                ),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 10.w),
                                    filled: true,
                                    fillColor: const Color(0xffE8E8E8),
                                    hintText: '56xxxxxxx',
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(34)),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(34)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(34))),
                                onChanged: (phone) {
                                  setState(() {

                                  });
                                  cartCubit.countryCode = phone.countryCode;
                                  log('${phone.completeNumber}');
                                  log('aaaaaaaaaaaaaaa${phone.countryCode}');
                                },
                                onSaved: (phone) {
                                  cartCubit.phoneOfReceiver.text = phone!.completeNumber;
                                },
                                invalidNumberMessage:
                                "pleaseEnterAValidMobileNumber".tr(),
                                initialCountryCode: 'SA',
                              )
                              // CustomTextFormField(
                              //   controller: cartCubit.phoneOfReceiver,
                              //   fillColor: Colors.grey.shade500,
                              //   hintColor: Colors.black,
                              //   textColor: Colors.black,
                              //   cursorColor: kDarkGoldColor,
                              //   suffix: Container(
                              //     width: 20.w,
                              //     decoration: BoxDecoration(
                              //       color: Colors.white,
                              //       borderRadius: BorderRadius.circular(20.r)
                              //     ),
                              //
                              //       child: Center(child: Text('966+'))),
                              //   keyboardType: TextInputType.phone,
                              //   validate: (value) {
                              //     if (value!.isEmpty) {
                              //       return "thisFieldIsRequired".tr();
                              //     }
                              //
                              //     else if(value.length!=9){
                              //       return 'يجب ادخال رقم جوال صحيح';
                              //     }
                              //   },
                              // ),
                            ],
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
                      child: StatefulBuilder(
                        builder: (context, setState) => Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Radio<PaymentMethod>(
                                  value: PaymentMethod.offlinePayment,
                                  groupValue: paymentMethod,
                                  fillColor: MaterialStateProperty.all<Color>(
                                      kDarkGoldColor),
                                  onChanged: (PaymentMethod? value) {},
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text('PayWhenReceive'.tr(),style: TextStyle(
                                  fontSize: 10.sp
                                ),),
                              ],
                            ),
                            Row(
                              children: [
                                Radio<PaymentMethod>(
                                  value: PaymentMethod.onlinePayment,
                                  groupValue: paymentMethod,
                                  onChanged: (value) {
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
                                  width: 16.w,
                                ),
                                Text('PayOnline'.tr(),style: TextStyle(
                                  fontSize: 13.sp
                                ),),
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
                    // Visibility(visible: false, child: Divider()),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // PromoCodeTextField(),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // if (widget.giftInCart != 0) Text('code2'.tr()),
                    // if (widget.giftInCart != 0)
                    //   SizedBox(
                    //     height: 10,
                    //   ),
                    // if (widget.giftInCart != 0)
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
                    // if (widget.cashInCart != 0) Text('cashBack'.tr()),
                    // if (widget.cashInCart != 0)
                    //   SizedBox(
                    //     height: 10,
                    //   ),
                    // if (widget.cashInCart != 0)
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Label(
                          text: 'Total'.tr(),
                        ),
                        Text(
                          '${cartCubit.newOrder?.data?.order?.subTotal} ${"SAR".tr()}',
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    BlocConsumer<CartCubit, CartState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        print("00000Abdooooo${cartCubit.newOrder?.data?.order?.total}");
                        return PaymentComponent(
                          total:
                              num.parse(cartCubit.newOrder?.data?.order?.total ?? ''),
                          cartId: cartCubit.newOrder?.data?.order?.id ?? '',
                          phone: '${cartCubit.countryCode}${cartCubit.phoneOfReceiver.text}',
                          name: cartCubit.nameOfReceiver.text,
                          address: cartCubit.addressOfReceiver.text,
                          country: cartCubit.selectedCountry,
                          city: cartCubit.selectedCity,
                          zipCode: cartCubit.zibCode.text,
                          email: cartCubit.email.text,
                        );
                      },
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    // SizedBox(
                    //   height: 30,
                    // ),
                    // CustomButton(
                    //   onTap: () {
                    //     print("Ss");
                    //     globalKey.currentState!.validate();
                    //     // if (nameOfReceiver.text.isNotEmpty &&
                    //     //     phoneOfReceiver.text.isNotEmpty &&
                    //     //     addressOfReceiver.text.isNotEmpty)
                    //     //   navigateTo(
                    //     //       context,
                    //     //       NewDetailsOrderAfter(
                    //     //         subTotal: cartCubit.total.toInt(),
                    //     //         cityId: cityId!,
                    //     //         countryId: countryId!,
                    //     //         promoCodeId:
                    //     //             CacheHelper.getData('couponId') == null
                    //     //                 ? 0
                    //     //                 : int.parse(
                    //     //                     CacheHelper.getData('couponId')),
                    //     //         promoCodeValue:
                    //     //             CacheHelper.getData('couponValue') == null
                    //     //                 ? 0
                    //     //                 : int.parse(
                    //     //                     CacheHelper.getData('couponValue')),
                    //     //         name: nameOfReceiver.text,
                    //     //         phone: phoneOfReceiver.text,
                    //     //         address: addressOfReceiver.text,
                    //     //         gift: widget.code2.text,
                    //     //         cash: widget.code3.text,
                    //     //       ));
                    //     // if (addressOfReceiver.text.isEmpty) {
                    //     //   showToast(
                    //     //       text: "pleaseEnterTheAddress".tr(),
                    //     //       color: Colors.red,
                    //     //       location: ToastGravity.CENTER);
                    //     // } else if (nameOfReceiver.text.isEmpty) {
                    //     //   showToast(
                    //     //       text: "pleaseEnterTheName".tr(),
                    //     //       color: Colors.red,
                    //     //       location: ToastGravity.CENTER);
                    //     // } else if (phoneOfReceiver.text.isEmpty) {
                    //     //   showToast(
                    //     //       text: "pleaseEnterYourMobileNumber".tr(),
                    //     //       color: Colors.red,
                    //     //       location: ToastGravity.CENTER);
                    //     // } else if (countryId == null) {
                    //     //   showToast(
                    //     //       text: "pleaseSelectTheCountry".tr(),
                    //     //       color: Colors.red,
                    //     //       location: ToastGravity.CENTER);
                    //     // } else if (cityId == null) {
                    //     //   showToast(
                    //     //       text: "pleaseSelectACity".tr(),
                    //     //       color: Colors.red,
                    //     //       location: ToastGravity.CENTER);
                    //     // } else {
                    //     //   cartCubit.make_order(
                    //     //       payment_status:
                    //     //           paymentMethod == PaymentMethod.offlinePayment
                    //     //               ? 1
                    //     //               : 0,
                    //     //       payment_type:
                    //     //           paymentMethod == PaymentMethod.offlinePayment
                    //     //               ? 1
                    //     //               : 0,
                    //     //       deliveryType:
                    //     //           receiveMethod == ReceiveMethod.fromHome ? 0 : 1,
                    //     //       address: addressOfReceiver.text,
                    //     //       name: nameOfReceiver.text,
                    //     //       phone: phoneOfReceiver.text,
                    //     //       orderPrice: cartCubit.total,
                    //     //       countryId: countryId!,
                    //     //       cityId: cityId!,
                    //     //       context: context);
                    //     // }
                    //   },
                    //   height: 50,
                    //   text: 'Next'.tr(),
                    // ),
                    // SizedBox(
                    //   height: 30,
                    // )
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
              // height: 50,
              decoration: BoxDecoration(
                color: Color(0xfff3f3f3),
                border: Border.all(color: Colors.black26, width: 0.3),
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextFormField(
                controller: CartCubit.get(context).promoCode,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 22.w, vertical: 15.h),
                  suffixIcon: InkWell(
                    onTap: () {
                      if (CartCubit.get(context).promoCode.text.isNotEmpty&&CartCubit.get(context).isCopunValid!=true) {
                        CartCubit.get(context).checkPromoStatus();
                      }else if(CartCubit.get(context).isCopunValid==true){
                        CartCubit.get(context).cancelPromoCode();
                      }
                    },
                    child: Container(
                      width: 90.w,

                      child: Center(
                        child: state is CheckPromoLoadingState
                            ? CustomCircularProgress()
                            : CartCubit.get(context).isCopunValid==true
                                ? Text(
                                    'الغاء التفعيل',
                                    style: TextStyle(color: kLightGoldColor),
                                  )
                                : Text(
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
                style: TextStyle(color: Colors.black,fontSize: 10.sp),
              ),
            ),
            if (CartCubit.get(context).isCopunValid != null)
              Text(
                CartCubit.get(context).isCopunValid!
                    ? "validCoupon".tr()
                    : "invalidCoupon".tr(),
                style: TextStyle(
                  fontSize: 12.sp,
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
