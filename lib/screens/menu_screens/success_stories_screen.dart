import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:safsofa/shared/constants.dart';

class SuccessStoriesScreen extends StatelessWidget {
  const SuccessStoriesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'SuccessStories'.tr(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) => Column(
                        children: [
                          Label(text: 'تسليم اثاث لمنزل العميل'),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                '22-06-2018',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            kLoremIpsum,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 8 / 6),
                            itemBuilder: (context, index) => Container(
                              decoration:
                                  BoxDecoration(color: Colors.grey.shade400),
                            ),
                            itemCount: 3,
                          )
                        ],
                      ),
                  separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Divider(),
                      ),
                  itemCount: 3),
            )
          ],
        ),
      ),
    );
  }
}
