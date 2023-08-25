import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spllive/helper_files/ui_utils.dart';
import 'package:spllive/routes/app_routes_name.dart';
import '../../../Custom Controllers/wallet_controller.dart';
import '../../../api_services/api_service.dart';
import '../../../helper_files/common_utils.dart';
import '../../../helper_files/constant_variables.dart';
import '../../../models/commun_models/bid_request_model.dart';
import '../../../models/commun_models/digit_list_model.dart';
import '../../../models/commun_models/user_details_model.dart';
import '../../../models/daily_market_api_response_model.dart';
import '../../../models/game_modes_api_response_model.dart';
import '../../Local Storage.dart';

class GameModePagesController extends GetxController {
  RxBool containerChange = false.obs;
  var arguments = Get.arguments;
  Rx<GameModesApiResponseModel> gameModeList = GameModesApiResponseModel().obs;
  var marketValue = MarketData().obs;
  var openBiddingOpen = true.obs;
  var openCloseValue = "OPENBID".tr.obs;
  var closeBiddingOpen = true.obs;
  RxBool isBulkMode = false.obs;
  var playmore;
  RxList<Bids> selectedBidsList = <Bids>[].obs;
  RxList<GameMode> gameModesList = <GameMode>[].obs;
  Rx<BidRequestModel> requestModel = BidRequestModel().obs;

  var digitRow = [
    DigitListModelOffline(value: "0", isSelected: false),
    DigitListModelOffline(value: "1", isSelected: false),
    DigitListModelOffline(value: "2", isSelected: false),
    DigitListModelOffline(value: "3", isSelected: false),
    DigitListModelOffline(value: "4", isSelected: false),
    DigitListModelOffline(value: "5", isSelected: false),
    DigitListModelOffline(value: "6", isSelected: false),
    DigitListModelOffline(value: "7", isSelected: false),
    DigitListModelOffline(value: "8", isSelected: false),
    DigitListModelOffline(value: "9", isSelected: false),
  ].obs;

  String removeTimeStampFromDateString(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(dateTime);
  }

  @override
  void onInit() {
    marketValue.value = arguments;
    checkBiddingStatus();
    callGetGameModes();
    getArguments();
    checkBids();
    super.onInit();
  }

  @override
  void onClose() async {
    requestModel.value.bids?.clear();
    await LocalStorage.write(ConstantsVariables.playMore, true);
    super.onClose();
  }

  onTapOpenClose() {
    if (openBiddingOpen.value && openCloseValue.value != "OPENBID".tr) {
      openCloseValue.value = "OPENBID".tr;
      callGetGameModes();
    } else {
      callGetGameModes();
    }
  }

  void setSelectedRadioValue(String value) {
    openCloseValue.value = value;
  }

  void checkBiddingStatus() {
    var timeDiffForOpenBidding = CommonUtils()
        .getDifferenceBetweenGivenTimeFromNow(
            marketValue.value.openTime ?? "00:00 AM");
    var timeDiffForCloseBidding = CommonUtils()
        .getDifferenceBetweenGivenTimeFromNow(
            marketValue.value.closeTime ?? "00:00 AM");
    timeDiffForOpenBidding < 2 ? openBiddingOpen.value = false : true;

    timeDiffForCloseBidding < 2 ? closeBiddingOpen.value = false : true;

    if (!openBiddingOpen.value) {
      openCloseValue.value = "CLOSEBID".tr;
    }
  }

  // void getUserBalance() {
  //   ApiService().getBalance().then((value) async {
  //     debugPrint("((((((((((((((((((((((((((()))))))))))))))))))))))))))");
  //     debugPrint("Wallet balance Api Response :- $value");
  //     if (value['status']) {
  //       var tempBalance = value['data']['Amount'] ?? 00;
  //       walletBalance.value = tempBalance.toString();
  //     } else {
  //       AppUtils.showErrorSnackBar(
  //         bodyText: value['message'] ?? "",
  //       );
  //     }
  //   });
  // }

  onBackButton() async {
    selectedBidsList.clear();
    await LocalStorage.write(ConstantsVariables.bidsList, selectedBidsList);
    final walletController = Get.find<WalletController>();
    walletController.getUserBalance();
    walletController.walletBalance.refresh();
    Get.offAllNamed(AppRoutName.dashBoardPage);
  }

  void callGetGameModes() async {
    ApiService()
        .getGameModes(
            openCloseValue: openCloseValue.value != "CLOSEBID".tr ? "0" : "1",
            marketID: marketValue.value.id ?? 0)
        .then((value) async {
      debugPrint("Get Game modes Api Response :- $value");

      if (value['status']) {
        GameModesApiResponseModel gameModeModel =
            GameModesApiResponseModel.fromJson(value);
        gameModeList.value = gameModeModel;
        print("Game modes Api Response $gameModeList ");
        if (gameModeModel.data != null) {
          openBiddingOpen.value = gameModeModel.data!.isBidOpenForOpen ?? false;
          closeBiddingOpen.value =
              gameModeModel.data!.isBidOpenForClose ?? false;
          gameModesList.value = gameModeModel.data!.gameMode ?? <GameMode>[];
        }
      } else {
        AppUtils.showErrorSnackBar(
          bodyText: value['message'] ?? "",
        );
      }
    });
    print(playmore);
  }

