import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/cubits/taqi_work_cubit/cubit/taqi_work_cubit.dart';
import 'package:safsofa/cubits/taqi_work_cubit/cubit/taqi_work_state.dart';
import 'package:safsofa/screens/new/personel_page/help/custom_circular_progress/custom_circular_progress.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../shared/components/custom_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/custom_form_field.dart';
import '../../shared/components/custom_label.dart';
import '../../shared/constants.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  @override
  void initState() {
    TaqiWorkCubit.get(context).getJobs();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "jobs".tr(),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<TaqiWorkCubit,TaqiWorkState>(builder: (context,state) {
              var cubit = TaqiWorkCubit.get(context);
              return AnimatedConditionalBuilder(
                  condition: cubit.jobModel != null,
                  builder: (context) => AnimatedConditionalBuilder(
                      condition: cubit.jobModel?.data?.length != 0,
                      builder: (context) => ListView.separated(
                            padding: EdgeInsets.all(10.r),
                            separatorBuilder: (context, index) => SizedBox(
                              height: 10.h,
                            ),
                            itemBuilder: (context, index) => Container(
                              padding: EdgeInsets.all(10.r),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: .5,
                                      color: Colors.grey.shade300)),
                              child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cubit.jobModel?.data?[index].title ??
                                          '',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Text(cubit.jobModel?.data?[index]
                                            .description ??
                                        ''),
                                    if (cubit.jobModel?.data?[index].salary !=
                                        null)
                                      Row(
                                        children: [
                                          Text(
                                            "${"salary".tr()}: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.sp,
                                                color: Color(0xffFE9C8F)),
                                          ),
                                          Text(
                                            "${cubit.jobModel?.data?[index]
                                                .salary
                                                .toString() ??
                                                ''} ${"rial".tr()}",
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Color(0xffFE9C8F)),
                                          ),
                                        ],
                                      ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0.w),
                                      child: CustomButton(
                                        onTap: () {
                                          cubit.jobErrorModel=null;
                                          cubit.name.clear();
                                          cubit.phone.clear();
                                          cubit.email.clear();
                                          cubit.file=null;
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return BlocConsumer<
                                                    TaqiWorkCubit,
                                                    TaqiWorkState>(
                                                  listener: (context, state) {
                                                    if (state
                                                    is ApplyJobSuccessState) {
                                                        Navigator.pop(context);
                                                        cubit.name.clear();
                                                        cubit.phone.clear();
                                                        cubit.email.clear();
                                                        cubit.file=null;
                                                    }
                                                  },
                                                  builder: (context, state) {
                                                    return AlertDialog(
                                                      content:
                                                      SingleChildScrollView(
                                                        child: Form(
                                                          key: cubit.formKey,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            mainAxisSize:
                                                            MainAxisSize.min,
                                                            // crossAxisAlignment:
                                                            //     CrossAxisAlignment
                                                            //         .start,
                                                            children: [
                                                              Label(
                                                                  text: 'name'
                                                                      .tr()),
                                                              CustomFormField(
                                                                  controller:
                                                                  cubit.name,
                                                                  validate: (va){
                                                                    if(cubit.jobErrorModel?.errors?.name!=null){
                                                                      return cubit.jobErrorModel?.errors?.name??'';
                                                                    }
                                                                  }
                                                                // label: "name".tr(),
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Label(
                                                                  text: 'Email'
                                                                      .tr()),
                                                              CustomFormField(
                                                                  controller:
                                                                  cubit.email,
                                                                  inputType:
                                                                  TextInputType
                                                                      .emailAddress,
                                                                  validate: (va){
                                                                    if(cubit.jobErrorModel?.errors?.email!=null){
                                                                      return cubit.jobErrorModel?.errors?.email??'';
                                                                    }
                                                                  }

                                                                // label: "Email".tr(),
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Label(
                                                                  text: 'Phone'
                                                                      .tr()),
                                                              CustomFormField(
                                                                  controller:
                                                                  cubit.phone,
                                                                  inputType:
                                                                  TextInputType
                                                                      .phone,
                                                                  validate: (va){
                                                                    if(cubit.jobErrorModel?.errors?.phone!=null){
                                                                      return cubit.jobErrorModel?.errors?.phone??'';
                                                                    }
                                                                  }
                                                                // label: "Phone".tr(),
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              TaqiWorkCubit.get(
                                                                  context)
                                                                  .file ==
                                                                  null
                                                                  ? TextButton(
                                                                onPressed:
                                                                    () {
                                                                  TaqiWorkCubit.get(
                                                                      context)
                                                                      .pickMediaFile();
                                                                },
                                                                child: Text(
                                                                  'chooseAFile'
                                                                      .tr(),
                                                                  style:
                                                                  TextStyle(
                                                                    color:
                                                                    kCustomBlack,
                                                                    fontWeight:
                                                                    FontWeight.bold,
                                                                  ),
                                                                ),
                                                              )
                                                                  : Container(
                                                                width: MediaQuery.of(context)
                                                                    .size
                                                                    .width /
                                                                    2.5,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade300,
                                                                    shape: BoxShape
                                                                        .rectangle,
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .black),
                                                                    borderRadius:
                                                                    BorderRadius.circular(6)),
                                                                child: Row(
                                                                  children: [
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        TaqiWorkCubit.get(context).removePickedFile();
                                                                      },
                                                                      child:
                                                                      Icon(
                                                                        Icons.close,
                                                                        color:
                                                                        Colors.black,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                      5,
                                                                    ),
                                                                    Expanded(child: Text("${TaqiWorkCubit.get(context).file?.name}"))
                                                                  ],
                                                                ),
                                                              ),
                                                              if(cubit.jobErrorModel?.errors?.cv!=null)
                                                              Text(cubit.jobErrorModel?.errors?.cv??'',style: TextStyle(
                                                                color: Colors.red
                                                              ),),
                                                              SizedBox(
                                                                height: 30,
                                                              ),
                                                              state is SendingLoadingState
                                                                  ? Center(
                                                                child: CircularProgressIndicator(
                                                                    color:
                                                                    kDarkGoldColor),
                                                              )
                                                                  : CustomButton(
                                                                onTap: () {
                                                                  cubit.formKey.currentState?.validate();
                                                                  cubit.applyJob(id: cubit.jobModel?.data?[index].id??0);
                                                                },
                                                                text: 'Send'
                                                                    .tr(),
                                                                height: 50,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              });
                                        },
                                        text: "applyNow".tr(),
                                      ),
                                    )
                                  ]),
                            ),
                            itemCount: cubit.jobModel?.data?.length??0,
                          ),
                      fallback: (context) => Center(
                            child: Text("Jobs is Empty"),
                          )),
                  fallback: (context) => Center(
                        child: CustomCircularProgress(),
                      ));
            }),
          )
        ],
      ),
    );
  }
}
