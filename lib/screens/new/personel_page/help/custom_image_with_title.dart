import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/shared/constants.dart';

class CustomImageWithTitleComponent extends StatelessWidget {
  bool? isPngImage;
  Color? containerColor;
  CustomImageWithTitleComponent({
    Key? key,
    this.isPngImage,
    this.pngImage,
    this.containerColor,
    required this.image,
    required this.title,
    required this.onTap,
    this.textWithEnglish = false,
    this.titleEnglish,
  }) : super(key: key);

  final dynamic image;
  final Image? pngImage;
  final String title;
  final Function onTap;
  final bool textWithEnglish;
  final String? titleEnglish;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Column(
        children: [
          Container(
            width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                  color:containerColor?? kCustomBlack,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: image,
              )),
          SizedBox(
            height: 5.h,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.caption!,
            textAlign: TextAlign.center,
          ),
          textWithEnglish != false
              ? SizedBox(
            height: 5.h,
          )
              : const SizedBox(),
          textWithEnglish != false
              ? Text(
            "$titleEnglish",
            style: Theme.of(context).textTheme.caption,
          )
              : const SizedBox(),
        ],
      ),
    );
  }
}
