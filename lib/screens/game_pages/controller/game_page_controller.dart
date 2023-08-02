import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/ui_utils.dart';
import 'package:spllive/routes/app_routes_name.dart';
import '../../../helper_files/constant_variables.dart';
import '../../../models/commun_models/bid_request_model.dart';
import '../../../models/commun_models/digit_list_model.dart';
import '../../../models/commun_models/json_file_model.dart';
import '../../../models/commun_models/user_details_model.dart';
import '../../../models/game_modes_api_response_model.dart';
import '../../Local Storage.dart';

class GamePageController extends GetxController {
  // RxList<String> filteredItems = RxList<String>();
  RxInt containerWidget = 0.obs;
  var coinController = TextEditingController();
  var searchController = TextEditingController();
  RxBool isEnable = false.obs;
  RxBool showNumbersLine = false.obs;
  GameMode gameMode = GameMode();
  List<String> matches = <String>[].obs;
  bool enteredDigitsIsValidate = false;

  var biddingType = "".obs;
  var marketName = "".obs;
  var marketTime = "".obs;
  RxString totalAmount = "00".obs;
  var marketId = 0;
  RxBool isBulkMode = false.obs;
  RxBool validCoinsEntered = false.obs;
  String addedNormalBidValue = "";
  RxInt panaControllerLength = 2.obs;

  int selectedIndexOfDigitRow = 0;

  var argument = Get.arguments;
  var selectedBidsList = <Bids>[].obs;
  JsonFileModel jsonModel = JsonFileModel();

  var digitList = <DigitListModelOffline>[].obs;
  RxList<String> suggestionList = <String>[].obs;
  TextEditingController autoCompleteFieldController = TextEditingController();
  BidRequestModel requestModel = BidRequestModel();

  var singleAnkList = <DigitListModelOffline>[].obs;
  var jodiList = <DigitListModelOffline>[].obs;
  var triplePanaList = <DigitListModelOffline>[].obs;
  var singlePanaList = <DigitListModelOffline>[].obs;
  var doublePanaList = <DigitListModelOffline>[].obs;
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
  Timer? _debounce;
  @override
  void onInit() {
    super.onInit();
    getArguments();
  }

  ondebounce() {
    if (_debounce != null && _debounce!.isActive) {
      _debounce!.cancel();
    }
    Timer(const Duration(milliseconds: 400), () {
      if (int.parse(coinController.text) == 0) {
        AppUtils.showErrorSnackBar(bodyText: "Please enter minimun 1 coin");
      }
    });
  }

  Future<void> loadJsonFile() async {
    final String response =
        await rootBundle.loadString('assets/JSON File/digit_file.json');
    final data = await json.decode(response);
    jsonModel = JsonFileModel.fromJson(data);
  }

  Future<void> getArguments() async {
    gameMode = argument['gameMode'];
    biddingType.value = argument['biddingType'];
    marketName.value = argument['marketName'];
    marketId = argument['marketId'];
    marketTime.value = argument['time'];
    isBulkMode.value = argument['isBulkMode'];
    await loadJsonFile();
    switch (gameMode.name) {
      case "Single Digit":
        showNumbersLine.value = false;
        enteredDigitsIsValidate = true;
        panaControllerLength.value = 1;
        suggestionList.value = jsonModel.singleAnk!;
        for (var e in jsonModel.singleAnk!) {
          singleAnkList.add(DigitListModelOffline.fromJson(e));
        }
        digitList.value = singleAnkList;
        break;
      case "Jodi Digit":
        showNumbersLine.value = false;
        suggestionList.value = jsonModel.jodi!;
        panaControllerLength.value = 2;
        for (var e in jsonModel.jodi!) {
          jodiList.add(DigitListModelOffline.fromJson(e));
        }
        digitList.value = jodiList;
        break;
      case "Single Pana":
        digitRow.first.isSelected = true;
        showNumbersLine.value = true;
        panaControllerLength.value = 3;
        suggestionList.value = jsonModel.singlePana!.single.l0!;
        for (var e in jsonModel.singlePana!.single.l0!) {
          singlePanaList.add(DigitListModelOffline.fromJson(e));
        }
        digitList.value = singlePanaList;
        break;
      case "Double Pana":
        digitRow.first.isSelected = true;
        showNumbersLine.value = true;
        panaControllerLength.value = 3;
        suggestionList.value = jsonModel.doublePana!.single.l0!;
        for (var e in jsonModel.doublePana!.single.l0!) {
          doublePanaList.add(DigitListModelOffline.fromJson(e));
        }
        digitList.value = doublePanaList;
        break;
      case "Tripple Pana":
        showNumbersLine.value = false;
        suggestionList.value = jsonModel.triplePana!;
        panaControllerLength.value = 3;
        for (var e in jsonModel.triplePana!) {
          triplePanaList.add(DigitListModelOffline.fromJson(e));
        }
        digitList.value = triplePanaList;
        break;
    }

    var data = await LocalStorage.read(ConstantsVariables.userData);
    UserDetailsModel userData = UserDetailsModel.fromJson(data);
    requestModel.userId = userData.id;
    requestModel.bidType = biddingType.value;
    requestModel.dailyMarketId = marketId;
  }

