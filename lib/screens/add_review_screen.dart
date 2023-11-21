

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/screens/home_layout.dart';
import 'package:safsofa/shared/constants.dart';

import '../shared/components/custom_button.dart';
import '../shared/components/custom_label.dart';
import '../shared/components/description_text_field.dart';
import 'package:easy_localization/easy_localization.dart';



class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({super.key});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  TextEditingController commentController = TextEditingController();
  List<XFile>? images;

  Future geImageGallery1() async {
    images = await ImagePicker().pickMultiImage();
    setState(() {});
  }

  double rating = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, true);
          return true;
        },
    child: SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              AppCubit.get(context).selectedIndex=0;
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
              HomeLayout()
              ), (route) => false);
            }, icon: Icon(kLanguage=='en'?Icons.arrow_back_ios_new_outlined:Icons.arrow_forward_ios_outlined),
          ),
        ),
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.0.w),
          child: ListView(
            children: [
              SizedBox(height: 20.h,),
              Container(
                height: MediaQuery.of(context).size.height * 0.12,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                        AssetImage('assets/images/AddReview.png'))),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: RatingBar.builder(
                  initialRating: rating,
                  minRating: 1,
                  itemSize: 40,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  glowColor: Color(0xffF3E184),
                  unratedColor: Color(0xffCFD8DC),
                  itemPadding:
                  EdgeInsets.symmetric(horizontal: 1, vertical: 5),
                  onRatingUpdate: (value) {
                    setState(() {
                      rating = value;
                    });
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
              controller: commentController,
              maxLines: 6,
            ),
            SizedBox(
              height: 30,
            ),
            Text('ProductImages'.tr(),style: TextStyle(
              fontWeight: FontWeight.bold
            ),),
            InkWell(
              onTap: () => geImageGallery1(),
              child: Icon(Icons.add_a_photo_outlined),
            ),
            if (images != null && images!.isNotEmpty)
                 SizedBox(
          height: MediaQuery.of(context).size.height / 5,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(
                horizontal:
                MediaQuery.of(context).size.width / 60),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Stack(
                children: [
                  Image(
                    height:
                    MediaQuery.of(context).size.width / 2,
                    width:
                    MediaQuery.of(context).size.width / 2,
                    image: FileImage(
                      File(images![index].path),
                    ),
                    fit: BoxFit.cover,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        images?.removeAt(index);
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor:
                      Colors.white.withOpacity(0.7),
                      child: Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
            separatorBuilder: (context, index) => SizedBox(
              width: MediaQuery.of(context).size.width / 30,
            ),
            itemCount: images!.length,
          ),),
              SizedBox(height: 20.h,),
              CustomButton(
              height: 50.h,
                  text: 'AddReview'.tr(),
                onTap: (){},
              ),
              SizedBox(height:20.h),

            ],
          ),
        ),
      ),
    )
    );
  }
}



















