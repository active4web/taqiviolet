import 'package:flutter/material.dart';

import '../models/make_order_model.dart';

class SuccessScr extends StatelessWidget {

 final MakeOrderModel makeOrderModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Image.asset("assets/images/succ.png")
        ,
        Text("اكتمل طلبك بنجاح"),
          Text("#${makeOrderModel.data.codeOrder}  رقم الطلب")
        ],
      ),
    );
  }

 SuccessScr(this.makeOrderModel);
}
