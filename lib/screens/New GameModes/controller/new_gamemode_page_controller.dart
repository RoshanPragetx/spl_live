import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/ui_utils.dart';
import 'package:spllive/routes/app_routes_name.dart';
import '../../../Custom Controllers/wallet_controller.dart';
import '../../../api_services/api_service.dart';
import '../../../api_services/api_urls.dart';
import '../../../helper_files/app_colors.dart';
import '../../../helper_files/constant_variables.dart';
import '../../../helper_files/custom_text_style.dart';
import '../../../helper_files/dimentions.dart';
import '../../../models/commun_models/bid_request_model.dart';
import '../../../models/commun_models/digit_list_model.dart';
import '../../../models/commun_models/json_file_model.dart';
import '../../../models/commun_models/user_details_model.dart';
import '../../../models/game_modes_api_response_model.dart';
import '../../../models/new_game_model.dart';
import '../../Local Storage.dart';

class NewGamemodePageController extends GetxController {
  var coinController = TextEditingController();
  TextEditingController digitController = TextEditingController();

  var biddingType = "".obs;
  var marketName = "".obs;
  var marketId = 0;
  var selectedBidsList = <Bids>[].obs;
  var digitList = <DigitListModelOffline>[].obs;
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

  Rx<GameMode> gameMode = GameMode().obs;
  List<String> _validationListForNormalMode = [];
  TextEditingController autoCompleteFieldController = TextEditingController();
  Model2 newgameModel = Model2();
  String bidType = "Open";
  var argument = Get.arguments;
  JsonFileModel jsonModel = JsonFileModel();
  Rx<BidRequestModel> requestModel = BidRequestModel().obs;
  RxBool isBulkMode = false.obs;
  late FocusNode focusNode;
  RxInt panaControllerLength = 2.obs;
  bool enteredDigitsIsValidate = false;
  String addedNormalBidValue = "";
  String newGameModeBidValue = "";
  var spdptpList = [];
  String spValue = "SP";
  String dpValue = "DP";
  String tpValue = "TP";
  RxBool spValue1 = false.obs;
  RxBool dpValue2 = false.obs;
  RxBool tpValue3 = false.obs;
  List<String> selectedValues = [];
  var apiUrl = "";
  RxString totalAmount = "0".obs;
  Rx<GameModesApiResponseModel> gameModeList = GameModesApiResponseModel().obs;
  Timer? _debounce;
  var redBrackelist = [
    "11",
    "22",
    "33",
    "44",
    "55",
    "66",
    "77",
    "88",
    "99",
    "00"
  ];

  @override
  void onInit() {
    super.onInit();
    getArguments();
    focusNode = FocusNode();
  }

  ondebounce(bool validate, String value) {
    if (_debounce != null && _debounce!.isActive) {
      _debounce!.cancel();
    }
    Timer(const Duration(milliseconds: 800), () {
      enteredDigitsIsValidate = validate;
      addedNormalBidValue = value;
      newGamemodeValidation(validate, value);
    });
  }

  void validateEnteredDigit(bool validate, String value) {
    enteredDigitsIsValidate = validate;
    addedNormalBidValue = value;
    if (!isBulkMode.value && value.length == panaControllerLength.value) {
      focusNode.nextFocus();
    }
  }

  void _calculateTotalAmount() {
    var tempTotal = 0;
    for (var element in selectedBidsList) {
      tempTotal += element.coins ?? 0;
    }
    totalAmount.value = tempTotal.toString();
  }

  void onDeleteBids(int index) {
    selectedBidsList.remove(selectedBidsList[index]);
    selectedBidsList.refresh();
    _calculateTotalAmount();
  }

  // checkbidType() {
  //   // print(addedNormalBidValue);
  //   //  print(gameMode.value.id);
  //   int count = 1;
  //   for (int i = 0; i < addedNormalBidValue.length; i++) {
  //     if (addedNormalBidValue.lastIndexOf(addedNormalBidValue[i]) != i) {
  //       count += 1;
  //     }
  //   }
  //   // print("Count : $count");
  //   return count;
  // }

