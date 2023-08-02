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
import '../../../models/commun_models/user_details_model.dart';
import '../../../models/starline_daily_market_api_response.dart';
import '../../../models/starline_game_modes_api_response_model.dart';
import '../../Local Storage.dart';

class StarLineGamePageController extends GetxController {
  // var coinController = TextEditingController();
  var searchController = TextEditingController();

  RxBool showNumbersLine = false.obs;
  RxBool validCoinsEntered = false.obs;
  Timer? _debounce;

  RxString totalAmount = "00".obs;
  int selectedIndexOfDigitRow = 0;

  Rx<StarLineGameMod> gameMode = StarLineGameMod().obs;
  Rx<StarlineMarketData> marketData = StarlineMarketData().obs;

  var argument = Get.arguments;
  var selectedBidsList = <StarLineBids>[];
  JsonFileModel jsonModel = JsonFileModel();

  var digitList = <DigitListModelOffline>[].obs;

  var singleAnkList = <DigitListModelOffline>[];
  var jodiList = <DigitListModelOffline>[];
  var triplePanaList = <DigitListModelOffline>[];
  var singlePanaList = <DigitListModelOffline>[];
  var doublePanaList = <DigitListModelOffline>[];
  List<TextEditingController> coinController = [];
  List<FocusNode> focusNodes = [];
  List<int> newList = [];
  List<StarLineBids> jp = [];
  var getBIdType = "";
  var biddingType = "".obs;
  var marketName = "".obs;
  var marketTime = "".obs;
  var marketId = 0;
  bool getBidData = false;
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
  // var arguments = Get.arguments;
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
    for (var controller in coinController) {
      controller.dispose();
    }
    super.onClose();
  }

  ondebounce(index) {
    if (_debounce != null && _debounce!.isActive) {
      _debounce!.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 700), () {
      onTapOfDigitTile(index);
      digitList[index].isSelected = true;
      print("Text changed! Text: ${digitList[index].isSelected}");
    });
  }
  // void setContainerBorderColorForIndex(int index, Color color) {
  //   // Update the containerBorderColor value at the specified index
  //   containerBorderColor2[index] = color;

  //   // Trigger an update to rebuild the UI
  //   update();
  // }

  // Color getContainerBorderColor(int index) {
  //   if (index < 0 || index >= containerBorderColor2.length) {
  //     // Handle out-of-bounds index if necessary
  //     return Colors.black; // Default border color
  //   }
  //   return containerBorderColor2[index];
  // }

  void initializeTextControllers() {
    coinController.clear();
    for (int i = 0; i < digitList.length; i++) {
      coinController.add(TextEditingController());
    }
    print(coinController.length);
  }

  void setContainerBorderColor(Color color) {
    containerBorderColor.value = color;
  }

  // void setupFocusNodeListeners() {
  //   for (int i = 0; i < digitList.length; i++) {
  //     focusNodes[i].addListener(() {
  //       focusNodes[i].requestFocus();
  //     });
  //   }
  // }

  Future<void> getArguments() async {
    gameMode.value = argument['gameMode'];
    marketData.value = argument['marketData'];
    getBidData = argument['getBidData'];
    getBIdType = argument['getBIdType'];
    print(getBIdType);
    await loadJsonFile();
    switch (gameMode.value.name) {
      case "Single Digit":
        showNumbersLine.value = false;
        for (var e in jsonModel.singleAnk!) {
          singleAnkList.add(DigitListModelOffline.fromJson(e));
        }
        digitList.value = singleAnkList;
        initializeTextControllers();
        break;
      case "Jodi Digit":
        showNumbersLine.value = false;
        for (var e in jsonModel.jodi!) {
          jodiList.add(DigitListModelOffline.fromJson(e));
        }
        digitList.value = jodiList;
        initializeTextControllers();
        break;
      case "Single Pana":
        digitRow.first.isSelected = true;
        showNumbersLine.value = true;

        for (var e in jsonModel.singlePana!.single.l0!) {
          singlePanaList.add(DigitListModelOffline.fromJson(e));
        }
        digitList.value = singlePanaList;
        initializeTextControllers();
        break;
      case "Double Pana":
        digitRow.first.isSelected = true;
        showNumbersLine.value = true;
        for (var e in jsonModel.doublePana!.single.l0!) {
          doublePanaList.add(DigitListModelOffline.fromJson(e));
        }
        digitList.value = doublePanaList;
        initializeTextControllers();
        break;
      case "Tripple Pana":
        showNumbersLine.value = false;
        for (var e in jsonModel.triplePana!) {
          triplePanaList.add(DigitListModelOffline.fromJson(e));
        }
        digitList.value = triplePanaList;
        initializeTextControllers();
        break;
    }
    // var data = await LocalStorage.read(ConstantsVariables.userData);
    // UserDetailsModel userData = UserDetailsModel.fromJson(data);
    // requestModel.userId = userData.id;
    // requestModel.bidType = biddingType.value;
    // requestModel.dailyMarketId = marketId;
  }

  void onTapOfSaveButton() async {
    if (selectedBidsList.isNotEmpty) {
      await LocalStorage.write(ConstantsVariables.boolData, true);
      Get.offAndToNamed(AppRoutName.starLineGameModesPage, arguments: {
        "bidsList": selectedBidsList,
        "gameMode": gameMode.value,
        "marketData": marketData.value,
        // "biddingType": biddingType.value,
        // "marketName": marketName.value,
        // "marketId": marketId,
        // "totalAmount": totalAmount.value,
      })?.then((value) => selectedBidsList.clear());
      for (int i = 0; i < digitList.length; i++) {
        digitList[i].isSelected = false;
      }
      digitList.refresh();
      // coinController.clear();
    } else {
      AppUtils.showErrorSnackBar(
        bodyText: "Please add some bids!",
      );
    }
  }

  void onTapOfNumbersLine(int index) {
    for (int i = 0; i < digitRow.length; i++) {
      digitRow[i].isSelected = false;
    }
    digitRow[index].isSelected = true;
    digitRow.refresh();
    if (gameMode.value.name == "Single Pana") {
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
    switch (index) {
      case 0:
        for (var e in panaList.l0!) {
          tempList.add(DigitListModelOffline.fromJson(e));
        }
        break;
      case 1:
        for (var e in panaList.l1!) {
          tempList.add(DigitListModelOffline.fromJson(e));
        }
        break;
      case 2:
        for (var e in panaList.l2!) {
          tempList.add(DigitListModelOffline.fromJson(e));
        }
        break;
      case 3:
        for (var e in panaList.l3!) {
          tempList.add(DigitListModelOffline.fromJson(e));
        }
        break;
      case 4:
        for (var e in panaList.l4!) {
          tempList.add(DigitListModelOffline.fromJson(e));
        }
        break;
      case 5:
        for (var e in panaList.l5!) {
          tempList.add(DigitListModelOffline.fromJson(e));
        }
        break;
      case 6:
        for (var e in panaList.l6!) {
          tempList.add(DigitListModelOffline.fromJson(e));
        }
        break;
      case 7:
        for (var e in panaList.l7!) {
          tempList.add(DigitListModelOffline.fromJson(e));
        }
        break;
      case 8:
        for (var e in panaList.l8!) {
          tempList.add(DigitListModelOffline.fromJson(e));
        }
        break;
      case 9:
        for (var e in panaList.l9!) {
          tempList.add(DigitListModelOffline.fromJson(e));
        }
        break;
      default:
        for (var e in panaList.l0!) {
          tempList.add(DigitListModelOffline.fromJson(e));
        }
        break;
    }
    digitList.value = tempList;
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
    if (coinController[index].text.isNotEmpty) {
      if (!validCoinsEntered.value) {
        AppUtils.showErrorSnackBar(bodyText: "Please enter valid coins");
        return;
      }
      int tempCoins = int.parse("${digitList[index].coins}");
      digitList[index].coins =
          tempCoins + int.parse(coinController[index].text);
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
              coins: int.parse(coinController[index].text),
              starlineGameId: gameMode.value.id,
              remarks:
                  "You invested At ${marketData.value.time} on ${digitList[index].value} (${gameMode.value.name})",
            ),
          );
        }
      } else {
        selectedBidsList.add(
          StarLineBids(
            bidNo: digitList[index].value,
            coins: int.parse(coinController[index].text),
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
}
