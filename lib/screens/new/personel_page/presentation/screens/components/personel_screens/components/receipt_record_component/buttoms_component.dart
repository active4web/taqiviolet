import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/screens/new/personel_page/help/toast/toast.dart';
import '../../../../../../help/custom_bottom_without_border.dart';
import '../../../../../../help/toast/toast_states.dart';
import '../../receipt_record_screen/controller/receipt_record_cubit.dart';
import '../../receipt_record_screen/controller/receipt_record_state.dart';


class MainBottomsComponent extends StatelessWidget {
  const MainBottomsComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReceiptRecordCubit, ReceiptRecordState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit=ReceiptRecordCubit.get(context);
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomBottomWithoutBorder(function: () {
              print("image: ${cubit.imageUploaded}");
              if(cubit.imageUploaded!=null){
                if(cubit.formKey.currentState!.validate() && cubit.formKey2.currentState!.validate()){
                  // cubit.sendReceiptRecordFormData();
                }
              }
              else{
                ToastConfig.showToast(msg: 'يجب عليك تأكيد توقيع الموظف', toastStates: ToastStates.success);
              }
            }, text: "تم",
              width: 120.w,
              height: 25.h,),
            SizedBox(width: 10.w,),
            CustomBottomWithoutBorder(function: () {}, text: "طباعه",
              width: 120.w,
              height: 25.h,),
          ],
        );
      },
    );
  }
}
