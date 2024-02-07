import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../api_services/api_service.dart';
import '../../../../helper_files/constant_variables.dart';
import '../../../../helper_files/ui_utils.dart';
import '../../../../models/bank_details_model.dart';
import '../../../../models/commun_models/response_model.dart';
import '../../../../models/commun_models/user_details_model.dart';
import '../../../../routes/app_routes_name.dart';
import '../../../Local Storage.dart';

class CreateWithDrawalPageController extends GetxController {
  TextEditingController amountTextController = TextEditingController();
  UserDetailsModel userDetailsModel = UserDetailsModel();

  RxString accountName = "".obs;
  RxString bankName = "".obs;
  RxString accountNumber = "".obs;
  RxString ifcsCode = "".obs;
  var userId = "";

  final _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  @override
  void onInit() {
    fetchStoredUserDetailsAndGetBankDetailsByUserId();
    super.onInit();
  }

  Future<void> fetchStoredUserDetailsAndGetBankDetailsByUserId() async {
    var data = await LocalStorage.read(ConstantsVariables.userData);
    UserDetailsModel userData = UserDetailsModel.fromJson(data);

    userId = userData.id == null ? "" : userData.id.toString();

    if (userId.isNotEmpty) {
      callGetBankDetails(userId);
    } else {
      AppUtils.showErrorSnackBar(
        bodyText: "SOMETHINGWENTWRONG".tr,
      );
    }
  }

  void callGetBankDetails(String userId) async {
    ApiService().getBankDetails({"id": userId}).then((value) async {
      if (value['status']) {
        BankDetailsResponseModel model = BankDetailsResponseModel.fromJson(value);
        // if (model.message!.isNotEmpty) {
        //   AppUtils.showSuccessSnackBar(
        //       bodyText: model.message, headerText: "SUCCESSMESSAGE".tr);
        // }
        accountName.value = model.data!.accountHolderName ?? "";
        bankName.value = model.data!.bankName ?? "";
        accountNumber.value = model.data!.accountNumber ?? "";
        ifcsCode.value = model.data!.iFSCCode ?? "";
      } else {
        // AppUtils.showErrorSnackBar(
        //   bodyText: value['message'] ?? "",
        // );
      }
    });
  }

  String getRandomString(int length) => String.fromCharCodes(
        Iterable.generate(
          length,
          (_) => _chars.codeUnitAt(
            _rnd.nextInt(_chars.length),
          ),
        ),
      );

  void createWithdrawalRequest() async {
    ApiService().createWithdrawalRequest(await createWithdrawalRequestBody()).then((value) async {
      if (value['status']) {
        ResponseModel model = ResponseModel.fromJson(value);
        amountTextController.clear();
        Get.offAndToNamed(AppRoutName.withdrawalpage);
        if (model.message!.isNotEmpty) {
          AppUtils.showSuccessSnackBar(bodyText: model.message, headerText: "SUCCESSMESSAGE".tr);
        }
      } else {
        AppUtils.showErrorSnackBar(
          bodyText: value['message'] ?? "",
        );
      }
    });
  }

  Future<Map> createWithdrawalRequestBody() async {
    var createWithdrawalRequestBody = {
      "userId": userId,
      "requestId": getRandomString(10),
      "amount": amountTextController.text
    };

    return createWithdrawalRequestBody;
  }
}
