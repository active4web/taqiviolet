import 'package:flutter/material.dart%20';
import '../cubits/cartCubit/cart_cubit.dart';
import '../cubits/cartCubit/cart_state.dart';
import '../shared/components/custom_app_bar.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../shared/components/custom_button.dart';
import '../shared/components/custom_text_form_field.dart';
import '../shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewDetailsOrderAfter extends StatelessWidget {
  const NewDetailsOrderAfter({Key? key, required this.subTotal, required this.cityId, required this.countryId, required this.promoCodeId, required this.phone, required this.name, required this.address, required this.gift, required this.cash, required this.promoCodeValue,}) : super(key: key);

  final int subTotal;
  final int cityId;
  final int countryId;
  final int promoCodeId;
  final int promoCodeValue;
  final String phone;
  final String name;
  final String address;
  final String gift;
  final String cash;
  @override
  Widget build(BuildContext context) {
    print(subTotal);
    print(cityId);
    print(countryId);
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        CartCubit cubit = CartCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            title: 'orderDetails2'.tr(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "cashback".tr(),
                  style: TextStyle(
                    color: kCustomBlack,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                CustomTextFormField(
                  readOnly: true,
                  hintText: cash.isEmpty ? "0" : "${cash}",
                  fillColor: Colors.grey.shade500,
                  hintColor: Colors.black,
                  textColor: Colors.black,
                  cursorColor: kDarkGoldColor,
                  keyboardType: TextInputType.phone,
                  validate: (value) {},
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "wallet".tr(),
                  style: TextStyle(
                    color: kCustomBlack,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                CustomTextFormField(
                  readOnly: true,
                  hintText: gift.isEmpty ? "0" : "${gift}",
                  fillColor: Colors.grey.shade500,
                  hintColor: Colors.black,
                  textColor: Colors.black,
                  cursorColor: kDarkGoldColor,
                  keyboardType: TextInputType.phone,
                  validate: (value) {},

                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "coupons".tr(),
                  style: TextStyle(
                    color: kCustomBlack,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                CustomTextFormField(
                  readOnly: true,
                  hintText: "${promoCodeValue}",
                  fillColor: Colors.grey.shade500,
                  hintColor: Colors.black,
                  textColor: Colors.black,
                  cursorColor: kDarkGoldColor,
                  keyboardType: TextInputType.phone,
                  validate: (value) {},

                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Total".tr(),
                  style: TextStyle(
                    color: kCustomBlack,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                CustomTextFormField(
                  readOnly: true,
                  hintText: "${subTotal}",
                  fillColor: Colors.grey.shade500,
                  hintColor: Colors.black,
                  textColor: Colors.black,
                  cursorColor: kDarkGoldColor,
                  keyboardType: TextInputType.phone,
                  validate: (value) {},

                ),
                SizedBox(
                  height: 20,
                ),
                ConditionalBuilder(
                  condition: state is ! MakeOrderLoadingStateNew,
                  fallback: (context){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  builder: (context){
                    return CustomButton(
                      onTap: () {
                        print("Ss");
                        cubit.makeOrderDetails(
                          paymentStatus: 1,
                          paymentType: 1,
                          subTotal: subTotal,
                          countryId: countryId,
                          cityId: cityId,
                          promoCodeId: promoCodeId,
                          phone: phone,
                          name: name,
                          address: address,
                          deliveryType: 1,
                          cashBack: cash ,
                          totalGift: gift, context: context,
                        );
                        // navigateTo(context, NewDetailsOrderAfter());

                      },
                      height: 50,
                      text: 'CheckOut'.tr(),
                    );
                  },
                ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),

        );
      },
    );
  }
}
