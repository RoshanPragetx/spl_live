import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spllive/Custom%20Controllers/wallet_controller.dart';
import 'package:spllive/components/new_auto_complete_text_field_with_suggetion.dart';
import 'package:spllive/components/simple_button_with_corner.dart';
import 'package:spllive/helper_files/app_colors.dart';
import 'package:spllive/helper_files/constant_image.dart';
import 'package:spllive/helper_files/custom_text_style.dart';
import 'package:spllive/helper_files/dimentions.dart';
import 'package:spllive/helper_files/ui_utils.dart';
import 'package:spllive/routes/app_routes_name.dart';
import 'package:spllive/screens/New%20GameModes/controller/new_gamemode_page_controller.dart';

// ignore: must_be_immutable
class Gamemodenew extends StatelessWidget {
  Gamemodenew({super.key});
  var walletController = Get.put(WalletController());
  var controller = Get.put(NewGamemodePageController());
  var verticalSpace = SizedBox(
    height: 10,
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppUtils().simpleAppbar(
        appBarTitle: "MILAN NIGHT",
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          InkWell(
            onTap: () => Get.offAndToNamed(AppRoutName.transactionPage),
            child: Row(
              children: [
                SizedBox(
                  height: Dimensions.h22,
                  width: Dimensions.w25,
                  child: SvgPicture.asset(
                    ConstantImage.walletAppbar,
                    color: AppColors.white,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: Dimensions.h8,
                      bottom: Dimensions.h10,
                      left: Dimensions.h10,
                      right: Dimensions.h10),
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
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.h10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "TWO DIGIT PANEL",
                    style: CustomTextStyle.textRobotoSansMedium.copyWith(
                      color: AppColors.appbarColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "OPEN",
                    style: CustomTextStyle.textRobotoSansMedium.copyWith(
                      color: AppColors.appbarColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
            ),
            verticalSpace,
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.h10,
                    ),
                    child: AutoTextFieldWithSuggetion(
                      optionsBuilder: (p0) {
                        return Characters("");
                      },
                      height: Dimensions.h35,
                      controller: controller.digitController,
                      hintText: "Enter Ank",
                      containerWidth: double.infinity,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.h10,
                    ),
                    child: AutoTextFieldWithSuggetion(
                      optionsBuilder: (p0) {
                        return Characters("");
                      },
                      height: Dimensions.h35,
                      controller: controller.digitController,
                      hintText: "Enter Points",
                      containerWidth: double.infinity,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                ),
              ],
            ),
            verticalSpace,
            verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.h13),
              child: RoundedCornerButton(
                text: "PLUSADD".tr,
                color: AppColors.appbarColor,
                borderColor: AppColors.appbarColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                fontColor: AppColors.white,
                letterSpacing: 1,
                borderRadius: 5,
                borderWidth: 0.2,
                textStyle: CustomTextStyle.textRobotoSansBold,
                onTap: () {
                  // controller.coinsFocusNode.unfocus();
                  // controller.openFocusNode.requestFocus();
                  // controller.onTapOfAddBidButton();
                },
                height: Dimensions.h35,
                width: Dimensions.h150,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: size.width,
        height: Dimensions.h50,
        color: AppColors.appbarColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            nameColumn(titleText: "Bids", subText: "0"),
            nameColumn(titleText: "Points", subText: "0"),
            SizedBox(
              width: Dimensions.w60,
            ),
            RoundedCornerButton(
              text: "SAVE".tr.toUpperCase(),
              color: AppColors.white,
              borderColor: AppColors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              fontColor: AppColors.black,
              letterSpacing: 1,
              borderRadius: 5,
              borderWidth: 0.2,
              textStyle: CustomTextStyle.textRobotoSansBold,
              onTap: () {
                // controller.coinsFocusNode.unfocus();
                // controller.openFocusNode.requestFocus();
                // controller.onTapOfAddBidButton();
              },
              height: Dimensions.h25,
              width: Dimensions.w100,
            ),
          ],
        ),
      ),
    );
  }

  Widget nameColumn({required String titleText, required String subText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: Container(
        // color: AppColors.balanceCoinsColor,
        width: Dimensions.w80,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Column(
            children: [
              Text(
                textAlign: TextAlign.center,
                titleText,
                style: CustomTextStyle.textRobotoSansMedium.copyWith(
                  color: AppColors.white,
                  fontSize: 15,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  textAlign: TextAlign.center,
                  subText,
                  style: CustomTextStyle.textRobotoSansLight.copyWith(
                    color: AppColors.white,
                    fontSize: 13,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
