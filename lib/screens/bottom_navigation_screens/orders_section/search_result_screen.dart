import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/screens/bottom_navigation_screens/orders_section/pending_orders_screen.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import '../../../cubits/appCubit/app_cubit.dart';
import '../../../cubits/my_orders_cubit.dart';
import '../../../shared/constants.dart';
import 'package:easy_localization/easy_localization.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'searchResult'.tr(),
      ),
      body: BlocConsumer<MyOrdersCubit, MyOrdersState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit=MyOrdersCubit.get(context);
          return cubit.searchOrderModel == null
              ? Center(
            child: CircularProgressIndicator(),
          )
              :
          MyOrdersCubit.get(context).searchOrderModel?.data?.length==0 ?
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                height: 200.h,
                image:
                NetworkImage("$MBaseUrl"+"${AppCubit.get(context).emptyImages?.data?[2].value??''}"),

              ),
              Text(AppCubit.get(context).emptyImages?.data?[2].title??'',style: TextStyle(
                  color: Colors.grey,fontSize: 16.sp
              ),),
              SizedBox(height: 50.h,)
            ],
          ):
          ListView.separated(
              padding: const EdgeInsets.all(22),
              itemBuilder: (context, index) {

                return CustomOrder(myOrdersData: cubit.searchOrderModel!.data![index],
                  status: int.parse(cubit.searchOrderModel?.data?[index].status??'0'),);
                // OrderStatusCard(
                //   myOrdersData: cubit.previousOrders!.data![index]);
              },
              separatorBuilder: (context, index) => SizedBox(
                height: 4.h,
              ),
              itemCount:
              MyOrdersCubit.get(context).searchOrderModel?.data?.length??0);
        },
      ),
    );
  }
}
