import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/app_colors.dart';
import 'package:spllive/helper_files/constant_image.dart';
import 'package:spllive/helper_files/custom_text_style.dart';
import 'package:spllive/helper_files/dimentions.dart';
import 'package:spllive/routes/app_routes_name.dart';
import '../../components/simple_button_with_corner.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var verticalSpace = SizedBox(
      height: Dimensions.h10,
    );
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: Dimensions.h150,
              width: Dimensions.h200,
              child: Image.asset(
                ConstantImage.splLogo,
                fit: BoxFit.contain,
              ),
            ),
            Text(
              "WELCOME_TEXT".tr,
              style: CustomTextStyle.textRobotoSlabBold
                  .copyWith(fontSize: Dimensions.h30, color: AppColors.black),
            ),
            SizedBox(
              height: Dimensions.h10,
            ),
            Text("WELCOMETEXT".tr,
                textAlign: TextAlign.center,
                style: CustomTextStyle.textPTsansMedium.copyWith(
                  fontSize: Dimensions.h14,
                )),
            verticalSpace,
            verticalSpace,
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
              textStyle: CustomTextStyle.textPTsansBold,
              onTap: () => Get.toNamed(AppRoutName.signInPage),
              height: Dimensions.h28,
              width: double.infinity,
            ),
            verticalSpace,
            orView(),
            verticalSpace,
            RoundedCornerButton(
              text: "SIGN UP".tr,
              color: AppColors.white,
              borderColor: AppColors.appbarColor,
              fontSize: Dimensions.h12,
              fontWeight: FontWeight.w500,
              fontColor: AppColors.appbarColor,
              letterSpacing: 0,
              borderRadius: Dimensions.r25,
              borderWidth: 1.5,
              textStyle: CustomTextStyle.textPTsansBold,
              onTap: () => Get.toNamed(AppRoutName.signUnPage),
              height: Dimensions.h28,
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
            color: AppColors.grey,
            indent: Dimensions.w20,
            endIndent: Dimensions.w20,
            thickness: 2,
          ),
        ),
        Text(
          "OR".tr,
          style: CustomTextStyle.textRobotoSlabBold.copyWith(
              fontSize: Dimensions.h20,
              color: AppColors.greyShade,
              fontWeight: FontWeight.w300),
        ),
        Expanded(
          child: Divider(
            color: AppColors.grey,
            indent: Dimensions.w20,
            endIndent: Dimensions.w20,
            thickness: 2,
          ),
        ),
      ],
    );
  }
//   Row orView() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Expanded(
//           child: Divider(
//             color: Colors.grey,
//             indent: Dimensions.w20,
//             endIndent: Dimensions.w20,
//             thickness: 2,
//           ),
//         ),
//         Text(
//           "OR",
//           style: CustomTextStyle.textRobotoSlabMedium
//               .copyWith(fontSize: Dimensions.h25),
//         ),
//         Expanded(
//           child: Divider(
//             color: Colors.grey,
//             indent: Dimensions.w20,
//             endIndent: Dimensions.w20,
//             thickness: 2,
//           ),
//         ),
//       ],
//     );
//   }
}
