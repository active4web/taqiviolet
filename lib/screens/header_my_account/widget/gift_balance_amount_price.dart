import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/gify_cubit/gift_cubit.dart';

class GiftBalanceAmountPriceComponent extends StatelessWidget {
  const GiftBalanceAmountPriceComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GiftCubit, GiftState>(
      builder: (context,State){
        GiftCubit cubit = GiftCubit.get(context);

        return   GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 6,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1 / 0.4,
              mainAxisSpacing: 6.0,
              crossAxisSpacing: 6.0),
          itemBuilder: (context, index) => InkWell(
            onTap: (){
              print(index);
              cubit.changeBorderPrice(index);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color:cubit.selectedIndex==index?  Colors.black : Colors.grey,
                ),
                shape: BoxShape.rectangle,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Text('\$ 68870.00',
                              textAlign: TextAlign.center)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
