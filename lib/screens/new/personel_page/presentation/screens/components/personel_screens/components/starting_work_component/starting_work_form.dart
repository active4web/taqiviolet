import 'dart:ui' as ui;

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/screens/new/personel_page/help/toast/toast.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import '../../../../../../help/custom_bottom_without_border.dart';
import '../../../../../../help/custom_circular_progress/custom_circular_progress.dart';
import '../../../../../../help/toast/toast_states.dart';
import '../../starting_wotk_from_screen/controller/starting_work_cubit.dart';
import '../../starting_wotk_from_screen/controller/starting_work_state.dart';
import '../receipt_record_component/custom_form_field_without_border.dart';

class MainStartingWorkForm extends StatelessWidget {
  MainStartingWorkForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StartingWorkCubit, StartingWorkState>(
      listener: (context, state) {
        var cubit = StartingWorkCubit.get(context);

        if (state is SendStartWorkFormDataSuccessState) {
          cubit.deleteAllData();
        cubit.getAllStartWorkData();
        }
      },
      builder: (context, state) {
        var cubit = StartingWorkCubit.get(context);
        return ConditionalBuilder(
            condition: state is! SendStartWorkFormDataLoadingState,
            builder: (context) => Form(
                  key: cubit.formKey,
                  child: Column(
                    children: [
                      // Container(
                      //   padding: EdgeInsets.symmetric(horizontal: 12.r),
                      //   width: double.infinity,
                      //   color: Colors.grey,
                      //   height: 40.h,
                      //   child: Row(
                      //     //crossAxisAlignment: CrossAxisAlignment.center,
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text(
                      //         "اسم الموظف",
                      //         style: TextStyle(
                      //             fontSize: 10.sp, fontWeight: FontWeight.w300),
                      //       ),
                      //       SizedBox(width: 5.w),
                      //       Expanded(
                      //         child: CustomSpecificDropDown(
                      //             borderColor: Colors.grey,
                      //             initialValue: cubit.selectedEmployee ?? "",
                      //             hintText: cubit.selectedEmployee ?? "test",
                      //             listItems: cubit.employees,
                      //             validator: (value) {},
                      //             onChange: (value) {
                      //               cubit.changeSelectedEmployee(value!);
                      //             },
                      //             hintColor: Colors.black),
                      //       ),
                      //       SizedBox(
                      //         width: 5,
                      //       ),
                      //       Text(
                      //         "Name",
                      //         style: TextStyle(
                      //             fontSize: 10.sp, fontWeight: FontWeight.w300),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.r),
                          width: double.infinity,
                          height: 40.h,
                          color: index % 2 != 0 ? Colors.grey : Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                cubit.form()[index].arabicTitle,
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w300),
                              ),
                              SizedBox(width: 5.w),
                              Expanded(
                                child: MainCustomFormFieldWithoutBorder(
                                  keyBoardType: TextInputType.text,
                                    isReadOnly: true,
                                  controller: cubit.form()[index].controller,
                                  validator: (value) {
                                    if (value!.trim().isEmpty) {
                                      return "لا يجب ان يكون فارغ";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                cubit.form()[index].englishTitle,
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                        ),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 0.h,
                        ),
                        itemCount: cubit.form().length,
                      ),
                      SizedBox(
                        height: 0.h,
                      ),
                      Row(
                        children: [
                          Text(
                            "توقيع الموظف",
                            style: TextStyle(
                                fontSize: 10.sp, fontWeight: FontWeight.w300),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: Container(
                              height: 80.h,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: SfSignaturePad(
                                        key: cubit.signatureGlobalKey,
                                        backgroundColor: Colors.white,
                                        strokeColor: Colors.black,
                                        minimumStrokeWidth: 1.0,
                                        maximumStrokeWidth: 4.0),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            cubit.handleSaveButtonPressed(
                                                context: context,
                                                key: cubit.signatureGlobalKey,
                                                ui: ui.ImageByteFormat.png);
                                          },
                                          child: Icon(Icons.done)),
                                      InkWell(
                                          onTap: () {
                                            cubit.handleClearButtonPressed(key: cubit.signatureGlobalKey);
                                          },
                                          child: Icon(Icons.delete)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Signature",
                            style: TextStyle(
                                fontSize: 10.sp, fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.r),
                        width: double.infinity,
                        height: 80.h,
                        color: Colors.grey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "قرار المدير المباشر",
                              style: TextStyle(
                                  fontSize: 10.sp, fontWeight: FontWeight.w300),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: MainCustomFormFieldWithoutBorder(
                                keyBoardType: TextInputType.text,
                                controller: cubit.directManagerDecision,
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return "لا يجب ان يكون فارغ";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Direct Manager \n Decision",
                              style: TextStyle(
                                  fontSize: 10.sp, fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.r),
                        width: double.infinity,
                        height: 40.h,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "المدير العام",
                              style: TextStyle(
                                  fontSize: 10.sp, fontWeight: FontWeight.w300),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                                child: MainCustomFormFieldWithoutBorder(
                              keyBoardType: TextInputType.text,
                              controller: cubit.generalManager,
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "لا يجب ان يكون فارغ";
                                }
                                return null;
                              },
                            )),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "General Manager",
                              style: TextStyle(
                                  fontSize: 10.sp, fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      // Container(
                      //   color: Colors.grey,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text(
                      //         "توقيع مدير الموظفين",
                      //         style: TextStyle(
                      //             fontSize: 10.sp, fontWeight: FontWeight.w300),
                      //       ),
                      //       SizedBox(width: 5),
                      //       cubit.signatureData!.data!.signature==""?Expanded(
                      //         child: Container(
                      //           height: 80.h,
                      //           child: Column(
                      //             children: [
                      //               Expanded(
                      //                 child: SfSignaturePad(
                      //                     key: cubit.signatureGlobalKey2,
                      //                     backgroundColor: Colors.white,
                      //                     strokeColor: Colors.black,
                      //                     minimumStrokeWidth: 1.0,
                      //                     maximumStrokeWidth: 4.0),
                      //               ),
                      //               Row(
                      //                 mainAxisAlignment: MainAxisAlignment.center,
                      //                 children: [
                      //                   InkWell(
                      //                       onTap: () {
                      //                         cubit.handleSaveButtonPressed(
                      //                             context: context,
                      //                             key: cubit.signatureGlobalKey2,
                      //                             ui: ui.ImageByteFormat.png);
                      //                       },
                      //                       child: Icon(Icons.done)),
                      //                   InkWell(
                      //                       onTap: () {
                      //                         cubit.handleClearButtonPressed(key: cubit.signatureGlobalKey2);
                      //                       },
                      //                       child: Icon(Icons.delete)),
                      //                 ],
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //       ):
                      //       Expanded(child: Image.network(cubit.signatureData!.data!.signature!,)),
                      //       SizedBox(
                      //         width: 5,
                      //       ),
                      //       Text(
                      //         "Signature",
                      //         style: TextStyle(
                      //             fontSize: 10.sp, fontWeight: FontWeight.w300),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomBottomWithoutBorder(
                            function: () {
                              if(cubit.imageUploaded!=null){
                                if (cubit.formKey.currentState!.validate()) {
                                  // cubit.sendStartWorkData();
                                }
                              }else{
                                ToastConfig.showToast(msg: "يجب تأكيد توقيع الموظف", toastStates:ToastStates.success);
                              }
                            },
                            text: "تم",
                            width: 120.w,
                            height: 25.h,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          CustomBottomWithoutBorder(
                            function: () {},
                            text: "طباعه",
                            width: 120.w,
                            height: 25.h,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            fallback: (context) => CustomCircularProgress());
      },
    );
  }
}
