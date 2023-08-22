import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/ui_utils.dart';
import 'package:spllive/routes/app_routes_name.dart';
import '../../../helper_files/app_colors.dart';
import '../../../helper_files/constant_variables.dart';
import '../../../models/commun_models/digit_list_model.dart';
import '../../../models/commun_models/json_file_model.dart';
import '../../../models/commun_models/starline_bid_request_model.dart';
import '../../../models/starline_daily_market_api_response.dart';
import '../../../models/starline_game_modes_api_response_model.dart';
import '../../Local Storage.dart';

class StarLineGamePageController extends GetxController {
  var coinController = TextEditingController();
  var searchController = TextEditingController();
  RxBool showNumbersLine = false.obs;
  RxBool validCoinsEntered = false.obs;
  Timer? _debounce;
  RxString totalAmount = "0".obs;
  int selectedIndexOfDigitRow = 0;
  Rx<StarLineGameMod> gameMode = StarLineGameMod().obs;
  Rx<StarlineMarketData> marketData = StarlineMarketData().obs;
  var argument = Get.arguments;
  RxList<StarLineBids> selectedBidsList = <StarLineBids>[].obs;
  JsonFileModel jsonModel = JsonFileModel();
  var digitList = <DigitListModelOffline>[].obs;
  var searchDigitList = <DigitListModelOffline>[].obs;
  var singleAnkList = <DigitListModelOffline>[];
  var jodiList = <DigitListModelOffline>[];
  var triplePanaList = <DigitListModelOffline>[];
  var singlePanaList = <DigitListModelOffline>[];
  var doublePanaList = <DigitListModelOffline>[];
  List<FocusNode> focusNodes = [];
  List<int> newList = [];
  List<StarLineBids> jp = [];
  var getBIdType = "";
  var biddingType = "".obs;
  var marketName = "".obs;
  var marketTime = "".obs;
  var marketId = 0;
  bool getBidData = false;
  List<String> matches = <String>[].obs;
  RxBool isEnable = false.obs;
  RxList<String> suggestionList = <String>[].obs;
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
  final Rx<Color> containerBorderColor = AppColors.black.obs;
  RxList<Color> containerBorderColor2 = <Color>[].obs;
  RxInt panaControllerLength = 2.obs;
  RxList<StarLineBids> bidList = <StarLineBids>[].obs;
  @override
  void onInit() {
    getArguments();
    super.onInit();
  }

