import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/ui_utils.dart';
import 'package:spllive/routes/app_routes_name.dart';

import '../../Set MPIN Page/model/user_details_model.dart';

class UserDetailsPageController extends GetxController {
  var fullNameController = TextEditingController();
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  // var fullNameFocusNode = FocusNode();
  // var userNameFocusNode = FocusNode();
  // var passwordFocusNode = FocusNode();
  // var confirmPasswordFocusNode = FocusNode();

  RxBool pVisibility = false.obs;
  RxBool cpVisibility = false.obs;

  void onTapOfVisibilityIcon(RxBool visibility) {
    visibility.value = !visibility.value;
  }

  void onTapOfRegister() {
    if (fullNameController.text.isEmpty) {
      AppUtils.showErrorSnackBar(
        bodyText: "ENTERFULLNAME".tr,
      );
    } else if (userNameController.text.isEmpty) {
      AppUtils.showErrorSnackBar(
        bodyText: "ENTERUSERNAME".tr,
      );
    } else if (passwordController.text.isEmpty) {
      AppUtils.showErrorSnackBar(
        bodyText: "ENTERPASSWORD".tr,
      );
    } else if (passwordController.text.toString().length < 6) {
      AppUtils.showErrorSnackBar(
        bodyText: "ENTERVALIDPASSWORD".tr,
      );
    } else if (confirmPasswordController.text.isEmpty) {
      AppUtils.showErrorSnackBar(
        bodyText: "ENTERCONFIRMPASSWORD".tr,
      );
    } else if (confirmPasswordController.text.toString().length < 6) {
      AppUtils.showErrorSnackBar(
        bodyText: "ENTERVALIDCONFIRMPASSWORD".tr,
      );
    } else if (passwordController.text != confirmPasswordController.text) {
      AppUtils.showErrorSnackBar(
        bodyText: "PASSWORDDOESNTMATCHED".tr,
      );
    } else {
      var userDetails = UserDetails(
        fullName: fullNameController.text,
        userName: userNameController.text,
        password: passwordController.text,
      );
      Get.toNamed(AppRoutName.setMPINPage, arguments: userDetails);
    }
  }
}
