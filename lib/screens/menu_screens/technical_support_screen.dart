import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/technicalSupporDetailstCubit/technical_suppor_detailst_cubit.dart';
import '../../cubits/technicalSupporDetailstCubit/technical_suppor_detailst_state.dart';
import '../../cubits/technicalSupportCubit/technical_support_cubit.dart';
import '../../cubits/technicalSupportCubit/technical_support_state.dart';
import '../../shared/defaults.dart';
import 'contact_us_screen.dart';

class TechnicalSupportScreen extends StatelessWidget {
  const TechnicalSupportScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<TechnicalSupportCubit, TechnicalSupportState>(
      builder: (context, state) {
        TechnicalSupportCubit cubit = TechnicalSupportCubit.get(context);
        state is TechnicalSupportInitial ? cubit.getTechnicalSupport():print("getdata");

        return Scaffold(
          appBar: CustomAppBar(
            title: 'TechnicalSupport'.tr(),
          ),
          body: state is!     GetTechnicalSupportSuccessState?Center(child: CircularProgressIndicator(),):Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Label(text: 'RequestHelp'.tr()),
                SizedBox(
                  height: 30,
                ),
                CustomButton(onTap: (){
                  navigateTo(context, ContactUsScreen());
                },
                  height: 50,
                  text: 'CreateRequest'.tr(),
                ),
                SizedBox(
                  height: 30,
                ),
              Expanded(
                child: ListView.builder(itemCount:cubit.AllSupportsListOfData.length ,itemBuilder: (context,pos){
                  return InkWell(onTap: (){
                    print(cubit.AllSupportsListOfData[pos].id);
                    TechnicalSupportDetailsCubit.get(context).id= cubit.AllSupportsListOfData[pos].id;
                    TechnicalSupportDetailsCubit.get(context).getTechnicalSupport() ;
                    print(TechnicalSupportDetailsCubit.get(context).id);
                    navigateTo(context, RequestCard());
                  },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 1)]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                cubit.AllSupportsListOfData[pos].name,
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                cubit.AllSupportsListOfData[pos].createdAt,
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                              Text(
                                cubit.AllSupportsListOfData[pos].updatedAt,
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(cubit.AllSupportsListOfData[pos].notes??""
                               ,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ),
                           Icon(Icons.remove_red_eye,color: cubit.AllSupportsListOfData[pos].status==0?Colors.grey:Colors.green,) ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
              )

                ,
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );

      },
    );







  }
}

class RequestCard extends StatelessWidget {
  const RequestCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return BlocBuilder<TechnicalSupportDetailsCubit, TechnicalSupportDetailstState>(
      builder: (context, state) {
        TechnicalSupportDetailsCubit cubit = TechnicalSupportDetailsCubit.get(context);


        return Scaffold(
          appBar: CustomAppBar(
            title: 'TechnicalSupport'.tr(),
          ),
          body: state is!     GetTechnicalSupportdetailstSuccessState?Center(child: CircularProgressIndicator(),):
          Container(
            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 1)]),
            child: ListView.builder(itemCount: cubit.detailsSupportDetailsData.length,itemBuilder: (context,pos){
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        cubit.detailsSupportDetailsData[pos].name,
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    cubit.detailsSupportDetailsData[0].phone,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),SizedBox(
                    height: 20,
                  ),
                  Text(
                    cubit.detailsSupportDetailsData[pos].message,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cubit.detailsSupportDetailsData[pos].updatedAt,
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        cubit.detailsSupportDetailsData[pos].createdAt,
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          cubit.detailsSupportDetailsData[pos].notes??"",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      )
                      ,   Icon(Icons.remove_red_eye,color: cubit.detailsSupportDetailsData[pos].status==0?Colors.grey:Colors.green,) ,
                    ],
                  )
                ],
              );
            })
          ),
        );

      },
    );







    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 1)]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'مشكله في الطلب الخاص بي',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '27-11-2020',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                '3:30 AM',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'تم الحل',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
