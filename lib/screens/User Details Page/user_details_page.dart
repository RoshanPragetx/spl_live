import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:spllive/helper_files/app_colors.dart';
import 'package:spllive/helper_files/constant_image.dart';
import 'package:spllive/routes/app_routes_name.dart';

import '../../components/edit_text_field_with_icon.dart';
import '../../components/password_field_with_icon.dart';
import '../../components/simple_button_with_corner.dart';
import '../../helper_files/custom_text_style.dart';
import '../../helper_files/dimentions.dart';
import 'controller/user_details_page_controller.dart';

class UserDetailsPage extends StatelessWidget {
  UserDetailsPage({Key? key}) : super(key: key);

  final controller = Get.find<UserDetailsPageController>();

  final verticalSpace = SizedBox(
    height: Dimensions.h15,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: Dimensions.h15, right: Dimensions.h15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                verticalSpace,
                verticalSpace,
                verticalSpace,
                verticalSpace,
                verticalSpace,
                verticalSpace,
                verticalSpace,
                Center(
                  child: SizedBox(
                    height: Dimensions.h70,
                    width: Dimensions.w150,
                    child: Image.asset(
                      ConstantImage.splLogo,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                verticalSpace,
                Text(
                  "SIGN UP".tr,
                  style: CustomTextStyle.textRobotoSlabBold.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: Dimensions.h25,
                    letterSpacing: 1,
                    color: AppColors.appbarColor,
                  ),
                ),
                verticalSpace,
                _buildNormalField(
                  hintText: "Enter Full Name".tr,
                  textController: controller.fullNameController,
                  maxLength: 100,
                  keyboardType: TextInputType.name,
                  autofocus: true,
                  //focusNode: controller.fullNameFocusNode,
                ),
                verticalSpace,
                _buildNormalField(
                  hintText: "Enter User Name".tr,
                  textController: controller.userNameController,
                  maxLength: 100,
                  keyboardType: TextInputType.name,
                  //  focusNode: controller.userNameFocusNode,
                ),
                verticalSpace,
                _buildPasswordField(
                  hintText: "Enter Password".tr,
                  textController: controller.passwordController,
                  visibility: controller.pVisibility,
                ),
                verticalSpace,
                _buildPasswordField(
                  hintText: "Enter Confirm Password".tr,
                  textController: controller.confirmPasswordController,
                  visibility: controller.cpVisibility,
                ),
                verticalSpace,
                _buildSignUpButtonRow(),
                verticalSpace,
                _buildCreateAccount(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildNormalField({
    required String hintText,
    required TextEditingController textController,
    required int maxLength,
    required TextInputType keyboardType,
    List<TextInputFormatter>? formatter,
    bool? autofocus,
    FocusNode? focusNode,
  }) {
    return RoundedCornerEditTextWithIcon(
      height: Dimensions.h40,
      controller: textController,
      keyboardType: keyboardType,
      hintText: hintText,
      imagePath: ConstantImage.profileIconSVG,
      maxLines: 1,
      minLines: 1,
      isEnabled: true,
      maxLength: maxLength,
      formatter: formatter,
      focusNode: focusNode,
      autofocus: autofocus ?? false,
    );
  }

  _buildPasswordField({
    required String hintText,
    required TextEditingController textController,
    required RxBool visibility,
    FocusNode? focusNode,
    Function(String)? onChanged,
  }) {
    return Obx(() {
      return PasswordFieldWithIcon(
        focusNode: focusNode,
        onChanged: onChanged,
        height: Dimensions.h40,
        keyBoardType: TextInputType.visiblePassword,
        controller: textController,
        hintText: hintText,
        hidePassword: visibility.value,
        suffixIcon: InkWell(
          onTap: () {
            controller.onTapOfVisibilityIcon(visibility);
          },
          child: Icon(
            Icons.visibility,
            size: Dimensions.h15,
            color: visibility.value ? AppColors.grey : AppColors.appbarColor,
          ),
        ),
        suffixIconColor: AppColors.appbarColor,
        imagePath: ConstantImage.lockSVG,
      );
    });
  }

  _buildSignUpButtonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RoundedCornerButton(
          height: Dimensions.h30,
          width: Dimensions.w300,
          letterSpacing: 1,
          color: AppColors.appbarColor,
          fontSize: Dimensions.h12,
          fontWeight: FontWeight.w500,
          // text: "SIGNUP".tr,
          text: "Register",
          textStyle: CustomTextStyle.textRobotoSansMedium,
          borderRadius: Dimensions.h25,
          borderColor: AppColors.appbarColor,
          borderWidth: 2,
          fontColor: AppColors.white,
          onTap: () => controller.onTapOfRegister(),
        ),
      ],
    );
  }

  _buildCreateAccount() {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.h15),
      child: GestureDetector(
        onTap: () => Get.offAllNamed(AppRoutName.signInPage),
        child: Center(
          child: Text(
            "ACCOUNTLOGIN".tr,
            // "${"HAVEANACCOUNT".tr}? ${"LOGIN".tr} ${"HERE".tr}.",
            style: CustomTextStyle.textPTsansMedium.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: Dimensions.h14,
              letterSpacing: 1,
              color: AppColors.appbarColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );
  }
}
