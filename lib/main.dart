import 'package:flutter/material.dart';
import 'package:safsofa/cubits/app_cubit.dart';
import 'package:safsofa/screens/home_layout.dart';
import 'package:safsofa/shared/bloc_observer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await EasyLocalization.ensureInitialized();
  await CacheHelper.init();
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar'), Locale('it')],
        startLocale: Locale('ar'),
        saveLocale: true,
        path:
            'assets/languages', // <-- change the path of the translation files
        fallbackLocale: Locale('ar'),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Tajawal'),
          home: HomeLayout()),
    );
  }
}
