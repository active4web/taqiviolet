import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info/package_info.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/appCubit/app_states.dart';
import 'package:safsofa/shared/components/custom_bottom_bar.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:http/http.dart' as http;
// import 'package:new_version/new_version.dart';
import 'dart:io';

import 'package:upgrader/upgrader.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout>with AutomaticKeepAliveClientMixin {

  AppUpdateInfo? _updateInfo;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  bool _flexibleUpdateAvailable = false;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> checkForUpdate() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageName = packageInfo.packageName;

    String lastVersion="${packageInfo.version.split(".")[2]}.${packageInfo.buildNumber}";
    // packageInfo.version
    //  print("name: ${packageName}");
    //  print("infoo: ${packageInfo.version.split(".")[2]}.${packageInfo.buildNumber}");
    // Replace with the appropriate package name for your app on pub.dev
    String apiUrl = 'http://itunes.apple.com/lookup?bundleId=$packageName';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      // print("myyyyyyyresponse: $response");
      if (response.statusCode == 200) {
        Map<String, dynamic> packageInfo = json.decode(response.body);

        print("request Infoooo: ${packageInfo}");
        String latestVersion = packageInfo["results"][0]['version'];

        print("last version ${packageInfo["results"][0]['version']}");
        if (latestVersion.compareTo(lastVersion) > 0) {
          // There is a new version available

          _showVersionDialog(context);
        } else {
          // The app is up-to-date

        }
      } else {
        throw Exception('Failed to load package information');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  _showVersionDialog(context) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title ="updateTitle".tr();
        String message =
            "updateDescription".tr();
        String btnLabel = "update".tr();
        return Platform.isIOS
            ? new CupertinoAlertDialog(

          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0
              ),
              child: Text(btnLabel,style: TextStyle(
                color: kCustomBlack,
                fontWeight: FontWeight.bold
              ),),
              onPressed: () => _launchURL(),
            ),
          ],
        )
            : new AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              child: Text(btnLabel),
              onPressed: () => _launchURL(),
            ),
          ],
        );
      },
    );
  }
  _launchURL() async {
    String url="https://apps.apple.com/us/app/taqi-violet-%D8%AA%D8%A7%D9%82%D9%8A-%D9%81%D9%8A%D9%88%D9%84%D8%AA/id1665396042";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }





  @override
  void initState() {
   checkForUpdate();
    super.initState();


  }






  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) =>Scaffold(
         // key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          extendBody: true,
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
          floatingActionButton: InkWell(
            onTap: () {
              cubit.changeNavBar(2, context);
            },
            child: Container(
              padding: EdgeInsets.all(15.r),
              decoration:
              BoxDecoration(color: Color(0xff393846), shape: BoxShape.circle),
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Icon(
                    CupertinoIcons.bag,
                    size: 30.r,
                    color: cubit.selectedIndex == 2 ? kDarkGoldColor :Colors.grey,
                  ),
                  if (cartCount != 0)
                    StreamBuilder<int>(
                      initialData: cartCount,
                      stream: cartCountControlller.stream,
                      builder: (context, snapShot) {
                        if (snapShot.data != 0) {
                          return Container(
                            width: 20.w,
                            height: 20.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            child: Padding(
                              padding:  EdgeInsets.all(3.r),
                              child: Text(
                                snapShot.data.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.sp),
                              ),
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                ],
              ),
            ),
          ),
          body: cubit.screens[cubit.selectedIndex!]
          /*IndexedStack(
        children: cubit.screens,
        index: cubit.selectedIndex,
                  )*/
          ,
          bottomNavigationBar:  CustomBottomNavigationBar(),
        )
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true
  ;}
