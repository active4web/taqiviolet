import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Notifications'.tr(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              Row(
                children: [
                  TextButton(
                    child: Text(
                      'DeleteAll'.tr(),
                      style: TextStyle(color: Color(0xffD0021B)),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => ListTile(
                        leading: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Color(0xfff5f5f5),
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: Icon(
                              Icons.shopping_bag_rounded,
                              color: Colors.grey,
                              size: 20,
                            ),
                          ),
                        ),
                        title: Text('تم شحن طلبك 2 كراسي ظهر طويل'),
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        subtitle: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text('9-11-2021'),
                        ),
                      ),
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: 4)
            ],
          ),
        ),
      ),
    );
  }
}
