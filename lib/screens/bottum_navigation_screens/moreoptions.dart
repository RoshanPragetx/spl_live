import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:spllive/helper_files/app_colors.dart';
import 'package:spllive/helper_files/constant_variables.dart';
import 'package:spllive/helper_files/custom_text_style.dart';
import 'package:spllive/helper_files/dimentions.dart';
import 'package:spllive/routes/app_routes_name.dart';
import 'package:spllive/screens/Local%20Storage.dart';
import '../../helper_files/constant_image.dart';
import '../../helper_files/ui_utils.dart';
import '../home_screen/controller/homepage_controller.dart';
import 'controller/bottum_navigation_controller.dart';

class MoreOptions extends StatelessWidget {
  const MoreOptions({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;
    var controller = Get.put(MoreListController());
    var homeController = Get.put(HomePageController());
    // ignore: sized_box_for_whitespace
    return Column(
      children: [
        AppUtils().simpleAppbar(appBarTitle: "MORE".tr, actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
            child: InkWell(
              onTap: () {
                Share.share("http://spl.live");
              },
              child: Container(
                width: Dimensions.w20,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(Dimensions.r25),
                ),
                child: Icon(
                  Icons.share,
                  size: 13,
                  color: AppColors.appbarColor,
                ),
              ),
            ),
          ),
        ]),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  height: Dimensions.h15,
                ),
                listItems(
                    onTap: () {
                      Get.toNamed(AppRoutName.profilePage);
                    },
                    iconData: ConstantImage.profileIconSVG,
                    text: "MYPROFILE".tr),
                listItems(
                    onTap: () {
                      Get.toNamed(AppRoutName.myAccountPage);
                    },
                    iconData: ConstantImage.bakAccount,
                    text: "MYACCOUNT".tr),
                listItems(
                    onTap: () {
                      Get.toNamed(AppRoutName.gameRatePage);
                    },
                    iconData: ConstantImage.gameRate,
                    text: "GAMERATE".tr),
                listItems(
                    onTap: () {
                      Get.toNamed(AppRoutName.notificationDetailsPage);
                    },
                    iconData: ConstantImage.notifiacation,
                    text: "NOTIFICATIONS".tr),
                listItems(
                    onTap: () {},
                    iconData: ConstantImage.playIcon,
                    text: "HOWTOPLAY".tr),
                listItems(
                    onTap: () {},
                    iconData: ConstantImage.plusIcon,
                    text: "ADDFUND".tr),
                listItems(
                    onTap: () {
                      homeController.pageWidget.value = 1;
                      homeController.currentIndex.value = 1;
                    },
                    iconData: ConstantImage.clockIcon,
                    text: "BIDDINGHISTORY".tr),
                listItems(
                    onTap: () async {
                      await LocalStorage.write(
                          ConstantsVariables.withDrawal, true);
                      homeController.pageWidget.value = 4;
                      homeController.currentIndex.value = 4;
                      Get.toNamed(AppRoutName.withdrawalpage);
                    },
                    iconData: ConstantImage.withDrawalIcon,
                    text: "WITHDRAWAL_TXT1".tr),
                listItems(
                    onTap: () {
                      Get.toNamed(AppRoutName.transactionPage);
                    },
                    iconData: ConstantImage.addFundIcon,
                    text: "TRANSACTIONHISTORY".tr),
                listItems(
                    onTap: () {
                      Get.toNamed(AppRoutName.feedBackPage);
                    },
                    iconData: ConstantImage.giveFeedbackIcon,
                    text: "GIVEFEEDBACK".tr),
                listItems(
                  onTap: () {
                    controller.onTapOfRateUs();
                  },
                  iconData: ConstantImage.rateusStartIcon,
                  text: "RATEUS".tr,
                ),
                listItems(
                  onTap: () {
                    Get.toNamed(AppRoutName.stalineTerms);
                  },
                  iconData: ConstantImage.addFundIcon,
                  text: "STARLINETERMS&CONDITION".tr,
                ),
                listItems(
                  onTap: () {
                    Get.toNamed(AppRoutName.aboutPage);
                  },
                  iconData: ConstantImage.infoIcon,
                  text: "ABOUTUS".tr,
                ),
                listItems(
                  onTap: () {
                    controller.callLogout();
                  },
                  iconData: ConstantImage.signOutIcon,
                  text: "SIGNOUT".tr,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

Widget listItems(
    {required Function() onTap,
    required String iconData,
    required String text}) {
  return InkWell(
    onTap: onTap,
    child: Column(
      children: [
        SizedBox(
          height: Dimensions.h30,
          child: Row(
            children: [
              SizedBox(
                width: Dimensions.w20,
              ),
              Padding(
                padding: EdgeInsets.only(top: Dimensions.h3),
                child: SizedBox(
                  // color: Colors.amber,
                  height: Dimensions.h20,
                  width: Dimensions.w20,
                  child: SvgPicture.asset(
                    iconData,
                    color: AppColors.appbarColor,
                  ),
                ),
              ),
              SizedBox(
                width: Dimensions.w15,
              ),
              Text(text,
                  style: CustomTextStyle.textPTsansMedium.copyWith(
                      fontSize: Dimensions.h14, fontWeight: FontWeight.w500))
            ],
          ),
        ),
        Divider(
          color: AppColors.grey,
          endIndent: 10,
          indent: 50,
        )
      ],
    ),
  );
}
