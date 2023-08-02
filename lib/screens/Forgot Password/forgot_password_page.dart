import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/app_colors.dart';
import 'package:spllive/helper_files/constant_image.dart';
import 'package:spllive/helper_files/custom_text_style.dart';

import '../../components/edit_text_field_with_icon.dart';
import '../../components/simple_button_with_corner.dart';
import '../../helper_files/dimentions.dart';
import '../../helper_files/ui_utils.dart';
import 'controller/forgot_password_page_controller.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({Key? key}) : super(key: key);

  final controller = Get.find<ForgotPasswordController>();
  final verticalSpace = SizedBox(height: Dimensions.h20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.appbarColor),
        systemOverlayStyle: AppUtils.toolBarStyleDark,
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildForgotPasswordForm(context),
          ],
        ),
      ),
    );
  }

  _buildForgotPasswordForm(context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.h20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              height: Dimensions.h80,
              width: Dimensions.w200,
              child: Image.asset(
                ConstantImage.splLogo,
                fit: BoxFit.contain,
              ),
            ),
          ),
          verticalSpace,
          Center(
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                "FORGOTPASSWORD".tr,
                style: CustomTextStyle.textRobotoSlabBold.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.h23,
                  letterSpacing: 1,
                  color: AppColors.appbarColor,
                ),
              ),
            ),
          ),
          //  verticalSpace,
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: Dimensions.w20),
          //   child: Text(
          //     "FORGOT_SUBTEXT".tr,
          //     textAlign: TextAlign.center,
          //     style: CustomTextStyle.textRobotoSansLight.copyWith(
          //       fontSize: Dimensions.h14,
          //       //  letterSpacing: 1,
          //       height: 1.5,
          //       color: AppColors.grey,
          //     ),
          //   ),
          // ),
          verticalSpace,
          _buildMobileNumberField(),
          verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w15),
            child: RoundedCornerButton(
              text: "SUBMIT".tr,
              color: AppColors.appbarColor,
              borderColor: AppColors.appbarColor,
              fontSize: Dimensions.h12,
              fontWeight: FontWeight.w200,
              fontColor: AppColors.white,
              letterSpacing: 0,
              borderRadius: Dimensions.r25,
              borderWidth: 0,
              textStyle: CustomTextStyle.textRobotoSansLight,
              onTap: () => controller.onTapOfContinue(),
              height: Dimensions.h30,
              width: double.infinity,
            ),
          )
        ],
      ),
    );
  }

  _buildMobileNumberField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          // Container(
          //   height: Dimensions.h40,
          //   padding: EdgeInsets.zero,
          //   decoration: BoxDecoration(
          //     color: AppColors.grey.withOpacity(0.2),
          //     borderRadius: BorderRadius.all(
          //       Radius.circular(Dimensions.r10),
          //     ),
          //   ),
          //   child: CountryListPick(
          //     appBar: AppBar(
          //       backgroundColor: AppColors.appbarColor,
          //       title: const Text('Choose your country code'),
          //     ),
          //     pickerBuilder: (context, code) {
          //       return Padding(
          //         padding: EdgeInsets.symmetric(horizontal: Dimensions.h5),
          //         child: Row(
          //           children: [
          //             Text(
          //               code != null ? code.dialCode ?? "+91" : "91",
          //               style: CustomTextStyle.textPTsansMedium.copyWith(
          //                 color: AppColors.appbarColor,
          //                 fontSize: Dimensions.h16,
          //               ),
          //             ),
          //             Padding(
          //               padding: EdgeInsets.only(
          //                 left: Dimensions.w7,
          //               ),
          //               child: SvgPicture.asset(
          //                 ConstantImage.dropDownArrowSVG,
          //                 color: AppColors.grey,
          //               ),
          //             ),
          //           ],
          //         ),
          //       );
          //     },
          //     theme: CountryTheme(
          //       isShowFlag: false,
          //       isShowTitle: false,
          //       isShowCode: true,
          //       isDownIcon: true,
          //       showEnglishName: true,
          //       alphabetSelectedTextColor: AppColors.white,
          //       labelColor: AppColors.grey,
          //       alphabetTextColor: Colors.green,
          //     ),
          //     initialSelection: '+91',
          //     onChanged: (code) {
          //       String tempCountryCode =
          //           code != null ? code.dialCode ?? "+91" : "91";
          //       controller.onChangeCountryCode(tempCountryCode);
          //     },
          //     useUiOverlay: true,
          //     useSafeArea: false,
          //   ),
          // ),

          Expanded(
            child: RoundedCornerEditTextWithIcon(
              height: Dimensions.h40,
              onChanged: (v) {},
              autofocus: true,
              controller: controller.mobileNumberController,
              keyboardType: TextInputType.phone,
              hintText: "ENTERMOBILENUMBER".tr,
              imagePath: ConstantImage.phoneSVG,
              maxLines: 1,
              minLines: 1,
              isEnabled: true,
              maxLength: 10,
              formatter: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
        ],
      ),
    );
  }
}
