import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spllive/helper_files/ui_utils.dart';
import 'package:spllive/routes/app_routes_name.dart';
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
  // RxString selectedRadioValue = 'open'.obs;
  RxBool containerChange = false.obs;
  var arguments = Get.arguments;
  Rx<GameModesApiResponseModel> gameModeList = GameModesApiResponseModel().obs;
  var marketValue = MarketData().obs;
  var openBiddingOpen = true.obs;
  // var openCloseRadioValue = 0.obs;
  var openCloseValue = "OPENBID".tr.obs;
  var closeBiddingOpen = true.obs;
  RxBool isBulkMode = false.obs;
  var playmore;
  // RxString totalAmount = "00".obs;
  // var biddingType = "".obs;
  // var gameName = "".obs;
  // var marketName = "".obs;
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
    print(marketValue.value.closeTime);
    checkBiddingStatus();
    callGetGameModes();
    getArguments();
    checkBids();
    super.onInit();
  }

  @override
  void onClose() async {
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

  onBackButton() async {
    Get.offAndToNamed(AppRoutName.dashBoardPage);
    selectedBidsList.clear();
    await LocalStorage.write(ConstantsVariables.bidsList, selectedBidsList);
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
    print("read PlayMore  $hh");
    if (!hh) {
      var bidList = await LocalStorage.read(ConstantsVariables.bidsList);
      // selectedBidsList.value = bidList as List<Bids>;
      print(
          " bidList on GameModes page ${bidList.toString()}  -----------------");
    } else {
      print("THre is no Play More");
    }
    // requestModel.refresh();
    // print("${requestModel.value.bids.toString()}  + +++++++");
  }

  void onTapOfGameModeTile(int index) {
    if (gameModesList[index].name!.contains("Sangam")) {
      Get.toNamed(AppRoutName.sangamPages, arguments: {
        "gameMode": gameModesList[index],
        "marketData": marketValue.value,
        "gameModeList": gameModeList,
        "bidsList": selectedBidsList,
        "gameName": gameModesList[index].name,
        "totalAmount": totalAmount.value,
      });
    } else if (gameModesList[index].name!.contains("Bulk") ||
        gameModesList[index].name!.contains("jodi")) {
      print(selectedBidsList);
      Get.toNamed(AppRoutName.singleAnkPage, arguments: {
        "gameMode": gameModesList[index],
        "marketName": marketValue.value.market ?? "",
        "marketId": marketValue.value.id ?? "",
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
    } else if (gameModesList[index].name!.contains("Choice") ||
        gameModesList[index].name!.contains("Digits Based Jodi") ||
        gameModesList[index].name!.contains("Odd Even")) {
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
        "bidsList": selectedBidsList,
        "gameName": gameModesList[index].name,
        "totalAmount": totalAmount.value,
      });
    } else {
      print(selectedBidsList);
      Get.toNamed(AppRoutName.newGameModePage, arguments: {
        "gameMode": gameModesList[index],
        "marketName": marketValue.value.market ?? "",
        "marketId": marketValue.value.id ?? "",
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
    }
  }

  var biddingType = "".obs;
  RxString totalAmount = "0".obs;
  var marketName = "".obs;
  Future<void> getArguments() async {
    //biddingType.value = arguments["biddingType"];
    // marketName.value = arguments["marketName"];
    // totalAmount.value = arguments["totalAmount"];
    // requestModel.value.bids = arguments["bidsList"];
    // checkBidsList();
    var data = await LocalStorage.read(ConstantsVariables.userData);
    playmore = await LocalStorage.read(ConstantsVariables.playMore);
    print("playmore $playmore");
    UserDetailsModel userData = UserDetailsModel.fromJson(data);
    requestModel.value.userId = userData.id;
    selectedBidsList = await LocalStorage.read(ConstantsVariables.bidsList);
    print("@#@@#@#@@#$selectedBidsList");
    // requestModel.value.bidType = arguments["biddingType"];
    // requestModel.value.dailyMarketId = arguments["marketId"];
    requestModel.refresh();
    // gameName.value = arguments["gameName"];
  }
}
