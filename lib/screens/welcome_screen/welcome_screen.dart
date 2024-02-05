import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/app_colors.dart';
import 'package:spllive/helper_files/custom_text_style.dart';
import 'package:spllive/helper_files/dimentions.dart';
import 'package:spllive/screens/welcome_screen/controller/welcome_screen.dart';
import 'package:spllive/utils/constant.dart';

import '../../components/simple_button_with_corner.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final controller = Get.put<WelcomeScreenController>(WelcomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: Dimensions.h150,
              width: Dimensions.h200,
              child: Image.asset(
                AppImage.splLogo,
                fit: BoxFit.contain,
              ),
            ),
            Text(
              "Welcome",
              style: CustomTextStyle.textRobotoSlabLight.copyWith(
                fontSize: Dimensions.h25,
                color: AppColors.appbarColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: Dimensions.h10),
            SizedBox(height: Dimensions.h10),
            RoundedCornerButton(
              text: "SIGNIN".tr,
              color: AppColors.appbarColor,
              borderColor: AppColors.appbarColor,
              fontSize: Dimensions.h12,
              fontWeight: FontWeight.w500,
              fontColor: AppColors.white,
              letterSpacing: 0,
              borderRadius: Dimensions.r25,
              borderWidth: 1,
              textStyle: CustomTextStyle.textRobotoSansLight,
              onTap: () => Get.toNamed(AppRouteNames.signInPage),
              height: Dimensions.h30,
              width: double.infinity,
            ),
            SizedBox(height: Dimensions.h10),
            orView(),
            SizedBox(height: Dimensions.h10),
            RoundedCornerButton(
              text: "SIGNUP".tr,
              color: AppColors.white,
              borderColor: AppColors.appbarColor,
              fontSize: Dimensions.h12,
              fontWeight: FontWeight.w500,
              fontColor: AppColors.appbarColor,
              letterSpacing: 0,
              borderRadius: Dimensions.r50,
              borderWidth: 1,
              textStyle: CustomTextStyle.textRobotoSansMedium,
              onTap: () => Get.toNamed(AppRouteNames.signUnPage),
              height: Dimensions.h30,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  Row orView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            color: AppColors.greyShade.withOpacity(0.6),
            indent: Dimensions.w20,
            endIndent: Dimensions.w20,
            thickness: 2,
          ),
        ),
        Text(
          "OR",
          style: CustomTextStyle.textRobotoSlabMedium.copyWith(
            fontSize: Dimensions.h20,
            color: AppColors.greyShade.withOpacity(0.6),
            fontWeight: FontWeight.w300,
          ),
        ),
        Expanded(
          child: Divider(
            color: AppColors.greyShade.withOpacity(0.6),
            indent: Dimensions.w20,
            endIndent: Dimensions.w20,
            thickness: 2,
          ),
        ),
      ],
    );
  }
}
