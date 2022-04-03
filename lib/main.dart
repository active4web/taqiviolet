import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/blogCubit/blog_cubit.dart';
import 'package:safsofa/cubits/homeCubit/home_cubit.dart';
import 'package:safsofa/cubits/offerCubit/offer_cubit.dart';
import 'package:safsofa/cubits/shopsCubit/shops_cubit.dart';
import 'package:safsofa/cubits/subCategory/sub_cat_cubit.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/shared/bloc_observer.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';
import 'package:safsofa/shared/router.dart';
import 'package:devicelocale/devicelocale.dart';

import 'cubits/AllDataStoreProductCatSub/all_data_cat_sub_pro_cubit.dart';
import 'cubits/authCubit/auth_cubit.dart';
import 'cubits/onbordingCubit/onboarding_cubit.dart';
import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';

Future<void> getDataInBackground(RemoteMessage message) async {
  print("on background: ${message.data.toString()}");
  showToast(text: "${message.data.toString()}", color: Colors.green);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  DioHelper.init();
  Mhelper.init();
  await EasyLocalization.ensureInitialized();
  String currentLocale = await Devicelocale.currentLocale;
  await CacheHelper.init();
  kToken = await CacheHelper.getData('token');
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print("${event.data.toString()}");
    showToast(text: "On app opened:${event.data.toString()}", color: Colors.green);
  });
  FirebaseMessaging.onMessage.listen((event) {
    print("on message: ${event.data.toString()}");
    showToast(text: "${event.data.toString()}", color: Colors.green);
  });

  FirebaseMessaging.onBackgroundMessage(getDataInBackground);

  print(kToken);
  kLanguage = CacheHelper.getData('language');
  BlocOverrides.runZoned(
    () {
      runApp(
        EasyLocalization(
            supportedLocales: [Locale('en'), Locale('ar'), Locale('it')],
            startLocale: Locale(currentLocale.substring(0, 2)),
            saveLocale: true,
            path: 'assets/languages',
            // <-- change the path of the translation files
            fallbackLocale: Locale('ar'),
            child: Phoenix(child: MyApp(kToken))),
      );
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  String KToken;

  MyApp(this.KToken);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(KToken);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OnboardngCubit(),
        ),
        BlocProvider(
          create: (context) => OfferCubit(),
        ),
        BlocProvider(
          create: (context) => BlogCubit(),
        ),
        BlocProvider(create: (context) => AppCubit()..fetchData()),
        BlocProvider(create: (context) => AuthCubit()..getDeviceToken()),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => SubCatCubit()),
        BlocProvider(create: (context) => ShopsCubit()),
        BlocProvider(create: (context) => AllDataCatSubProCubit()),
      ],
      child: MaterialApp(
          title: 'Safsofa',
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Tajawal',
            textSelectionTheme:
                TextSelectionThemeData(cursorColor: Colors.black),
          ),
          onGenerateRoute: onGenerateRoute,
          navigatorKey: navigatorKey,
          initialRoute:
              KToken == null ? Routes.onBoardingRoute : Routes.mainRoute),
    );
  }
}
