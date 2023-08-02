import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/ui_utils.dart';
import 'package:spllive/models/starline_chart_model.dart';
import 'package:spllive/routes/app_routes_name.dart';
import '../../../api_services/api_service.dart';
import '../../../helper_files/constant_variables.dart';
import '../../../models/commun_models/user_details_model.dart';
import '../../../routes/app_routes.dart';
import '../../Local Storage.dart';
import '../model/user_details_model.dart';

class SetMPINPageController extends GetxController {
  var arguments = Get.arguments;
  RxString mpin = "".obs;
  RxString confirmMpin = "".obs;
  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  UserDetails userDetails = UserDetails();
  UserDetailsModel userData = UserDetailsModel();
  Timer? cursorTimer;
  bool _fromLoginPage = false;

  @override
  void onInit() {
    getArguments();
    //getUserData();
    super.onInit();
  }

  @override
  void dispose() {
    focusNode1.dispose();
    focusNode2.dispose();
    super.dispose();
  }

  // Future<void> getUserData() async {
  //   var data = await LocalStorage.read(ConstantsVariables.userData);
  //   userData = UserDetailsModel.fromJson(data);
  //   // getMarketBidsByUserId(lazyLoad: false);
  //   print("userDetails :---$data");
  // }

  void getArguments() {
    print("000000000000000000000$arguments");
    if (arguments != null) {
      userDetails = arguments;
      print("userDetails when condition false : $userDetails");
      _fromLoginPage = false;
    } else {
      _fromLoginPage = true;
      print("userDetails when condition true : $userDetails");
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
      print("fromloginpage $_fromLoginPage");
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
        print("userData&&&&&&&&&&&&&&&&&&&&&&&& : $userData");
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
