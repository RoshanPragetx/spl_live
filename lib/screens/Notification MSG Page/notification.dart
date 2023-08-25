import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/app_colors.dart';
import 'package:spllive/helper_files/custom_text_style.dart';
import 'package:spllive/helper_files/dimentions.dart';
import 'package:spllive/helper_files/ui_utils.dart';

import '../../helper_files/constant_image.dart';
import 'controller/notification_controller.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});
  var verticalSpace = SizedBox(
    height: Dimensions.h10,
  );
  var controller = Get.put(NotificationController());
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                verticalSpace,
                Expanded(
                    child: Obx(
                  () => ListView.builder(
                    itemCount: controller.notificationData.length,
                    itemBuilder: (context, index) {
                      return notificationWidget(size,
                          notifiactionHeder:
                              controller.notificationData[index].title ?? "",
                          notifiactionSubTitle:
                              controller.notificationData[index].description ??
                                  "");
                    },
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget notificationWidget(Size size,
      {required String notifiactionHeder,
      required String notifiactionSubTitle}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              color: AppColors.grey,
              blurRadius: 5,
              offset: const Offset(2, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.h8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Dimensions.h5,
                  ),
                  Text(
                    notifiactionHeder,
                    style: CustomTextStyle.textRobotoSansBold.copyWith(
                      color: AppColors.black,
                      fontSize: Dimensions.h13,
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.h5,
                  ),
                  SizedBox(
                    width: Dimensions.w200,
                    child: Text(
                      notifiactionSubTitle,
                      textAlign: TextAlign.start,
                      style: CustomTextStyle.textRobotoSansLight.copyWith(
                        color: AppColors.black,
                        fontSize: Dimensions.h13,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Dimensions.h50,
                width: Dimensions.w100,
                child: Image.asset(
                  ConstantImage.splLogo,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}