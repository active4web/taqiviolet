import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart ';
import 'package:flutter/material.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/appCubit/app_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/screens/send_a_gift_screen.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/components/custom_form_field.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:safsofa/shared/components/custom_location_picker.dart';
import 'package:safsofa/shared/components/custom_text_form_field.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';

import '../cubits/cartCubit/cart_cubit.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ReceiveMethod receiveMethod = ReceiveMethod.fromHome;
    PaymentMethod paymentMethod = PaymentMethod.offlinePayment;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        CartCubit cartCubit = CartCubit.get(context);
        return Scaffold(key:cartCubit.scaffoldkey ,
          appBar: CustomAppBar(
            title: 'CheckOut'.tr(),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      navigateTo(context, SendAGiftScreen());

                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      color: Color(0xfff3f3f3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_circle,
                            color: Colors.black54,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'sendagift'.tr(),
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Label(
                    text: 'SelectReceiveWay'.tr(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  StatefulBuilder(
                    builder: (context, setState) =>
                        Column(
                          children: [
                            Row(
                              children: [
                                Radio<ReceiveMethod>(
                                  value: ReceiveMethod.fromHome,
                                  groupValue: receiveMethod,
                                  onChanged: (ReceiveMethod value) {
                                    print(value);
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
                            Row(
                              children: [
                                Radio<ReceiveMethod>(
                                  fillColor: MaterialStateProperty.all<Color>(
                                      kDarkGoldColor),
                                  value: ReceiveMethod.fromStore,
                                  groupValue: receiveMethod,
                                  onChanged: (ReceiveMethod value) {
                                    setState(() {
                                      receiveMethod = value;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text('ReceiveFromStore'.tr()),
                              ],
                            ),
                          ],
                        ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Label(
                    text: 'ChooseLocation'.tr(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  cubit.address != null
                      ? ListTile(
                    tileColor: Color(0xfff3f3f3),
                    leading: Icon(
                      Icons.location_on_outlined,
                      color: kDarkGoldColor,
                      size: 25,
                    ),
                    title: Text(
                      cubit.address ?? '',
                      style:
                      TextStyle(fontSize: 15, color: Colors.black54),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        cubit.address = null;
                        cubit.emit(PickLocationSuccess());
                      },
                      child: Icon(
                        Icons.remove_circle,
                        color: Colors.black54,
                      ),
                    ),
                  )
                      : SizedBox(),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      navigateTo(context, LocationPickerScreen());
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      color: Color(0xfff3f3f3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_circle,
                            color: Colors.black54,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'AddLocation'.tr(),
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  Label(
                    text: 'ChoosePaymentMethod'.tr(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  StatefulBuilder(
                    builder: (context, setState) =>
                        Column(
                          children: [
                            Row(
                              children: [
                                Radio<PaymentMethod>(
                                  value: PaymentMethod.offlinePayment,
                                  groupValue: paymentMethod,
                                  onChanged: (PaymentMethod value) {
                                    setState(() {
                                      paymentMethod = value;
                                    });
                                  },
                                  fillColor: MaterialStateProperty.all<Color>(
                                      kDarkGoldColor),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text('PayWhenReceive'.tr()),
                              ],
                            ),
                            Row(
                              children: [
                                Radio<PaymentMethod>(
                                  value: PaymentMethod.onlinePayment,
                                  groupValue: paymentMethod,
                                  onChanged: (PaymentMethod value) {
                                    setState(() {
                                      paymentMethod = value;
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
                  SizedBox(
                    height: 10,
                  ),
                  Divider(),
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
                  CustomButton(onTap: () {
                    cartCubit.make_order(address_id:1, address_save:0,
                        payment_status: paymentMethod ==
                            PaymentMethod.offlinePayment ? 1 : 0,
                        payment_type: receiveMethod ==
                            ReceiveMethod.fromHome ? 1 : 0,
                        sub_total: cartCubit.total,context: context);
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
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xfff3f3f3),
        border: Border.all(color: Colors.black26, width: 0.3),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 22,
              ),
              suffixIcon: Container(
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
              hintTextDirection: TextDirection.rtl),
          style: TextStyle(color: Colors.black)),
    );
  }
}

enum ReceiveMethod { fromHome, fromStore }
enum PaymentMethod { onlinePayment, offlinePayment }
