import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/screens/new/personel_page/help/toast/toast.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import '../../../../../../help/custom_bottom_without_border.dart';
import '../../../../../../help/custom_circular_progress/custom_circular_progress.dart';
import '../../../../../../help/custom_translate_check_box.dart';
import '../../../../../../help/toast/toast_states.dart';
import '../../vacation_form/controller/vacation_cubit.dart';
import '../../vacation_form/controller/vacation_state.dart';
import '../infraction_component/fom_reusable_component/form_reusable_component.dart';
import '../receipt_record_component/custom_form_field_without_border.dart';
import 'dart:ui' as ui;
class MainVacationFormComponent extends StatelessWidget {
  MainVacationFormComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VacationCubit, VacationState>(
      listener: (context, state) {
        var cubit=VacationCubit.get(context);

        if(state is SendVacationFormDataSuccessState){
         cubit.deleteAllData();
          cubit.getAllVacationsData();
       }
      },
      builder: (context, state) {
        var cubit=VacationCubit.get(context);
        return ConditionalBuilder(
            condition: state is! SendVacationFormDataLoadingState,
            builder: (context)=>Form(
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
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.r),
                          width: double.infinity,
                          height: 40.h,
                          color: index % 2 == 0 ? Colors.grey : Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(cubit.form()[index].arabicTitle, style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w300
                              ),),
                              SizedBox(width: 5.w),
                              Expanded(
                                child: MainCustomFormFieldWithoutBorder(
                                  keyBoardType: TextInputType.text,
                                  isReadOnly: true,
                                  controller: cubit.form()[index].controller,
                                  validator: (value) {
                                    if(value!.trim().isEmpty){
                                      return "لا يجب ان يكون فارغا";
                                    }
                                    return null;
                                  },

                                ),
                              ),
                              SizedBox(width: 5,),
                              Text(cubit.form()[index].englishTitle, style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w300
                              ),)
                            ],
                          ),
                        ),
                    separatorBuilder: (context, index) => SizedBox(height: 0.h,),
                    itemCount: cubit.form().length,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.r),
                    width: double.infinity,
                    height: 80.h,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Text("الاجازه المطلوبه", style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w300
                        ),),
                        SizedBox(width: 5),
                        Container(
                          width: 1.w,
                          height: 30.h,
                          color: Colors.black,
                        ),
                        SizedBox(width: 8.w,),
                        Column(
                          children: [
                            Text("من", style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w200
                            ),),
                            Text("From", style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w300
                            ),),
                          ],
                        ),
                        SizedBox(width: 3.w,),
                        Expanded(
                          child: Container(
                            width: 100.w,
                            height: 40.h,
                            child: MainCustomFormFieldWithoutBorder(
                              fontSize: 11.sp,
                              controller: cubit.vacationStartingDateController,
                              onTap: () async {
                                await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2023),
                                    lastDate: DateTime(2060)).then((value) {
                                  cubit.vacationStartingDateController.text =
                                  "${value!.year}-${value.month}-${value.day}";
                                });
                              },

                              keyBoardType: TextInputType.none,
                              validator: (value) {
                                if(value!.trim().isEmpty){
                                  return "لا يجب ان يكون فارغا";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 4.w,),
                        Column(
                          children: [
                            Text("الي", style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w200
                            ),),
                            Text("to", style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w300
                            ),),
                          ],
                        ),
                        SizedBox(width: 5.w,),
                        Expanded(
                          child: Container(

                            child: MainCustomFormFieldWithoutBorder(
                              fontSize: 11.sp,
                              controller: cubit.vacationEndingDateController,
                              onTap: () async {
                                await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2023),
                                    lastDate: DateTime(2060)).then((value) {
                                  cubit.vacationEndingDateController.text =
                                  "${value!.year}-${value.month}-${value.day}";
                                });
                              },
                              keyBoardType: TextInputType.none,
                              validator: (value) {
                                if(value!.trim().isEmpty){
                                  return "لا يجب ان يكون فارغا";
                                }
                                return null;
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.r),
                    width: double.infinity,
                    height: 80.h,
                    color: Colors.grey,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: FormReusableComponent(
                              englishTitle: "Type of vacation",
                              arabicTitle: "نوع الاجازه", isVacation: true),
                        ),
                        Expanded(
                          flex: 1,
                          child: FormReusableComponent(
                              englishTitle: "Duducted from annual leave",
                              arabicTitle: "خصم من الاجازه السنويه",
                              isVacation: true),
                        ),
                        CustomTranslateCheckBox(function: (value) {
                          cubit.changeVacationType(0);
                        }, check: cubit.isFromYearVacation),
                        Expanded(
                          flex: 1,
                          child: FormReusableComponent(
                              englishTitle: "Without Salary",
                              arabicTitle: "بدون مرتب",
                              isVacation: true),
                        ),
                        CustomTranslateCheckBox(function: (value) {
                          cubit.changeVacationType(1);
                        }, check: cubit.isWithoutSalary),
                        Expanded(
                          flex: 1,
                          child: FormReusableComponent(
                              englishTitle: "Annual Vacation",
                              arabicTitle: "سنويه",
                              isVacation: true),
                        ),
                        CustomTranslateCheckBox(function: (value) {
                          cubit.changeVacationType(2);
                        }, check: cubit.isYearVacation),


                      ],
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.r),
                    width: double.infinity,
                    height: 60.h,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: FormReusableComponent(
                            englishTitle: "Type of vacation",
                            arabicTitle: "التذاكر المطلوبه",),
                        ),
                        Expanded(
                          flex: 1,
                          child: FormReusableComponent(
                            englishTitle: "Family Only",
                            arabicTitle: "المائه فقط",
                          ),
                        ),
                        CustomTranslateCheckBox(function: (value) {
                          cubit.changeTicketType(0);
                        }, check: cubit.isHundred),
                        Expanded(
                          flex: 1,
                          child: FormReusableComponent(
                            englishTitle: "Employee &Family",
                            arabicTitle: "الموظف والعائله",
                          ),
                        ),
                        CustomTranslateCheckBox(function: (value) {
                          cubit.changeTicketType(1);
                        }, check: cubit.isEmployeeAndFamily),
                        Expanded(
                          flex: 1,
                          child: FormReusableComponent(
                            englishTitle: "Employee Only",
                            arabicTitle: "الموظف فقط",
                          ),
                        ),
                        CustomTranslateCheckBox(function: (value) {
                          cubit.changeTicketType(2);
                        }, check: cubit.isEmployee),


                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.r),
                    width: double.infinity,
                    height: 60.h,
                    color: Colors.grey,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: FormReusableComponent(
                            englishTitle: "Replacement",
                            arabicTitle: "البديل",),
                        ),
                        Expanded(
                          flex: 1,
                          child: FormReusableComponent(
                            englishTitle: "Replacement not required",
                            arabicTitle: "بديل غير مطلوب",
                          ),
                        ),
                        CustomTranslateCheckBox(function: (value) {
                          cubit.changeReplacementType(0);
                        }, check: cubit.isNotRequired),
                        Expanded(
                          flex: 1,
                          child: FormReusableComponent(
                            englishTitle: "Replacement required",
                            arabicTitle: "بديل مطلوب",
                          ),
                        ),
                        CustomTranslateCheckBox(function: (value) {
                          cubit.changeReplacementType(1);
                        }, check: cubit.isRequired),
                        Expanded(
                          flex: 1,
                          child: FormReusableComponent(
                            englishTitle: "Employee Only",
                            arabicTitle: "الموظف فقط",
                          ),
                        ),
                        CustomTranslateCheckBox(function: (value) {
                          cubit.changeReplacementType(2);
                        }, check: cubit.isEmployeeOnly),


                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.r),
                    width: double.infinity,
                    height: 40.h,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('العنوان', style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w300
                        ),),
                        SizedBox(width: 5.w),
                        Expanded(
                          child: MainCustomFormFieldWithoutBorder(
                            keyBoardType: TextInputType.text,
                            controller: cubit.addressController,
                            validator: (value) {
                              if(value!.trim().isEmpty){
                                return "لا يجب ان يكون فارغا";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 5,),
                        Text("Address", style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w300
                        ),)
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.r),
                    width: double.infinity,
                    height: 40.h,
                    color: Colors.grey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('الهاتف', style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w300
                        ),),
                        SizedBox(width: 5.w),
                        Expanded(
                          child: MainCustomFormFieldWithoutBorder(
                            keyBoardType: TextInputType.text,
                            controller: cubit.phoneController,
                            validator: (value) {
                              if(value!.trim().isEmpty){
                                return "لا يجب ان يكون فارغا";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 5,),
                        Text("Telephone", style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w300
                        ),)
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "توقيع الموظف",
                        style:
                        TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w300),
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
                                        cubit.handleClearButtonPressed(
                                            key: cubit.signatureGlobalKey);
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
                        style:
                        TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                  SizedBox(height: 20.h,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.r),
                    width: double.infinity,
                    height: 80.h,
                    color: Colors.grey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("قرار المدير المباشر", style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w300
                        ),),
                        SizedBox(width: 5),
                        Expanded(
                          child: MainCustomFormFieldWithoutBorder(
                            //height: 70,
                            keyBoardType: TextInputType.text,
                            controller: cubit.directManagerDecisionController,
                            validator: (value) {
                              if(value!.trim().isEmpty){
                                return "لا يجب ان يكون فارغا";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 5,),
                        Text("Director\'s Signature", style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w300
                        ),)
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.r),
                    width: double.infinity,
                    height: 40.h,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("المدير العام", style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w300
                        ),),
                        SizedBox(width: 5),
                        Expanded(
                          child: MainCustomFormFieldWithoutBorder(
                            keyBoardType: TextInputType.text,
                            controller: cubit.generalManagerController,
                            validator: (value) {
                              if(value!.trim().isEmpty){
                                return "لا يجب ان يكون فارغا";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 5,),
                        Text("General Manager", style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w300
                        ),)
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomBottomWithoutBorder(function: () {
                       if(cubit.imageUploaded!=null){
                         if(cubit.formKey.currentState!.validate()){
                          cubit.sendVacationFormData();
                         }
                       }else{
                         ToastConfig.showToast(msg:  "يجب تأكيد توقيع الموظف", toastStates: ToastStates.success);
                       }
                      }, text: "تم",
                        width: 120.w,
                        height: 25.h,),
                      SizedBox(width: 10.w,),
                      CustomBottomWithoutBorder(function: () {}, text: "طباعه",
                        width: 120.w,
                        height: 25.h,),
                    ],
                  ),
                ],
              ),
            ),
            fallback: (context)=>CustomCircularProgress());
      },
    );
  }

}
