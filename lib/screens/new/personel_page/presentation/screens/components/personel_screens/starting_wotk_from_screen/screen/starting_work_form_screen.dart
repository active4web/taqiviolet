import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../../../../shared/constants.dart';
import '../../../../../../help/app_strings.dart';
import '../../../../../../help/custom_circular_progress/custom_circular_progress.dart';
import '../../../../../../help/custom_yellow_container.dart';
import '../../components/receipt_record_component/custom_form_field_without_border.dart';
import '../../components/starting_work_component/starting_work_form.dart';
import '../controller/starting_work_cubit.dart';
import '../controller/starting_work_state.dart';

class MainStartingWorkFormScreen extends StatefulWidget {
   const MainStartingWorkFormScreen({Key? key}) : super(key: key);

  @override
  State<MainStartingWorkFormScreen> createState() => _MainStartingWorkFormScreenState();
}

class _MainStartingWorkFormScreenState extends State<MainStartingWorkFormScreen> with SingleTickerProviderStateMixin {

  TabController? tabController;

  @override
  void initState() {
    tabController=TabController(length: 2, vsync: this);
    StartingWorkCubit.get(context).getSignatureData();
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
                'مباشرة عمل',
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
      body: BlocConsumer<StartingWorkCubit, StartingWorkState>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit=StartingWorkCubit.get(context);
    return  Column(
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
                  Padding(
                    padding:  EdgeInsets.all(15.r),
                    child: SingleChildScrollView(
                      child: ConditionalBuilder(
                          condition: cubit.signatureData!=null,
                          builder: (context)=>Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppStrings.arabicStartWork,
                                    style: Theme.of(context).textTheme.bodyText1,
                                  ),
                                  Text(
                                    AppStrings.englishStartWork,
                                    style: Theme.of(context).textTheme.bodyText1,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "رقم",
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                        fontSize: 15.sp
                                    ),
                                  ),
                                  Container(
                                    width: 100.w,
                                    height: 30.h,
                                    child: MainCustomFormFieldWithoutBorder(
                                        controller: cubit.numberController,
                                        validator: (value){},
                                        keyBoardType: TextInputType.number),
                                  ),
                                  Text(
                                    "No:",
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                        fontSize: 15.sp
                                    ),
                                  ),
                                  Text(
                                    "التاريخ",
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                        fontSize: 15.sp
                                    ),
                                  ),
                                  Container(
                                    width: 100.w,
                                    height: 30.h,
                                    child: TextFormField(
                                      controller: cubit.dateController,
                                      decoration:InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                      ),
                                      keyboardType: TextInputType.none,
                                    ),
                                  ),
                                  Text(
                                    "Date:",
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                        fontSize: 15.sp
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              MainStartingWorkForm()
                            ],
                          ),
                          fallback: (context)=>CustomCircularProgress()),
                    ),
                  ),
                  ConditionalBuilder(
                      condition: cubit.startWorkModel!=null,
                      builder: (context)=>ConditionalBuilder(
                          condition: cubit.startWorkModel!.data!.isNotEmpty,
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
                                            Expanded(child: Text(cubit.startWorkModel!.data![index].id.toString(),
                                              style: Theme.of(context).textTheme.headline3,
                                              textAlign: TextAlign.center,)),
                                            Expanded(child: Text(cubit.startWorkModel!.data![index].date.toString(),
                                              style: Theme.of(context).textTheme.headline3,
                                              textAlign: TextAlign.center,)),
                                            Expanded(
                                                child: Text(
                                                  cubit.startWorkModel!.data![index].approve==0?'لم يتم الموافقه':'تمت الموافقه',
                                                  style: Theme.of(context).textTheme.headline3,)),
                                            Expanded(
                                                child: Icon(Icons.more_horiz,size: 18,)),
                                          ],
                                        ),
                                      ),
                                      separatorBuilder: (context,index)=>SizedBox(height: 2.h,),
                                      itemCount: cubit.startWorkModel!.data!.length),
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