  @override
  void onClose() {
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    coinController.dispose();
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
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

  void setContainerBorderColor(Color color) {
    containerBorderColor.value = color;
  }

  Future<void> getArguments() async {
    bidList = await LocalStorage.read(ConstantsVariables.starlineBidsList);
    gameMode.value = argument['gameMode'];
    marketData.value = argument['marketData'];
    getBidData = argument['getBidData'];
    getBIdType = argument['getBIdType'];
    print(getBIdType);
    await loadJsonFile();
    switch (gameMode.value.name) {
      case "Single Ank Bulk":
        showNumbersLine.value = false;
        // enteredDigitsIsValidate = true;
        panaControllerLength.value = 1;
        suggestionList.value = jsonModel.singleAnk!;
        for (var e in jsonModel.singleAnk!) {
          singleAnkList.add(DigitListModelOffline.fromJson(e));
        }
        digitList.value = singleAnkList;
        //    initializeTextControllers();
        break;
      // case "Jodi Bulk":
      //   showNumbersLine.value = false;
      //   suggestionList.value = jsonModel.jodi!;
      //   panaControllerLength.value = 2;
      //   for (var e in jsonModel.jodi!) {
      //     jodiList.add(DigitListModelOffline.fromJson(e));
      //   }
      //   digitList.value = jodiList;
      //   //   initializeTextControllers();
      //   break;
      case "Single Pana Bulk":
        digitRow.first.isSelected = true;
        showNumbersLine.value = true;
        panaControllerLength.value = 3;
        suggestionList.value = jsonModel.singlePana!.single.l0!;
        for (var e in jsonModel.singlePana!.single.l0!) {
          singlePanaList.add(DigitListModelOffline.fromJson(e));
        }
        digitList.value = singlePanaList;
        //  initializeTextControllers();
        break;
      case "Double Pana Bulk":
        digitRow.first.isSelected = true;
        showNumbersLine.value = true;
        panaControllerLength.value = 3;
        suggestionList.value = jsonModel.doublePana!.single.l0!;
        for (var e in jsonModel.doublePana!.single.l0!) {
          doublePanaList.add(DigitListModelOffline.fromJson(e));
        }
        digitList.value = doublePanaList;
        //  initializeTextControllers();
        break;
      case "Tripple Pana":
        showNumbersLine.value = false;
        suggestionList.value = jsonModel.triplePana!;
        panaControllerLength.value = 3;
        for (var e in jsonModel.triplePana!) {
          triplePanaList.add(DigitListModelOffline.fromJson(e));
        }
        digitList.value = triplePanaList;
        // initializeTextControllers();
        break;
    }
    // var data = await LocalStorage.read(ConstantsVariables.userData);
    // UserDetailsModel userData = UserDetailsModel.fromJson(data);
    // requestModel.userId = userData.id;
    // requestModel.bidType = biddingType.value;
    // requestModel.dailyMarketId = marketId;
  }

  Future<void> onTapOfSaveButton() async {
    if (selectedBidsList.isNotEmpty) {
      if (bidList.isNotEmpty) {
        for (var i = 0; i < bidList.length; i++) {
          // selectedBidsList.add(bidsList[i]);
          selectedBidsList.add(bidList[i]);
          var existingIndex = selectedBidsList.indexOf(bidList[i]);
          selectedBidsList.refresh();
        }

        await LocalStorage.write(
            ConstantsVariables.starlineBidsList, selectedBidsList);
        Get.offAndToNamed(AppRoutName.starlineBidpage, arguments: {
          "bidsList": selectedBidsList,
          "gameMode": gameMode.value,
          "marketData": marketData.value,
        })?.then((value) {
          // selectedBidsList.clear();
        });
        for (int i = 0; i < digitList.length; i++) {
          digitList[i].isSelected = false;
        }
        digitList.refresh();
        coinController.clear();
      } else {
        await LocalStorage.write(
            ConstantsVariables.starlineBidsList, selectedBidsList);
        Get.offAndToNamed(AppRoutName.starlineBidpage, arguments: {
          "bidsList": selectedBidsList,
          "gameMode": gameMode.value,
          "marketData": marketData.value,
        })?.then((value) {
          // selectedBidsList.clear();
        });
        for (int i = 0; i < digitList.length; i++) {
          digitList[i].isSelected = false;
        }
        digitList.refresh();
        coinController.clear();
        getArguments();
      }
    } else {
      AppUtils.showErrorSnackBar(
        bodyText: "Please add some bids!",
      );
    }
  }

  void onTapNumberList(index) {
    if (validCoinsEntered.value) {
      if (digitList[index].isSelected == false) {
        onTapOfDigitTile(index);
        digitList[index].isSelected = true;
      } else {
        // digitList[index].isSelected = false;
        onLongPressDigitTile(index);
      }
    }
  }

  void onTapOfNumbersLine(int index) {
    for (int i = 0; i < digitRow.length; i++) {
      digitRow[i].isSelected = false;
    }
    digitRow[index].isSelected = true;
    digitRow.refresh();
    if (gameMode.value.name!.toUpperCase() == "SINGLE PANA BULK") {
      panaSwitchCase(jsonModel.singlePana!.single, index);
    } else {
      panaSwitchCase(jsonModel.doublePana!.single, index);
    }
    digitList.refresh();
  }

  Future<void> loadJsonFile() async {
    final String response =
        await rootBundle.loadString('assets/JSON File/digit_file.json');
    final data = await json.decode(response);
    jsonModel = JsonFileModel.fromJson(data);
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
  }

  // void onTapNumberList(index) {
  //   if (digitList[index].isSelected == false) {
  //     onTapOfDigitTile(index);
  //     digitList[index].isSelected = true;
  //   } else {
  //     digitList[index].isSelected = false;
  //     onLongPressDigitTile(index);
  //   }
  // }
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
      newList.add(digitList[index].coins!.toInt());
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
            StarLineBids(
              bidNo: digitList[index].value,
              coins: int.parse(coinController.text),
              starlineGameId: gameMode.value.id,
              remarks:
                  "You invested At ${marketData.value.time} on ${digitList[index].value} (${gameMode.value.name})",
            ),
          );
          //_calculateTotalAmount();
        }
      } else {
        selectedBidsList.add(
          StarLineBids(
            bidNo: digitList[index].value,
            coins: int.parse(coinController.text),
            starlineGameId: gameMode.value.id,
            remarks:
                "You invested At ${marketData.value.time} on ${digitList[index].value} (${gameMode.value.name})",
          ),
        );
      }
      print("============ ${selectedBidsList.toList()}");
      _calculateTotalAmount();
    } else {
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

  void onSearch(val) {
    debugPrint(val);
    digitList.refresh();
    debugPrint(" ===== ${gameMode.value.id}=====");
    List<DigitListModelOffline> tempList = digitList;
    if (val.toString().isNotEmpty) {
      var searchResultList = tempList
          .where((element) => element.value
              .toString()
              .toLowerCase()
              .trim()
              .contains(val.toString().toLowerCase().trim()))
          .toList();
      searchResultList.toSet().toList();
      digitList.value = searchResultList;
    } else {
      debugPrint(" ===== Empty search bar =====");
      debugPrint(" ===== ${gameMode.value.id}=====");
      switch (gameMode.value.id) {
        case 5:
          digitList.value = singleAnkList;
          break;
        case 6:
          panaSwitchCase(jsonModel.singlePana!.single, selectedIndexOfDigitRow);
          break;
        case 7:
          panaSwitchCase(jsonModel.doublePana!.single, selectedIndexOfDigitRow);
          break;
        default:
          AppUtils.showErrorSnackBar(bodyText: "SOMETHINGWENTWRONG".tr);
          break;
      }
    }
  }
}
