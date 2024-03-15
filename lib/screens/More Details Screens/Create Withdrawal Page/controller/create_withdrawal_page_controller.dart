import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:spllive/Custom%20Controllers/wallet_controller.dart';
import 'package:spllive/helper_files/app_colors.dart';
import 'package:spllive/helper_files/constant_image.dart';
import 'package:spllive/helper_files/custom_text_style.dart';
import 'package:spllive/helper_files/dimentions.dart';

import '../../../../api_services/api_service.dart';
import '../../../../helper_files/constant_variables.dart';
import '../../../../helper_files/ui_utils.dart';
import '../../../../models/bank_details_model.dart';
import '../../../../models/commun_models/response_model.dart';
import '../../../../models/commun_models/user_details_model.dart';

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
  final walletCon = Get.put<WalletController>(WalletController());
  Future<void> fetchStoredUserDetailsAndGetBankDetailsByUserId() async {
    final data = GetStorage().read(ConstantsVariables.userData);
    UserDetailsModel userData = UserDetailsModel.fromJson(data);

    userId = userData.id == null ? "" : userData.id.toString();

    if (userId.isNotEmpty) {
      callGetBankDetails(userId);
    } else {
      AppUtils.showErrorSnackBar(bodyText: "SOMETHINGWENTWRONG".tr);
    }
  }

  void callGetBankDetails(String userId) async {
    ApiService().getBankDetails({"id": userId}).then((value) async {
      BankDetailsResponseModel model = BankDetailsResponseModel.fromJson(value);
      if (value['status']) {
        BankDetailsResponseModel model = BankDetailsResponseModel.fromJson(value);
        accountName.value = model.data!.accountHolderName ?? "";
        bankName.value = model.data!.bankName ?? "";
        accountNumber.value = model.data!.accountNumber ?? "";
        ifcsCode.value = model.data!.iFSCCode ?? "";
      } else {
        if (value['message'].toString().toLowerCase() == "no bank detail found") {
          return Get.dialog(
            barrierDismissible: false,
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: Get.width, minWidth: Get.width - 30),
              child: AlertDialog(
                insetPadding: EdgeInsets.zero,
                contentPadding: const EdgeInsets.symmetric(horizontal: 55, vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                content: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(ConstantImage.close, height: Dimensions.h60, width: Dimensions.w60),
                      const SizedBox(height: 20),
                      Text(
                        "Please Add Bank Details",
                        style: CustomTextStyle.textRobotoSansMedium.copyWith(
                          color: AppColors.appbarColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          Get.back();
                          Get.back();
                          walletCon.selectedIndex.value = 2;
                        },
                        child: Container(
                          decoration:
                              BoxDecoration(color: AppColors.appbarColor, borderRadius: BorderRadius.circular(8)),
                          height: Dimensions.h40,
                          width: Dimensions.w150,
                          child: Center(
                            child: Text(
                              'OK',
                              style: CustomTextStyle.textRobotoSansBold.copyWith(color: AppColors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
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
        if (model.message!.isNotEmpty) {
          if (model.message == "Withdrawal request created successfully") {
            return Get.dialog(
              barrierDismissible: false,
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: Get.width, minWidth: Get.width - 30),
                child: AlertDialog(
                  insetPadding: EdgeInsets.all(10),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 55, vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  content: SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check, size: Dimensions.h60, color: AppColors.green),
                        const SizedBox(height: 20),
                        Text(
                          model.message ?? "",
                          textAlign: TextAlign.center,
                          style: CustomTextStyle.textRobotoSansMedium.copyWith(
                            color: AppColors.appbarColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () => Get.back(),
                          child: Container(
                            decoration:
                                BoxDecoration(color: AppColors.appbarColor, borderRadius: BorderRadius.circular(8)),
                            height: Dimensions.h40,
                            width: Dimensions.w150,
                            child: Center(
                              child: Text(
                                'OK',
                                style:
                                    CustomTextStyle.textRobotoSansBold.copyWith(color: AppColors.white, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Get.dialog(
              barrierDismissible: false,
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: Get.width, minWidth: Get.width - 30),
                child: AlertDialog(
                  insetPadding: EdgeInsets.all(10),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 55, vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  content: SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(ConstantImage.close, height: Dimensions.h60, width: Dimensions.w60),
                        const SizedBox(height: 20),
                        Text(
                          model.message ?? "",
                          textAlign: TextAlign.center,
                          style: CustomTextStyle.textRobotoSansMedium.copyWith(
                            color: AppColors.appbarColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () => Get.back(),
                          child: Container(
                            decoration:
                                BoxDecoration(color: AppColors.appbarColor, borderRadius: BorderRadius.circular(8)),
                            height: Dimensions.h40,
                            width: Dimensions.w150,
                            child: Center(
                              child: Text(
                                'OK',
                                style:
                                    CustomTextStyle.textRobotoSansBold.copyWith(color: AppColors.white, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          // AppUtils.showSuccessSnackBar(bodyText: model.message, headerText: "SUCCESSMESSAGE".tr);
        }
      } else {
        AppUtils.showErrorSnackBar(bodyText: value['message'] ?? "");
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
