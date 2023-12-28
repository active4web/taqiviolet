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
import '../../components/vacation_component/vacation_form_component.dart';
import '../controller/vacation_cubit.dart';
import '../controller/vacation_state.dart';

class MainVacationFormScreen extends StatefulWidget {
  const MainVacationFormScreen({Key? key}) : super(key: key);

  @override
  State<MainVacationFormScreen> createState() => _MainVacationFormScreenState();
}

class _MainVacationFormScreenState extends State<MainVacationFormScreen> with SingleTickerProviderStateMixin {

  TabController? tabController;
@override
  void initState() {
  tabController=TabController(length: 2, vsync: this);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VacationCubit, VacationState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var cubit=VacationCubit.get(context);
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
                'نموذج طلب اجازة',
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
      body:  Column(
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
                      padding: EdgeInsets.all(15.r),
                      child: SingleChildScrollView(
                        child: ConditionalBuilder(
                            condition: cubit.signatureData!=null,
                            builder: (context)=>Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppStrings.vacationFormAr,
                                      style: Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Text(
                                      AppStrings.vacationFormEn,
                                      style: Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                MainVacationFormComponent()
                              ],
                            ),
                            fallback: (context)=>CustomCircularProgress()),
                      ),
                    ),
                    ConditionalBuilder(
                        condition: cubit.vacationModel!=null,
                        builder: (context)=>ConditionalBuilder(
                            condition: cubit.vacationModel!.data!.isNotEmpty,
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
                                              Expanded(child: Text(cubit.vacationModel!.data![index].id.toString(),
                                                style: Theme.of(context).textTheme.headline3,
                                                textAlign: TextAlign.center,)),
                                              Expanded(child: Text(cubit.vacationModel!.data![index].from.toString(),
                                                style: Theme.of(context).textTheme.headline3,
                                                textAlign: TextAlign.center,)),
                                              Expanded(
                                                  child: Text(
                                                    cubit.vacationModel!.data![index].approve==0?'لم يتم الموافقه':'تمت الموافقه',
                                                    style: Theme.of(context).textTheme.headline3,)),
                                              Expanded(
                                                  child: Icon(Icons.more_horiz,size: 18,)),
                                            ],
                                          ),
                                        ),
                                        separatorBuilder: (context,index)=>SizedBox(height: 2.h,),
                                        itemCount: cubit.vacationModel!.data!.length),
                                  )
                                ],
                              ),
                            ),
                            fallback: (context)=>Text("لا يوجد اي طلبات",
                              style: Theme.of(context).textTheme.headline3,)),
                        fallback: (context)=>CustomCircularProgress()),
                  ]))
        ],
      ),
    );
  },
);
  }
}
