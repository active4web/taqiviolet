import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GetAllUsers extends StatelessWidget {
  final Function onTap;
  final String name;
  final String message;
  final Color color;
  final String? date;
  const GetAllUsers({Key? key,
    required this.onTap,
    required this.name,
    required this.message,
    required this.color,
    this.date
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),

      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Padding(
          padding: EdgeInsets.all(15.h),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.sp,
                child: SvgPicture.asset('assets/images/Group 345.svg',height: double.infinity),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight:
                          FontWeight.bold,
                        fontSize: 12.sp
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            message,
                            style: TextStyle(
                              fontSize: 12.sp
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        Text(
                          date??'10/5/2020 ',
                          style: TextStyle(
                            fontSize: 12.sp
                          )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
