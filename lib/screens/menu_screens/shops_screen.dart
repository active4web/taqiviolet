import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/shared/components/custom_app_bar_with_search.dart';
import 'package:safsofa/shared/components/custom_search_bar.dart';
import 'package:safsofa/shared/constants.dart';

class ShopsScreen extends StatelessWidget {
  const ShopsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithSearch(
        title: 'Shops'.tr(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 20,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 4 / 5,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                itemBuilder: (context, index) => Column(
                  children: [
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10)),
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'اسم المتجر',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
