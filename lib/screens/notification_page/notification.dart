import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/app_colors.dart';
import 'package:spllive/helper_files/dimentions.dart';
import 'package:spllive/helper_files/ui_utils.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppUtils().simpleAppbar(appBarTitle: "NOTIFICATIONS".tr),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: double.infinity,
          child: Column(
            children: [
              notificationWidget(size),
              notificationWidget(size),
              notificationWidget(size)
            ],
          ),
        ),
      ),
    );
  }

  Container notificationWidget(Size size) {
    return Container(
      color: AppColors.grey.withOpacity(0.55),
      width: size.width,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.h8),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "GOODAFTERNOON".tr,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text("GOOD AFTERNOON" * 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("3/11/23 12:45 PM"),
                )
              ],
            ),
            Divider(
              color: AppColors.black,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}
