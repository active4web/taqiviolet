import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/screens/check_out_screen.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:safsofa/shared/defaults.dart';

import '../../cubits/appCubit/app_cubit.dart';
import '../../cubits/cartCubit/cart_cubit.dart';
import '../../cubits/cartCubit/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../network/local/cache_helper.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  if(CartCubit.get(context).state is CartStateInitial) CartCubit.get(context).getCartData();
    CartCubit cubit = CartCubit.get(context);
    // if(CartCubit.get(context).state is CartStateInitial) cubit.getCartData();
    //   cubit.getCartData();
    print("getCartData");
    // //  cubit.getCartData() ;
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        print("state is $state");
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Cart'.tr(),
          ),
          body: state is CartStateSuccessState

              ?  SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                children: [
                  ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child:



        // Column(
        //                     children: [
        //                       Padding(
        //                         padding: const EdgeInsets.all(8.0),
        //                         child: Text(CacheHelper.getData("lan") == "ar"
        //                             ? cubit.myCartModel.data[index].name.ar??""
        //                             : CacheHelper.getData("lan") == "en"
        //                                 ? cubit.myCartModel.data[index].name.en??""
        //                                 : cubit
        //                                     .myCartModel.data[index].name.it??""),
        //                       ),
        //                       Padding(
        //                         padding: const EdgeInsets.all(8.0),
        //                         child: Text( cubit
        //                             .myCartModel.data[index].price.toString()),
        //                       ), Padding(
        //                         padding: const EdgeInsets.all(8.0),
        //                         child: Text( "discount".tr()+cubit
        //                             .myCartModel.data[index].discount??"0"),
        //                       ) ,Padding(
        //                         padding: const EdgeInsets.all(8.0),
        //                         child: Text( cubit
        //                             .myCartModel.data[index].quantity),
        //                       )   ,Padding(
        //                         padding: const EdgeInsets.all(8.0),
        //                         child: Text( CacheHelper.getData("lan") == "ar"
        //                             ? cubit.myCartModel.data[index].details.ar??""
        //                             : CacheHelper.getData("lan") == "en"
        //                             ? cubit.myCartModel.data[index].details.en??""
        //                             : cubit
        //                             .myCartModel.data[index].details.it??""),
        //                       )      ],
        //                   )

                          Row(
                            children: [
                              Flexible(
                                flex: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xfff4f4f4),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            cubit.myCartModel.data[index].images)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Flexible(
                                flex: 5,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 10, top: 20),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width *
                                            0.45,
                                        child: Text(
                                          cubit.myCartModel.data[index].name,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
        cubit
                                  .myCartModel.data[index].price.toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'ريال',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            cubit.myCartModel.data[index].quantity.toString(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black54),
                                          ),
                                          Container(
                                            height: 20,
                                            width: 1,
                                            color: Colors.black26,
                                          ),

                                        ],
                                      ),
                                      CounterRow(quantity:  cubit.myCartModel.data[index].quantity.toString(),onAdd: (){
                                        // print("999999999999999999");
                                        // int.parse(cubit.myCartModel.data[index].quantity)+1;
                                        //
                                        // print(  int.parse(cubit.myCartModel.data[index].quantity)+1);
                                        cubit.addquantity(product_id:cubit.myCartModel.data[index].id ,product_quantity:   cubit.myCartModel.data[index].quantity+1 );
                                      },onRemove: (){
                                        cubit.addquantity(product_id:cubit.myCartModel.data[index].id ,product_quantity: cubit.myCartModel.data[index].quantity-1 );
                                     //  cubit.myCartModel.data[index].quantity-1;
                                     //   print(   cubit.myCartModel.data[index].quantity-1);
                                        print("111111111111111111");
                                      }),   ],
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {

cubit.delITemFRomCart(product_id:cubit.myCartModel.data[index].id);



                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: Color(0xffFE9C8F),
                                      ),
                                    ),
                                    Spacer()
                                  ],
                                ),
                              )
                            ],
                          ),
                          ),
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: cubit.myCartModel.data.length),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Label(
                        text: 'Total'.tr(),
                      ),
                      Text(
                       cubit.total.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black54),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    height: 50,
                    text: 'CheckOut'.tr(),
                    onTap: () {
                      navigateTo(context, CheckOutScreen());
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  )
                ],
              ),
            ),
          ):Center(child: CircularProgressIndicator(),) ,
        );
      },
    );
  }
}

class CounterRow extends StatelessWidget {
  const CounterRow({
    Key key,
    this.containerSize = 25,
    this.fontSize = 14,
    this.quantity ="",
    this.onAdd,
    this.onRemove,
  }) : super(key: key);

  final double containerSize;
  final double fontSize;
  final String quantity;
  final Function onAdd;
  final Function onRemove;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onAdd,
          child: Container(
            width: containerSize,
            height: containerSize,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(50)),
            child: Center(
              child: Icon(
                Icons.add,
                color: Colors.black54,
                size: fontSize,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          width: 35,
          child: Center(
            child: Text(quantity.toString(),
                style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54)),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        GestureDetector(
          onTap: onRemove,
          child: Container(
            width: containerSize,
            height: containerSize,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(50)),
            child: Center(
              child: Icon(
                Icons.remove,
                color: Colors.black54,
                size: fontSize,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
