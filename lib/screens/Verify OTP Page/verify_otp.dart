import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:spllive/helper_files/app_colors.dart';

import '../../components/simple_button_with_corner.dart';
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
        verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w20),
          child: Text(
            "Enter 6 digit code that you received in your mobile number".tr,
            textAlign: TextAlign.center,
            style: CustomTextStyle.textRobotoSlabLight.copyWith(
              fontSize: Dimensions.h14,
              letterSpacing: 1,
              height: 1.5,
              color: AppColors.black,
            ),
          ),
        ),
        verticalSpace,
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
                    text: "Didn't receive the otp ? ",
                    style: CustomTextStyle.textRobotoSlabMedium.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: Dimensions.h14,
                    ),
                    children: [
                      TextSpan(
                        text: "Resend OTP",
                        style: CustomTextStyle.textRobotoSlabMedium.copyWith(
                          color: AppColors.black,
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
            fontSize: Dimensions.h15,
            fontWeight: FontWeight.w500,
            fontColor: AppColors.white,
            letterSpacing: 0,
            borderRadius: Dimensions.r9,
            borderWidth: 1,
            textStyle: CustomTextStyle.textRobotoSlabMedium,
            onTap: () => controller.onTapOfContinue(),
            height: Dimensions.h40,
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
            style: CustomTextStyle.textPTsansBold.copyWith(
              fontWeight: FontWeight.normal,
              fontSize: Dimensions.h15,
              letterSpacing: 1,
              color: AppColors.black,
            ),
          ),
          SizedBox(
            height: Dimensions.h10,
          ),
          PinCodeTextField(
            length: pinCodeLength,
            appContext: context,
            obscureText: false,
            animationType: AnimationType.fade,
            keyboardType: TextInputType.number,
            enableActiveFill: true,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                activeFillColor: AppColors.grey.withOpacity(0.2),
                inactiveFillColor: AppColors.grey.withOpacity(0.2),
                selectedFillColor: AppColors.grey.withOpacity(0.2),
                inactiveColor: Colors.transparent,
                activeColor: Colors.transparent,
                selectedColor: Colors.transparent,
                errorBorderColor: Colors.transparent,
                borderWidth: 0,
                borderRadius: BorderRadius.all(Radius.circular(Dimensions.r5))),
            textStyle: CustomTextStyle.textRobotoSlabMedium.copyWith(
                color: AppColors.appbarColor, fontWeight: FontWeight.bold),
            animationDuration: const Duration(milliseconds: 200),
            // controller: controller.otpController,
            onCompleted: (val) {
              pinType.value = val;
            },
            onChanged: (val) {
              pinType.value = val;
            },
            beforeTextPaste: (text) {
              return false;
            },
          ),
        ],
      ),
    );
  }
}
