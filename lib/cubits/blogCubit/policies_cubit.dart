import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:safsofa/models/privacy_policy_model.dart';
import 'package:safsofa/network/local/cache_helper.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/shared/constants.dart';

part 'policies_state.dart';

class BlogCubit extends Cubit<PoliciesState> {
  BlogCubit() : super(PoliciesInitial());

  static BlogCubit get(context) => BlocProvider.of(context);

  ///TODO:Get Blog Data
  // BlogModel blog;
  // List<Blogs> blogs;
  // List<LastBlogs> lastblog;
  PrivacyPolicyModel _privacyPolicyModel;
  List<PrivacyPolicyData> policies = [];
  void getPoliciesData() async {
    policies.clear();
    emit(GetPoliciesLoadingState());
    await Mhelper.getData(
            UrlPath: dataFromPrivacyPolicy,
            query: {'lang': (CacheHelper.getData("language") ?? "ar")})
        .then((value) async {
      print(value.data);
      _privacyPolicyModel = PrivacyPolicyModel.fromJson(value.data);
      _privacyPolicyModel.data.forEach((element) {
        if (element.id > 17 && element.id <= 19) {
          policies.add(element);
          print("Data of policy:${policies[0].title}");
        }
      });
      // print(blogs);
      emit(GetPoliciesSuccessState());
    }).catchError((err) {
      print("ERR:$err");
      emit(GetPoliciesErrorState());
    });
  }
}
