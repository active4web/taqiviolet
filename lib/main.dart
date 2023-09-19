 import 'dart:convert';
import 'dart:developer';
import 'package:devicelocale/devicelocale.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/commitments/commitments_cubit.dart';
import 'package:safsofa/cubits/common_questionCubit/common_question_cubit.dart';
import 'package:safsofa/cubits/favorites_cubit/favorites_cubit.dart';
import 'package:safsofa/cubits/gify_cubit/gift_cubit.dart';
import 'package:safsofa/cubits/homeCubit/home_cubit.dart';
import 'package:safsofa/cubits/offerCubit/offer_cubit.dart';
import 'package:safsofa/cubits/policiesCubit/policies_cubit.dart';
import 'package:safsofa/cubits/subCategory/sub_cat_cubit.dart';
import 'package:safsofa/cubits/taqi_work_cubit/cubit/taqi_work_cubit.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/push_notifcation.dart';
import 'package:safsofa/screens/new/personel_page/presentation/screens/components/personel_screens/infraction_screen/controller/infraction_cubit.dart';
import 'package:safsofa/screens/new/personel_page/presentation/screens/components/personel_screens/receipt_record_screen/controller/receipt_record_cubit.dart';
import 'package:safsofa/screens/new/personel_page/presentation/screens/components/personel_screens/starting_wotk_from_screen/controller/starting_work_cubit.dart';
import 'package:safsofa/screens/new/personel_page/presentation/screens/components/personel_screens/vacation_form/controller/vacation_cubit.dart';
import 'package:safsofa/screens/splash_and_onboarding/splash_screen.dart';
import 'package:safsofa/shared/bloc_observer.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';
import 'package:safsofa/shared/router.dart';
import 'dart:developer' as developer;
import 'cubits/OrderReceived/order_received_cubit.dart';
import 'cubits/aboutCubit/about_cubit.dart';
import 'cubits/authCubit/auth_cubit.dart';
import 'cubits/cartCubit/cart_cubit.dart';
import 'cubits/contactUsCubit/contact_us_cubit.dart';
import 'cubits/contactsCubit/contacts_cubit.dart';
import 'cubits/coupones_cubit/coupones_cubit.dart';
import 'cubits/cubit/getdataprofile_cubit.dart';
import 'cubits/dataInList/data_in_list_cubit.dart';
import 'cubits/listsCubit/lists_cubit.dart';
import 'cubits/mobile_cubit.dart';
import 'cubits/my_orders_cubit.dart';
import 'cubits/onbordingCubit/onboarding_cubit.dart';
import 'cubits/orderReceivedItemInList/order_received_item_in_list_cubit.dart';
import 'cubits/privacy_cubit/privacy_policy_cubit.dart';
import 'cubits/technicalSupporDetailstCubit/technical_suppor_detailst_cubit.dart';
import 'cubits/technicalSupportCubit/technical_support_cubit.dart';
import 'models/cart_models/cart_local_model/cart_local_model.dart';
import 'network/local/cache_helper.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  await EasyLocalization.ensureInitialized();
  Mhelper.init();
  await FirebaseMessaging.instance.getToken().then((value) {
    CacheHelper.setData(key: 'FCM', value: value);
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await PushNotificationManagger.initialize(flutterLocalNotificationsPlugin);

  if (CacheHelper.getData('localCart') != null) {
    cartProducts =
        CartLocalModel.fromJson(jsonDecode(CacheHelper.getData('localCart')));
  }
  cartCount = CacheHelper.getData('cartCount') ?? 0;
  // HttpOverrides.global = new MyHttpOverrides();
  String? currentLocale = await Devicelocale.currentLocale;
  kToken = await CacheHelper.getData('token');
  if (CacheHelper.getData('language') == null) {
    kLanguage = currentLocale?.substring(0, 2);
  } else {
    kLanguage = await CacheHelper.getData('language');
  }

  log('$kToken');
  BlocOverrides.runZoned(
        () {
      runApp(
        EasyLocalization(
            supportedLocales: [Locale('en'), Locale('ar'), Locale('it')],
            startLocale: Locale(kLanguage!),
            saveLocale: true,
            path: 'assets/languages',
            // <-- change the path of the translation files
            fallbackLocale: Locale('ar'),
            child: Phoenix(child: MyApp())),
      );
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
      builder: (context,child) {
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
              //TODO :
              BlocProvider(
                create: (context) => GiftCubit(),
              ),

              BlocProvider(
                create: (context) => PoliciesCubit(),
              ),
              BlocProvider(
                create: (context) => TaqiWorkCubit(),
              ),
              BlocProvider(create: (context) => AppCubit()),
              BlocProvider(create: (context) => AuthCubit() /*..getDeviceToken()*/),
              BlocProvider(create: (context) => HomeCubit()),
              BlocProvider(create: (context) => CouponesCubit()),
              BlocProvider(create: (context) => SubCatCubit()),
              BlocProvider(create: (context) => CommonQuestionCubit()),
              BlocProvider(create: (context) => FavoritesCubit()),
              BlocProvider(create: (context) => InfractionCubit()),
              BlocProvider(create: (context) => ReceiptRecordCubit()),
              BlocProvider(create: (context) => StartingWorkCubit()),
              BlocProvider(create: (context) => VacationCubit()),
              BlocProvider(create: (context) => CommitmentsCubit()),
            ],
            child:
                 MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Taqi Violet',
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                    fontFamily: 'arial',
                    textSelectionTheme:
                    TextSelectionThemeData(cursorColor: Colors.black),
                  ),
                  navigatorKey: navigatorKey,
                  home: SplashScreen(),


            ));
      }
    );
  }
}