  // checkPanaType() {
  //   var panaType = checkbidType();
  //   if (panaType == 1) {
  //     // return
  //   } else if (panaType == 2) {
  //     // print("doublePana");
  //     return panaType = gameMode.value.id;
  //   } else {
  //     //  print("tripplePana");
  //     return panaType = gameMode.value.id;
  //   }
  // }

  void onTapOfAddButton() {
    // FocusManager.instance.primaryFocus?.unfocus();
    isBulkMode.value = false;
    print(requestModel.value.dailyMarketId);
    if (!isBulkMode.value) {
      if (_validationListForNormalMode.contains(addedNormalBidValue) == false) {
        AppUtils.showErrorSnackBar(
          bodyText: "Please enter valid ${gameMode.value.name!.toLowerCase()}",
        );
        autoCompleteFieldController.clear();
        coinController.clear();
        focusNode.previousFocus();
      } else if (coinController.text.trim().isEmpty ||
          int.parse(coinController.text.trim()) < 1) {
        AppUtils.showErrorSnackBar(
          bodyText: "Please enter valid points",
        );
        autoCompleteFieldController.clear();
        coinController.clear();
        focusNode.previousFocus();
      } else if (int.parse(coinController.text) > 10000) {
        AppUtils.showErrorSnackBar(
          bodyText: "You can not add more than 10000 points",
        );
      } else {
        if (spdptpList.isEmpty) {
          var existingIndex = selectedBidsList
              .indexWhere((element) => element.bidNo == addedNormalBidValue);
          if (existingIndex != -1) {
            // If the bidNo already exists in selectedBidsList, update coins value.
            selectedBidsList[existingIndex].coins =
                (selectedBidsList[existingIndex].coins! +
                    int.parse(coinController.text));
          } else {
            selectedBidsList.add(
              Bids(
                bidNo: addedNormalBidValue,
                coins: int.parse(coinController.text),
                gameId: gameMode.value.id,
                subGameId: gameMode.value.id,
                gameModeName: gameMode.value.name,
                remarks:
                    "You invested At ${marketName.value} on $addedNormalBidValue (${gameMode.value.name})",
              ),
            );
          }
        }
        print("===== selectedBidsList =======");
        // print(selectedBidsList.toList());
        _calculateTotalAmount();
        autoCompleteFieldController.clear();
        coinController.clear();
        selectedBidsList.refresh();
        focusNode.previousFocus();
      }
    } else {
      if (!enteredDigitsIsValidate) {
        AppUtils.showErrorSnackBar(
          bodyText: "Please enter valid ${gameMode.value.name!.toLowerCase()}",
        );
        return;
      } else if (addedNormalBidValue.isEmpty) {
        AppUtils.showErrorSnackBar(
          bodyText: "Please enter ${gameMode.value.name!.toLowerCase()}",
        );
        return;
      } else if (coinController.text.isEmpty ||
          int.parse(coinController.text.trim()) < 1) {
        AppUtils.showErrorSnackBar(
          bodyText: "Please enter valid points",
        );
        return;
      } else if (int.parse(coinController.text) > 10000) {
        AppUtils.showErrorSnackBar(
          bodyText: "You can not add more than 10000 points",
        );
      } else {
        var existingIndex = selectedBidsList
            .indexWhere((element) => element.bidNo == addedNormalBidValue);
        if (existingIndex != -1) {
          // If the bidNo already exists in selectedBidsList, update coins value.
          selectedBidsList[existingIndex].coins =
              (selectedBidsList[existingIndex].coins! +
                  int.parse(coinController.text));
        } else {
          selectedBidsList.add(
            Bids(
              bidNo: addedNormalBidValue,
              coins: int.parse(coinController.text),
              gameId: gameMode.value.id,
              subGameId: gameMode.value.id,
              gameModeName: gameMode.value.name,
              remarks:
                  "You invested At ${marketName.value} on $addedNormalBidValue (${gameMode.value.name})",
            ),
          );
        }
        print("selectebidlist : $selectedBidsList");
        autoCompleteFieldController.clear();
        coinController.clear();
        selectedBidsList.refresh();
      }
    }

    ///  print(requestModel.toJson());
    // for (var index in selectedBidsList) {
    //   print(
    //       "${index.bidNo} ${index.gameId} ${index.gameModeName} ${index.subGameId} ");
    //   // print("checkPanaType() ${checkPanaType()}");
    // }
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

                selectedBidsList.clear();
                coinController.clear();
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

  Future<void> onTapOfSaveButton(context) async {
    if (selectedBidsList.isNotEmpty) {
      requestModel.value.bids = selectedBidsList;
      showConfirmationDialog(context);
    } else {
      AppUtils.showErrorSnackBar(
        bodyText: "Please add some bids!",
      );
    }
  }

  void createMarketBidApi() async {
    ApiService().createMarketBid(requestModel.toJson()).then((value) async {
      debugPrint("create bid api response :- $value");
      if (value['status']) {
        // Get.back();
        // Get.back();
        if (value['data'] == false) {
          selectedBidsList.clear();
          Get.offAndToNamed(AppRoutName.dashBoardPage);
          AppUtils.showErrorSnackBar(
            bodyText: value['message'] ?? "",
          );
        } else {
          Get.offAndToNamed(AppRoutName.dashBoardPage);
          AppUtils.showSuccessSnackBar(
              bodyText: value['message'] ?? "",
              headerText: "SUCCESSMESSAGE".tr);
          final walletController = Get.find<WalletController>();
          walletController.getUserBalance();
          walletController.walletBalance.refresh();
        }
      } else {
        AppUtils.showErrorSnackBar(
          bodyText: value['message'] ?? "",
        );
      }
    });
  }

  void getArguments() async {
    gameModeList = argument['gameModeList'];
    print(
        "gameModeList : ${gameModeList.value.data?.gameMode!.elementAt(0).name}");
    gameMode.value = argument['gameMode'];
    biddingType.value = argument['biddingType'];
    marketName.value = argument['marketName'];
    marketId = argument['marketId'];
    isBulkMode.value = argument['isBulkMode'];
    // marketData.value = argument['marketData'];
    // requestModel.value.dailyMarketId = marketData.value.id;
    requestModel.value.bidType = bidType;
    var data = await LocalStorage.read(ConstantsVariables.userData);
    UserDetailsModel userData = UserDetailsModel.fromJson(data);
    requestModel.value.userId = userData.id;
    requestModel.value.bidType = biddingType.value;
    requestModel.value.dailyMarketId = marketId;

    await loadJsonFile();
    RxBool showNumbersLine = false.obs;
    RxList<String> suggestionList = <String>[].obs;
    List<String> _tempValidationList = [];

    switch (gameMode.value.name) {
      case "Single Ank":
        showNumbersLine.value = false;
        panaControllerLength.value = 1;
        _tempValidationList = jsonModel.singleAnk!;
        suggestionList.value = jsonModel.singleAnk!;
        enteredDigitsIsValidate = true;
        panaControllerLength.value = 1;
        for (var e in jsonModel.singleAnk!) {
          singleAnkList.add(DigitListModelOffline.fromJson(e));
        }
        digitList.value = singleAnkList;
        break;
      case "Jodi":
        showNumbersLine.value = false;
        _tempValidationList = jsonModel.jodi!;
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
        _tempValidationList = jsonModel.allSinglePana!;
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
        _tempValidationList = jsonModel.allDoublePana!;
        suggestionList.value = jsonModel.doublePana!.single.l0!;
        for (var e in jsonModel.doublePana!.single.l0!) {
          doublePanaList.add(DigitListModelOffline.fromJson(e));
        }
        digitList.value = doublePanaList;
        break;
      case "Tripple Pana":
        showNumbersLine.value = false;
        _tempValidationList = jsonModel.triplePana!;
        suggestionList.value = jsonModel.triplePana!;
        panaControllerLength.value = 3;
        for (var e in jsonModel.triplePana!) {
          triplePanaList.add(DigitListModelOffline.fromJson(e));
        }
        digitList.value = triplePanaList;
        break;
      case "SPDPTP":
        apiUrl = ApiUtils.spdptp;
        showNumbersLine.value = false;
        // _tempValidationList = jsonModel.triplePana!;
        // suggestionList.value = jsonModel.triplePana!;
        for (var e in spdptpList) {
          _tempValidationList = e;
        }
        panaControllerLength.value = 1;

        // digitList.value = triplePanaList;
        break;
      case "Panel Group":
        showNumbersLine.value = false;
        apiUrl = ApiUtils.panelGroup;
        panaControllerLength.value = 3;
        //   _tempValidationList == jsonModel.allSinglePana;
        break;

      case "SP Motor":
        showNumbersLine.value = false;
        apiUrl = ApiUtils.spMotor;
        panaControllerLength.value = 9;
        break;
      case "DP Motor":
        showNumbersLine.value = false;
        apiUrl = ApiUtils.dpMotor;
        panaControllerLength.value = 9;
        break;
      case "Two Digits Panel":
        showNumbersLine.value = false;
        apiUrl = ApiUtils.towDigitJodi;
        panaControllerLength.value = 2;
        break;
      case "Red Brackets":
        showNumbersLine.value = false;
        _tempValidationList = redBrackelist;
        suggestionList.value = redBrackelist;
        panaControllerLength.value = 2;
        break;
      case "Group Jodi":
        showNumbersLine.value = false;
        apiUrl = ApiUtils.groupJody;
        print(apiUrl);
        panaControllerLength.value = 2;
        break;
    }
    _validationListForNormalMode.addAll(_tempValidationList);
  }

  Future<void> loadJsonFile() async {
    final String response =
        await rootBundle.loadString('assets/JSON File/digit_file.json');
    final data = await json.decode(response);
    jsonModel = JsonFileModel.fromJson(data);
  }

  Future<Map> spdptpbody() async {
    String panaType = selectedValues.join(',');
    print(panaType);
    final a = {"digit": autoCompleteFieldController.text, "panaType": panaType};
    final b = {"pana": autoCompleteFieldController.text};
    if (gameMode.value.name == "Panel Group") {
      return b;
    } else {
      return a;
    }
  }

  newGamemodeValidation(bool validate, String value) {
    if (autoCompleteFieldController.text.isEmpty) {
      AppUtils.showErrorSnackBar(
        bodyText: "Please enter ${gameMode.value.name!.toLowerCase()}",
      );
    } else if (gameMode.value.name == "Red Brackets") {
      if (autoCompleteFieldController.text.length < 2) {
        AppUtils.showErrorSnackBar(
          bodyText: "Please enter ${gameMode.value.name!.toLowerCase()}",
        );
      }
    } else if (gameMode.value.name == "SPDPTP") {
      if (spValue1.value == false &&
          dpValue2.value == false &&
          tpValue3.value == false) {
        AppUtils.showErrorSnackBar(
          bodyText: "Please Check SP or DP Values}",
        );
      } else if (autoCompleteFieldController.text.isEmpty) {
        AppUtils.showErrorSnackBar(
          bodyText: "Please enter ${gameMode.value.name!.toLowerCase()}",
        );
      }
    }
    enteredDigitsIsValidate = validate;
    // addedNormalBidValue = value;
    if (value.length == panaControllerLength.value) {
      focusNode.nextFocus();
    }
  }

  void getspdptp() async {
    if (gameMode.value.name == "SPDPTP") {
      if (spValue1.value == false &&
          dpValue2.value == false &&
          tpValue3.value == false) {
        AppUtils.showErrorSnackBar(
          bodyText: "Please Check SP or DP Values",
        );
      } else {
        ApiService().newGameModeApi(await spdptpbody(), apiUrl).then(
          (value) async {
            debugPrint("New Game-Mode Api Response :- $value");
            if (value['status']) {
              spdptpList = value['data'];
              //_validationListForNormalMode = newarrr;
              if (coinController.text.trim().isEmpty ||
                  int.parse(coinController.text.trim()) < 1) {
                AppUtils.showErrorSnackBar(
                  bodyText: "Please enter valid points",
                );
              } else if (int.parse(coinController.text) > 10000) {
                AppUtils.showErrorSnackBar(
                  bodyText: "You can not add more than 10000 points",
                );
              } else {
                if (spdptpList.isEmpty) {
                  AppUtils.showErrorSnackBar(
                    bodyText:
                        "Please enter ${gameMode.value.name!.toLowerCase()}",
                  );
                } else {
                  print("======= List not empty =====");
                  // print(spdptpList);
                  //  var gameArr = gameModeList;
                  // print("Jevin");
                  // print(gameModeList);
                  //  for (var i = 0; i < spdptpList.length; i++) {
                  //     Roshan
                  //   int checkPanaType(String digit) {
                  //     int count = 1;
                  //     for (int i = 0; i < digit.length; i++) {
                  //       if (digit.lastIndexOf(digit[i]) != i) {
                  //         count += 1;
                  //       }
                  //     }
                  //     return count;
                  //}
                  //   String determinePanaType(String digit) {
                  //     int panaType = checkPanaType(digit);
                  //     if (panaType == 1) {
                  //       return 'singlePana';
                  //     } else if (panaType == 2) {
                  //       return 'doublePana';
                  //     } else {
                  //       return 'tripplePana';
                  //     }
                  //   }

                  // check pana type
                  // var count = 1;
                  // for (var i = 0; i < spdptpList.length; i++) {
                  //   if (spdptpList.lastIndexOf(spdptpList[i]) != i) {
                  //     count += 1;
                  //   }
                  // }

//               var obj = gameArr
// .where((oldValue) => "Single Pana" == (oldValue.name));
//               print(obj.elementAt(0).name);

                  // if (count == 1) {
                  //   // singlePana
                  // } else if (count == 2) {
                  //   // doublePana
                  // } else {
                  //   // tripplePana
                  // }
                  // }
                  //   print(spdptpList[i].toString());
                  // selectedBidsList.add(
                  //   Bids(
                  //     bidNo: spdptpList[i].toString(),
                  //     coins: int.parse(coinController.text),
                  //     gameId: gameMode.value.id,
                  //     subGameId: gameMode.value.id,
                  //     gameModeName: gameMode.value.name,
                  //     remarks:
                  //         "You invested At ${marketName.value} on $addedNormalBidValue (${gameMode.value.name})",
                  //   ),
                  // );
                  for (var i = 0; i < spdptpList.length; i++) {
                    addedNormalBidValue = spdptpList[i].toString();
                    var existingIndex = selectedBidsList.indexWhere(
                        (element) => element.bidNo == addedNormalBidValue);

                    if (existingIndex != -1) {
                      // If the bidNo already exists in selectedBidsList, update coins value.
                      selectedBidsList[existingIndex].coins =
                          (selectedBidsList[existingIndex].coins! +
                              int.parse(coinController.text));
                    } else {
                      selectedBidsList.add(
                        Bids(
                          bidNo: addedNormalBidValue,
                          coins: int.parse(coinController.text),
                          gameId: gameMode.value.id,
                          subGameId: gameMode.value.id,
                          gameModeName: gameMode.value.name,
                          remarks:
                              "You invested At ${marketName.value} on $addedNormalBidValue (${gameMode.value.name})",
                        ),
                      );
                    }
                  }
                  print("===== selectedBidsList =======");
                  // print(selectedBidsList.toJson());
                }
                _calculateTotalAmount();
                selectedBidsList.refresh();
              }
              // print(spdptpList);
            } else {
              AppUtils.showErrorSnackBar(
                bodyText: value['message'] ?? "",
              );
            }
            autoCompleteFieldController.clear();
            coinController.clear();
            selectedBidsList.refresh();
          },
        );
      }
    } else {
      ApiService().newGameModeApi(await spdptpbody(), apiUrl).then(
        (value) async {
          debugPrint("New Game-Mode Api Response :- $value");
          if (value['status']) {
            spdptpList = value['data'];
            //_validationListForNormalMode = newarrr;
            if (coinController.text.trim().isEmpty ||
                int.parse(coinController.text.trim()) < 1) {
              AppUtils.showErrorSnackBar(
                bodyText: "Please enter valid points",
              );
            } else if (int.parse(coinController.text) > 10000) {
              AppUtils.showErrorSnackBar(
                bodyText: "You can not add more than 10000 points",
              );
            } else {
              if (spdptpList.isEmpty) {
                AppUtils.showErrorSnackBar(
                  bodyText:
                      "Please enter valid ${gameMode.value.name!.toLowerCase()}",
                );
              } else {
                print("======= List not empty =====");
                // print(spdptpList);
                //  var gameArr = gameModeList;
                // print("Jevin");
                // print(gameModeList);
                //  for (var i = 0; i < spdptpList.length; i++) {
                //     Roshan
                //   int checkPanaType(String digit) {
                //     int count = 1;
                //     for (int i = 0; i < digit.length; i++) {
                //       if (digit.lastIndexOf(digit[i]) != i) {
                //         count += 1;
                //       }
                //     }
                //     return count;
                //}
                //   String determinePanaType(String digit) {
                //     int panaType = checkPanaType(digit);
                //     if (panaType == 1) {
                //       return 'singlePana';
                //     } else if (panaType == 2) {
                //       return 'doublePana';
                //     } else {
                //       return 'tripplePana';
                //     }
                //   }

                // check pana type
                // var count = 1;
                // for (var i = 0; i < spdptpList.length; i++) {
                //   if (spdptpList.lastIndexOf(spdptpList[i]) != i) {
                //     count += 1;
                //   }
                // }

//               var obj = gameArr
// .where((oldValue) => "Single Pana" == (oldValue.name));
//               print(obj.elementAt(0).name);

                // if (count == 1) {
                //   // singlePana
                // } else if (count == 2) {
                //   // doublePana
                // } else {
                //   // tripplePana
                // }
                // }
                //   print(spdptpList[i].toString());
                // selectedBidsList.add(
                //   Bids(
                //     bidNo: spdptpList[i].toString(),
                //     coins: int.parse(coinController.text),
                //     gameId: gameMode.value.id,
                //     subGameId: gameMode.value.id,
                //     gameModeName: gameMode.value.name,
                //     remarks:
                //         "You invested At ${marketName.value} on $addedNormalBidValue (${gameMode.value.name})",
                //   ),
                // );

                for (var i = 0; i < spdptpList.length; i++) {
                  addedNormalBidValue = spdptpList[i].toString();
                  var existingIndex = selectedBidsList.indexWhere(
                      (element) => element.bidNo == addedNormalBidValue);

                  if (existingIndex != -1) {
                    // If the bidNo already exists in selectedBidsList, update coins value.
                    selectedBidsList[existingIndex].coins =
                        (selectedBidsList[existingIndex].coins! +
                            int.parse(coinController.text));
                  } else {
                    selectedBidsList.add(
                      Bids(
                        bidNo: addedNormalBidValue,
                        coins: int.parse(coinController.text),
                        gameId: gameMode.value.id,
                        subGameId: gameMode.value.id,
                        gameModeName: gameMode.value.name,
                        remarks:
                            "You invested At ${marketName.value} on $addedNormalBidValue (${gameMode.value.name})",
                      ),
                    );
                  }
                }

                print("===== selectedBidsList =======");
                // print(selectedBidsList.toJson());
              }
              _calculateTotalAmount();
              //selectedBidsList.refresh();
            }
            // print(spdptpList);
          } else {
            AppUtils.showErrorSnackBar(
              bodyText: value['message'] ?? "",
            );
          }
          autoCompleteFieldController.clear();
          coinController.clear();
          selectedBidsList.refresh();
        },
      );
    }
  }

  Future<Map> panelGroupBody() async {
    final a = {
      "pana": autoCompleteFieldController.text,
    };
    return a;
  }

  void getpanelData() async {
    ApiService().newGameModeApi(await panelGroupBody(), apiUrl).then(
      (value) async {
        debugPrint("Forgot MPIN Api Response :- $value");
        if (value['status']) {
          spdptpList = value['data'];
          if (coinController.text.trim().isEmpty ||
              int.parse(coinController.text.trim()) < 1) {
            AppUtils.showErrorSnackBar(
              bodyText: "Please enter valid points",
            );
            return;
          } else if (int.parse(coinController.text) > 10000) {
            AppUtils.showErrorSnackBar(
              bodyText: "You can not add more than 10000 points",
            );
            return;
          } else if (autoCompleteFieldController.text.trim().isEmpty) {
            AppUtils.showErrorSnackBar(
              bodyText: "Please enter ${gameMode.value.name!.toLowerCase()}",
            );
            return;
          } else {
            if (spdptpList.isEmpty) {
              for (var i = 0; i < spdptpList.length; i++) {
                selectedBidsList.add(
                  Bids(
                    bidNo: spdptpList[i].toString(),
                    coins: int.parse(coinController.text),
                    gameId: gameMode.value.id,
                    subGameId: gameMode.value.id,
                    gameModeName: gameMode.value.name,
                    remarks:
                        "You invested At ${marketName.value} on $addedNormalBidValue (${gameMode.value.name})",
                  ),
                );
              }
              autoCompleteFieldController.clear();
              coinController.clear();
              selectedBidsList.refresh();
              focusNode.previousFocus();
            } else {
              for (var i = 0; i < spdptpList.length; i++) {
                selectedBidsList.add(
                  Bids(
                    bidNo: spdptpList[i].toString(),
                    coins: int.parse(coinController.text),
                    gameId: gameMode.value.id,
                    subGameId: gameMode.value.id,
                    gameModeName: gameMode.value.name,
                    remarks:
                        "You invested At ${marketName.value} on $addedNormalBidValue (${gameMode.value.name})",
                  ),
                );
              }
            }
          }
          _calculateTotalAmount();
          selectedBidsList.refresh();
        } else {
          AppUtils.showErrorSnackBar(
            bodyText: value['message'] ?? "",
          );
        }
        autoCompleteFieldController.clear();
        coinController.clear();
        selectedBidsList.refresh();
        focusNode.previousFocus();
      },
    );
  }

  Future<Map> spMotorBody() async {
    final a = {
      "digit": autoCompleteFieldController.text,
    };
    return a;
  }

  void spMotorData() async {
    ApiService().newGameModeApi(await spMotorBody(), apiUrl).then(
      (value) async {
        debugPrint("Forgot MPIN Api Response :- $value");
        if (value['status']) {
          spdptpList = value['data'];
          if (spdptpList.isEmpty) {
            print("===== spdptpList empty =================");
            print(spdptpList);
          } else {
            print("======= List not empty =====");
            // print(spdptpList);
            for (var i = 0; i < spdptpList.length; i++) {
              print(spdptpList[i].toString());
              selectedBidsList.add(
                Bids(
                  bidNo: spdptpList[i].toString(),
                  coins: int.parse(coinController.text),
                  gameId: gameMode.value.id,
                  subGameId: gameMode.value.id,
                  gameModeName: gameMode.value.name,
                  remarks:
                      "You invested At ${marketName.value} on $addedNormalBidValue (${gameMode.value.name})",
                ),
              );
            }
            print("===== selectedBidsList =======");
            print(selectedBidsList.toJson());
          }
          // print(spdptpList);
        } else {
          AppUtils.showErrorSnackBar(
            bodyText: value['message'] ?? "",
          );
        }
      },
    );
  }

  Future<Map> dpMotorBody() async {
    final a = {
      "digit": autoCompleteFieldController.text,
    };
    return a;
  }

  void dpMotorData() async {
    ApiService().newGameModeApi(await dpMotorBody(), apiUrl).then(
      (value) async {
        debugPrint("Forgot MPIN Api Response :- $value");
        if (value['status']) {
          spdptpList = value['data'];

          if (spdptpList.isEmpty) {
            print("===== spdptpList empty =================");
            print(spdptpList);
          } else {
            print("======= List not empty =====");
            // print(spdptpList);
            for (var i = 0; i < spdptpList.length; i++) {
// spdptpList[i].toString() pass this value in one fiunction which returm the type of the pana

// gameId
// Main game modes
// Single Ank, Jodi, Single Pana, Double Pana, Triple Pana
// Single Ank, Jodi,  Single Pana, Double Pana, ==> Bulk
// make once fucntion which takes  child game modes name and will return parent game modes with Id == GameId
// Panel Group, SDDPTP, Red Brackets, Choice Pana SPDP, SP Moter, DP Moter, Group Jodi, Digit Based Jodi,
// Odd Even
// make One function which will take pana as a parameter and will return pana type with parent game
// mode name ==? Sub game mode Id
              print(spdptpList[i].toString());
              selectedBidsList.add(
                Bids(
                  bidNo: spdptpList[i].toString(),
                  coins: int.parse(coinController.text),
                  gameId: gameMode.value.id,
                  subGameId: gameMode.value.id,
                  gameModeName: gameMode.value.name,
                  remarks:
                      "You invested At ${marketName.value} on $addedNormalBidValue (${gameMode.value.name})",
                ),
              );
            }
            print("===== selectedBidsList =======");
            print(selectedBidsList.toJson());
          }
          // print(spdptpList);
        } else {
          AppUtils.showErrorSnackBar(
            bodyText: value['message'] ?? "",
          );
        }
      },
    );
  }

  Future<Map> toDigitBody() async {
    final a = {
      "digit": autoCompleteFieldController.text,
    };
    return a;
  }

  void twoDigitData() async {
    ApiService().newGameModeApi(await toDigitBody(), apiUrl).then(
      (value) async {
        debugPrint("Forgot MPIN Api Response :- $value");
        if (value['status']) {
          spdptpList = value['data'];

          if (spdptpList.isEmpty) {
            selectedBidsList.add(
              Bids(
                bidNo: addedNormalBidValue,
                coins: int.parse(coinController.text),
                gameId: gameMode.value.id,
                subGameId: gameMode.value.id,
                gameModeName: gameMode.value.name,
                remarks:
                    "You invested At ${marketName.value} on $addedNormalBidValue (${gameMode.value.name})",
              ),
            );
          } else {
            print("======= List not empty =====");
            // print(spdptpList);
            for (var i = 0; i < spdptpList.length; i++) {
// spdptpList[i].toString() pass this value in one fiunction which returm the type of the pana

// gameId
// Main game modes
// Single Ank, Jodi, Single Pana, Double Pana, Triple Pana
// Single Ank, Jodi,  Single Pana, Double Pana, ==> Bulk
// make once fucntion which takes  child game modes name and will return parent game modes with Id == GameId
// Panel Group, SDDPTP, Red Brackets, Choice Pana SPDP, SP Moter, DP Moter, Group Jodi, Digit Based Jodi,
// Odd Even
// make One function which will take pana as a parameter and will return pana type with parent game
// mode name ==? Sub game mode Id
              //   print(gameModeList[0].data?.gameMode?[0].id);
              selectedBidsList.add(
                Bids(
                  bidNo: spdptpList[i].toString(),
                  coins: int.parse(coinController.text),
                  gameId: gameMode.value.id,
                  subGameId: gameMode.value.id,
                  gameModeName: gameMode.value.name,
                  remarks:
                      "You invested At ${marketName.value} on $addedNormalBidValue (${gameMode.value.name})",
                ),
              );
            }
            print("===== selectedBidsList =======");
            //  print(selectedBidsList.toJson());
          }
          // print(spdptpList);
        } else {
          AppUtils.showErrorSnackBar(
            bodyText: value['message'] ?? "",
          );
        }
      },
    );
  }

  Future<Map> groupJodiBody() async {
    final a = {
      "digit": autoCompleteFieldController.text,
    };
    return a;
  }

  void groupJodiData() async {
    ApiService().newGameModeApi(await groupJodiBody(), apiUrl).then(
      (value) async {
        debugPrint("Forgot MPIN Api Response :- $value");
        if (value['status']) {
          spdptpList = value['data'];
          if (spdptpList.isEmpty) {
            print("===== spdptpList empty =================");
            print(spdptpList);
          } else {
            print("======= List not empty =====");
            // print(spdptpList);
            for (var i = 0; i < spdptpList.length; i++) {
              print(spdptpList[i].toString());
              selectedBidsList.add(
                Bids(
                  bidNo: spdptpList[i].toString(),
                  coins: int.parse(coinController.text),
                  gameId: gameMode.value.id,
                  subGameId: gameMode.value.id,
                  gameModeName: gameMode.value.name,
                  remarks:
                      "You invested At ${marketName.value} on $addedNormalBidValue (${gameMode.value.name})",
                ),
              );
            }
            print("===== selectedBidsList =======");
          }
          // print(spdptpList);
        } else {
          AppUtils.showErrorSnackBar(
            bodyText: value['message'] ?? "",
          );
        }
      },
    );
  }
}
