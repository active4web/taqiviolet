import 'dart:developer';

import 'package:flutter/material.dart';

import '../cubits/OrderReceived/order_received_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';


import '../cubits/orderReceivedItemInList/order_received_item_in_list_cubit.dart';
import '../shared/defaults.dart';
import 'Orderreceived_item_in_list.dart';

class OrderReceived extends StatefulWidget {
  const OrderReceived({Key key}) : super(key: key);

  @override
  _OrderReceivedState createState() => _OrderReceivedState();
}

class _OrderReceivedState extends State<OrderReceived> {
  @override
  Widget build(BuildContext context) {
    OrderReceivedCubit cubit=OrderReceivedCubit.get(context);
   cubit. state is OrderReceivedInitial ?cubit.getOrderReceivedData():log("hh");
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<OrderReceivedCubit, OrderReceivedState>(
          listener: (context, state) {
            // TODO: implement listener


          },
          builder: (context, state) {


            return  cubit.reOrderModel==null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("قائمة التسوق",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                                Text("قوائمك",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                              ]),
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: cubit.reOrderModel.data.length,
                              itemBuilder: (context, pos) {
                                return InkWell(onTap: (){
                                 // OrderReceivedItemInList
                                  OrderReceivedItemInListCubit.get(context).getOrderReceivedData(cubit.reOrderModel.data[pos].id.toString());

                                  navigateTo(context, OrderReceivedItemInList());
                                },
                                  child: Card(
                                    child: Column( children: [
                                      SizedBox(height: 10,),
                                      Row(     mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,children: [IconButton(onPressed: (){
                           //   cubit.postdeletItemlistsData(id: cubit.dataInList.data.products[pos].id.toString());


                                      }, icon: Icon(Icons.clear)),SizedBox()]),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(cubit.reOrderModel.data
                                                [pos].id.toString()),
                                            Text("ID"),
                                          ],
                                        ),
                                      ),


                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(cubit.reOrderModel.data
                                                [pos].total.toString()),
                                            Text("total"),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(cubit.reOrderModel.data
                                            [pos].codeOrder.toString()),
                                            Text("codeOrder"),
                                          ],
                                        ),
                                      ),     Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(cubit.reOrderModel.data
                                            [pos].deliveryCost.toString()),
                                            Text("deliveryCost"),
                                          ],
                                        ),
                                      ),              ]),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
