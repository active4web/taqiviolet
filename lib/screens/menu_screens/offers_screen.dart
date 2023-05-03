import 'dart:developer';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/offerCubit/offer_cubit.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';

class OffersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var cubit = OfferCubit.get(context);
    cubit.getOfferData();
    return BlocConsumer<OfferCubit, OfferState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Offers'.tr(),
          ),
          body: state is! GetOfferSuccessState
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: cubit.allOffer!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: BigOfferCard(
                          title: "${cubit.allOffer![index].title}",
                          discountValue:
                              cubit.allOffer![index].discount.toString(),
                          OfferImage: "${cubit.allOffer![index].image}",
                        ),
                      );
                    },
                  ),
                ),
        );
      },
    );
  }
}

class BigOfferCard extends StatelessWidget {
  String? discountValue;
  String? OfferImage;
  String? title;

  BigOfferCard({
    @required this.discountValue,
    @required this.title,
    @required this.OfferImage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 1)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: NetworkImage("${OfferImage}"), fit: BoxFit.cover)),
                child: Column(
                  children: [
                    Text(
                      '$title',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      ' ${title} علي $discountValue ',
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20)),
              color: Colors.white,
            ),
            child: Text(
              '$discountValue احصل علي خصم ',
              style: TextStyle(fontSize: 12),
            ),
          ),
        )
      ],
    );
  }
}
