import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../help/app_strings.dart';
import '../../receipt_record_screen/controller/receipt_record_cubit.dart';
import '../../receipt_record_screen/controller/receipt_record_state.dart';
import 'custom_form_field_without_border.dart';

class MainMuslimConventInformation extends StatelessWidget {
  MainMuslimConventInformation({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReceiptRecordCubit, ReceiptRecordState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var cubit=ReceiptRecordCubit.get(context);
    return Form(
      key: cubit.formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const  Expanded(
                child:  Text(AppStrings.arabicMuslimConventInfo,
                ),
              ),
              Text(AppStrings.englishMuslimConventInfo,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 15.sp
                ),),

            ],
          ),
          SizedBox(height: 14.h,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.r),
            width: double.infinity,
            color: Colors.grey,
            height: 40.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("اسم الموظف",style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w300
                ),),
                SizedBox(width: 5.w),
                Expanded(
                  child: MainCustomFormFieldWithoutBorder(
                      controller: cubit.nameController, validator: (value){
                    if(value!.trim().isEmpty){
                      return 'يجب ان لا يكون فارغ';
                    }
                    return null;
                  }, keyBoardType: TextInputType.text),
                ),
                SizedBox(width: 5,),
                Text("Name",style: TextStyle(
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
            color:Colors.white,
            child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("الادارة",style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w300
                ),),
                SizedBox(width: 5.w),
                Expanded(
                  child: MainCustomFormFieldWithoutBorder(
                      controller: cubit.departmentNameController,
                      validator: (value){
                        if(value!.trim().isEmpty){
                          return 'يجب ان لا يكون فارغ';
                        }
                        return null;
                      }, keyBoardType: TextInputType.text),
                ),
                SizedBox(width: 5,),
                Text("Department",style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w300
                ),)
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) =>
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.r),
                  width: double.infinity,
                  height: 40.h,
                  color: index%2==0?Colors.grey:Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(cubit.form()[index].arabicTitle,style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w300
                      ),),
                      SizedBox(width: 5.w),
                      Expanded(
                        child: MainCustomFormFieldWithoutBorder(controller: cubit.form()[index].controller, validator: (value){
                          if(value!.trim().isEmpty){
                            return 'يجب ان لا يكون فارغ';
                          }
                          return null;
                        }, keyBoardType: TextInputType.text),
                      ),
                      SizedBox(width: 5,),
                      Text(cubit.form()[index].englishTitle,style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w300
                      ),)
                    ],
                  ),
                ),
            separatorBuilder: (context, index) => SizedBox(height: 0.h,),
            itemCount: cubit.form().length,),
        ],
      ),
    );
  },
);
  }
}
