import 'package:conditional_builder/conditional_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/inspirationCubit/inspiration_cubit.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cubits/inspirationCubit/inspiration_state.dart';
import '../shared/components/custom_app_bar.dart';

class DisplayInspirationProducts extends StatelessWidget {
  DisplayInspirationProducts({
    Key key,
    this.categoryName,
  }) : super(key: key);

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    InspirationCubit cubit = InspirationCubit.get(context);
    cubit.getInspirationData();
    return BlocProvider(
      create: (context) => InspirationCubit()..getInspirationData(),
      child: BlocConsumer<InspirationCubit, InspirationStates>(
        listener: (context, state) {
          print("get dataحخهحخهعخهحخهخخحهحخ");
        },
        builder: (context, state) {
          // print('<' * 10 + cubit.inspirationModel.data[0].image + '>' * 10);
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: CustomAppBar(title: this.categoryName.tr()),
              body: ConditionalBuilder(
                condition: cubit.inspirationData.isNotEmpty ||
                    state is GetInspirationSuccessState,
                builder: (context) => SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 10,
                        // childAspectRatio: ,
                      ),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          _launchURLBrowser(
                              cubit.inspirationData[index].urllink);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image(
                            image: NetworkImage(
                              cubit.inspirationData[index].image,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      itemCount: cubit.inspirationData.length,
                    ),
                  ),
                ),
                fallback: (context) => Center(
                  child: CircularProgressIndicator(
                    color: kDarkGoldColor,
                  ),
                ),
              ));
        },
      ),
    );
  }
}

_launchURLBrowser(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
