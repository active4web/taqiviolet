import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/gify_cubit/gift_cubit.dart';
import 'package:safsofa/shared/components/custom_network_image.dart';

class GiftBalanceDesignImageComponent extends StatelessWidget {
  const GiftBalanceDesignImageComponent({Key? key}) : super(key: key);

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
              childAspectRatio: 1 / 1.4,
              mainAxisSpacing: 6.0,
              crossAxisSpacing: 6.0),

          //Todo :
          itemBuilder: (context, index) => InkWell(
            onTap:(){
              print(index);
              cubit.changeBorderImage(index);

            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color:cubit.selectedImageIndex ==index?  Colors.black : Colors.white,
                ),
                borderRadius: BorderRadius.circular(10),
                shape: BoxShape.rectangle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: CustomNetworkImage(
                  image:
                  'https://thumbs.dreamstime.com/z/fields-meadows-indan-forming-field-indan-imag-feald-indian-image-forming-170966228.jpg',
                  border: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
