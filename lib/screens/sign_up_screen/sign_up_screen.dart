// ignore_for_file: unused_import

import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/app_colors.dart';
import 'package:spllive/helper_files/constant_image.dart';
import 'package:spllive/routes/app_routes_name.dart';
import '../../components/edit_text_field_with_icon.dart';
import '../../components/simple_button_with_corner.dart';
import '../../helper_files/custom_text_style.dart';
import '../../helper_files/dimentions.dart';
import '../../helper_files/ui_utils.dart';
import 'controller/sign_up_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final controller = Get.find<SignUpPageController>();

  final verticalSpace = SizedBox(
    height: Dimensions.h20,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.appbarColor),
        systemOverlayStyle: AppUtils.toolBarStyleDark,
      ),
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.w35,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Expanded(child: verticalSpace),
            // verticalSpace,
            SizedBox(
              height: Dimensions.h150,
              width: Dimensions.w200,
              child: Image.asset(
                ConstantImage.splLogo,
                fit: BoxFit.contain,
              ),
            ),
            Text(
              "REGISTER".tr,
              style: CustomTextStyle.textRobotoSlabMedium.copyWith(
                  color: AppColors.appbarColor, fontSize: Dimensions.h20),
            ),
            verticalSpace,
            Text("REGISTERTEXT".tr,
                textAlign: TextAlign.center,
                style: CustomTextStyle.textPTsansMedium
                    .copyWith(fontSize: Dimensions.h17, color: AppColors.black)
                //   style:
                //       TextStyle(fontSize: Dimensions.h15, color: AppColors.black),
                // ),)
                ),
            verticalSpace,
            _buildMobileNumberField(),
            verticalSpace,
            RoundedCornerButton(
              text: "SEND OTP".tr,
              color: AppColors.appbarColor,
              borderColor: AppColors.appbarColor,
              fontSize: Dimensions.h12,
              fontWeight: FontWeight.w500,
              fontColor: AppColors.white,
              letterSpacing: 0,
              borderRadius: Dimensions.r25,
              borderWidth: 1,
              textStyle: CustomTextStyle.textPTsansBold,
              onTap: () => controller.onTapOfSendOtp(),
              height: Dimensions.h30,
              width: double.infinity,
            ),
            // Expanded(child: verticalSpace),
            // verticalSpace,
            // GestureDetector(
            //   onTap: () => Get.offAllNamed(AppRoutName.signInPage),
            //   child: Container(
            //     padding: const EdgeInsets.all(10),
            //     child: Text(
            //       "HAVEANACCOUNT".tr,
            //       textAlign: TextAlign.center,
            //       style: CustomTextStyle.textRobotoSlabMedium.copyWith(
            //         fontSize: Dimensions.h15,
            //         letterSpacing: 1,
            //         height: 1.5,
            //         color: AppColors.black,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  _buildMobileNumberField() {
    return Row(
      children: [
        Container(
          height: Dimensions.h40,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: AppColors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.all(
              Radius.circular(Dimensions.r10),
            ),
          ),
          child: CountryListPick(
            appBar: AppBar(
              backgroundColor: AppColors.grey.withOpacity(0.2),
              title: const Text('Choose your country code'),
            ),
            pickerBuilder: (context, code) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.h5),
                child: Row(
                  children: [
                    Text(
                      code != null ? code.dialCode ?? "+91" : "91",
                      style: CustomTextStyle.textRobotoSlabMedium.copyWith(
                        color: AppColors.appbarColor,
                        fontSize: Dimensions.h16,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: Dimensions.w7,
                      ),
                      child: SvgPicture.asset(
                        ConstantImage.dropDownArrowSVG,
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
              );
            },
            theme: CountryTheme(
              isShowFlag: false,
              isShowTitle: false,
              isShowCode: true,
              isDownIcon: true,
              showEnglishName: true,
              alphabetSelectedTextColor: AppColors.white,
              labelColor: AppColors.grey,
              alphabetTextColor: AppColors.green,
            ),
            initialSelection: '+91',
            onChanged: (code) {
              String tempCountryCode =
                  code != null ? code.dialCode ?? "+91" : "91";
              controller.onChangeCountryCode(tempCountryCode);
            },
            useUiOverlay: true,
            useSafeArea: false,
          ),
        ),
        SizedBox(
          width: Dimensions.w9,
        ),
        Expanded(
          child: RoundedCornerEditTextWithIcon(
            height: Dimensions.h40,
            controller: controller.mobileNumberController,
            keyboardType: TextInputType.phone,
            hintText: "Enter Mobile Number".tr,
            imagePath: ConstantImage.phoneSVG,
            maxLines: 1,
            minLines: 1,
            isEnabled: true,
            maxLength: 10,
            formatter: [FilteringTextInputFormatter.digitsOnly],
          ),
        ),
      ],
    );
  }
}
