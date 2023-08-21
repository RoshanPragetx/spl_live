// ignore_for_file: unused_import, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_storage/get_storage.dart';

import '../../../components/button_widget.dart';
import '../../../components/edit_text_password.dart';
import '../../../helper_files/app_colors.dart';
import '../../../helper_files/custom_text_style.dart';
import '../../../helper_files/dimentions.dart';
import '../../../helper_files/ui_utils.dart';
import 'controller/change_mpin_controller.dart';

// ignore: must_be_immutable
class ChangeMpinPage extends StatelessWidget {
  ChangeMpinPage({super.key});

  var controller = Get.put(ChangeMpinPageController());

  // ignore: unused_field
  final _formKey = GlobalKey<FormState>();
  var vericalSpace = SizedBox(height: Dimensions.h11);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppUtils().simpleAppbar(appBarTitle: "Change Mobile Pin"),
      backgroundColor: AppColors.white,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w15),
          child: Column(
            children: [
              // Padding(padding: EdgeInsets.all(Dimensions.h5)),
              vericalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ENTEROLDPINTEXT".tr,
                    style: CustomTextStyle.textPTsansMedium.copyWith(
                      color: AppColors.appbarColor,
                      fontSize: Dimensions.h15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  vericalSpace,
                  Obx(
                    () => EdittextFieldwithvalidation(
                      controller: controller.oldMPIN,
                      autofocus: true,
                      focusNode: controller.oldMPINFocusNode,
                      hintText: "OLDPINTEXT".tr,
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      obscureText: controller.isObscureOldPin.value,
                      onChanged: (value) {
                        controller.onChanged1(value);
                        if (value.length == 4) {
                          controller.oldMPINFocusNode.unfocus();
                          controller.newMPINFocusNode.requestFocus();
                        }
                      },
                      onTap: () {
                        controller.isObscureOldPin.value =
                            !controller.isObscureOldPin.value;
                      },
                    ),
                  ),
                ],
              ),
              Obx(
                () => controller.oldPinMessage.value.isEmpty
                    ? Container()
                    : Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          controller.oldPinMessage.value,
                          style: TextStyle(color: AppColors.redColor),
                        ),
                      ),
              ),
              vericalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ENTERNEWPINTEXT".tr,
                    style: CustomTextStyle.textPTsansMedium.copyWith(
                      color: AppColors.appbarColor,
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.h15,
                    ),
                  ),
                  vericalSpace,
                  Obx(
                    () => EdittextFieldwithvalidation(
                      focusNode: controller.newMPINFocusNode,
                      controller: controller.newMPIN,
                      hintText: "NEWPINTEXT".tr,
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      obscureText: controller.isObscureNewPin.value,
                      onChanged: (value) {
                        controller.onChanged2(value);
                        if (value.length == 4) {
                          controller.newMPINFocusNode.unfocus();
                          controller.reEnterMPINFocusNode.requestFocus();
                        }
                      },
                      onTap: () {
                        controller.isObscureNewPin.value =
                            !controller.isObscureNewPin.value;
                      },
                    ),
                  ),
                ],
              ),

              Obx(
                () => controller.newPinMessage.value.isEmpty
                    ? Container()
                    : Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          controller.newPinMessage.value,
                          style: TextStyle(color: AppColors.redColor),
                        ),
                      ),
              ),
              vericalSpace,
              Container(
                decoration: BoxDecoration(color: AppColors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ENTERCONFIRMPINTEXT".tr,
                      style: CustomTextStyle.textPTsansMedium.copyWith(
                        color: AppColors.appbarColor,
                        fontSize: Dimensions.h15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    vericalSpace,
                    Obx(
                      () => EdittextFieldwithvalidation(
                        focusNode: controller.reEnterMPINFocusNode,
                        controller: controller.reEnterMPIN,
                        hintText: "NEWPINTEXT".tr,
                        maxLength: 4,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        obscureText: controller.isObscureConfirmPin.value,
                        onChanged: (value) {
                          controller.onChanged3(value);
                        },
                        onTap: () {
                          controller.isObscureConfirmPin.value =
                              !controller.isObscureConfirmPin.value;
                        },
                      ),
                    ),
                    Obx(
                      () => controller.confirmPinMessage.value.isEmpty
                          ? Container()
                          : Container(
                              alignment: Alignment.centerLeft,
                              padding:
                                  EdgeInsets.symmetric(vertical: Dimensions.r8),
                              child: Text(
                                controller.confirmPinMessage.value,
                                style: TextStyle(color: AppColors.redColor),
                              ),
                            ),
                    ),
                    // SizedBox(
                    //   height: Dimensions.h20,
                    // ),
                    // Text(
                    //   "DIGITTEXT".tr,
                    //   style: CustomTextStyle.textPTsansMedium.copyWith(
                    //     color: AppColors.redColor,
                    //   ),
                    // )
                  ],
                ),
              ),
              SizedBox(
                height: Dimensions.h20,
              ),
              Obx(
                () => controller.isValidate.value == true
                    ? ButtonWidget(
                        onTap: () {
                          controller.changePasswordApi();
                        },
                        text: "SUBMIT".tr,
                        buttonColor: AppColors.appbarColor,
                        height: Dimensions.h30,
                        width: size.width / 1.2,
                        radius: Dimensions.h20,
                      )
                    : ButtonWidget(
                        onTap: () {},
                        text: "SUBMIT".tr,
                        buttonColor: AppColors.grey,
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
