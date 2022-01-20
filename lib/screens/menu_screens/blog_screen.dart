import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/components/custom_label.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Blog'.tr(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Label(text: 'LatestArticles'.tr()),
            SizedBox(
              height: 20,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: 2,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 8 / 9,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10),
              itemBuilder: (context, index) => ArticleCard(),
            ),
            SizedBox(
              height: 30,
            ),
            Label(text: 'Articles'.tr()),
            SizedBox(
              height: 20,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: 20,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 6 / 9,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10),
              itemBuilder: (context, index) => ArticleCard(),
            )
          ],
        ),
      ),
    );
  }
}

class ArticleCard extends StatelessWidget {
  const ArticleCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10)),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
              color: Colors.black45,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'عنوان المقالة ',
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      '15-11-2021',
                      style: TextStyle(color: Colors.white, fontSize: 8),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
