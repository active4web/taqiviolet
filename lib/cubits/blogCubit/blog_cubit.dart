import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/models/blogModel.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/shared/constants.dart';

part 'blog_state.dart';

class BlogCubit extends Cubit<BlogState> {
  BlogCubit() : super(BlogInitial());

  static BlogCubit get(context) => BlocProvider.of(context);

  ///TODO:Get Blog Data
  BlogModel blog;
  List<Blogs> blogs;
  List<LastBlogs> lastblog;

  void getBlogData() {
    emit(GetBlogLoadingState());
    Mhelper.getData(
      UrlPath: blogEndpoint,
    ).then((value) {
      print("Data of Blog:${value.data}");
      blog = BlogModel.fromJson(value.data);
      blogs = blog.data.blogs;
      lastblog = blog.data.lastblog;
      print(blogs);
      emit(GetBlogSuccessState());
    }).catchError((err) {
      print("ERR:$err");
      emit(GetBlogErrorState());
    });
  }
}
