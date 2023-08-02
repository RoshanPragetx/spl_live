// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/ui_utils.dart';
import 'package:spllive/routes/app_routes_name.dart';
import '../../../api_services/api_service.dart';
import '../../../helper_files/constant_variables.dart';
import '../../../routes/app_routes.dart';
import '../../Local Storage.dart';
import '../model/user_details_model.dart';

class SetMPINPageController extends GetxController {
  var arguments = Get.arguments;
  RxString mpin = "".obs;
  RxString confirmMpin = "".obs;
  UserDetails userDetails = UserDetails();
  bool _fromLoginPage = false;

  @override
  void onInit() {
    getArguments();
    super.onInit();
  }

  void getArguments() {
    if (arguments != null) {
      userDetails = arguments;
      _fromLoginPage = false;
    } else {
      _fromLoginPage = true;
    }
  }

  void onTapOfContinue() {
    if (mpin.isEmpty) {
      AppUtils.showErrorSnackBar(
        bodyText: "ENTERMPIN".tr,
      );
    } else if (mpin.value.length < 4) {
      AppUtils.showErrorSnackBar(
        bodyText: "ENTERVALIDMPIN".tr,
      );
    } else if (confirmMpin.isEmpty) {
      AppUtils.showErrorSnackBar(
        bodyText: "ENTERCONFIRMMPIN".tr,
      );
    } else if (confirmMpin.value.length < 4) {
      AppUtils.showErrorSnackBar(
        bodyText: "ENTERVALIDCONFIRMMPIN".tr,
      );
    } else if (mpin.value != confirmMpin.value) {
      AppUtils.showErrorSnackBar(
        bodyText: "MPINDOWSNTMATCHED".tr,
      );
    } else {
      _fromLoginPage ? callSetMpinApi() : callSetUserDetailsApi();
    }
  }

  void callSetUserDetailsApi() async {
    ApiService().setUserDetails(await userDetailsBody()).then((value) async {
      debugPrint("Set User Details Api Response :- $value");
      if (value != null && value['status']) {
        AppUtils.showSuccessSnackBar(
          bodyText: "${value['message']}",
          headerText: "SUCCESSMESSAGE".tr,
        );
        var userData = value['data'];
        if (userData != null) {
          String authToken = userData['Token'] ?? "Null From API";
          bool isActive = userData['IsActive'] ?? false;
          bool isVerified = userData['IsVerified'] ?? false;
          // bool isMpinSet =  userData['IsMPinSet'] ?? false;
          await LocalStorage.write(ConstantsVariables.authToken, authToken);
          await LocalStorage.write(ConstantsVariables.isActive, isActive);
          await LocalStorage.write(ConstantsVariables.isVerified, isVerified);
          // await LocalStorage.write(ConstantsVariables.isMpinSet, isMpinSet);
          await LocalStorage.write(ConstantsVariables.userData, userData);
        } else {
          AppUtils.showErrorSnackBar(bodyText: "Something went wrong!!!");
        }
        Get.offAllNamed(AppRoutName.dashBoardPage);
      } else {
        AppUtils.showErrorSnackBar(
          bodyText: value['message'] ?? "",
        );
      }
    });
  }

  Future<Map> userDetailsBody() async {
    final userDetailsBody = {
      "userName": userDetails.userName,
      "fullName": userDetails.fullName,
      "password": userDetails.password,
      "mPin": mpin.value,
    };
    return userDetailsBody;
  }

  Future<void> callSetMpinApi() async {
    ApiService().setMPIN(await setMpinBody()).then((value) async {
      debugPrint("Set MPIN Api Response :- $value");
      if (value != null && value['status']) {
        // AppUtils.showSuccessSnackBar(
        //   bodyText: "${value['message']}",
        //   headerText: "SUCCESSMESSAGE".tr,
        // );
        var userData = value['data'];
        if (userData != null) {
          String authToken = userData['Token'] ?? "Null From API";
          bool isActive = userData['IsActive'] ?? false;
          bool isVerified = userData['IsVerified'] ?? false;
          // bool isMpinSet =  userData['IsMPinSet'] ?? false;
          await LocalStorage.write(ConstantsVariables.authToken, authToken);
          await LocalStorage.write(ConstantsVariables.isActive, isActive);
          await LocalStorage.write(ConstantsVariables.isVerified, isVerified);
          // await LocalStorage.write(ConstantsVariables.isMpinSet, isMpinSet);
          await LocalStorage.write(ConstantsVariables.userData, userData);
        } else {
          AppUtils.showErrorSnackBar(bodyText: "Something went wrong!!!");
        }
        Get.offAllNamed(AppRoutName.dashBoardPage);
      } else {
        AppUtils.showErrorSnackBar(
          bodyText: value['message'] ?? "",
        );
      }
    });
  }

  Future<Map> setMpinBody() async {
    final userDetailsBody = {
      "mPin": mpin.value,
    };
    return userDetailsBody;
  }
}
