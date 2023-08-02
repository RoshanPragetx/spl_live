import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/constant_image.dart';

import '../../../helper_files/app_colors.dart';
import '../../../helper_files/custom_text_style.dart';
import '../../../helper_files/dimentions.dart';
import '../../../helper_files/ui_utils.dart';
import 'controller/about_page_controller.dart';

// ignore: must_be_immutable
class AboutUsPage extends StatelessWidget {
  AboutUsPage({super.key});
  var controller = Get.put(AboutUsPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppUtils().simpleAppbar(appBarTitle: "About Us"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w20),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: Dimensions.h228,
              child: SvgPicture.asset(ConstantImage.aboutUsImage),
            ),
            Row(
              children: [
                Text(
                  "ABOUTAPP".tr,
                  style: CustomTextStyle.textPTsansMedium.copyWith(
                    letterSpacing: 1,
                    color: AppColors.appbarColor,
                    fontWeight: FontWeight.bold,
                    fontSize: Dimensions.h15,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Dimensions.h5,
            ),
            Text(
              "WELCOME_SPL".tr,
              style: CustomTextStyle.textPTsansMedium.copyWith(
                fontSize: Dimensions.h13,
              ),
            ),
            SizedBox(
              height: Dimensions.h10,
            ),
            Text(
              "WELCOME_SPL2".tr,
              style: CustomTextStyle.textPTsansMedium.copyWith(
                fontSize: Dimensions.h13,
              ),
            )
          ],
        ),
      ),
    );
  }
}
