import 'package:flutter/material.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/services.dart';
import 'package:safsofa/cubits/gify_cubit/gift_cubit.dart';
import 'package:safsofa/screens/header_my_account/widget/custom_text_form_field.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:safsofa/shared/components/custom_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:safsofa/shared/constants.dart';

import '../../network/local/cache_helper.dart';

class GiftBalanceScreen extends StatefulWidget {
  GiftBalanceScreen({Key? key}) : super(key: key);

  @override
  State<GiftBalanceScreen> createState() => _GiftBalanceScreenState();
}

class _GiftBalanceScreenState extends State<GiftBalanceScreen> {
  final TextEditingController emailForRecipientController =
      TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController messageController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
@override
  void initState() {
  GiftCubit.get(context).getAllListGiftsWalletData();
  GiftCubit.get(context).getAllListGiftsWalletDataOld();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  print(CacheHelper.getData('token'));
    return BlocConsumer<GiftCubit, GiftState>(
      listener: (context, state) {
        if(state is DeleteGiftsWalletSuccessStateOld){
          GiftCubit.get(context).getAllListGiftsWalletData();
          GiftCubit.get(context).getAllListGiftsWalletDataOld();
        }
      },
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
          body: ConditionalBuilder(
            condition: state is! GetAllListGiftsWalletLoadingState && state is ! GetAllListGiftsWalletLoadingStateOld ,
            fallback: (context) => Center(child: RefreshProgressIndicator()),
            builder: (context){
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            cubit.changePageIndex(cubit.index=1);
                          },
                          child: Container(
                            height: 30,
                            color: cubit.index==1 ? kCustomBlack : Colors.transparent,
                            child: Center(
                              child: Text("الحالى",
                                style: TextStyle(
                                  color: cubit.index==1 ? Colors.white : Colors.black87,
                                ),),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            cubit.changePageIndex(cubit.index=2);
                          },
                          child: Container(
                            height: 30,
                            color: cubit.index==2 ? kCustomBlack : Colors.transparent,
                            child: Center(
                              child: Text("القديم",
                                style: TextStyle(
                                  color: cubit.index==2 ? Colors.white : Colors.black87,
                                ),),
                            ),
                          ),
                        ),
                      ),

                      // ,
                      // Text("القديم"),
                    ],
                  ),
                  if(cubit.index==1)
                    Expanded(
                      child: ConditionalBuilder(
                        condition: state is! GetAllListGiftsWalletLoadingState,
                        fallback: (context) => Center(child: RefreshProgressIndicator()),
                        builder:(context){
                          return Padding(
                            padding: EdgeInsets.all(20),
                            child:
                            cubit.newListGiftsWalletModel!.data!.listgiftwallets!.length==0 ?
                                Center(child: Text(" لا يوجد هدايا حاليا",
                                style: TextStyle(
                                  fontSize: 25,
                                ),),):
                            ListView.separated(
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      CustomNetworkImage(
                                        image: '${cubit.newListGiftsWalletModel!.data!.listgiftwallets![index].image}',
                                        border: BorderRadius.all(Radius.circular(10)),
                                        height: 160,
                                        width: double.infinity,
                                      ),
                                      SizedBox(height: 10,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text("price".tr() ,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),),
                                                  Text(" : ${cubit.newListGiftsWalletModel!.data!.listgiftwallets![index].price}",
                                                    style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text("value".tr() ,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),),
                                                  Text(" : ${cubit.newListGiftsWalletModel!.data!.listgiftwallets![index].price}",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                    ),),
                                                ],
                                              ),

                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("sender".tr() ,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),),
                                              Text(" : ${cubit.newListGiftsWalletModel!.data!.listgiftwallets![index].name}",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),),
                                            ],
                                          ),
                                          Text("${cubit.newListGiftsWalletModel!.data!.listgiftwallets![index].message}"*10,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10,),
                                  child: Container(
                                    height: 1,
                                    color: Colors.grey,
                                    width: double.infinity,
                                  ),
                                );
                              },
                              itemCount: cubit.newListGiftsWalletModel!.data!.listgiftwallets!.length,
                            ),
                          );
                        },
                      ),
                    ),
                  if(cubit.index==2)
                    Expanded(child: ConditionalBuilder(
                      condition: state is! GetAllListGiftsWalletLoadingStateOld && cubit.newListGiftsWalletModelOld!.data!=null,
                      fallback: (context) => Center(child: RefreshProgressIndicator()),
                      builder:(context){
                        return Padding(
                          padding: EdgeInsets.all(20),
                          child:
                          cubit.newListGiftsWalletModelOld!.data!.listgiftwallets!.length==0 ?
                          Center(child: Text(" لا يوجد هدايا حاليا",
                            style: TextStyle(
                              fontSize: 25,
                            ),),):
                          ListView.separated(
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        CustomNetworkImage(
                                          image: '${cubit.newListGiftsWalletModelOld!.data!.listgiftwallets![index].image}',
                                          border: BorderRadius.all(Radius.circular(10)),
                                          height: 160,
                                          width: double.infinity,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.circular(100),
                                            ),
                                            child: InkWell(
                                              onTap: (){
                                                cubit.deleteGiftsWalletDataOld(
                                                  id: cubit.newListGiftsWalletModelOld!.data!.listgiftwallets![index].iD!,
                                                );
                                              },
                                              child: Center(
                                                child: Icon(Icons.close,color: Colors.white,),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text("price".tr() ,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),),
                                                Text(" : ${cubit.newListGiftsWalletModelOld!.data!.listgiftwallets![index].price}",
                                                  style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text("value".tr() ,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),),
                                                Text(" : ${cubit.newListGiftsWalletModelOld!.data!.listgiftwallets![index].price}",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),),
                                              ],
                                            ),

                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("sender".tr() ,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),),
                                            Text(" : ${cubit.newListGiftsWalletModelOld!.data!.listgiftwallets![index].senderName}",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),),
                                          ],
                                        ),
                                        Text("${cubit.newListGiftsWalletModelOld!.data!.listgiftwallets![index].message}"*10,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 10,),
                                child: Container(
                                  height: 1,
                                  color: Colors.grey,
                                  width: double.infinity,
                                ),
                              );
                            },
                            itemCount: cubit.newListGiftsWalletModelOld!.data!.listgiftwallets!.length,
                          ),
                        );
                      },
                    )),
                ],
              );
            },

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
