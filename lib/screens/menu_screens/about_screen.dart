import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/aboutCubit/about_state.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../cubits/aboutCubit/about_cubit.dart';
import '../../shared/components/custom_app_bar.dart';
import '../../shared/constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AboutCubit cubit = AboutCubit.get(context);
    // cubit.getInfoAboutUs();
    // cubit.getAbout();

    return BlocBuilder<AboutCubit, AboutStates>(
      builder: (context, state) {
        state is AboutInitial ? cubit.getAbout() : print("getdata");
        return Scaffold(
          appBar: CustomAppBar(title: "AboutUs".tr()),
          body: state is! GetAboutSuccessState
              ? Center(
                  child: CircularProgressIndicator(
                  color: kDarkGoldColor,
                ))
              : Padding(
                  padding: const EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) => Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    cubit.aboutModel.data[index].title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color: kDarkGoldColor),
                                  ),
                                ],
                              ),
                              // Label(
                              //   text: cubit.aboutModel.data[index].title,
                              // ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                cubit.aboutModel.data[index].content,
                                style: TextStyle(fontSize: 15, height: 2),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              if (index == cubit.aboutData.length - 1)
                                InkWell(
                                  onTap: () async {
                                    await launch(
                                        "https://taqiviolet.com/employment-Form");
                                  },
                                  child: Text(
                                    "press here".tr(),
                                    style: TextStyle(
                                      color: Colors.lightBlue,
                                      fontSize: 15,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          separatorBuilder: (context, index) => Column(
                            children: [
                              Divider(
                                thickness: 1,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                          itemCount: cubit.aboutModel.data.length,
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Text(
                              "Commercial Registration No: ".tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: kDarkGoldColor),
                            ),
                            Text(
                              "205152080",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.black),
                            )
                          ],
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Text(
                              "Tax Registration No: ".tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: kDarkGoldColor),
                            ),
                            Text(
                              "310856446400003",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.black),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