  void checkBids() async {
    var hh = await LocalStorage.read(ConstantsVariables.playMore);

    if (!hh) {
      var bidList = await LocalStorage.read(ConstantsVariables.bidsList);
      // selectedBidsList.value = bidList as List<Bids>;
    } else {}
    // requestModel.refresh();
    // print("${requestModel.value.bids.toString()}  + +++++++");
  }

  void onTapOfGameModeTile(int index) {
    print(gameModesList[index].name);
    bool isBulkMode = false;
    bool digitBasedJodi = false;
    bool choicePanaSpDp = false;
    bool digitsBasedJodi = false;
    bool oddEven = false;
    bool halfSangamA = false;
    bool halfSangamB = false;
    bool fullSangam = false;
    switch (gameModesList[index].name) {
      case "Single Ank Bulk":
        isBulkMode = true;
        break;
      case "Jodi Bulk":
        isBulkMode = true;
        break;
      case "Single Pana Bulk":
        isBulkMode = true;
        break;
      case "Double Pana Bulk":
        isBulkMode = true;
        break;
      case "Digit Based Jodi":
        digitBasedJodi = true;
        break;
      case "Choice Pana SPDP":
        choicePanaSpDp = true;
        break;
      case "Digits Based Jodi":
        digitsBasedJodi = true;
        break;
      case "Odd Even":
        oddEven = true;
        break;
      case "Half Sangam A":
        halfSangamA = true;
        break;
      case "Half Sangam B":
        halfSangamB = true;

        break;
      case "Full Sangam":
        halfSangamB = true;
        break;
      default:
    }

    if (halfSangamA || halfSangamB || fullSangam) {
      Get.toNamed(AppRoutName.sangamPages, arguments: {
        "gameMode": gameModesList[index],
        "marketName": marketValue.value.market ?? "",
        "marketData": marketValue.value,
        "gameModeList": gameModeList,
        "marketValue": marketValue.value,
        "bidsList": selectedBidsList,
        "gameName": gameModesList[index].name,
        "totalAmount": totalAmount.value,
      });
      print(marketValue.value.market);
    } else if (isBulkMode) {
      print(selectedBidsList);
      Get.toNamed(AppRoutName.singleAnkPage, arguments: {
        "gameMode": gameModesList[index],
        "marketName": marketValue.value.market ?? "",
        "marketId": marketValue.value.id ?? "",
        "marketValue": marketValue.value,
        "time": openCloseValue.value == "OPENBID".tr
            ? marketValue.value.openTime ?? ""
            : marketValue.value.closeTime ?? "",
        "biddingType": openCloseValue.value == "OPENBID".tr ? "Open" : "Close",
        "isBulkMode": true,
        "gameModeList": gameModeList,
        "bidsList": selectedBidsList,
        "gameName": gameModesList[index].name,
        "totalAmount": totalAmount.value,
      });
      print(marketValue.value.market);
    } else if (choicePanaSpDp || digitsBasedJodi || oddEven) {
      Get.toNamed(AppRoutName.newOddEvenPage, arguments: {
        "gameMode": gameModesList[index],
        "marketName": marketValue.value.market ?? "",
        "marketId": marketValue.value.id ?? "",
        "time": openCloseValue.value == "OPENBID".tr
            ? marketValue.value.openTime ?? ""
            : marketValue.value.closeTime ?? "",
        "biddingType": openCloseValue.value == "OPENBID".tr ? "Open" : "Close",
        "isBulkMode": false,
        "gameModeList": gameModeList,
        "marketValue": marketValue.value,
        "bidsList": selectedBidsList,
        "gameName": gameModesList[index].name,
        "totalAmount": totalAmount.value,
      });
    } else {
      Get.toNamed(AppRoutName.newGameModePage, arguments: {
        "gameMode": gameModesList[index],
        "marketName": marketValue.value.market ?? "",
        "marketId": marketValue.value.id ?? "",
        "marketValue": marketValue.value,
        "time": openCloseValue.value == "OPENBID".tr
            ? marketValue.value.openTime ?? ""
            : marketValue.value.closeTime ?? "",
        "biddingType": openCloseValue.value == "OPENBID".tr ? "Open" : "Close",
        "isBulkMode": false,
        "gameModeList": gameModeList,
        "bidsList": selectedBidsList,
        "gameName": gameModesList[index].name,
        "totalAmount": totalAmount.value,
      });
      print(marketValue.value.market);
    }
  }

  var biddingType = "".obs;
  RxString totalAmount = "0".obs;
  var marketName = "".obs;
  Future<void> getArguments() async {
    var data = await LocalStorage.read(ConstantsVariables.userData);
    playmore = await LocalStorage.read(ConstantsVariables.playMore);
    UserDetailsModel userData = UserDetailsModel.fromJson(data);
    requestModel.value.userId = userData.id;
    selectedBidsList.value =
        await LocalStorage.read(ConstantsVariables.bidsList) ?? [];
    print("@#@@#@#@@#$selectedBidsList");
    requestModel.refresh();
  }
}
