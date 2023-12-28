import 'package:flutter/material.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/services.dart';
import 'package:safsofa/cubits/new_gifts_cubit/new_gifts_cubit.dart';
import 'package:safsofa/cubits/new_gifts_cubit/new_gifts_states.dart';
import 'package:safsofa/screens/header_my_account/widget/gift_card.dart';
import '../../shared/components/custom_network_image.dart';
import '../../shared/defaults.dart';
import '../new_pay_after_gifts_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class CheckBalanceGiftCardScreen extends StatelessWidget {
  CheckBalanceGiftCardScreen({Key? key}) : super(key: key);
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController personalIdentificationNumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)=>NewGiftsCubit()..getAllNewGiftsData(),
    child: BlocConsumer<NewGiftsCubit, NewGiftsStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
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
            condition: state is! GetAllNewGiftsLoadingState,
            fallback: (context) => Center(child: RefreshProgressIndicator()),
            builder: (context){
              var cubit = NewGiftsCubit.get(context);
              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // CustomTextFormField(
                        //   controller: cardNumberController,
                        //   text: 'cardNumber'.tr(),
                        // ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // CustomTextFormField(
                        //   controller: personalIdentificationNumberController,
                        //   text: 'personalIdentificationNumber'.tr(),
                        // ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // CustomButton(
                        //   onTap: () {
                        //     if (_formKey.currentState!.validate()) {
                        //       print('object');
                        //     } else {
                        //       print('yes');
                        //     }
                        //   },
                        //   height: 50,
                        //   text: 'checkTheBalance'.tr(),
                        // ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // Divider(),
                        // SizedBox(
                        //   height: 15,
                        // ),
                        Text(
                          'sellTheMostGoods'.tr(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: cubit.newListCardsModel!.data!.listcards!.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1 / 0.95,
                              mainAxisSpacing: 2.0,
                              crossAxisSpacing: 6.0),
                          itemBuilder: (context, index) =>
                              InkWell(
                                  onTap: () {
                                    navigateTo(context, NewPayScreenAfterGifts(
                                      id: cubit.newListCardsModel!.data!.listcards![index].id,
                                      name: cubit.newListCardsModel!.data!.listcards![index].name,
                                      image: cubit.newListCardsModel!.data!.listcards![index].image,
                                      price: cubit.newListCardsModel!.data!.listcards![index].price,
                                    ));
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomNetworkImage(
                                        image: '${cubit.newListCardsModel!.data!.listcards![index].image}',
                                        border: BorderRadius.all(Radius.circular(10)),
                                        height: 100,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text('theValue'.tr(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(' ${cubit.newListCardsModel!.data!.listcards![index].counts} ${'rS'.tr()}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('thePrice'.tr(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(' ${cubit.newListCardsModel!.data!.listcards![index].price} ${'rS'.tr()}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),

                                    ],
                                  ),
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
