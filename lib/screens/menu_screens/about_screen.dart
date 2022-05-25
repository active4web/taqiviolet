import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/cubits/aboutCubit/about_state.dart';
import 'package:safsofa/shared/components/custom_app_bar_with_logo.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/aboutCubit/about_cubit.dart';
class AboutScreen extends StatelessWidget {
  const AboutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AboutCubit, AboutStates>(
      builder: (context, state) {
        AboutCubit cubit = AboutCubit.get(context);
        state is AboutInitial ? cubit.getAbout():print("getdata");
        return Scaffold(
          appBar: CustomAppBarWithLogo(),
          body:  state is! GetAboutSuccessState?Center(child: Text("the data is Uploading......")):SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  Label(
                    text: 'AboutUs'.tr(),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    cubit.aboutModel.data[0].txtName,
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 30,
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
