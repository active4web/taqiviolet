import 'dart:developer';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/onbordingCubit/onboarding_cubit.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/router.dart';

import '../home_layout.dart';

class OnboardingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PageController _PageController = PageController();
    int currentIndex = 0;
    return BlocProvider(
      create: (context) => OnboardngCubit(),
      child: BlocConsumer<OnboardngCubit, OnboardingState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = OnboardngCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.black,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  systemOverlayStyle:
                      SystemUiOverlayStyle(statusBarColor: Colors.transparent),
                  expandedHeight: sizeFromHeight(1),
                  backgroundColor: Colors.black,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: EdgeInsets.zero,
                    background: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: PageView.builder(
                              pageSnapping: false,
                              controller: _PageController,
                              onPageChanged: (index) => cubit
                                  .changeIndex(index)
                                  .then((value) => currentIndex = index),
                              physics: BouncingScrollPhysics(),
                              itemCount: cubit.list.length,
                              itemBuilder: (context, index) => Align(
                                    alignment: AlignmentDirectional.topStart,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                cubit.list[index].Image.tr()),
                                            fit: BoxFit.cover),
                                        borderRadius:
                                            BorderRadiusDirectional.only(
                                          bottomEnd: Radius.circular(50),
                                        ),
                                      ),
                                      margin: EdgeInsets.all(0),
                                      padding: EdgeInsets.zero,
                                      height: sizeFromHeight(1.1),
                                      width: sizeFromWidth(1.1),
                                    ),
                                  )),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Row(
                            children: [
                              for (int i = 0; i < 2; i++)
                                Padding(
                                  child: _getIndicator(i, currentIndex),
                                  padding: EdgeInsets.all(8),
                                )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: Text(
                              cubit.list[currentIndex].title,
                              style: TextStyle(
                                  color: ColorManager.lightGolden,
                                  fontSize: 17,
                                  fontFamily: "Tajawal"),
                              textAlign: TextAlign.center,
                            )),
                        SizedBox(
                          height: 40,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            persistentFooterButtons: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        MagicRouter.navigateAndPopAll(HomeLayout());
                      },
                      child: Text(
                        "Skip".tr(),
                        style: TextStyle(
                            color: ColorManager.Golden,
                            fontSize: 17,
                            fontFamily: "Tajawal"),
                        textAlign: TextAlign.center,
                      ),
                    )),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _getIndicator(int index, currentIndex) {
    log('$currentIndex');
    return Container(
      height: 6,
      width: 27,
      decoration: BoxDecoration(
          color: currentIndex == index
              ? ColorManager.lightGolden
              : ColorManager.Golden,
          borderRadius: BorderRadius.circular(5)),
    );
  }
}
