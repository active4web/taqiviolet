import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safsofa/cubits/app_states.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/components/custom_image_picker.dart';
import 'package:safsofa/shared/components/description_text_field.dart';

import '../cubits/app_cubit.dart';
import '../shared/components/custom_button.dart';
import '../shared/components/custom_label.dart';

class AddReviewScreen extends StatelessWidget {
  const AddReviewScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    XFile xFile1;
    XFile xFile2;
    XFile imageFile1;
    XFile imageFile2;
    File file1;
    File file2;
    double rating = 0;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'AddReview'.tr(),
      ),
      body: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (imageFile1 != null) {
            file1 = File(imageFile1.path);
          }
          if (imageFile2 != null) {
            file2 = File(imageFile2.path);
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.12,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/AddReview.png'))),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  StatefulBuilder(
                    builder: (context, setState) => RatingBar.builder(
                      initialRating: rating,
                      minRating: 1,
                      itemSize: 40,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      glowColor: Color(0xffF3E184),
                      unratedColor: Color(0xffCFD8DC),
                      itemPadding:
                          EdgeInsets.symmetric(horizontal: 1, vertical: 5),
                      onRatingUpdate: (value) {
                        rating = value;
                        setState(() {});
                      },
                      itemBuilder: (context, _) => Icon(
                        Icons.star_rate_rounded,
                        color: Color(0xffF3E184),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Label(
                    text: 'Comment'.tr(),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DescriptionTextField(
                    hintText: "Write your comment on the product".tr(),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Label(
                    text: 'ProductImages'.tr(),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomImagePicker(),
                      CustomImagePicker(),
                      CustomImagePicker(),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                    height: 50,
                    text: 'AddReview'.tr(),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
