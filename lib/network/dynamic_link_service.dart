import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class DynamicLinkService{
  static final DynamicLinkService _singleton = DynamicLinkService._internal();
  DynamicLinkService._internal();
  static DynamicLinkService get instance => _singleton;

  void createDynamicLink() async{
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://taqi.page.link.com/details"),
      uriPrefix: "https://taqi.page.link",
      androidParameters: const AndroidParameters(packageName: ""),
      iosParameters: const IOSParameters(
          bundleId: "com.acive.taqi",
          appStoreId: "1665396042"
      ),
    );
    final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    debugPrint("${dynamicLink.shortUrl}");
  }
}