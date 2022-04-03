import 'package:flutter/material.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/appCubit/app_states.dart';
import 'package:safsofa/cubits/blogCubit/blog_cubit.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogDetailsScreen extends StatelessWidget {
  String indexSt;
  BlogDetailsScreen({@required this.indexSt});

  int index=0;
  List data=[];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlogCubit, BlogState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlogCubit.get(context);
        if(indexSt.contains("a")){
          index=int.parse(indexSt.substring(0,1));
          data=cubit.lastblog;
        }
        else{
          index=int.parse(indexSt);
          data=cubit.blogs;
        }
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          extendBodyBehindAppBar: true,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(10)),
                      child: Image(
                        image: NetworkImage("${data[index].image}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(10)),
                          color: Colors.black54,
                        ),
                        child: Row(
                          children: [
                            Text(
                              '${data[index].createdAt.substring(0, 10)}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Expanded(
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(
                                  '${data[index].title}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(22),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      "${data[index].content}",
                      style: TextStyle(fontSize: 20),
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
