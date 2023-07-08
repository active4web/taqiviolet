import 'package:flutter/material.dart%20';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/services.dart';
import 'package:safsofa/cubits/new_gifts_cubit/new_gifts_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/new_gifts_cubit/new_gifts_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import '../shared/components/custom_button.dart';
import '../shared/components/custom_label.dart';
import '../shared/components/custom_network_image.dart';
import 'package:safsofa/screens/header_my_account/widget/custom_text_form_field.dart';

import '../shared/constants.dart';

class NewPayScreenAfterGifts extends StatelessWidget {
  NewPayScreenAfterGifts({super.key,required this.id,required this.price,required this.image,required this.name});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailForRecipientController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  dynamic id;
  String? image;
  String? name;
  String? price;

  @override
  Widget build(BuildContext context) {
    print(kToken);
    return BlocProvider(
      create: (context)=>NewGiftsCubit()..getNewGiftsDetailsData(id: id),
      child: BlocConsumer<NewGiftsCubit, NewGiftsStates>(
        listener: (context, state) {
          if(state is SendNewCardSuccessState){
            NewGiftsCubit.get(context).newImage="";
            NewGiftsCubit.get(context).newPrice="";
            nameController.text=" ";
            messageController.text=" ";
            emailForRecipientController.text=" ";
          }
        },
        builder: (context, state) {
          var cubit = NewGiftsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 2.0,
              centerTitle: true,
              title: Text('giftCard'.tr(),
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
              condition: state is! GetNewGiftsDetailsLoadingState,
              fallback: (context) => Center(child: RefreshProgressIndicator()),
              builder:(context){
                return Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: CustomNetworkImage(
                              image: cubit.newImage=="" ? image! : cubit.newImage!,
                              border: BorderRadius.all(Radius.circular(10)),
                              height: 180,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                name!,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'SHEIN',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            ' $price ${'rS'.tr()}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          if(cubit.newCardDetailsModel!.data!.listcardimages!.length!=0)
                          Text("design".tr()),
                          SizedBox(
                            height: 10,
                          ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: cubit.newCardDetailsModel!.data!.listcardimages!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 1 / 1.1,
                          mainAxisSpacing: 2.0,
                          crossAxisSpacing: 6.0,
                      ),
                        itemBuilder: (context, index){
                        return InkWell(
                          onTap: (){
                            print("111");
                            cubit.changeImage(
                              cubit.newCardDetailsModel!.data!.listcardimages![index].image!,
                              cubit.newCardDetailsModel!.data!.listcardimages![index].id!,

                            );
                            print("111");
                          },
                          child: Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.black87,
                                width: 2,
                              ),
                            ),
                            child: CustomNetworkImage(
                              image: cubit.newCardDetailsModel!.data!.listcardimages![index].image!,
                              border: BorderRadius.all(Radius.circular(10)),
                              height: 180,
                            ),
                          ),
                        );
                        }
                    ),
                          SizedBox(
                            height: 10,
                          ),
                          if(cubit.newCardDetailsModel!.data!.listcardprice!.length!=0)
                          Text("amount".tr()),
                          SizedBox(
                            height: 10,
                          ),
                          GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: cubit.newCardDetailsModel!.data!.listcardprice!.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                childAspectRatio: 1 / 0.4,
                                mainAxisSpacing: 2.0,
                                crossAxisSpacing: 6.0,
                              ),
                              itemBuilder: (context, index){
                                return InkWell(
                                  onTap: (){
                                    cubit.changePrice(
                                        cubit.newCardDetailsModel!.data!.listcardprice![index].price!,
                                      cubit.newCardDetailsModel!.data!.listcardprice![index].id!,
                                    );
                                    print(cubit.newPrice);
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color: cubit.newPrice== cubit.newCardDetailsModel!.data!.listcardprice![index].price!?
                                      Colors.red : Colors.white ,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.black87,
                                        width: 2,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text("${cubit.newCardDetailsModel!.data!.listcardprice![index].price!}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    ),
                                  ),
                                );
                              }
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Label(text: 'to'.tr(),),
                          CustomTextFormField(
                            controller: emailForRecipientController,
                            text: 'enterTheRecipientEmailAddress'.tr(),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Label(
                            text: 'from'.tr(),
                          ),
                          CustomTextFormField(
                            controller: nameController,
                            text: 'enterYourName'.tr(),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Label(
                            text: 'typeYourMessage'.tr(),
                          ),
                          CustomTextFormField(
                            controller: messageController,
                            text: 'validateMessage'.tr(),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              // Transform.scale(
                              //   scale: 1,
                              //   child: Checkbox(
                              //     activeColor: Colors.green,
                              //     value: cubit.isSelectedCheck,
                              //     onChanged: (bool? value) {
                              //       cubit.changedSelectedCheck(value: value!);
                              //       print(cubit.isSelectedCheck);
                              //     },
                              //     shape: const CircleBorder(
                              //       side: BorderSide(color: Colors.grey),
                              //     ),
                              //   ),
                              // ),
                              SizedBox(
                                width: 3,
                              ),
                              Expanded(
                                  child: Text(
                                    'checkBoxGiftCard'.tr(),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ConditionalBuilder(
                            condition: state is ! SendNewCardLoadingState,
                            fallback: (context) => Center(child: RefreshProgressIndicator()),
                            builder: (context){
                              return  CustomButton(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    cubit.addNewCard(
                                      cartId: id,
                                      phone: emailForRecipientController.text,
                                      message: messageController.text,
                                      senderName: nameController.text,
                                      price: price.toString(),
                                      imgId: cubit.newImageId!,
                                      priceId: cubit.newPriceId!,
                                    );
                                    print('object');
                                  } else {
                                    print('yes');
                                  }
                                },
                                height: 50,
                                text: 'payingOff'.tr(),
                              );
                            },

                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'kljhjkhjhjjjjfjidh jhfkjsdnlkf jkjkhjhkjh hiui fgdfgd dfd',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
