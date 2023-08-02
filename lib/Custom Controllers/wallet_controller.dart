import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/ui_utils.dart';
import '../api_services/api_service.dart';
import '../helper_files/constant_variables.dart';
import '../screens/Local Storage.dart';

class WalletController extends GetxController {
  RxString walletBalance = "00".obs;

  @override
  void onInit() {
    getUserBalance();
    super.onInit();
  }

  @override
  void onClose() async {
    // await LocalStorage.write(ConstantsVariables.withDrawal, false);
    super.onClose();
  }

  void getUserBalance() {
    ApiService().getBalance().then((value) async {
      debugPrint("Forgot MPIN Api Response :- $value");
      if (value['status']) {
        var tempBalance = value['data']['Amount'] ?? 00;
        walletBalance.value = tempBalance.toString();
      } else {
        AppUtils.showErrorSnackBar(
          bodyText: value['message'] ?? "",
        );
      }
    });
  }
}
