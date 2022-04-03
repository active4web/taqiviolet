import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/blogCubit/blog_cubit.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';

import 'blog_details_screen.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlogCubit, BlogState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlogCubit.get(context);
        state is BlogInitial ? cubit.getBlogData() : print("Blog Screen}");
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Blog'.tr(),
          ),
          body: state is! GetBlogSuccessState
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: ListView(
                    children: [
                      Label(text: 'LatestArticles'.tr()),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: Color(0xfff6f6f6)),
                        child: (ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: cubit.lastblog.length,
                          itemBuilder: (context, index) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              width: 175,
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: ArticleCard(
                                  index: index.toString() + "a",
                                  title: cubit.lastblog[index].title,
                                  time: cubit.lastblog[index].time,
                                  image: cubit.lastblog[index].image,
                                ),
                              ),
                            ),
                          ),
                        )),
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
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.zero,
                        itemCount: cubit.blogs.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 6 / 9,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2,
                            crossAxisSpacing: 10),
                        itemBuilder: (context, index) => Directionality(
                          textDirection: TextDirection.rtl,
                          child: ArticleCard(
                            index: index.toString(),
                            title: cubit.blogs[index].title,
                            time: cubit.blogs[index].time,
                            image: cubit.blogs[index].image,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        );
      },
    );
  }
}

class ArticleCard extends StatelessWidget {
  String title;
  String time;
  String image;
  var index;

  ArticleCard(
      {@required this.title,
      @required this.time,
      @required this.image,
      @required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(
            context,
            BlogDetailsScreen(
              indexSt: index,
            ));
      },
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(25)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: NetworkImage("$image"),
                  fit: BoxFit.cover,
                )),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(25)),
                color: Colors.black54,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "$title",
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
                        '$time',
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
