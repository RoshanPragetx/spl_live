import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/ui_utils.dart';

import '../../../api_services/api_service.dart';
import '../../../helper_files/constant_variables.dart';
import '../../../models/commun_models/bid_request_model.dart';
import '../../../models/commun_models/json_file_model.dart';
import '../../../models/commun_models/user_details_model.dart';
import '../../../models/daily_market_api_response_model.dart';
import '../../../models/game_modes_api_response_model.dart';
import '../../Local Storage.dart';

class SangamPageController extends GetxController {
  bool isValue = false;
  String bidType = "Open";
  Rx<GameMode> gameMode = GameMode().obs;
  Rx<MarketData> marketData = MarketData().obs;
  // RxString totalAmount = "00".obs;
  RxString openText = "OPENDIGIT".tr.obs;
  RxString closeText = "CLOSEPANA".tr.obs;
  RxString openFieldHint = "ENTERDIGIT".tr.obs;
  RxString totalBiddingAmount = "0".obs;
  bool enteredOpenDigitsIsValidate = false;
  bool enteredCloseDigitsIsValidate = false;
  String openValue = "";
  String closeValue = "";
  RxList<String> suggestionOpenList = <String>["222", "124", "125", "145"].obs;
  RxList<String> suggestionCloseList = <String>["111", "123", "122", "145"].obs;
  List<String> digitList = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
  var argument = Get.arguments;
  Rx<BidRequestModel> requestModel = BidRequestModel().obs;
  RxBool isHalfSangam = false.obs;
  RxBool isOpenBid = true.obs;
  JsonFileModel jsonModel = JsonFileModel();
  var addedSangamList = <Bids>[].obs;
  var coinsController = TextEditingController();
  var openValueController = TextEditingController();
  var closeValueController = TextEditingController();
  // final FocusNode focusNode1 = FocusNode();
  final FocusNode coinsFocusNode = FocusNode();
  final FocusNode openFocusNode = FocusNode();
  FocusNode closeFocusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    getArguments();
  }

  void getArguments() async {
    gameMode.value = argument['gameMode'];
    marketData.value = argument['marketData'];
    requestModel.value.dailyMarketId = marketData.value.id;
    requestModel.value.bidType = bidType;
    var data = await LocalStorage.read(ConstantsVariables.userData);
    UserDetailsModel userData = UserDetailsModel.fromJson(data);
    requestModel.value.userId = userData.id;
    if (gameMode.value.name == "Full Sangam") {
      openText.value = "OPENPANA".tr;
      openFieldHint.value = "ENTERPANA".tr;
      bidType = "Open";
      isHalfSangam.value = false;
      // suggestionOpenList.value = digitList;
    } else {
      isHalfSangam.value = true;
      //  suggestionOpenList.value = digitList;
    }
    await loadJsonFile();
  }

  Future<void> loadJsonFile() async {
    final String response =
        await rootBundle.loadString('assets/JSON File/digit_file.json');
    final data = await json.decode(response);
    jsonModel = JsonFileModel.fromJson(data);
  }

  void createMarketBidApi() async {
    ApiService()
        .createMarketBid(requestModel.value.toJson())
        .then((value) async {
      debugPrint("create bid api response :- $value");
      if (value['status']) {
        if (value['data'] == null) {
          AppUtils.showErrorSnackBar(
            bodyText: value['message'] ?? "",
          );
        } else {
          Get.back();
          AppUtils.showSuccessSnackBar(
              bodyText: value['message'] ?? "",
              headerText: "SUCCESSMESSAGE".tr);
        }
      } else {
        AppUtils.showErrorSnackBar(
          bodyText: value['message'] ?? "",
        );
      }
    });
  }

  // void onDeleteSangamBid(int index) {
  //   addedSangamList.remove(addedSangamList[index]);
  //   addedSangamList.refresh();
  //   totalBiddingAmount.value =
  //       (int.parse(coinsController.text.toString()) * addedSangamList.length)
  //           .toString();
  // }

  void onDeleteBids(int index) {
    requestModel.value.bids = addedSangamList;
    requestModel.value.bids!.remove(addedSangamList[index]);
    requestModel.refresh();
  }

  void validateEnteredOpenDigit(String value) {
    // enteredOpenDigitsIsValidate = true;
    openValue = value;
    // if (enteredOpenDigitsIsValidate) {
    //   halfSangamPanaSwitchCase(
    //       jsonModel.singlePana!.single, int.parse(openValue));
    // }
  }

  void validateEnteredCloseDigit(bool validate, String value) {
    enteredOpenDigitsIsValidate = true;
    //  enteredCloseDigitsIsValidate = true;
    closeValue = value;
    print("closeValue$closeValue");
    // if (enteredOpenDigitsIsValidate) {
    //   halfSangamPanaSwitchCase(
    //       jsonModel.singlePana!.single, int.parse(openValue));
    // }
  }

  void onTapOfSaveButton() {
    if (requestModel.value.bids != null &&
        requestModel.value.bids!.isNotEmpty) {
      createMarketBidApi();
    } else {
      AppUtils.showErrorSnackBar(
        bodyText: "Please Add Some Bids!",
      );
    }
  }

  // void callback() {
  //   if (isValue) {
  //     onTapOfGameModeButton(value: true);
  //   } else {
  //     onTapOfGameModeButton(value: false);
  //   }
  // }

  // void onTapOfGameModeButton({required bool value}) {
  //   isOpenBid.value = value;
  //   if (isOpenBid.value) {
  //     openText.value = "OPENDIGIT".tr;
  //     closeText.value = "CLOSEPANA".tr;
  //   } else {
  //     openText.value = "CLOSEDIGIT".tr;
  //     closeText.value = "OPENPANA".tr;
  //   }
  // }

  void halfSangamPanaSwitchCase(ThreePana panaList, int digit) {
    switch (digit) {
      case 0:
        suggestionCloseList.value = panaList.l0!;
        break;
      case 1:
        suggestionCloseList.value = panaList.l1!;
        break;
      case 2:
        suggestionCloseList.value = panaList.l2!;
        break;
      case 3:
        suggestionCloseList.value = panaList.l3!;
        break;
      case 4:
        suggestionCloseList.value = panaList.l4!;
        break;
      case 5:
        suggestionCloseList.value = panaList.l5!;
        break;
      case 6:
        suggestionCloseList.value = panaList.l6!;
        break;
      case 7:
        suggestionCloseList.value = panaList.l7!;
        break;
      case 8:
        suggestionCloseList.value = panaList.l8!;
        break;
      case 9:
        suggestionCloseList.value = panaList.l9!;
        break;
      default:
        suggestionCloseList.value = panaList.l0!;
        break;
    }
  }

  void onTapOfAddBidButton() {
    if (int.parse(coinsController.text) > 0) {
      if (enteredOpenDigitsIsValidate) {
        //  if (enteredCloseDigitsIsValidate) {
        addedSangamList.add(
          Bids(
              bidNo: "$openValue-$closeValue",
              coins: int.parse(coinsController.text),
              gameId: gameMode.value.id,
              gameModeName: gameMode.value.name,
              remarks:
                  "You invested At ${marketData.value.market} on $openValue-$closeValue (${gameMode.value.name})"),
        );
        openValueController.clear();
        closeValueController.clear();
        coinsController.clear();
        int tempTotal = 0;
        for (int i = 0; i < addedSangamList.length; i++) {
          tempTotal += addedSangamList[i].coins ?? 0;
        }
        totalBiddingAmount.value = tempTotal.toString();
        requestModel.value.bids = addedSangamList;
        // } else {
        //   Get.closeCurrentSnackbar();
        //   AppUtils.showErrorSnackBar(
        //     bodyText: "Enter valid ${closeText.value}",
        //   );
        // }
      } else {
        Get.closeCurrentSnackbar();
        AppUtils.showErrorSnackBar(
          bodyText: "Enter valid ${openText.value}",
        );
      }
    } else {
      Get.closeCurrentSnackbar();
      AppUtils.showErrorSnackBar(
        bodyText: "Please Enter Valid Points!",
      );
    }
  }
}
