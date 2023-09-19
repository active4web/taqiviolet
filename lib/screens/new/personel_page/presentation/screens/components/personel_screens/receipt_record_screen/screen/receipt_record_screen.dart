import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../../../../shared/constants.dart';
import '../../../../../../help/custom_circular_progress/custom_circular_progress.dart';
import '../../../../../../help/custom_yellow_container.dart';
import '../../components/receipt_record_component/buttoms_component.dart';
import '../../components/receipt_record_component/muslim_convent_info_component.dart';
import '../../components/receipt_record_component/oher_data_component.dart';
import '../../components/receipt_record_component/record_component.dart';
import '../controller/receipt_record_cubit.dart';
import '../controller/receipt_record_state.dart';

class MainReceiptRecordScreen extends StatefulWidget {
  const MainReceiptRecordScreen({Key? key}) : super(key: key);

  @override
  State<MainReceiptRecordScreen> createState() => _MainReceiptRecordScreenState();
}

class _MainReceiptRecordScreenState extends State<MainReceiptRecordScreen> with SingleTickerProviderStateMixin {

  TabController? tabController;
  @override
  void initState() {
tabController=TabController(length: 2, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          // title: Text("${title}"),
          backgroundColor: Color(0xff393846),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Color(0xff393846),
              statusBarIconBrightness: Brightness.light),

          ///Color(),// Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
              color: kLightGoldColor,
              fontFamily: 'Tajawal',
              fontSize: 17),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(60),
              bottomLeft: Radius.circular(60),
            ),
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "محضر استلام",
                style: TextStyle(
                    color: kLightGoldColor, fontSize: 17),
              ),
              SizedBox(
                height: 10,
              ),


            ],
          ),
          iconTheme: IconThemeData(color: kLightGoldColor),
          actions: [
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 10),
              child: Image(
                image:
                AssetImage('assets/images/logoheader.png'),
              ),
            )
          ],
        ),
      ),
      body: BlocConsumer<ReceiptRecordCubit, ReceiptRecordState>(
        listener: (context, state) {
          var cubit = ReceiptRecordCubit.get(context);
          if (state is SendReceiptRecordFormDataSuccessState) {
            cubit.deleteAllData();
             cubit.getAllReceiptData();
          }
        },
        builder: (context, state) {
          var cubit = ReceiptRecordCubit.get(context);

          return Column(
            children: [
              TabBar(

                  controller: tabController,
                  tabs: [

                Tab(text: 'اضافة',),
                Tab(text: 'عرض',),
              ]),
              Expanded(

                  child: TabBarView(
                      controller: tabController,
                      children: [
                ConditionalBuilder(
                  condition: cubit.signatureData!=null,
                  builder: (context) => Padding(
                    padding: EdgeInsets.all(12.r),
                    child: SingleChildScrollView(
                      child: ConditionalBuilder(
                          condition: state is! SendReceiptRecordFormDataLoadingState,
                          builder: (context) => Column(
                            children: [
                              MainRecordComponent(),
                              SizedBox(
                                height: 14.h,
                              ),
                              MainMuslimConventInformation(),
                              SizedBox(
                                height: 8.h,
                              ),
                              MainOtherDataComponent(),
                              SizedBox(
                                height: 15.h,
                              ),
                              MainBottomsComponent(),
                            ],
                          ),
                          fallback: (context) => CustomCircularProgress()),
                    ),
                  ),
                  fallback: (context) => CustomCircularProgress(),
                ),
                ConditionalBuilder(
                    condition: cubit.receiptRecordModel!=null,
                    builder: (context)=>ConditionalBuilder(
                        condition: cubit.receiptRecordModel!.data!.isNotEmpty,
                        builder: (context)=>Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Column(
                            children: [
                              CustomYellowContainer(
                                widget: Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                          "رقم الطلب",
                                          style: Theme.of(context).textTheme.subtitle1,
                                          textAlign: TextAlign.center,
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                          "تاريخ الطلب",
                                          style: Theme.of(context).textTheme.subtitle1,
                                          textAlign: TextAlign.center,
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                          "الحالة",
                                          style: Theme.of(context).textTheme.subtitle1,
                                          textAlign: TextAlign.center,
                                        )),
                                    Expanded(
                                      child: Text(
                                        "المزيد",
                                        style: Theme.of(context).textTheme.subtitle1,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              SizedBox(height: 8.h,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: ListView.separated(
                                  shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context,index)=>Container(
                                      color: index%2!=0?Colors.white:Colors.grey,
                                      child: Row(
                                        children: [
                                          Expanded(child: Text(cubit.receiptRecordModel!.data![index].id.toString(),
                                          style: Theme.of(context).textTheme.headline3,
                                          textAlign: TextAlign.center,)),
                                          Expanded(child: Text(cubit.receiptRecordModel!.data![index].date.toString(),
                                          style: Theme.of(context).textTheme.headline3,
                                            textAlign: TextAlign.center,)),
                                          Expanded(
                                              child: Text(
                                                cubit.receiptRecordModel!.data![index].approve==0?'لم يتم الموافقه':'تمت الموافقه',
                                          style: Theme.of(context).textTheme.headline3,)),
                                          Expanded(
                                              child: Icon(Icons.more_horiz,size: 18,)),
                                        ],
                                      ),
                                    ),
                                    separatorBuilder: (context,index)=>SizedBox(height: 2.h,),
                                    itemCount: cubit.receiptRecordModel!.data!.length),
                              )
                            ],
                          ),
                        ),
                        fallback: (context)=>Text("لا يوجد اي طلبات",
                        style: Theme.of(context).textTheme.headline3,)),
                    fallback: (context)=>CustomCircularProgress()),
              ]))
            ],
          );
        },
      ),
    );
  }
}
