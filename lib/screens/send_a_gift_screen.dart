import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:safsofa/shared/constants.dart';
import '../cubits/cartCubit/cart_cubit.dart';
import '../cubits/cartCubit/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components/custom_app_bar.dart';
import '../shared/components/custom_button.dart';

class SendAGiftScreen extends StatefulWidget {
  final int orderId;
  const SendAGiftScreen({Key key,@required this.orderId}) : super(key: key);

  @override
  _SendAGiftScreenState createState() => _SendAGiftScreenState();
}

class _SendAGiftScreenState extends State<SendAGiftScreen> {
  bool showSenderName = true;
  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController qrData = TextEditingController();
    TextEditingController massge = TextEditingController();
    GlobalKey qrKey = GlobalKey();

    // var qrImage;
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {},
      builder: (context, state) {
        CartCubit cartCubit = CartCubit.get(context);
        return Scaffold(
          appBar: CustomAppBar(
            title: 'sendagift'.tr(),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  //    QrImage(data: "uuuuuu",size: 200,),
                  SizedBox(
                    height: 10,
                  ),
                  customwidget(label: 'name'.tr(), controler: name),
                  SizedBox(
                    height: 10,
                  ),
                  customwidget(label: 'Phone'.tr(), controler: phone),
                  SizedBox(
                    height: 10,
                  ),
                  customwidget(label: 'link'.tr(), controler: qrData),
                  SizedBox(
                    height: 10,
                  ),
                  customwidget(
                      label: 'Comment'.tr(), controler: massge, minLines: 5),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                          value: showSenderName,
                          activeColor: kDarkGoldColor,
                          onChanged: (value) {
                            setState(() {
                              showSenderName = !showSenderName;
                            });
                          }),
                      Text(
                        "showSenderName".tr(),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 19,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    onTap: () {
                      _popUpMenu(
                        context: context,
                        phone: phone.text,
                        name: name.text,
                        addname: showSenderName,
                        cartCubit: cartCubit,
                        massge: massge.text,
                        qrData: qrData.text,
                        orderId: widget.orderId,
                        qrKey: qrKey,
                      );

                      // _generateBarCode("jjjj",bytes).then((value) {
                      //
                      // });

                      //   cartCubit.sendgiftCards(phone: phone.text,address: addres.text,context: context,link: vido.text,message: massge.text,receiver: name.text,type: addname==true?1:0 );
                    },
                    height: 50,
                    text: 'preview'.tr(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget customwidget({label, controler, int minLines}) {
    return TextFormField(
      controller: controler,
      minLines: minLines,
      maxLines: null,
      decoration: InputDecoration(
        label: Text(label),
        border: OutlineInputBorder(),
        hintText: label,
      ),
    );
  }

  _popUpMenu(
      {context,
      String name,
      String massge,
      String phone,
      String qrData,
      int orderId,
      Key qrKey,
      addname,
      CartCubit cartCubit}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Image(
              image: AssetImage(
                'assets/images/logo.png',
              ),
            ),
            content: SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("gift card"),
                ),
                Container(
                    width: 200,
                    height: 200,
                    child: RepaintBoundary(
                      key: qrKey,
                      child: QrImage(
                          data: qrData, version: QrVersions.auto, size: 180),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("To : ${name}"),
                ),
                Text(" ${massge}"),
              ]),
            ),
            actions: [
              CustomButton(
                onTap: () {
                  cartCubit.sendgiftCards(
                      phone: phone,
                      context: context,
                      qrKey: qrKey,
                      qrData: qrData,
                      message: massge,
                      receiver: name,
                      orderId: orderId,
                      type: addname == true ? 1 : 0);

                  for (int i = 0; i < 2; i++) {
                    Navigator.pop(context);
                  }
                },
                height: 50,
                text: 'Send'.tr(),
              ),
              SizedBox(
                height: 8,
              ),
              CustomButton(
                onTap: () {
                  Navigator.pop(context);
                },
                height: 50,
                text: 'Modify'.tr(),
              ),
            ],
          );
        });
  }

  // Future _generateBarCode(String inputCode, qrImage) async {
  //   final qrCode = QrCode(4, QrErrorCorrectLevel.L)
  //     ..addData('Hello, world in QR form!');
  //   //   qrImage = QrImage(qrCode);
  // }
}
