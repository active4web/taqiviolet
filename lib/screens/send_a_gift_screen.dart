
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/src/public_ext.dart';
import '../cubits/cartCubit/cart_cubit.dart';
import '../cubits/cartCubit/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components/custom_app_bar.dart';
import '../shared/components/custom_button.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
class SendAGiftScreen extends StatefulWidget {
  const SendAGiftScreen({Key key}) : super(key: key);

  @override
  _SendAGiftScreenState createState() => _SendAGiftScreenState();
}
Uint8List _imageFile;
ScreenshotController screenshotController = ScreenshotController();
class _SendAGiftScreenState extends State<SendAGiftScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController city = TextEditingController();
    TextEditingController addres = TextEditingController();
    TextEditingController vido = TextEditingController();
    TextEditingController massge = TextEditingController();
    bool addname = false;

    var qrImage  ;
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        // TODO: implement listener
      },
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
                  customwidget(label: 'city'.tr(), controler: city),
                  SizedBox(
                    height: 10,
                  ),
                  customwidget(label: 'address'.tr(), controler: addres),
                  SizedBox(
                    height: 10,
                  ),
                  customwidget(label: 'link'.tr(), controler: vido),
                  SizedBox(
                    height: 10,
                  ),
                  customwidget(label: 'Comment'.tr(), controler: massge),
                  SizedBox(
                    height: 10,
                  ),
                  // ListTile(
                  //     title: Text("addname".tr()),
                  //     leading: Checkbox(
                  //       value: addname,
                  //       onChanged: (v) {
                  //         addname = v;
                  //         setState(() {
                  //
                  //         });
                  //       },
                  //     )),
                  SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    onTap: () {
                      _popUpMenu( context: context,phone: phone,name: name,addname: addname,addres: addres,cartCubit: cartCubit,massge: massge,vido: vido);

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

  Widget customwidget({label, controler}) {
    return TextFormField(
      controller: controler,
      decoration: InputDecoration(
        label: Text(label),
        border: OutlineInputBorder(),
        hintText: label,
      ),
    );
  }

  _popUpMenu({context, name, massge, phone, addres, vido, addname,cartCubit}) {
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
                Container(width: 200, height: 200,
                    child: Screenshot(
                      controller: screenshotController,
                      child: QrImage(data: vido.text, version: QrVersions.auto, size: 180),
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("To : ${name.text}"),
                ),
                Text(" ${massge.text}"),
              ]),
            ),actions: [
            CustomButton(
              onTap: ()async {

             cartCubit.sendgiftCards(phone: phone.text,address: addres.text,context: context,link: vido.text,message: massge.text,receiver: name.text,type: addname==true?1:0 );
             screenshotController.capture().then((Uint8List image)async {
               //Capture Done
               if (image != null)  {
                 final directory = await getApplicationDocumentsDirectory();
                 final imagePath = await File('${directory.path}/image.png').create();
                 await imagePath.writeAsBytes(image);
                 for(int i=0;i<2;i++ ){

                   Navigator.pop(context);
                 }
               }


             }).catchError((onError) {
               print(onError);
             });


              },
              height: 50,
              text: 'Send'.tr(),
            ),SizedBox(height: 8,),
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





}
