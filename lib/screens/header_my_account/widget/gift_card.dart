import 'package:flutter/material.dart%20';
import 'package:safsofa/shared/components/custom_network_image.dart';
import 'package:easy_localization/src/public_ext.dart';

import '../../../models/new_list_cards_model.dart';

class GiftCardComponent extends StatelessWidget {
    GiftCardComponent({Key? key,required this.newListCardsModel}) : super(key: key);
    Listcards? newListCardsModel;
  @override
  Widget build(BuildContext context) {
    print(newListCardsModel!.name);
    print("11111111111");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomNetworkImage(
          image: 'https://thumbs.dreamstime.com/z/fields-meadows-indan-forming-field-indan-imag-feald-indian-image-forming-170966228.jpg',
          border: BorderRadius.all(Radius.circular(10)),
          height: 130,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text('theValue'.tr(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            Expanded(
              child: Text(' 225.31 ${'rS'.tr()}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),

          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Text('thePrice'.tr(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            Expanded(
              child: Text(' 225.31 ${'rS'.tr()}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),

          ],
        ),

      ],
    );
  }
}
