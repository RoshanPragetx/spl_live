import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:spllive/helper_files/app_colors.dart';

import '../../components/simple_button_with_corner.dart';
import '../../helper_files/constant_image.dart';
import '../../helper_files/custom_text_style.dart';
import '../../helper_files/dimentions.dart';
import 'controller/verify_otp_controller.dart';

class VerifyOTPPage extends StatelessWidget {
  VerifyOTPPage({Key? key}) : super(key: key);

  final controller = Get.find<VerifyOTPController>();

  final verticalSpace = SizedBox(
    height: Dimensions.h20,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                height: Dimensions.h100,
                width: Dimensions.w150,
                child: Image.asset(
                  ConstantImage.splLogo,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Text(
              "ENTEROTP".tr,
              style: CustomTextStyle.textRobotoSlabBold.copyWith(
                fontSize: Dimensions.h20,
                letterSpacing: 1,
                color: AppColors.appbarColor,
              ),
            ),
            _buildOtpAndMpinForm(context),
          ],
        ),
      ),
    );
  }

  _buildOtpAndMpinForm(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // verticalSpace,
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: Dimensions.w20),
        //   child: Text(
        //     "OTPTEXT".tr,
        //     textAlign: TextAlign.center,
        //     style: CustomTextStyle.textRobotoSansLight.copyWith(
        //       fontSize: Dimensions.h14,
        //       letterSpacing: 1,
        //       height: 1.5,
        //       color: AppColors.black,
        //     ),
        //   ),
        // ),
        // verticalSpace,
        _buildPinCodeField(
          context: context,
          title: "OTP",
          pinType: controller.otp,
          pinCodeLength: 6,
        ),
        verticalSpace,
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.h12),
            child: GestureDetector(
              onTap: () => controller.callResendOtpApi(),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "DIDOTP".tr,
                    style: CustomTextStyle.textRobotoSansLight.copyWith(
                      color: AppColors.appbarColor,
                      fontWeight: FontWeight.normal,
                      fontSize: Dimensions.h14,
                    ),
                    children: [
                      TextSpan(
                        text: "RESENDOTP".tr,
                        style: CustomTextStyle.textRobotoSansLight.copyWith(
                          color: AppColors.appbarColor,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.normal,
                          fontSize: Dimensions.h14,
                        ),
                      )
                    ]),
              ),
            ),
          ),
        ),
        verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w18),
          child: RoundedCornerButton(
            text: "CONTINUE".tr,
            color: AppColors.appbarColor,
            borderColor: AppColors.appbarColor,
            fontSize: Dimensions.h12,
            fontWeight: FontWeight.w500,
            fontColor: AppColors.white,
            letterSpacing: 1,
            borderRadius: Dimensions.r9,
            borderWidth: 1,
            textStyle: CustomTextStyle.textRobotoSansMedium,
            onTap: () => controller.onTapOfContinue(),
            height: Dimensions.h30,
            width: double.infinity,
          ),
        ),
      ],
    );
  }

  _buildPinCodeField({
    required BuildContext context,
    required String title,
    required RxString pinType,
    required int pinCodeLength,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: CustomTextStyle.textRobotoSansMedium.copyWith(
              fontWeight: FontWeight.normal,
              fontSize: Dimensions.h15,
              letterSpacing: 1,
              color: AppColors.black,
            ),
          ),
          SizedBox(
            height: Dimensions.h10,
          ),
          PinCodeFields(
            autofocus: true,
            length: pinCodeLength,
            obscureText: false,
            obscureCharacter: "",
            textStyle: CustomTextStyle.textRobotoSansMedium.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20),
            animationDuration: const Duration(milliseconds: 200),
            onComplete: (val) {
              pinType.value = val;
            },
            keyboardType: TextInputType.number,
            animation: Animations.fade,
            activeBorderColor: AppColors.appbarColor,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            onChange: (val) {
              pinType.value = val;
            },
            enabled: true,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            responsive: true,
          ),
          // PinCodeTextField(
          //   autoFocus: true,
          //   length: pinCodeLength,
          //   appContext: context,
          //   cursorColor: AppColors.black,
          //   obscureText: false,
          //   animationType: AnimationType.fade,
          //   keyboardType: TextInputType.number,
          //   enableActiveFill: true,
          //   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          //   pinTheme: PinTheme(
          //       shape: PinCodeFieldShape.box,
          //       activeFillColor: AppColors.grey.withOpacity(0.2),
          //       inactiveFillColor: AppColors.grey.withOpacity(0.2),
          //       selectedFillColor: AppColors.grey.withOpacity(0.2),
          //       inactiveColor: Colors.transparent,
          //       activeColor: Colors.transparent,
          //       selectedColor: Colors.transparent,
          //       errorBorderColor: Colors.transparent,
          //       borderWidth: 0,
          //       borderRadius: BorderRadius.all(Radius.circular(Dimensions.r5))),
          //   textStyle: CustomTextStyle.textRobotoSlabMedium.copyWith(
          //       color: AppColors.appbarColor, fontWeight: FontWeight.bold),
          //   animationDuration: const Duration(milliseconds: 200),
          //   // controller: controller.otpController,
          //   onCompleted: (val) {
          //     pinType.value = val;
          //   },
          //   onChanged: (val) {
          //     pinType.value = val;
          //   },
          //   beforeTextPaste: (text) {
          //     return false;
          //   },
          // ),
        ],
      ),
    );
  }
}
