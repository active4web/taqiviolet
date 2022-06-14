import 'package:devicelocale/devicelocale.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/blogCubit/policies_cubit.dart';
import 'package:safsofa/cubits/homeCubit/home_cubit.dart';
import 'package:safsofa/cubits/offerCubit/offer_cubit.dart';
import 'package:safsofa/cubits/shopsCubit/shops_cubit.dart';
import 'package:safsofa/cubits/subCategory/sub_cat_cubit.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/shared/bloc_observer.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';
import 'package:safsofa/shared/router.dart';

import 'cubits/AllDataStoreProductCatSub/all_data_cat_sub_pro_cubit.dart';
import 'cubits/OrderReceived/order_received_cubit.dart';
import 'cubits/SuccessStoriesCubit/privacy_policy_cubit.dart';
import 'cubits/aboutCubit/about_cubit.dart';
import 'cubits/authCubit/auth_cubit.dart';
import 'cubits/cartCubit/cart_cubit.dart';
import 'cubits/contactUsCubit/contact_us_cubit.dart';
import 'cubits/contactsCubit/contacts_cubit.dart';
import 'cubits/cubit/getdataprofile_cubit.dart';
import 'cubits/dataInList/data_in_list_cubit.dart';
import 'cubits/inspirationCubit/inspiration_cubit.dart';
import 'cubits/listsCubit/lists_cubit.dart';
import 'cubits/mobile_cubit.dart';
import 'cubits/my_orders_cubit.dart';
import 'cubits/onbordingCubit/onboarding_cubit.dart';
import 'cubits/orderReceivedItemInList/order_received_item_in_list_cubit.dart';
import 'cubits/order_details_cubit.dart';
import 'cubits/technicalSupporDetailstCubit/technical_suppor_detailst_cubit.dart';
import 'cubits/technicalSupportCubit/technical_support_cubit.dart';
import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';

Future<void> getDataInBackground(RemoteMessage message) async {
  print("on background: ${message.data.toString()}");
  showToast(text: "${message.data.toString()}", color: Colors.green);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  print("Handling a background message: ${message.notification.title}");
  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.onBackgroundMessage(
      _firebaseMessagingBackgroundHandler);

  DioHelper.init();
  Mhelper.init();
  await EasyLocalization.ensureInitialized();
  String currentLocale = await Devicelocale.currentLocale;
  kLanguage = currentLocale;
  await CacheHelper.init();
  kToken = await CacheHelper.getData('token');

  print(CacheHelper.getData('id'));
  //  FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //    print("${event.data.toString()}");
  //    showToast(text: "On app opened:${event.data.toString()}", color: Colors.green);
  //  });
  //  FirebaseMessaging.onMessage.listen((event) {
  //    print("on message: ${event.data.toString()}");
  //    showToast(text: "${event.data.toString()}", color: Colors.green);
  //  });
  //
  // FirebaseMessaging.onBackgroundMessage(getDataInBackground);

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

// bool opensplash=false;

  MyApp(this.KToken);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // if(CacheHelper.getData('opensplash')==null){
    //   opensplash=true;
    //   CacheHelper.setData(key: 'opensplash',value:false );
    // }
    print(KToken);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OrderReceivedItemInListCubit(),
        ),
        BlocProvider(
          create: (context) => OrderReceivedCubit(),
        ),
        BlocProvider(
          create: (context) => DataInListCubit(),
        ),
        BlocProvider(
          create: (context) => ListsCubit(),
        ),
        BlocProvider(
          create: (context) => MobileCubit(),
        ),
        BlocProvider(
          create: (context) => MyOrdersCubit(),
        ),
        BlocProvider(
          create: (context) => CartCubit(),
        ),
        BlocProvider(
          create: (context) => GetdataprofileCubit(),
        ),
        BlocProvider(
          create: (context) => TechnicalSupportDetailsCubit(),
        ),
        BlocProvider(
          create: (context) => TechnicalSupportCubit(),
        ),
        BlocProvider(
          create: (context) => ContactCubit(),
        ),
        BlocProvider(
          create: (context) => ContactsCubit(),
        ),
        BlocProvider(
          create: (context) => OrderDetailsCubit(),
        ),
        BlocProvider(
          create: (context) => AboutCubit(),
        ),
        BlocProvider(
          create: (context) => PrivacyPolicyCubit(),
        ),
        BlocProvider(
          create: (context) => OnboardngCubit(),
        ),
        BlocProvider(
          create: (context) => OfferCubit(),
        ),
        BlocProvider(
          create: (context) => BlogCubit(),
        ),
        BlocProvider(
          create: (context) => InspirationCubit(),
        ),
        BlocProvider(
            create: (context) => AppCubit()
              ..getConstructionData()
              ..fetchData()),
        BlocProvider(create: (context) => AuthCubit()..getDeviceToken()),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => SubCatCubit()),
        BlocProvider(create: (context) => ShopsCubit()),
        BlocProvider(create: (context) => AllDataCatSubProCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Taqi Violet',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Tajawal',
          textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.black),
        ),
        onGenerateRoute: onGenerateRoute,
        navigatorKey: navigatorKey,
        initialRoute: Routes.onBoardingRoute,
        // KToken == null && opensplash
        //     ? Routes.onBoardingRoute
        //     : Routes.mainRoute,
      ),
    );
  }
}
