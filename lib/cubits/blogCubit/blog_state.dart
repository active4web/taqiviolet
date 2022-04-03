part of 'blog_cubit.dart';

@immutable
abstract class BlogState {}

class BlogInitial extends BlogState {}

class GetBlogLoadingState extends BlogState {}

class GetBlogSuccessState extends BlogState {}

class GetBlogErrorState extends BlogState {}
