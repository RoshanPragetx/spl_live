import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:spllive/helper_files/app_colors.dart';

import '../../helper_files/custom_text_style.dart';
import '../../helper_files/dimentions.dart';
import 'controller/mpin_page_controller.dart';

class MPINPageView extends StatelessWidget {
  MPINPageView({Key? key}) : super(key: key);

  final controller = Get.find<MPINPageController>();
  final verticalSpace = SizedBox(height: Dimensions.h20);

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
            _buildOtpAndMpinForm(context),
          ],
        ),
      ),
    );
  }

  _buildOtpAndMpinForm(context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.h20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "MPIN".tr,
              style: CustomTextStyle.textRobotoSlabBold.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: Dimensions.h25,
                letterSpacing: 1,
                color: AppColors.appbarColor,
              ),
            ),
          ),
          verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w20),
            child: Center(
              child: Text(
                "MPINPAGETEXT".tr,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: Dimensions.h14),
                // style: CustomTextStyle.textGothamLight.copyWith(
                //   fontSize: Dimensions.sp17,
                //   letterSpacing: 1,
                //   height: 1.5,
                //   color: AppColors.textColorMain,
                // ),
              ),
            ),
          ),
          verticalSpace,
          _buildPinCodeField(
            context: context,
            title: "MPIN",
            pinType: controller.mpin,
            pinCodeLength: 4,
          ),
          // verticalSpace,
          // Padding(
          //   padding:  EdgeInsets.symmetric(horizontal: Dimensions.w18),
          //   child: RoundedCornerButton(
          //     text: "CONTINUE".tr,
          //     color: AppColors.textColorMain,
          //     borderColor: AppColors.textColorMain,
          //     fontSize: Dimensions.sp16dot5,
          //     fontWeight: FontWeight.w500,
          //     fontColor: AppColors.white,
          //     letterSpacing: 0,
          //     borderRadius: Dimensions.r9,
          //     borderWidth: 1,
          //     textStyle: CustomTextStyle.textGothamLight,
          //     onTap: () => controller.onTapOfVerify(),
          //     height: Dimensions.h46,
          //     width: double.infinity,
          //   ),
          // ),
          verticalSpace,
          Center(
            child: GestureDetector(
              onTap: () => controller.forgotMPINApi(),
              child: Text(
                "${"FORGOTYOURMPIN".tr}?",
                textAlign: TextAlign.center,
                style: CustomTextStyle.textRobotoSlabBold.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: Dimensions.h12,
                  letterSpacing: 1,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
        ],
      ),
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
            style: CustomTextStyle.textRobotoSlabBold.copyWith(
              fontWeight: FontWeight.bold,
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
            mainAxisAlignment: MainAxisAlignment.start,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              activeFillColor: AppColors.grey.withOpacity(0.2),
              inactiveFillColor: AppColors.grey.withOpacity(0.2),
              selectedFillColor: AppColors.grey.withOpacity(0.2),
              inactiveColor: Colors.transparent,
              activeColor: Colors.transparent,
              selectedColor: Colors.transparent,
              errorBorderColor: Colors.transparent,
              fieldOuterPadding: EdgeInsets.only(right: Dimensions.h15),
              borderWidth: 0,
              borderRadius: BorderRadius.all(Radius.circular(Dimensions.r5)),
            ),
            // textStyle: CustomTextStyle.textGothamBold.copyWith(
            //     color: AppColors.splashScreenTextColor,
            //     fontWeight: FontWeight.bold),
            animationDuration: const Duration(milliseconds: 200),
            onCompleted: (val) {
              pinType.value = val;
              controller.onCompleteMPIN();
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