  // void onTapOfDigitTile(int index) {}

  void onTapNumberList(index) {
    if (validCoinsEntered.value) {
      if (digitList[index].isSelected == false) {
        onTapOfDigitTile(index);
        digitList[index].isSelected = true;
      } else {
        digitList[index].isSelected = false;
        onLongPressDigitTile(index);
      }
    }
  }

  void onTapOfDigitTile(int index) {
    if (coinController.text.isNotEmpty) {
      if (!validCoinsEntered.value) {
        AppUtils.showErrorSnackBar(bodyText: "Please enter valid coins");
        return;
      }
      int tempCoins = int.parse("${digitList[index].coins}");
      digitList[index].coins = tempCoins + int.parse(coinController.text);
      digitList[index].isSelected = true;
      digitList.refresh();
      if (selectedBidsList.isNotEmpty) {
        var tempBid = selectedBidsList
            .where((element) => element.bidNo == digitList[index].value)
            .toList();
        if (tempBid.isNotEmpty) {
          for (var element in selectedBidsList) {
            if (element.bidNo == digitList[index].value) {
              element.coins = digitList[index].coins;
            }
          }
        } else {
          selectedBidsList.add(
            Bids(
              bidNo: digitList[index].value,
              coins: int.parse(coinController.text),
              gameId: gameMode.id,
              gameModeName: gameMode.name,
              remarks:
                  "You invested At ${marketName.value} on ${digitList[index].value} (${gameMode.name})",
            ),
          );
        }
      } else {
        selectedBidsList.add(
          Bids(
            bidNo: digitList[index].value,
            coins: int.parse(coinController.text),
            gameId: gameMode.id,
            gameModeName: gameMode.name,
            remarks:
                "You invested At ${marketName.value} on ${digitList[index].value} (${gameMode.name})",
          ),
        );
      }
      print(digitList[index].isSelected);
      _calculateTotalAmount();
    } else {
      // digitList[index].coins = 0;
      // digitList[index].isSelected = false;
      // digitList.refresh();
      // selectedBidsList
      //     .removeWhere((element) => element.bidNo == digitList[index].value);
      // _calculateTotalAmount();
      // print("Enable Value:${isEnable.value}");
      AppUtils.showErrorSnackBar(bodyText: "Please enter coins!");
    }
  }

  void onLongPressDigitTile(int index) {
    digitList[index].coins = 0;
    digitList[index].isSelected = false;
    digitList.refresh();
    selectedBidsList
        .removeWhere((element) => element.bidNo == digitList[index].value);
    _calculateTotalAmount();
  }

  void _calculateTotalAmount() {
    var tempTotal = 0;
    for (var element in selectedBidsList) {
      tempTotal += element.coins ?? 0;
    }
    totalAmount.value = tempTotal.toString();
  }

  void onTapOfNumbersLine(int index) {
    for (int i = 0; i < digitRow.length; i++) {
      digitRow[i].isSelected = false;
    }
    digitRow[index].isSelected = true;
    digitRow.refresh();

    if (gameMode.name == "Single Pana") {
      panaSwitchCase(jsonModel.singlePana!.single, index);
    } else {
      panaSwitchCase(jsonModel.doublePana!.single, index);
    }
    digitList.refresh();
  }

