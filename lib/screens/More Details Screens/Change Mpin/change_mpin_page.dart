// ignore_for_file: unused_import, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_storage/get_storage.dart';

import '../../../components/button_widget.dart';
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
  var vericalSpace = SizedBox(
    height: Dimensions.h11,
  );
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                      "ENTERNEWPINTEXT".tr,
                      style: CustomTextStyle.textPTsansMedium.copyWith(
                        color: AppColors.appbarColor,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.h15,
                      ),
                    ),
                    Obx(() => TextFormField(
                          onChanged: (value) {
                            controller.validateMpin(value);
                          },
                          obscureText: controller.isObscureNewPin.value,
                          controller: controller.newMPIN,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Pin is required';
                            }
                            return null;
                          },
                          maxLength: 4,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            filled: true,
                            counterText: "",
                            border: InputBorder.none,
                            hintText: "NEWPINTEXT".tr,
                            hintStyle:
                                CustomTextStyle.textPTsansMedium.copyWith(
                              color: AppColors.appbarColor.withOpacity(0.5),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                controller.isObscureNewPin.value =
                                    !controller.isObscureNewPin.value;
                              },
                              child: controller.isObscureNewPin.value
                                  ? Icon(Icons.remove_red_eye,
                                      color: AppColors.appbarColor)
                                  : Icon(Icons.visibility_off,
                                      color: AppColors.grey),
                            ),
                          ),
                        )),
                  ],
                ),
                controller.newMPIN.text.isEmpty
                    ? Container()
                    : Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          controller.newPinMessage.value,
                          style: TextStyle(color: AppColors.redColor),
                        ),
                      ),
                SizedBox(
                  height: Dimensions.h5,
                ),
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
                      Obx(() => TextFormField(
                            onChanged: (value) {
                              controller.validateMpin(value);
                            },
                            maxLength: 4,
                            obscureText: controller.isObscureConfirmPin.value,
                            controller: controller.reEnterMPIN,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Pin is required';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              filled: true,
                              counterText: "",
                              border: InputBorder.none,
                              hintText: "CONFIRMPINTEXT".tr,
                              hintStyle:
                                  CustomTextStyle.textPTsansMedium.copyWith(
                                color: AppColors.appbarColor.withOpacity(0.5),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  controller.isObscureConfirmPin.value =
                                      !controller.isObscureConfirmPin.value;
                                },
                                child: controller.isObscureConfirmPin.value
                                    ? Icon(Icons.remove_red_eye,
                                        color: AppColors.appbarColor)
                                    : Icon(Icons.visibility_off,
                                        color: AppColors.grey),
                              ),
                            ),
                          )),
                      controller.reEnterMPIN.text.isEmpty
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
                      SizedBox(
                        height: Dimensions.h20,
                      ),
                      Text(
                        "DIGITTEXT".tr,
                        style: CustomTextStyle.textPTsansMedium.copyWith(
                          color: AppColors.redColor,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimensions.h20,
                ),
                controller.newMPIN.text == controller.reEnterMPIN.text ||
                        controller.reEnterMPIN.text == null
                    ? ButtonWidget(
                        onTap: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
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
              ],
            ),
          ),
        ));
  }
}
