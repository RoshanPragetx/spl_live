// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spllive/components/button_widget.dart';
import 'package:spllive/helper_files/ui_utils.dart';
import '../../../components/edit_text_password.dart';
import '../../../helper_files/app_colors.dart';
import '../../../helper_files/custom_text_style.dart';
import '../../../helper_files/dimentions.dart';
import 'controller/change_password_controller.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({Key, key}) : super(key: key);

  var controller = Get.put(ChangepasswordPageController());

  // ignore: unused_field
  final _formKey = GlobalKey<FormState>();
  var verticalSpace = SizedBox(height: Dimensions.h11);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppUtils().simpleAppbar(appBarTitle: "Change Password"),
      backgroundColor: AppColors.white,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(Dimensions.h5),
                child: Container(
                  decoration: BoxDecoration(color: AppColors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Dimensions.h15,
                      ),
                      Text(
                        "ENTEROLDPASSWORD".tr,
                        style: CustomTextStyle.textPTsansMedium.copyWith(
                          color: AppColors.appbarColor,
                          fontSize: Dimensions.h15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      verticalSpace,
                      Obx(
                        () => EdittextFieldwithvalidation(
                          // focusNode: controller.oldMPASSWORDFocusNode,
                          controller: controller.oldPassword,
                          keyboardType: TextInputType.text,
                          autofocus: true,
                          hintText: "OLDPASSWORD".tr,
                          obscureText: controller.isObscureOldPassword.value,
                          onChanged: (value) {
                            controller.onChanged(value);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              // controller.oldMPASSWORDFocusNode.unfocus();
                              // controller.newMPASSWORDFocusNode.requestFocus();
                              return 'Password is required';
                            }
                            return null;
                          },
                          onTap: () {
                            controller.isObscureOldPassword.value =
                                !controller.isObscureOldPassword.value;
                          },
                        ),
                      ),
                      Obx(
                        () => controller.oldPasswordMessage.value.isEmpty
                            ? const SizedBox()
                            : Text(
                                textAlign: TextAlign.start,
                                controller.oldPasswordMessage.value,
                                style: TextStyle(color: AppColors.redColor),
                              ),
                      ),
                      SizedBox(
                        height: Dimensions.h15,
                      ),
                      Text(
                        "ENTERPASSWORD".tr,
                        style: CustomTextStyle.textPTsansMedium.copyWith(
                          color: AppColors.appbarColor,
                          fontSize: Dimensions.h15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      verticalSpace,
                      Obx(
                        () => EdittextFieldwithvalidation(
                          // focusNode: controller.newMPASSWORDFocusNode,
                          controller: controller.newPassword,
                          hintText: "NEWPASSWORD".tr,

                          obscureText: controller.isObscureNewPassword.value,
                          onChanged: (value) {
                            controller.onChanged2(value);
                          },
                          validator: (value) {
                            // controller.newMPASSWORDFocusNode.unfocus();
                            // controller.reEnterPASSWORDFocusNode.requestFocus();
                            if (value!.isEmpty) {
                              return 'Password is required';
                            } else if (value.length < 6) {
                              return 'dk';
                              // Password Cannot be less than 6 characters
                            }
                            return null;
                          },
                          onTap: () {
                            controller.isObscureNewPassword.value =
                                !controller.isObscureNewPassword.value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Obx(
                () => controller.newPasswordMessage.value.isEmpty
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          textAlign: TextAlign.start,
                          controller.newPasswordMessage.value,
                          style: TextStyle(color: AppColors.redColor),
                        ),
                      ),
              ),
              SizedBox(
                height: Dimensions.h5,
              ),
              Padding(
                padding: EdgeInsets.all(Dimensions.r8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "CONFIRMPASSWORD".tr,
                      style: CustomTextStyle.textPTsansMedium.copyWith(
                          color: AppColors.appbarColor,
                          fontSize: Dimensions.h15,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: Dimensions.h11,
                    ),
                    Obx(
                      () => EdittextFieldwithvalidation(
                        // focusNode: controller.reEnterPASSWORDFocusNode,
                        controller: controller.confirmPassword,
                        hintText: "ENTERCONFIRMPASSWORD".tr,
                        obscureText: controller.isObscureConfirmPassword.value,
                        onChanged: (value) {
                          controller.onChanged3(value);

                          if (controller.newPassword.value.text.length ==
                              controller.confirmPassword.text.length) {
                            FocusScope.of(context).unfocus();
                          }
                        },
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return 'Password is required';
                        //   } else if (value.length < 6) {
                        //     return 'Password Cannot be less than 6 characters';
                        //   }
                        //   return null;
                        // },
                        onTap: () {
                          controller.isObscureConfirmPassword.value =
                              !controller.isObscureConfirmPassword.value;
                        },
                      ),
                    ),
                    Obx(() => controller.confirmPasswordMessage.value.isEmpty
                        ? Container()
                        : Container(
                            alignment: Alignment.centerLeft,
                            padding:
                                EdgeInsets.symmetric(vertical: Dimensions.r8),
                            child: Text(
                              controller.confirmPasswordMessage.value,
                              style: TextStyle(color: AppColors.redColor),
                            ),
                          )),
                    SizedBox(
                      height: Dimensions.h5,
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(Dimensions.r8),
                    //   child: Text(
                    //     "PASSWORDTEXT".tr,
                    //     style: CustomTextStyle.textPTsansMedium.copyWith(
                    //       color: AppColors.redColor,
                    //       fontSize: Dimensions.h10,
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
              SizedBox(
                height: Dimensions.h5,
              ),
              !controller.isValidate.value
                  ? Align(
                      alignment: Alignment.center,
                      child: ButtonWidget(
                        onTap: () {
                          controller.onTapConfirmPass();
                          // FocusScope.of(context).unfocus();
                        },
                        text: "SUBMIT",
                        buttonColor: AppColors.grey,
                        height: Dimensions.h30,
                        width: size.width / 1.2,
                        radius: Dimensions.h20,
                      ),
                    )
                  : Align(
                      alignment: Alignment.center,
                      child: ButtonWidget(
                        onTap: () {
                          controller.onTapConfirmPass();
                          // FocusScope.of(context).unfocus();
                        },
                        text: "SUBMIT",
                        buttonColor: AppColors.appbarColor,
                        height: Dimensions.h30,
                        width: size.width / 1.2,
                        radius: Dimensions.h20,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
