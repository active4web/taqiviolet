import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/mobile_cubit.dart';
import '../shared/components/custom_app_bar_with_search.dart';
import '../shared/constants.dart';

class MobileScr extends StatefulWidget {
  @override
  _MobileScrState createState() => _MobileScrState();
}

class _MobileScrState extends State<MobileScr> {
  @override
  Widget build(BuildContext context) {
    MobileCubit mobileCubit = MobileCubit.get(context);
    mobileCubit.state is MobileInitial
        ? mobileCubit.getdataprofileCData()
        : log("getdata");
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBarWithSearch(
          title: 'Mobile',
          colorIcon: kDarkGoldColor,
        ),
        body: BlocConsumer<MobileCubit, MobileState>(
          listener: (context, state) {},
          builder: (context, state) {
            return mobileCubit.phonesModel == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : GridView.builder(
                    itemCount: mobileCubit.phonesModel!.data!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0),
                    itemBuilder: (BuildContext context, int index) {
                      return Image.network(
                          "${mobileCubit.phonesModel?.data![index].image}");
                    },
                  );
          },
        ));
  }
}