// import 'dart:io';
//
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:safsofa/cubits/order_details_cubit.dart';
// import 'package:safsofa/shared/components/custom_app_bar.dart';
// import 'package:safsofa/shared/components/description_text_field.dart';
// import 'package:safsofa/shared/defaults.dart';
//
// import '../shared/components/custom_button.dart';
// import '../shared/components/custom_label.dart';
//
// class AddReviewScreen extends StatefulWidget {
//   AddReviewScreen({ @required this.prodId, @required this.orderId});
//
//   final int? prodId;
//   final int? orderId;
//
//   @override
//   State<AddReviewScreen> createState() => _AddReviewScreenState();
// }
//
// class _AddReviewScreenState extends State<AddReviewScreen> {
//   TextEditingController commentController = TextEditingController();
//   List<XFile>? images;
//
//   Future geImageGallery1() async {
//     images = await ImagePicker().pickMultiImage();
//     setState(() {});
//   }
//
//   double rating = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pop(context, true);
//         return true;
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: CustomAppBar(
//           title: 'AddReview'.tr(),
//           icon: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.pop(context, true);
//             },
//           ),
//         ),
//         body: BlocProvider(
//           create: (context) => OrderDetailsCubit(),
//           child: BlocConsumer<OrderDetailsCubit, OrderDetailsState>(
//             listener: (context, state) {
//               // AppCubit cubit = AppCubit.get(context);
//               if (state is OrderDetailsSuccessState) {
//                 // file1 = null;
//                 // file2 = null;
//                 // file3 = null;
//                 // cubit.getProductReviews(productId: widget.prodId);
//                 showAlertDialogWithAction(
//                     message: "yourRatingHasBeenAddedSuccessfully".tr(),
//                     context: context,
//                     imagePath: 'assets/images/AddReview.png',
//                     messageColor: Colors.black,
//                     buttonText: "Done".tr(),
//                     action: () {
//                       Navigator.pop(context);
//                       Navigator.pop(context, true);
//                     });
//               } else if (state is OrderDetailsErrorState) {
//                 showToast(
//                     text: "somethingWentWrong".tr(),
//                     color: Colors.red,
//                     location: ToastGravity.CENTER);
//               }
//             },
//             builder: (context, state) {
//               return SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.all(22),
//                   child: Column(
//                     children: [
//                       Container(
//                         height: MediaQuery.of(context).size.height * 0.12,
//                         decoration: BoxDecoration(
//                             image: DecorationImage(
//                                 image:
//                                     AssetImage('assets/images/AddReview.png'))),
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       RatingBar.builder(
//                         initialRating: rating,
//                         minRating: 1,
//                         itemSize: 40,
//                         direction: Axis.horizontal,
//                         allowHalfRating: true,
//                         itemCount: 5,
//                         glowColor: Color(0xffF3E184),
//                         unratedColor: Color(0xffCFD8DC),
//                         itemPadding:
//                             EdgeInsets.symmetric(horizontal: 1, vertical: 5),
//                         onRatingUpdate: (value) {
//                           setState(() {
//                             rating = value;
//                           });
//                         },
//                         itemBuilder: (context, _) => Icon(
//                           Icons.star_rate_rounded,
//                           color: Color(0xffF3E184),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       Label(
//                         text: 'Comment'.tr(),
//                       ),
//                       SizedBox(
//                         height: 15,
//                       ),
//                       DescriptionTextField(
//                         hintText: "Write your comment on the product".tr(),
//                         controller: commentController,
//                         maxLines: 6,
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       InkWell(
//                         onTap: () => geImageGallery1(),
//                         child: Label(
//                           text: 'ProductImages'.tr(),
//                         ),
//                       ),
//                       if (images != null && images!.isNotEmpty)
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height / 5,
//                           child: ListView.separated(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal:
//                                     MediaQuery.of(context).size.width / 60),
//                             scrollDirection: Axis.horizontal,
//                             itemBuilder: (context, index) => ClipRRect(
//                               borderRadius: BorderRadius.circular(15),
//                               child: Stack(
//                                 children: [
//                                   Image(
//                                     height:
//                                         MediaQuery.of(context).size.width / 2,
//                                     width:
//                                         MediaQuery.of(context).size.width / 2,
//                                     image: FileImage(
//                                       File(images![index].path),
//                                     ),
//                                     fit: BoxFit.cover,
//                                   ),
//                                   InkWell(
//                                     onTap: () {
//                                       setState(() {
//                                         images?.removeAt(index);
//                                       });
//                                     },
//                                     child: CircleAvatar(
//                                       backgroundColor:
//                                           Colors.white.withOpacity(0.7),
//                                       child: Icon(
//                                         Icons.close,
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             separatorBuilder: (context, index) => SizedBox(
//                               width: MediaQuery.of(context).size.width / 30,
//                             ),
//                             itemCount: images!.length,
//                           ),
//                         ),
//                       SizedBox(
//                         height: 15,
//                       ),
//                       SizedBox(
//                         height: 40,
//                       ),
//                       state is OrderDetailsLoadingState
//                           ? Center(
//                               child: CircularProgressIndicator(
//                                   color: Colors.black),
//                             )
//                           : CustomButton(
//                               height: 50,
//                               text: 'AddReview'.tr(),
//                               onTap: () async {
//                                 if (rating > 0) {
//                                   var res = await OrderDetailsCubit.get(context)
//                                       .addReviewForProduct(
//                                     orderId: widget.orderId!,
//                                     productId: widget.prodId!,
//                                     rate: rating.toString() ?? "0",
//                                     comment: commentController.text,
//                                     reviewImages: images!,
//                                   );
//                                   if (res.data['status']) {
//                                     setState(() {
//                                       rating = 0.0;
//                                       commentController.clear();
//                                       images?.clear();
//                                     });
//                                   }
//                                 } else {
//                                   showToast(
//                                       text: "pleaseAddYourReview".tr(),
//                                       color: Colors.red,
//                                       location: ToastGravity.CENTER);
//                                 }
//
//                                 // log(cubit.file1.path ?? '');
//                                 // log(cubit.file2.path ?? '');
//                                 // log(cubit.file3.path ?? '');
//                                 // cubit.addReview(
//                                 //   comment: commentController.text,
//                                 //   rating: rating.toInt(),
//                                 //   productId: cubit.,
//                                 //   // image1: cubit.file1,
//                                 //   // image2: cubit.file2,
//                                 //   // image3: cubit.file3,
//                                 // );
//                               },
//                             ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
