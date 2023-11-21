import 'package:flutter/material.dart%20';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';

class FinancialReportsScreen extends StatelessWidget {
  const FinancialReportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'financialReports'.tr(),),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text("المتبقى"),
                      Text("200"),
                    ],
                  ),
                  Column(
                    children: [
                      Text("الربح"),
                      Text("200"),
                    ],
                  ),
                  Column(
                    children: [
                      Text("رأس المال"),
                      Text("200"),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Expanded(
                    child: InkWell(
                      onTap: (){

                      },
                      child: Container(
                        child:  Center(
                          child: Text(
                            "الارباح والخساير",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                      ),
                    )),
                SizedBox(width: 10,),
                Expanded(
                    child: InkWell(
                      onTap: (){

                      },
                      child: Container(
                        child:  Center(
                          child: Text(
                            "اجمالى الدخل",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){

                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child:  Center(
                      child: Text(
                        "المصروفات الكلية",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
                // SizedBox(width: 10,),
                // Expanded(
                //     child: InkWell(
                //       onTap: (){
                //
                //       },
                //       child: Container(
                //         child:  Center(
                //           child: Text(
                //             "بنود غير مسواة",
                //             style: TextStyle(
                //               fontSize: 20,
                //               color: Colors.black87,
                //             ),
                //           ),
                //         ),
                //         height: 120,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(10),
                //           color: Colors.white,
                //           border: Border.all(
                //             color: Colors.grey.withOpacity(0.5),
                //           ),
                //         ),
                //       ),
                //     )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
