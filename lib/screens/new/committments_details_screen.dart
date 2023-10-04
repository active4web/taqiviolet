
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/cubits/commitments/commitments_cubit.dart';
import 'package:safsofa/screens/new/personel_page/help/custom_circular_progress/custom_circular_progress.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../shared/constants.dart';
class CommitmentsDetailsScreen extends StatefulWidget {
  const CommitmentsDetailsScreen({super.key, required this.title, required this.type});

  final String title;
  final int type;

  @override
  State<CommitmentsDetailsScreen> createState() => _CommitmentsDetailsScreenState();
}

class _CommitmentsDetailsScreenState extends State<CommitmentsDetailsScreen> {
  @override
  void initState() {
    CommitmentsCubit.get(context)..getCommitmentsDetails(type: widget.type);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: BlocConsumer<CommitmentsCubit,CommitmentsState>(
        listener: (context,state){},
        builder: (context,state) {
          var commitmentsCubit=CommitmentsCubit.get(context);
          return state is GetCommitmentsLoading?CustomCircularProgress():Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "clause".tr(),
                          style: TextStyle(
                              fontSize: 10.sp
                          ),
                        ),
                        SizedBox(width: 10,),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 15.0.w),
                          child: Text(
                            "assignment".tr(),
                            style: TextStyle(
                                fontSize: 10.sp
                            ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(right: 10.0.w),
                          child: Text(
                            "date".tr(),
                            style: TextStyle(
                                fontSize: 10.sp
                            ),
                          ),
                        ),
                        Text(
                          "notes".tr(),
                          style: TextStyle(
                              fontSize: 10.sp
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),

                  Table(
                    columnWidths: {
                      0: FlexColumnWidth(53.w),
                      1: FlexColumnWidth(25.w),
                      2: FlexColumnWidth(35.w),
                      3: FlexColumnWidth(40.w),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    border: TableBorder.symmetric(inside: BorderSide(color: kCustomBlack)),
                    children: List.generate(commitmentsCubit.commitmentsModel?.data?.length??0,

                      // cubit.searchController.text == ''
                      //     ? cubit.projectsData!.data!.length
                      //     : cubit.searchData.length,
                          (index) =>
                          TableRow(
                            decoration: BoxDecoration(
                                color:   Colors.white),
                            children: [
                              TextWidget(text: commitmentsCubit.commitmentsModel?.data?[index].subject??""),
                              TextWidget(text: commitmentsCubit.commitmentsModel?.data?[index].totalMoney??""),
                              TextWidget(text: commitmentsCubit.commitmentsModel?.data?[index].date??""),
                              TextWidget(text: commitmentsCubit.commitmentsModel?.data?[index].paymentMethod??""),
                            ],
                          ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}

Widget TextWidget({required String text}){
  return Padding(
    padding:  EdgeInsets.symmetric(horizontal: 8.0.w,vertical: 5.h),
    child: Text(
      text,
      style: TextStyle(
          fontSize: 10.sp
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    ),
  );
}