  void panaSwitchCase(ThreePana panaList, int index) {
    List<DigitListModelOffline> tempList = [];
    List<String> temListFor = [];
    switch (index) {
      case 0:
        for (var e in panaList.l0!) {
          tempList.add(DigitListModelOffline.fromJson(e));
          temListFor.add(e);
        }
        break;
      case 1:
        for (var e in panaList.l1!) {
          tempList.add(DigitListModelOffline.fromJson(e));
          temListFor.add(e);
        }
        break;
      case 2:
        for (var e in panaList.l2!) {
          tempList.add(DigitListModelOffline.fromJson(e));
          temListFor.add(e);
        }
        break;
      case 3:
        for (var e in panaList.l3!) {
          tempList.add(DigitListModelOffline.fromJson(e));
          temListFor.add(e);
        }
        break;
      case 4:
        for (var e in panaList.l4!) {
          tempList.add(DigitListModelOffline.fromJson(e));
          temListFor.add(e);
        }
        break;
      case 5:
        for (var e in panaList.l5!) {
          tempList.add(DigitListModelOffline.fromJson(e));
          temListFor.add(e);
        }
        break;
      case 6:
        for (var e in panaList.l6!) {
          tempList.add(DigitListModelOffline.fromJson(e));
          temListFor.add(e);
        }
        break;
      case 7:
        for (var e in panaList.l7!) {
          tempList.add(DigitListModelOffline.fromJson(e));
          temListFor.add(e);
        }
        break;
      case 8:
        for (var e in panaList.l8!) {
          tempList.add(DigitListModelOffline.fromJson(e));
          temListFor.add(e);
        }
        break;
      case 9:
        for (var e in panaList.l9!) {
          tempList.add(DigitListModelOffline.fromJson(e));
          temListFor.add(e);
        }
        break;
      default:
        for (var e in panaList.l0!) {
          tempList.add(DigitListModelOffline.fromJson(e));
          temListFor.add(e);
        }
        break;
    }
    digitList.value = tempList;
    suggestionList.value = temListFor;
    // print(temListFor);
  }

  Future<void> onTapOfSaveButton() async {
    if (selectedBidsList.isNotEmpty) {
      await LocalStorage.write(ConstantsVariables.bidsList, selectedBidsList);
      Get.offAndToNamed(AppRoutName.selectedBidsPage, arguments: {
        "bidsList": selectedBidsList,
        "biddingType": biddingType.value,
        "gameName": gameMode.name,
        "marketName": marketName.value,
        "marketId": marketId,
        "totalAmount": totalAmount.value,
      });
      digitList.clear();
      searchController.clear();
      coinController.clear();
      totalAmount.value = "00";
      getArguments();
    } else {
      AppUtils.showErrorSnackBar(
        bodyText: "Please add some bids!",
      );
    }
  }
}

// void onTapOfDigitTile(int index) {
//   if (coinController.text.isNotEmpty) {
//     if (isBulkMode.value) {
//       if (!validCoinsEntered.value) {
//         AppUtils.showErrorSnackBar(bodyText: "Please enter valid coins");
//         return;
//       }
//       int tempCoins = int.parse("${digitList[index].coins}");
//       digitList[index].coins = tempCoins + int.parse(coinController.text);
//       digitList[index].isSelected = true;
//       digitList.refresh();
//       if (selectedBidsList.isNotEmpty) {
//         var tempBid = selectedBidsList
//             .where((element) => element.bidNo == digitList[index].value)
//             .toList();
//         if (tempBid.isNotEmpty) {
//           for (var element in selectedBidsList) {
//             if (element.bidNo == digitList[index].value) {
//               element.coins = digitList[index].coins;
//             }
//           }
//         } else {
//           selectedBidsList.add(
//             Bids(
//               bidNo: digitList[index].value,
//               coins: int.parse(coinController.text),
//               gameId: gameMode.id,
//               gameModeName: gameMode.name,
//               remarks:
//                   "You invested At ${marketName.value} on ${digitList[index].value} (${gameMode.name})",
//             ),
//           );
//         }
//       } else {
//         selectedBidsList.add(
//           Bids(
//             bidNo: digitList[index].value,
//             coins: int.parse(coinController.text),
//             gameId: gameMode.id,
//             gameModeName: gameMode.name,
//             remarks:
//                 "You invested At ${marketName.value} on ${digitList[index].value} (${gameMode.name})",
//           ),
//         );
//       }
//     } else {
//       digitList[index].isSelected = digitList[index].isSelected! ? false : true;
//       digitList.refresh();
//       if (digitList[index].isSelected == true) {
//         selectedBidsList.add(
//           Bids(
//             bidNo: digitList[index].value,
//             coins: int.parse(coinController.text),
//             gameId: gameMode.id,
//             gameModeName: gameMode.name,
//             remarks:
//                 "You invested At ${marketName.value} on ${digitList[index].value} (${gameMode.name})",
//           ),
//         );
//       } else {
//         selectedBidsList
//             .removeWhere((element) => element.bidNo == digitList[index].value);
//       }
//     }

//     _calculateTotalAmount();
//   } else {
//     AppUtils.showErrorSnackBar(bodyText: "Please enter coins!");
//   }
// }

// }
