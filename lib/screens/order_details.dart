import 'package:flutter/material.dart';

import '../cubits/cubit/getdataprofile_cubit.dart';
import '../cubits/order_details_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components/custom_app_bar.dart';
class OrderDetailsSCR extends StatefulWidget {
  int id;

  OrderDetailsSCR(this.id);

  @override
  _OrderDetailsSCRState createState() => _OrderDetailsSCRState();
}

class _OrderDetailsSCRState extends State<OrderDetailsSCR> {

  @override
  Widget build(BuildContext context) {
    OrderDetailsCubit cubit=OrderDetailsCubit.get(context);
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<OrderDetailsCubit, OrderDetailsState>(
  listener: (context, state) {

  },
  builder: (context, state) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "تفاصيل الطلب",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:cubit.orderDetails==null?Center(child: CircularProgressIndicator(),): Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(),
                  child: Column(
                      children: [Text("الطلب"), Text(widget.id.toString() ) ]),
                ),
              ),
              Container(
                height: size.height * .3,
                child: ListView.builder(
                    itemCount: cubit.orderDetails.data.length,
                    itemBuilder: (context, pos) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Text(cubit.orderDetails.data[pos].price),
                          Text(cubit.orderDetails.data[pos].name.ar),],
                      );
                    }),
              ),
              customRow(lab: "السعر", val: cubit.total.toString()),
              customRow(lab: "خدمه التوصيل", val: "0"),
              customRow(lab: "قصيمة الخصم", val: "0"),
              Divider(
                height: 1,
              ),
              customRow(lab: "الاجمالي", val:  cubit.total.toString()),
              Text("طريقه الدفع"),
              Text("vi"),
              Text("العنوان"),
              Text(GetdataprofileCubit.get(context).getdataprofileModel.address),


        Divider(
          height: 1,
        )

         ,   Padding(
           padding: const EdgeInsets.all(8.0),
           child: Container(alignment:Alignment.center,child: Column(children: [Padding(
             padding: const EdgeInsets.all(8.0),
             child: Text("الاجمالي"),
           ),Text(cubit.getALLTotal()),]),),
         )]),
      ),
    );
  },
);
  }

  Widget customRow({String lab, String val}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          "$val  ريال",
          style: TextStyle(color: Colors.orange),
        ),
        Text(lab),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

  }
}
