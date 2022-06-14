import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/shared/components/custom_app_bar_with_search.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithSearch(
        colorIcon: Colors.white,
        title: 'Chats'.tr(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.all(22),
                itemBuilder: (context, index) => ListTile(
                      tileColor: Colors.white,
                      leading: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.blueGrey),
                      ),
                      title: Text('منى علي'),
                      dense: false,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      subtitle: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text('مرحبا عندي استفسار'),
                      ),
                      trailing: Text(
                        '20-12-2021',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                itemCount: 4),
          ],
        ),
      ),
    );
  }
}
