// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/app_colors.dart';
import 'package:spllive/helper_files/constant_variables.dart';
import 'package:spllive/helper_files/custom_text_style.dart';
import 'package:spllive/routes/app_routes_name.dart';
import 'package:spllive/screens/Local%20Storage.dart';

import '../../components/button_widget.dart';
import '../../helper_files/constant_image.dart';
import '../../helper_files/dimentions.dart';
import '../../helper_files/ui_utils.dart';
import '../home_screen/controller/homepage_controller.dart';
import 'controller/bottum_navigation_controller.dart';

class SPLWallet extends StatelessWidget {
  SPLWallet({super.key});
  var controller = Get.put(MoreListController());
  var homeController = Get.put(HomePageController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      //  color: Colors.green,
      height: size.height,
      width: double.infinity,
      child: Column(
        children: [
          AppUtils().simpleAppbar(
            appBarTitle: "",
            leadingWidht: Dimensions.w200,
            leading: Container(
              child: Row(
                children: [
                  SizedBox(width: Dimensions.w15),
                  Text(
                    "SPL_WALLET".tr,
                    style: CustomTextStyle.textRobotoSansMedium
                        .copyWith(fontSize: Dimensions.h20),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            child: Column(
              children: [
                SizedBox(
                  height: Dimensions.h10,
                ),
                Text(
                  "WALLETBALANCE".tr,
                  style: CustomTextStyle.textRobotoSansMedium
                      .copyWith(fontSize: Dimensions.h25),
                ),
                SizedBox(
                  height: Dimensions.h10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      ConstantImage.rupeeImageGreen,
                      height: Dimensions.h40,
                      width: Dimensions.w40,
                      fit: BoxFit.fitWidth,
                    ),
                    Obx(
                      () => Text(
                        controller.walletBalance.value,
                        style: CustomTextStyle.textRobotoSansMedium.copyWith(
                          fontSize: Dimensions.h35,
                          color: AppColors.buttonColorDarkGreen,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: Dimensions.h20,
                ),
                Text(
                  "WALLET_TEXT".tr,
                  textAlign: TextAlign.center,
                  style: CustomTextStyle.textRobotoSansMedium.copyWith(
                    fontSize: Dimensions.h22,
                  ),
                ),
                SizedBox(
                  height: Dimensions.h20,
                ),
                Padding(
                  padding: EdgeInsets.all(Dimensions.h10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ButtonWidget(
                          onTap: () {},
                          text: "ADDFUND_TEXT".tr,
                          buttonColor: AppColors.buttonColorDarkGreen,
                          height: Dimensions.h30,
                          width: size.width / 2,
                          radius: Dimensions.h25,
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.w5,
                      ),
                      Expanded(
                        child: ButtonWidget(
                          onTap: () {
                            homeController.pageWidget.value = 5;
                            homeController.currentIndex.value = 5;

                            Get.toNamed(AppRoutName.withdrawalpage);
                          },
                          text: "WITHDRAWAL_TXT".tr,
                          buttonColor: AppColors.buttonColorOrange,
                          height: Dimensions.h30,
                          width: size.width / 2,
                          radius: Dimensions.h25,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
