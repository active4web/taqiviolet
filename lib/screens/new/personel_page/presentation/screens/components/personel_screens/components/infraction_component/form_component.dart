import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/screens/new/personel_page/help/toast/toast.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import '../../../../../../../../../shared/constants.dart';
import '../../../../../../../../../shared/defaults.dart';
import '../../../../../../help/custom_bottom_without_border.dart';
import '../../../../../../help/custom_specific_drop_down/custom_specific_drop_down.dart';
import '../../../../../../help/toast/toast_states.dart';
import '../../infraction_screen/controller/infraction_cubit.dart';
import '../../infraction_screen/controller/infraction_state.dart';
import '../receipt_record_component/custom_form_field_without_border.dart';
import 'fom_reusable_component/form_reusable_component.dart';
import 'dart:ui' as ui;
class MainFormComponent extends StatelessWidget {
  MainFormComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InfractionCubit, InfractionState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = InfractionCubit.get(context);
        return Form(
          key: cubit.formKey,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.r),
                width: double.infinity,
                color: Colors.grey,
                height: 40.h,
                child: Row(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "اسم الموظف",
                      style:
                          TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(width: 5.w),
                Expanded(
                  child: CustomSpecificDropDown(
                      borderColor: Colors.grey,
                      initialValue: cubit.selectedEmployee ?? "",
                      hintText: cubit.selectedEmployee ?? "test",
                      listItems: cubit.employees,
                      validator: (value) {},
                      onChange: (value) {
                        cubit.changeSelectedEmployee(value!);
                      },
                      hintColor: Colors.black),
                ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Name",
                      style:
                          TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.r),
                  width: double.infinity,
                  height: 40.h,
                  color: index % 2 != 0 ? Colors.grey : Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cubit.from()[index].arabicTitle,
                        style: TextStyle(
                            fontSize: 10.sp, fontWeight: FontWeight.w300),
                      ),
                      Expanded(
                        child: MainCustomFormFieldWithoutBorder(
                          keyBoardType: TextInputType.text,
                          controller: cubit.from()[index].controller,
                          validator: (value) {
                            if(value!.trim().isEmpty){
                              return 'لا يجب ان يكون فارغ';
                            }
                            return null;
                          },
                        ),
                      ),
                      Text(
                        cubit.from()[index].englishTitle,
                        style: TextStyle(
                            fontSize: 10.sp, fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(
                  height: 8.h,
                ),
                itemCount: cubit.from().length,
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormReusableComponent(
                      englishTitle: 'Punishment', arabicTitle: 'نوع العقوبه'),
                  FormReusableComponent(
                      englishTitle: 'Deduction', arabicTitle: 'خصم'),
                  SizedBox(
                      width: 10.w,
                      height: 10.h,
                      child: Transform.translate(
                        offset: const Offset(0, 6),
                        child: Checkbox(
                          // activeColor: Colors.green,
                          value: cubit.isDeduction,
                          onChanged: (value) {
                            cubit.changePunishmentType(0);
                          },
                          checkColor: kCustomBlack,
                        ),
                      )),
                  FormReusableComponent(
                      englishTitle: 'Days/Hours', arabicTitle: 'عدد الايام/'),
                  SizedBox(
                    width: 10.w,
                    height: 10.h,
                    child: MainCustomFormFieldWithoutBorder(
                        controller: TextEditingController(),
                        validator: (value) {},
                        keyBoardType: TextInputType.number),
                  ),
                  FormReusableComponent(
                      englishTitle: 'Notes To File', arabicTitle: 'لفت نظر'),
                  SizedBox(
                      width: 10.w,
                      height: 10.h,
                      child: Transform.translate(
                        offset: const Offset(0, 6),
                        child: Checkbox(
                          // activeColor: Colors.green,
                          value: cubit.isNotes,
                          onChanged: (value) {
                            cubit.changePunishmentType(1);
                          },
                          checkColor:kCustomBlack,
                        ),
                      )),
                  FormReusableComponent(
                      englishTitle: 'Warning Letter', arabicTitle: 'انذار'),
                  SizedBox(
                      width: 10.w,
                      height: 10.h,
                      child: Transform.translate(
                        offset: Offset(0, 6),
                        child: Checkbox(
                          // activeColor: Colors.green,
                          value: cubit.isWarning,
                          onChanged: (value) {
                            cubit.changePunishmentType(2);
                          },
                          checkColor:kCustomBlack,
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.r),
                width: double.infinity,
                height: 40.h,
                color: Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "الاجراء الاداري",
                      style:
                          TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: MainCustomFormFieldWithoutBorder(
                        keyBoardType: TextInputType.text,
                        controller: cubit.procedureController,
                        validator: (value) {
                          if(value!.trim().isEmpty){
                            return 'لا يجب ان يكون فارغ';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Adminstrative Procedure",
                      style:
                          TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "توقيع الموظف",
                    style:
                        TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: SizedBox(
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
                      style:
                          TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: MainCustomFormFieldWithoutBorder(
                        keyBoardType: TextInputType.text,
                        controller: cubit.directManagerDescisionController,
                        validator: (value) {
                          if(value!.trim().isEmpty){
                            return 'لا يجب ان يكون فارغ';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Director\'s Signature",
                      style:
                          TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w300),
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
                height: 75.h,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "المدير العام",
                      style:
                          TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: MainCustomFormFieldWithoutBorder(
                        keyBoardType: TextInputType.text,
                        controller: cubit.generalManagerController,
                        validator: (value) {
                          if(value!.trim().isEmpty){
                            return 'لا يجب ان يكون فارغ';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "General Manager",
                      style:
                          TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomBottomWithoutBorder(
                    function: () {
                     if(cubit.imageUploaded!=null){
                       if(cubit.formKey.currentState!.validate()){
                         cubit.sendInfractionData();
                       }
                     }else{
                       ToastConfig.showToast(msg:  "يجب تأكيد توقيع الموظف", toastStates: ToastStates.success);}
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
        );
      },
    );
  }
}
