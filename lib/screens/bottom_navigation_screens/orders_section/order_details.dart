import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/screens/add_review_screen.dart';
import 'package:safsofa/shared/constants.dart';

import '../../../cubits/order_details_cubit.dart';
import '../../../shared/components/custom_app_bar.dart';

class OrderDetailsSCR extends StatelessWidget {
  final int id;

  OrderDetailsSCR({
    @required this.id,
  });

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderDetailsCubit()..getOrderDetails(id),
      child: BlocConsumer<OrderDetailsCubit, OrderDetailsState>(
        listener: (context, state) {},
        builder: (context, state) {
          OrderDetailsCubit cubit = OrderDetailsCubit.get(context);
          return Scaffold(
            appBar: CustomAppBar(
              title: "OrderDetails".tr(),
            ),
            body: state is! OrderDetailsSuccessState &&
                    cubit.orderDetails == null
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.all(16.0),
                    physics: BouncingScrollPhysics(),
                    children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(),
                            child: Column(children: [
                              Text(
                                "OrderNumber".tr(),
                                style: TextStyle(fontSize: 24),
                              ),
                              Text(
                                '#${cubit.orderDetails.data.orderDetails.codeOrder}',
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                  fontSize: 22,
                                ),
                              )
                            ]),
                          ),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              cubit.orderDetails.data.listProducts.length,
                          itemBuilder: (context, pos) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image(
                                        image: NetworkImage(
                                          cubit.orderDetails.data
                                              .listProducts[pos].image,
                                        ),
                                        height: 110,
                                        width: 110,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cubit.orderDetails.data
                                                .listProducts[pos].name,
                                            maxLines: 2,
                                            style: TextStyle(
                                              fontSize: 18,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '${"quantity".tr()}: ',
                                                style: TextStyle(
                                                    color: kDarkGoldColor,
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                cubit.orderDetails.data
                                                    .listProducts[pos].qty
                                                    .toString(),
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '${"price".tr()}: ',
                                                style: TextStyle(
                                                    color: kDarkGoldColor,
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                '${cubit.orderDetails.data.listProducts[pos].price} ${"SAR".tr()}',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ],
                                          ),
                                          if (cubit
                                                      .orderDetails
                                                      .data
                                                      .listProducts[pos]
                                                      .productRate ==
                                                  0 &&
                                              cubit.orderDetails.data
                                                      .orderDetails.status ==
                                                  "3")
                                            Align(
                                              alignment: AlignmentDirectional
                                                  .bottomEnd,
                                              child: TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddReviewScreen(
                                                      prodId: cubit
                                                          .orderDetails
                                                          .data
                                                          .listProducts[pos]
                                                          .productId,
                                                      orderId: cubit
                                                          .orderDetails
                                                          .data
                                                          .orderDetails
                                                          .id,
                                                    ),
                                                  ))
                                                      .then((value) {
                                                    if (value) {
                                                      cubit.getOrderDetails(
                                                          id, false);
                                                    }
                                                  });
                                                },
                                                child: Text(
                                                  "rate".tr(),
                                                  style: TextStyle(
                                                    color: kDarkGoldColor,
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: 15,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "paymentMethod".tr(),
                              style: TextStyle(fontSize: 20),
                            ),
                            cubit.orderDetails.data.orderDetails.paymentType ==
                                    0
                                ? Image(
                                    height: 40,
                                    width: 40,
                                    image: AssetImage('assets/images/cash.png'),
                                  )
                                : Wrap(
                                    direction: Axis.horizontal,
                                    children: [
                                      Image(
                                        height: 45,
                                        width: 45,
                                        image: AssetImage(
                                            'assets/images/visa.png'),
                                      ),
                                      Image(
                                        height: 45,
                                        width: 45,
                                        image: AssetImage(
                                            'assets/images/master_card.png'),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                        if (cubit.orderDetails.data.orderDetails.address !=
                                null &&
                            cubit.orderDetails.data.orderDetails.address
                                .isNotEmpty)
                          Text(
                            "Address".tr(),
                            style: TextStyle(fontSize: 20),
                          ),
                        if (cubit.orderDetails.data.orderDetails.address !=
                                null &&
                            cubit.orderDetails.data.orderDetails.address
                                .isNotEmpty)
                          Text(
                            cubit.orderDetails.data.orderDetails.address,
                            style: TextStyle(fontSize: 18),
                          ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200.withOpacity(0.5)),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                customRow(
                                  lab: "price".tr(),
                                  val:
                                      '${cubit.orderDetails.data.orderDetails.subTotal.toStringAsFixed(2)} ${"SAR".tr()}',
                                ),
                                if (cubit.orderDetails.data.orderDetails
                                        .deliveryType ==
                                    0)
                                  customRow(
                                    lab: "deliveryCost".tr(),
                                    val:
                                        '${cubit.orderDetails.data.orderDetails.deliveryCost.toStringAsFixed(2)} ${"SAR".tr()}',
                                  ),
                                if (cubit.orderDetails.data.orderDetails
                                        .promoCodeValue >
                                    0)
                                  customRow(
                                    lab: "discountValue".tr(),
                                    val:
                                        '${cubit.orderDetails.data.orderDetails.promoCodeValue.toStringAsFixed(2)} ${"SAR".tr()}',
                                  ),
                                Divider(
                                  height: 3,
                                  color: Colors.black54,
                                ),
                                customRow(
                                  lab: "Total".tr(),
                                  val:
                                      '${cubit.orderDetails.data.orderDetails.total.toStringAsFixed(2)} ${"SAR".tr()}',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
          );
        },
      ),
    );
  }

  Widget customRow({String lab, String val}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          lab,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        Text(
          "$val",
          style: TextStyle(color: Colors.orange, fontSize: 18),
        ),
      ],
    );
  }
}
