// ignore_for_file: unused_import, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spllive/Custom%20Controllers/wallet_controller.dart';
import 'package:spllive/components/simple_button_with_corner.dart';
import 'package:spllive/screens/home_screen/controller/homepage_controller.dart';

import '../../../components/button_widget.dart';
import '../../../helper_files/app_colors.dart';
import '../../../helper_files/constant_image.dart';
import '../../../helper_files/constant_variables.dart';
import '../../../helper_files/custom_text_style.dart';
import '../../../helper_files/dimentions.dart';
import '../../../helper_files/ui_utils.dart';
import '../../../routes/app_routes_name.dart';
import '../../Local Storage.dart';
import '../Check Withdrawal History/controller/check_withdrawal_history_controller.dart';

class WithdrawalPage extends StatelessWidget {
  WithdrawalPage({super.key});
  var walletController = Get.put(WalletController());
  var homeController = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var verticalSpace = SizedBox(
      height: Dimensions.h15,
    );
    return Scaffold(
      appBar: AppUtils().simpleAppbar(
        appBarTitle: "My Wallet",
        leading: IconButton(
          onPressed: () {
            homeController.pageWidget.value = 4;
            homeController.currentIndex.value = 4;
            Get.toNamed(AppRoutName.dashBoardPage);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          InkWell(
            // onTap: () => Get.offAndToNamed(AppRoutName.transactionPage),
            child: Row(
              children: [
                SizedBox(
                  height: Dimensions.w20,
                  width: Dimensions.w20,
                  child: SvgPicture.asset(
                    ConstantImage.walletAppbar,
                    color: AppColors.white,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: Dimensions.r8,
                      bottom: Dimensions.r10,
                      left: Dimensions.r15,
                      right: Dimensions.r10),
                  child: Obx(
                    () => Text(
                      walletController.walletBalance.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.w20, vertical: Dimensions.h10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace,
            Text(
              "WITHDRAWAL_TEXT".tr,
              style: CustomTextStyle.textRobotoSansLight.copyWith(
                color: AppColors.black,
                fontSize: Dimensions.h14,
              ),
            ),
            Text(
              "WITHDRAWAL_TEXT2".tr,
              style: CustomTextStyle.textRobotoSansLight.copyWith(
                color: AppColors.black,
                fontSize: Dimensions.h14,
              ),
            ),
            verticalSpace,
            Text(
              "WITHDRAWAL_TEXT3".tr,
              style: CustomTextStyle.textRobotoSansLight.copyWith(
                color: AppColors.black,
                fontSize: Dimensions.h14,
              ),
            ),
            SizedBox(
              height: Dimensions.h15,
            ),
            Text(
              "WITHDRAWAL_TEXT4".tr,
              style: CustomTextStyle.textRobotoSansLight.copyWith(
                color: AppColors.black,
                fontSize: Dimensions.h14,
              ),
            ),
            verticalSpace,
            Text(
              "WITHDRAWAL_TEXT5".tr,
              style: CustomTextStyle.textRobotoSansLight.copyWith(
                color: AppColors.black,
                fontSize: Dimensions.h14,
              ),
            ),
            verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.w10, vertical: Dimensions.h10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RoundedCornerButton(
                      // CHANGE TEXT TO CREATE WITHDRAWAL REQUEST
                      text: "CHECKWITHDRAWAL".tr,
                      color: AppColors.buttonColorDarkGreen,
                      borderColor: AppColors.buttonColorDarkGreen,
                      fontSize: Dimensions.h13,
                      fontWeight: FontWeight.w500,
                      fontColor: AppColors.white,
                      letterSpacing: 0.5,
                      borderRadius: Dimensions.h50,
                      borderWidth: 0,
                      textStyle: CustomTextStyle.textRobotoSansLight,
                      onTap: () {
                        Get.toNamed(AppRoutName.createWithDrawalPage);
                      },
                      height: Dimensions.h30,
                      width: Dimensions.w200,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: Dimensions.h70,
              color: AppColors.appbarColor,
              // child: Image.asset(
              //   'assets/images/samsung.jpg',
              // ),
            ),
            Padding(
              padding: EdgeInsets.all(Dimensions.r10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RoundedCornerButton(
                      text: "CHECKHISTORY".tr,
                      color: AppColors.blueButton,
                      borderColor: AppColors.blueButton,
                      fontSize: Dimensions.h13,
                      fontWeight: FontWeight.w500,
                      fontColor: AppColors.white,
                      letterSpacing: 0.5,
                      borderRadius: Dimensions.h50,
                      borderWidth: 0,
                      textStyle: CustomTextStyle.textRobotoSansLight,
                      onTap: () {
                        // checkWithdrawalPageController.get(lazyLoad: false);
                        print(
                            "====== My Wallet screen ====== Check withdrawalPageController ======");
                        Get.offAndToNamed(AppRoutName.checkWithDrawalPage);
                      },
                      height: Dimensions.h30,
                      width: Dimensions.w200,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
