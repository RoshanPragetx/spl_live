import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/ui_utils.dart';
import 'package:spllive/routes/app_routes_name.dart';

import '../../../api_services/api_service.dart';
import '../../../helper_files/constant_variables.dart';
import '../../../models/commun_models/user_details_model.dart';
import '../../Local Storage.dart';
import '../../Set MPIN Page/model/user_details_model.dart';

class VerifyOTPController extends GetxController {
  var argument = Get.arguments;
  bool verifyOTP = false;
  RxString otp = "".obs;
  RxString mpin = "".obs;
  RxString confirmMpin = "".obs;
  String phoneNumber = "";

  @override
  void onInit() {
    super.onInit();
    getStoredUserData();
    _startTimer();
  }

  var userData;
  Future<void> getStoredUserData() async {
    print(verifyOTP);
    if (argument != null) {
      phoneNumber = argument['phoneNumber'];
      // countryCode = argument['countryCode'];
      verifyOTP = false;
    } else {
      // var data = await LocalStorage.read(ConstantsVariables.userData);
      // userData = UserDetailsModel.fromJson(data);
      verifyOTP = true;
    }
  }

  void onTapOfContinue() {
    print(verifyOTP);
    if (otp.isEmpty) {
      AppUtils.showErrorSnackBar(
        bodyText: "ENTEROTP".tr,
      );
    } else if (otp.value.length < 6) {
      AppUtils.showErrorSnackBar(
        bodyText: "ENTERVALIDOTP".tr,
      );
    } else {
      verifyOTP ? callVerifyOTPApi() : callVerifyUserApi();
    }
  }

  void callVerifyUserApi() async {
    ApiService().verifyUser(await verifyUserBody()).then((value) async {
      debugPrint("Verify OTP Api Response :- $value");
      if (value['status']) {
        AppUtils.showSuccessSnackBar(
            bodyText: value['message'] ?? "", headerText: "SUCCESSMESSAGE".tr);
        var userData = value['data'];
        if (userData != null) {
          String authToken = userData['Token'] ?? "Null From API";
          bool isActive = userData['IsActive'] ?? false;
          bool isVerified = userData['IsVerified'] ?? false;
          await LocalStorage.write(ConstantsVariables.authToken, authToken);
          await LocalStorage.write(ConstantsVariables.isActive, isActive);
          await LocalStorage.write(ConstantsVariables.isVerified, isVerified);
          Get.toNamed(AppRoutName.userDetailsPage);
        } else {
          AppUtils.showErrorSnackBar(bodyText: "Something went wrong!!!");
        }
      } else {
        AppUtils.showErrorSnackBar(
          bodyText: value['message'] ?? "",
        );
      }
    });
  }

  Future<Map> verifyUserBody() async {
    final verifyUserBody = {
      "countryCode": "+91",
      "phoneNumber": phoneNumber,
      "otp": otp.value,
    };
    debugPrint("==============================${verifyUserBody.toString()}");
    return verifyUserBody;
  }

  void callVerifyOTPApi() async {
    ApiService().verifyOTP(await verifyOTPBody()).then((value) async {
      debugPrint("Verify OTP Api Response :- $value");
      if (value['status']) {
        AppUtils.showSuccessSnackBar(
            bodyText: value['message'] ?? "", headerText: "SUCCESSMESSAGE".tr);
        var userData = value['data'];
        String authToken = userData['Token'] ?? "Null From API";
        await LocalStorage.write(ConstantsVariables.authToken, authToken);
        if (userData != null) {
          Get.toNamed(
            AppRoutName.setMPINPage,
          );
        } else {
          AppUtils.showErrorSnackBar(bodyText: "Something went wrong!!!");
        }
      } else {
        AppUtils.showErrorSnackBar(
          bodyText: value['message'] ?? "",
        );
      }
    });
  }

  Future<Map> verifyOTPBody() async {
    final verifyOTPBody = {
      "otp": otp.value,
    };
    debugPrint(verifyOTPBody.toString());
    return verifyOTPBody;
  }

  void callResendOtpApi() async {
    ApiService().resendOTP(await resendOtpBody()).then((value) async {
      debugPrint("Resend otp Api Response :- $value");
      if (value['status']) {
        AppUtils.showSuccessSnackBar(
            bodyText: "${value['message']}", headerText: "SUCCESSMESSAGE".tr);
      } else {
        AppUtils.showErrorSnackBar(
          bodyText: value['message'] ?? "",
        );
      }
    });
  }

  Future<Map> resendOtpBody() async {
    final resendOtpBody = {
      "phoneNumber": phoneNumber,
      "countryCode": "+91",
    };
    return resendOtpBody;
  }

  var secondsRemaining = 60.obs;
  late Timer _timer;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        _timer.cancel(); // Stop the timer when it reaches 0
      }
    });
  }

  String get formattedTime {
    int minutes = (secondsRemaining.value ~/ 60);
    int seconds = (secondsRemaining.value % 60);
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void onClose() {
    _timer.cancel(); // Cancel the timer when the controller is closed
    super.onClose();
  }
}
