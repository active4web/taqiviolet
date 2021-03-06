import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/network/local/cache_helper.dart';
import 'package:safsofa/screens/bottom_navigation_screens/language_screen.dart';
import 'package:safsofa/screens/display_inspiration_products.dart';
import 'package:safsofa/screens/menu_screens/about_screen.dart';
import 'package:safsofa/screens/menu_screens/blog_screens/policies_screen.dart';
import 'package:safsofa/screens/menu_screens/contact_us_screen.dart';
import 'package:safsofa/screens/menu_screens/offers_screen.dart';
import 'package:safsofa/screens/menu_screens/privacy_policy_screen.dart';
import 'package:safsofa/screens/menu_screens/technical_support_screen.dart';
import 'package:safsofa/screens/menu_screens/terms_and_conditions_screen.dart';
import 'package:safsofa/screens/register_screens/login_screen.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  image: DecorationImage(
                    image: AssetImage('assets/images/mainlogoheadericon.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: MenuTile(
                      label: "This is Taqi Violet".tr(),
                      image: AssetImage('assets/images/logo.png'),
                      onTap: () {
                        navigateTo(context, AboutScreen());
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 5,
                    child: MenuTile(
                      label: 'privacy policy'.tr(),
                      image: AssetImage('assets/images/crown.png'),
                      onTap: () {
                        navigateTo(context, PrivacyPolicyScreen());
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: MenuTile(
                      label: 'Offers'.tr(),
                      image: AssetImage('assets/images/offers.png'),
                      onTap: () {
                        navigateTo(context, OffersScreen());
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: MenuTile(
                      label: 'Language'.tr(),
                      image: AssetImage('assets/images/language.png'),
                      onTap: () {
                        navigateTo(context, LanguageScreen());
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: MenuTile(
                      label: 'Policies'.tr(),
                      image: AssetImage('assets/images/blog.png'),
                      onTap: () {
                        navigateTo(context, PoliciesScreen());
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: MenuTile(
                      label: 'Inspiration and creativity'.tr(),
                      image: AssetImage('assets/images/shop.png'),
                      onTap: () {
                        navigateTo(
                            context,
                            DisplayInspirationProducts(
                              categoryName: 'Inspiration and creativity'.tr(),
                            ));
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: MenuTile(
                      label: 'TermsAndConditions'.tr(),
                      image: AssetImage('assets/images/privacy.png'),
                      onTap: () {
                        navigateTo(context, TermsAndConditionsScreen());
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: MenuTile(
                      label: 'TechnicalSupport'.tr(),
                      image: AssetImage('assets/images/support.png'),
                      onTap: () {
                        navigateTo(context, TechnicalSupportScreen());
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: MenuTile(
                      label: 'ContactUs'.tr(),
                      image: AssetImage('assets/images/phone.png'),
                      onTap: () {
                        navigateTo(context, ContactUsScreen());
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: MenuTile(
                      label: 'LogOut'.tr(),
                      image: AssetImage('assets/images/log out.png'),
                      onTap: () {
                        CacheHelper.clearCache();
                        kToken = null;
                        navigateAndFinish(context, LoginScreen());
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MenuTile extends StatelessWidget {
  const MenuTile({
    Key key,
    this.label,
    this.image,
    this.onTap,
  }) : super(key: key);

  final String label;
  final Function onTap;
  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height * 0.13,
        decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: kLightGoldColor),
            borderRadius: BorderRadius.circular(10)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.04,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: image,
                )),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(color: kLightGoldColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
