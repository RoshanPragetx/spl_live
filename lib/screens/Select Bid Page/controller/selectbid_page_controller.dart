import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/ui_utils.dart';

import '../../../Custom Controllers/wallet_controller.dart';
import '../../../api_services/api_service.dart';
import '../../../helper_files/app_colors.dart';
import '../../../helper_files/constant_variables.dart';
import '../../../helper_files/custom_text_style.dart';
import '../../../helper_files/dimentions.dart';
import '../../../models/commun_models/bid_request_model.dart';
import '../../../models/commun_models/user_details_model.dart';
import '../../../routes/app_routes_name.dart';
import '../../Local Storage.dart';

class SelectBidPageController extends GetxController {
  var arguments = Get.arguments;

  RxString totalAmount = "00".obs;
  var biddingType = "".obs;
  var gameName = "".obs;
  var marketName = "".obs;
  Rx<BidRequestModel> requestModel = BidRequestModel().obs;
  List<Bids> savedBidsList = <Bids>[];

  final walletController = Get.find<WalletController>();

  @override
  void onInit() {
    super.onInit();
    getArguments();
  }

  @override
  void onClose() {
    requestModel.value.bids?.clear();
  }

  Future<void> getArguments() async {
    biddingType.value = arguments["biddingType"];
    marketName.value = arguments["marketName"];
    totalAmount.value = arguments["totalAmount"];
    requestModel.value.bids = arguments["bidsList"];
    // checkBidsList();
    var data = await LocalStorage.read(ConstantsVariables.userData);
    UserDetailsModel userData = UserDetailsModel.fromJson(data);
    requestModel.value.userId = userData.id;
    requestModel.value.bidType = arguments["biddingType"];
    requestModel.value.dailyMarketId = arguments["marketId"];
    print("remodelDailyMarketId: ${requestModel.value.toJson()}");
    requestModel.refresh();
    gameName.value = arguments["gameName"];
    // await LocalStorage.write(ConstantsVariables.playMore, true);
    // var hh = await LocalStorage.read(ConstantsVariables.playMore);
    // print("playMore $hh");
  }

  void onDeleteBids(int index) {
    requestModel.value.bids!.remove(requestModel.value.bids![index]);
    requestModel.refresh();
    LocalStorage.write(ConstantsVariables.bidsList,
        requestModel.value.bids!.map((v) => v.toJson()).toList());
    _calculateTotalAmount();
    if (requestModel.value.bids!.isEmpty) {
      Get.back();
      Get.back();
    }
  }

  void _calculateTotalAmount() {
    int tempTotal = 0;
    for (var element in requestModel.value.bids ?? []) {
      tempTotal += int.parse(element.coins.toString());
    }
    totalAmount.value = tempTotal.toString();
  }

  void createMarketBidApi() async {
    ApiService().createMarketBid(requestModel.value.toJson()).then(
      (value) async {
        debugPrint("create bid api response :- $value");
        if (value['status']) {
          Get.back();
          Get.back();
          if (value['data'] == false) {
            Get.back();
            AppUtils.showErrorSnackBar(
              bodyText: value['message'] ?? "",
            );
          } else {
            AppUtils.showSuccessSnackBar(
                bodyText: value['message'] ?? "",
                headerText: "SUCCESSMESSAGE".tr);
          }
          LocalStorage.remove(ConstantsVariables.bidsList);
          LocalStorage.remove(ConstantsVariables.marketName);
          LocalStorage.remove(ConstantsVariables.biddingType);
        } else {
          AppUtils.showErrorSnackBar(
            bodyText: value['message'] ?? "",
          );
        }
        walletController.getUserBalance();
      },
    );
  }

  void playMore() async {
    Get.toNamed(AppRoutName.gameModePage);
  }

  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm!'),
          content: Text(
            'Do you really wish to submit?',
            style: CustomTextStyle.textRobotoSansLight.copyWith(
              color: AppColors.grey,
              fontSize: Dimensions.h14,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Handle cancel button press
                Get.back();
              },
              child: Text(
                'CANCLE',
                style: CustomTextStyle.textPTsansBold.copyWith(
                  color: AppColors.appbarColor,
                  fontSize: Dimensions.h13,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                createMarketBidApi();
                requestModel.value.bids!.clear();
                _calculateTotalAmount();
              },
              child: Text(
                'OKAY',
                style: CustomTextStyle.textPTsansBold.copyWith(
                  color: AppColors.appbarColor,
                  fontSize: Dimensions.h13,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
