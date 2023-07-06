import 'package:flutter/material.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/services.dart';
import 'package:safsofa/cubits/gify_cubit/gift_cubit.dart';
import 'package:safsofa/screens/header_my_account/widget/custom_text_form_field.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:safsofa/shared/components/custom_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GiftBalanceScreen extends StatelessWidget {
  GiftBalanceScreen({Key? key}) : super(key: key);
  final TextEditingController emailForRecipientController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GiftCubit, GiftState>(
      listener: (context, state) {},
      builder: (context, state) {
        GiftCubit cubit = GiftCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 2.0,
            centerTitle: true,
            title: Text('wallet'.tr(),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark),
          ),
          body: Padding(
            padding: EdgeInsets.all(20),
            child: ListView.separated(
              itemBuilder: (context, index) {
                return Container(
                  child: CustomNetworkImage(
                    image: 'https://thumbs.dreamstime.com/z/fields-meadows-indan-forming-field-indan-imag-feald-indian-image-forming-170966228.jpg',
                    border: BorderRadius.all(Radius.circular(10)),
                    height: 180,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 15,
                );
              },
              itemCount: 10,
            ),
          ),

          // اسكرينه الدفع

          // appBar: AppBar(
          //   backgroundColor: Colors.white,
          //   elevation: 2.0,
          //   centerTitle: true,
          //   title: Text('giftCard'.tr(),
          //       style: TextStyle(
          //           color: Colors.black,
          //           fontSize: 18,
          //           fontWeight: FontWeight.bold)),
          //   leading: IconButton(
          //     icon: Icon(
          //       Icons.arrow_back_ios,
          //       color: Colors.black,
          //     ),
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //   ),
          //   systemOverlayStyle: SystemUiOverlayStyle(
          //       statusBarColor: Colors.white,
          //       statusBarIconBrightness: Brightness.dark),
          //   actions: [
          //     Container(
          //       decoration: BoxDecoration(
          //         border: Border.all(color: Colors.black),
          //         shape: BoxShape.circle,
          //       ),
          //       child: Padding(
          //         padding: const EdgeInsets.all(1.0),
          //         child: Icon(
          //           Icons.question_mark,
          //           color: Colors.black,
          //         ),
          //       ),
          //     ),
          //     SizedBox(
          //       width: 5,
          //     ),
          //   ],
          // ),

          // body: Form(
          //   key: _formKey,
          //   child: SingleChildScrollView(
          //     physics: BouncingScrollPhysics(),
          //     child: Padding(
          //       padding: const EdgeInsets.all(10.0),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Padding(
          //             padding:
          //                 EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //             child: CustomNetworkImage(
          //               image:
          //                   'https://thumbs.dreamstime.com/z/fields-meadows-indan-forming-field-indan-imag-feald-indian-image-forming-170966228.jpg',
          //               border: BorderRadius.all(Radius.circular(10)),
          //               height: 180,
          //             ),
          //           ),
          //           SizedBox(
          //             height: 10,
          //           ),
          //           Row(
          //             children: [
          //               Text(
          //                 'electronicGiftCard'.tr(),
          //                 style: TextStyle(
          //                   color: Colors.black,
          //                   fontSize: 16,
          //                 ),
          //                 textAlign: TextAlign.start,
          //               ),
          //               SizedBox(width: 5),
          //               Text(
          //                 'SHEIN',
          //                 style: TextStyle(
          //                   color: Colors.black,
          //                   fontSize: 16,
          //                 ),
          //                 textAlign: TextAlign.start,
          //               ),
          //             ],
          //           ),
          //           SizedBox(
          //             height: 10,
          //           ),
          //           Text(
          //             ' 225.31 ${'rS'.tr()}',
          //             style: TextStyle(
          //               color: Colors.black,
          //               fontSize: 18,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //           SizedBox(
          //             height: 10,
          //           ),
          //           /*Text(
          //             'theDesign'.tr(),
          //             style: TextStyle(
          //               color: Colors.black,
          //               fontSize: 16,
          //             ),
          //             textAlign: TextAlign.start,
          //           ),
          //           SizedBox(
          //             height: 5,
          //           ),*/
          //         /*  GiftBalanceDesignImageComponent(),*/
          //      /*     SizedBox(
          //             height: 20,
          //           ),*/
          //          /* Text(
          //             'theAmount'.tr(),
          //             style: TextStyle(
          //               color: Colors.black,
          //               fontSize: 16,
          //             ),
          //             textAlign: TextAlign.start,
          //           ),
          //           SizedBox(
          //             height: 5,
          //           ),
          //           //ToDo
          //           GiftBalanceAmountPriceComponent(),*/
          //      /*     SizedBox(
          //             height: 20,
          //           ),*/
          //           Label(
          //             text: 'to'.tr(),
          //           ),
          //           CustomTextFormField(
          //             controller: emailForRecipientController,
          //             text: 'enterTheRecipientEmailAddress'.tr(),
          //           ),
          //           SizedBox(
          //             height: 15,
          //           ),
          //           Label(
          //             text: 'from'.tr(),
          //           ),
          //           CustomTextFormField(
          //             controller: nameController,
          //             text: 'enterYourName'.tr(),
          //           ),
          //           SizedBox(
          //             height: 15,
          //           ),
          //           Label(
          //             text: 'typeYourMessage'.tr(),
          //           ),
          //           CustomTextFormField(
          //             controller: messageController,
          //             text: 'validateMessage'.tr(),
          //           ),
          //           SizedBox(
          //             height: 15,
          //           ),
          //           Row(
          //             children: [
          //               Transform.scale(
          //                 scale: 1,
          //                 child: Checkbox(
          //                   activeColor: Colors.green,
          //                   value: cubit.isSelectedCheck,
          //                   onChanged: (bool? value) {
          //                     cubit.changedSelectedCheck(value: value!);
          //                     print(cubit.isSelectedCheck);
          //                   },
          //                   shape: const CircleBorder(
          //                     side: BorderSide(color: Colors.grey),
          //                   ),
          //                 ),
          //               ),
          //               SizedBox(
          //                 width: 3,
          //               ),
          //               Expanded(
          //                   child: Text(
          //                 'checkBoxGiftCard'.tr(),
          //               )),
          //             ],
          //           ),
          //           SizedBox(
          //             height: 15,
          //           ),
          //           CustomButton(
          //             onTap: () {
          //               if (_formKey.currentState!.validate()) {
          //                 print('object');
          //               } else {
          //                 print('yes');
          //               }
          //             },
          //             height: 50,
          //             text: 'payingOff'.tr(),
          //           ),
          //           SizedBox(
          //             height: 15,
          //           ),
          //           Text(
          //             'kljhjkhjhjjjjfjidh jhfkjsdnlkf jkjkhjhkjh hiui fgdfgd dfd',
          //             style: TextStyle(
          //               color: Colors.grey,
          //               fontSize: 16,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        );
      },
    );
  }
}
