import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../help/app_images.dart';
import '../../../../../../help/app_strings.dart';




class MainRecordComponent extends StatelessWidget {
  const MainRecordComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppStrings.arabicReceiptRecord,
              style: Theme.of(context).textTheme.bodyText1,),
            Text(AppStrings.englishReceiptRecord,
              style: Theme.of(context).textTheme.bodyText1,),

          ],
        ),
        SizedBox(height: 14.h,),
        Container(
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                  right: 33,
                  bottom: 15,
                  child: Image(image: AssetImage(AppImages.receipt2Image))),
              Positioned(
                  left: 33,
                  bottom: 15,
                  child: Image(
                      image: AssetImage(AppImages.receipt3Image))),
              Center(child: Image(
                  image: AssetImage(AppImages.receiptImage))),

            ],
          ),
        ),
      ],
    );
  }
}
