import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safsofa/cubits/appCubit/app_states.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';

import 'package:safsofa/shared/components/description_text_field.dart';
import 'package:safsofa/shared/defaults.dart';

import '../cubits/appCubit/app_cubit.dart';
import '../shared/components/custom_button.dart';
import '../shared/components/custom_label.dart';

class AddReviewScreen extends StatefulWidget {
  AddReviewScreen({Key key, this.prodId}) : super(key: key);

  final int prodId;
  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  XFile xFile1;

  XFile xFile2;

  XFile xFile3;

  XFile imageFile1;

  XFile imageFile2;

  XFile imageFile3;

  TextEditingController commentController = new TextEditingController();

  double rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'AddReview'.tr(),
      ),
      body: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          if (state is AddReviewSuccessState) {
            cubit.file1 = null;
            cubit.file2 = null;
            cubit.file3 = null;
            cubit.getProductReviews(productId: widget.prodId);
            showAlertDialogWithAction(
                message: state.message,
                context: context,
                imagePath: 'assets/images/AddReview.png',
                messageColor: Colors.black,
                buttonText: "Done".tr(),
                action: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
          } else if (state is AddReviewErrorState) {
            showToast(text: state.message, color: Colors.red);
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          if (imageFile1 != null) {
            cubit.file1 = File(imageFile1.path);
          }
          if (imageFile2 != null) {
            cubit.file2 = File(imageFile2.path);
          }
          if (imageFile3 != null) {
            cubit.file3 = File(imageFile3.path);
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
                  RatingBar.builder(
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
                    controller: commentController,
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
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     CustomImagePicker(
                  //       onTab: () async {
                  //         await cubit.pickImage(cubit.file1).then((value) {
                  //           setState(() {
                  //             imageFile1 = value;
                  //           });
                  //         });
                  //       },
                  //       imageFile: imageFile1,
                  //     ),
                  //     CustomImagePicker(
                  //       onTab: () async {
                  //         await cubit.pickImage(cubit.file2).then((value) {
                  //           setState(() {
                  //             imageFile2 = value;
                  //           });
                  //         });
                  //       },
                  //       imageFile: imageFile2,
                  //     ),
                  //     CustomImagePicker(
                  //       onTab: () async {
                  //         await cubit.pickImage(cubit.file3).then((value) {
                  //           setState(() {
                  //             imageFile3 = value;
                  //           });
                  //         });
                  //       },
                  //       imageFile: imageFile3,
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 40,
                  ),
                  state is AddReviewLoadingState
                      ? Center(
                          child: CircularProgressIndicator(color: Colors.black),
                        )
                      : CustomButton(
                          height: 50,
                          text: 'AddReview'.tr(),
                          onTap: () {
                            // log(cubit.file1.path ?? '');
                            // log(cubit.file2.path ?? '');
                            // log(cubit.file3.path ?? '');
                            // cubit.addReview(
                            //   comment: commentController.text,
                            //   rating: rating.toInt(),
                            //   productId: cubit.,
                            //   // image1: cubit.file1,
                            //   // image2: cubit.file2,
                            //   // image3: cubit.file3,
                            // );
                          },
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
