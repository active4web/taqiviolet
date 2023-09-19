import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import '../../../../../../help/app_strings.dart';
import '../../receipt_record_screen/controller/receipt_record_cubit.dart';
import '../../receipt_record_screen/controller/receipt_record_state.dart';
import 'custom_form_field_without_border.dart';
import 'dart:ui' as ui;
class MainOtherDataComponent extends StatelessWidget {
  const MainOtherDataComponent({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReceiptRecordCubit, ReceiptRecordState>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit=ReceiptRecordCubit.get(context);
    return Form(
      key: cubit.formKey2,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Text(
                      AppStrings.arabicAcknowledgeStatement,
                      style:
                          TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w200),
                    )),
                Expanded(
                    flex: 2,
                    child: Text(
                      AppStrings.englishAcknowledgeStatement,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: List.generate(
                cubit.otherData().length,
                (index) => Expanded(
                  child: Container(
                      decoration: const BoxDecoration(color: Colors.grey),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            cubit.otherData()[index].arabicTitle,
                            style: TextStyle(
                                fontWeight: FontWeight.w200, fontSize: 10),
                          ),
                          Text(
                           cubit.otherData()[index].englishTitle,
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 10),
                          ),
                          SizedBox(
                            child: MainCustomFormFieldWithoutBorder(
                              isCenter: true,
                                controller: index==0?cubit.statementController:index==1?cubit.numberController:cubit.notesController,
                                validator: (value) {
                                if(value!.trim().isEmpty){
                                  return 'يجب ان لا يكون فارغ';
                                }
                                return null;
                                },
                                keyBoardType:index!=1 ?TextInputType.text:TextInputType.number),
                          )
                        ],
                      )),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Text('تاريخ الاستلام:',style: Theme.of(context).textTheme.headline3!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp
                ),),
                SizedBox(width: 8.w,),
                Text(cubit.dateOfDay,style: Theme.of(context).textTheme.headline3!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp
                ),)
              ],
            ),
            SizedBox(
              height: 35.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "توقيع الموظف",
                  style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w300),
                ),
                Expanded(
                  child: SizedBox(
                    height: 80.h,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SfSignaturePad(
                              key: cubit.signatureGlobalKey,
                              backgroundColor: Colors.white,
                              strokeColor: Colors.black,
                              minimumStrokeWidth: 1.0,
                              maximumStrokeWidth: 4.0),
                        ),
                        Center(
                          child: Row(
                            children: [
                              InkWell(
                                  onTap: () {
                                    cubit.handleSaveButtonPressed(
                                        context: context, ui: ui.ImageByteFormat.png);
                                  },
                                  child: const Icon(Icons.done)),
                              InkWell(
                                  onTap: () {
                                    cubit.handleClearButtonPressed();
                                  },
                                  child: const Icon(Icons.delete)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Text(
                  "Signature",
                  style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w300),
                )
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  },
);
  }
}
