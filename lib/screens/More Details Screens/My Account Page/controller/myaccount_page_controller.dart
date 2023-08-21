import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/ui_utils.dart';

import '../../../../api_services/api_service.dart';
import '../../../../helper_files/constant_variables.dart';
import '../../../../models/bank_details_model.dart';
import '../../../../models/commun_models/user_details_model.dart';
import '../../../Local Storage.dart';

class MyAccountPageController extends GetxController {
  var bankNameController = TextEditingController();
  var accHolderNameController = TextEditingController();
  var accNoController = TextEditingController();
  var ifscCodeController = TextEditingController();
  UserDetailsModel userDetailsModel = UserDetailsModel();
  RxBool isEditDetails = false.obs;
  RxString accountName = "".obs;
  RxString bankName = "".obs;
  RxString accountNumber = "".obs;
  RxString ifcsCode = "".obs;
  var userId = "";
  int bankId = 0;

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

  void onTapOfEditDetails() async {
    if (isEditDetails.value) {
      callEditBankDetailsApi();
    } else {
      AppUtils.showErrorSnackBar(
        bodyText: "CONTACTADMINTOEDITDETAILS".tr,
      );
    }
  }

  void callGetBankDetails(String userId) async {
    ApiService().getBankDetails(userId).then((value) async {
      if (value['status']) {
        BankDetailsResponseModel model =
            BankDetailsResponseModel.fromJson(value);
        if (model.message!.isNotEmpty) {
          AppUtils.showSuccessSnackBar(
              bodyText: model.message, headerText: "SUCCESSMESSAGE".tr);
        }

        isEditDetails.value = model.data!.isEditPermission ?? false;
        accountName.value = model.data!.accountHolderName ?? "";
        bankName.value = model.data!.bankName ?? "";
        accountNumber.value = model.data!.accountNumber ?? "";
        ifcsCode.value = model.data!.iFSCCode ?? "";
        bankNameController.text = model.data!.bankName ?? "Null From API";
        accHolderNameController.text =
            model.data!.accountHolderName ?? "Null From API";
        accNoController.text = model.data!.accountNumber ?? "Null From API";
        ifscCodeController.text = model.data!.iFSCCode ?? "Null From API";
        // gPayNumberController.text = model.data!.gpayNumber ?? "Null From API";
        // paytmNumberController.text = model.data!.paytmNumber ?? "Null From API";
        // bhimUpiController.text = model.data!.bhimUPI ?? "Null From API";
        bankId = model.data!.id ?? 0;
      } else {
        isEditDetails.value = true;
        AppUtils.showErrorSnackBar(
          bodyText: value['message'] ?? "",
        );
      }
    });
  }

  void callEditBankDetailsApi() async {
    ApiService()
        .editBankDetails(await ediBankDetailsBody())
        .then((value) async {
      debugPrint("Edi bank details Api Response :- $value");
      if (value['status']) {
        BankDetailsResponseModel model =
            BankDetailsResponseModel.fromJson(value);
        isEditDetails.value = false;
        bankNameController.text = model.data!.bankName ?? "Null From API";
        accHolderNameController.text =
            model.data!.accountHolderName ?? "Null From API";
        accNoController.text = model.data!.accountNumber ?? "Null From API";
        ifscCodeController.text = model.data!.iFSCCode ?? "Null From API";
        bankId = model.data!.id ?? 0;

        AppUtils.showSuccessSnackBar(
            bodyText: value['message'] ?? "", headerText: "SUCCESSMESSAGE".tr);
      } else {
        isEditDetails.value = true;
        AppUtils.showErrorSnackBar(
          bodyText: value['message'] ?? "",
        );
      }
    });
  }

  Future<Map> ediBankDetailsBody() async {
    var ediBankDetailsBody = {
      "id": bankId,
      "userId": int.parse(userId),
      "bankName": bankNameController.text,
      "accountHolderName": accHolderNameController.text,
      "accountNumber": accNoController.text,
      "IFSCCode": ifscCodeController.text,
      // "gpayNumber": gPayNumberController.text,
      // "paytmNumber": paytmNumberController.text,
      // "bhimUPI": bhimUpiController.text,
    };

    ediBankDetailsBody.addIf(bankId != 0, "id", bankId);

    debugPrint(ediBankDetailsBody.toString());
    print(ediBankDetailsBody);
    return ediBankDetailsBody;
  }
}
