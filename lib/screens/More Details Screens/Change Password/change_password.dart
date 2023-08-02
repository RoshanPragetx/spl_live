// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spllive/components/button_widget.dart';
import 'package:spllive/helper_files/ui_utils.dart';

import '../../../helper_files/app_colors.dart';
import '../../../helper_files/custom_text_style.dart';
import '../../../helper_files/dimentions.dart';
import 'controller/change_password_controller.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({Key, key}) : super(key: key);

  var controller = Get.put(ChangepasswordPageController());

  // ignore: unused_field
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppUtils().simpleAppbar(appBarTitle: "Change Password"),
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
                        "ENTERPASSWORD".tr,
                        style: CustomTextStyle.textPTsansMedium.copyWith(
                          color: AppColors.appbarColor,
                          fontSize: Dimensions.h15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.h11,
                      ),
                      Obx(
                        () => TextFormField(
                          controller: controller.newPassword,
                          onChanged: (value) {
                            if (value.isEmpty) {
                              controller.newPasswordMessage.value = "";
                              controller.newPasswordMessage2.value = "";
                              controller.isValidate.value = false;
                            } else if (value[0] != value[0].toUpperCase()) {
                              controller.newPasswordMessage2.value =
                                  "First letter should be capital";
                              controller.isValidate.value = false;
                              if (value.length < 6) {
                                controller.newPasswordMessage.value =
                                    "Password cannot be less than 6 characters";
                              } else {
                                controller.newPasswordMessage.value = "";
                              }
                            } else if (value.length < 6) {
                              controller.newPasswordMessage.value =
                                  "Password cannot be less than 6 characters";
                              controller.isValidate.value = false;
                            } else if (value == controller.confirmPassword) {
                              controller.newPasswordMessage.value = "";
                              controller.isValidate.value = true;
                            } else {
                              controller.newPasswordMessage.value = "";
                              controller.isValidate.value = false;
                            }
                          },
                          obscureText: controller.isObscureNewPassword.value,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is required';
                            }
                            if (value.length < 6) {
                              return 'Password Cannot be less than 6 characters';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            counterText: "",
                            fillColor: AppColors.grey.withOpacity(0.2),
                            filled: true,
                            border: InputBorder.none,
                            hintText: "NEWPASSWORD".tr,
                            hintStyle:
                                CustomTextStyle.textPTsansMedium.copyWith(
                              color: AppColors.appbarColor.withOpacity(0.5),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                controller.isObscureNewPassword.value =
                                    !controller.isObscureNewPassword.value;
                              },
                              child: controller.isObscureNewPassword.value
                                  ? Icon(Icons.remove_red_eye,
                                      color: AppColors.appbarColor)
                                  : Icon(Icons.visibility_off,
                                      color: AppColors.grey),
                            ),
                          ),
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
              Obx(() => controller.newPasswordMessage2.value.isEmpty
                  ? SizedBox()
                  : Text(
                      controller.newPasswordMessage2.value,
                      style: TextStyle(color: AppColors.redColor),
                    )),
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
                    Obx(() => TextFormField(
                          onChanged: (value) {
                            if (value[0] == value[0].toUpperCase() &&
                                (value.length >= 6 &&
                                    value == controller.newPassword.text)) {
                              controller.isValidate.value = true;
                              controller.confirmPasswordMessage.value = "";
                            } else if (value.isEmpty) {
                              controller.confirmPasswordMessage.value = "";
                              controller.isValidate.value = false;
                            } else {
                              controller.isValidate.value = false;
                              controller.confirmPasswordMessage.value =
                                  "Password does not match";
                            }
                          },
                          obscureText:
                              controller.isObscureConfirmPassword.value,
                          controller: controller.confirmPassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            errorStyle:
                                CustomTextStyle.textPTsansMedium.copyWith(),
                            border: InputBorder.none,
                            counterText: "",
                            fillColor: AppColors.grey.withOpacity(0.2),
                            filled: true,
                            hintText: "ENTERCONFIRMPASSWORD".tr,
                            hintStyle:
                                CustomTextStyle.textPTsansMedium.copyWith(
                              color: AppColors.appbarColor.withOpacity(0.5),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                controller.isObscureConfirmPassword.value =
                                    !controller.isObscureConfirmPassword.value;
                              },
                              child: controller.isObscureConfirmPassword.value
                                  ? Icon(Icons.remove_red_eye,
                                      color: AppColors.appbarColor)
                                  : Icon(Icons.visibility_off,
                                      color: AppColors.grey),
                            ),
                          ),
                        )),
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
                    Padding(
                      padding: EdgeInsets.all(Dimensions.r8),
                      child: Text(
                        "PASSWORDTEXT".tr,
                        style: CustomTextStyle.textPTsansMedium.copyWith(
                          color: AppColors.redColor,
                          fontSize: Dimensions.h10,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: Dimensions.h5,
              ),
              Obx(
                () => controller.isValidate.value
                    ? Align(
                        alignment: Alignment.center,
                        child: ButtonWidget(
                          onTap: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            controller.changePasswordApi();
                          },
                          text: "SUBMIT",
                          buttonColor: AppColors.appbarColor,
                          height: Dimensions.h30,
                          width: size.width / 1.2,
                          radius: Dimensions.h20,
                        ),
                      )
                    : Align(
                        alignment: Alignment.center,
                        child: ButtonWidget(
                          onTap: () {},
                          text: "SUBMIT",
                          buttonColor: AppColors.grey,
                          height: Dimensions.h30,
                          width: size.width / 1.2,
                          radius: Dimensions.h20,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
