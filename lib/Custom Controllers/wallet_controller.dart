import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/ui_utils.dart';
import '../api_services/api_service.dart';

class WalletController extends GetxController {
  RxString walletBalance = "00".obs;

  @override
  void onInit() {
    getUserBalance();
    super.onInit();
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
