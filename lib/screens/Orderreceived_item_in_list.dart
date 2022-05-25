
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/appCubit/app_cubit.dart';
import '../cubits/orderReceivedItemInList/order_received_item_in_list_cubit.dart';
import '../shared/components/custom_app_bar.dart';
import '../shared/components/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
class OrderReceivedItemInList extends StatefulWidget {


  @override
  _OrderReceivedItemInListState createState() => _OrderReceivedItemInListState();
}

class _OrderReceivedItemInListState extends State<OrderReceivedItemInList> {
  @override
  Widget build(BuildContext context) {
    OrderReceivedItemInListCubit cubit=OrderReceivedItemInListCubit.get(context);
  //  cubit. state is OrderReceivedItemInListInitial ?cubit.getOrderReceivedData():print("hh");
    return SafeArea(
      child: Scaffold(appBar: CustomAppBar(title:"المنتجات" ),
        body: BlocConsumer<OrderReceivedItemInListCubit, OrderReceivedItemInListState>(
          listener: (context, state) {
            // TODO: implement listener


          },
          builder: (context, state) {


            return  cubit.orderReceivedItemInListModel==null
                ? Center(
              child: CircularProgressIndicator(),
            )
                : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [

                  //
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child:
                  //
                  //   Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //
                  //         Text("المنتجات",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                  //       ]),
                  // ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: cubit.orderReceivedItemInListModel.data.length,
                        itemBuilder: (context, pos) {
                          return Card(
                            child: Column( children: [

                              Container(height: MediaQuery.of(context).size.height*.3,width: MediaQuery.of(context).size.width,decoration: BoxDecoration(image: DecorationImage(image:NetworkImage(cubit.orderReceivedItemInListModel.data
                              [pos].images) ))),
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
                                    Text(cubit.orderReceivedItemInListModel.data
                                    [pos].name.toString()),
                                    Text("name"),
                                  ],
                                ),
                              ),


                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(cubit.orderReceivedItemInListModel.data
                                    [pos].price.toString()),
                                    Text("price"),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(cubit.orderReceivedItemInListModel.data
                                    [pos].details.toString()),
                                    Text("Details".tr()),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(cubit.orderReceivedItemInListModel.data
                                    [pos].quantity.toString()),
                                    Text("quantity"),
                                  ],
                                ),
                              ),
                              CustomButton(onTap: (){




                                 //
                                AppCubit.get(context)..AddToCart(quantity: cubit.orderReceivedItemInListModel.data
                                [pos].quantity,product_id:  cubit.orderReceivedItemInListModel.data
                                [pos].id);


                              },height: 50,text: "AddToCart".tr(),)



                            ]),
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