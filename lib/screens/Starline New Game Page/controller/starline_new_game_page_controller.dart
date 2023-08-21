import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../Custom Controllers/wallet_controller.dart';
import '../../../api_services/api_service.dart';
import '../../../api_services/api_urls.dart';
import '../../../helper_files/app_colors.dart';
import '../../../helper_files/constant_variables.dart';
import '../../../helper_files/custom_text_style.dart';
import '../../../helper_files/dimentions.dart';
import '../../../helper_files/ui_utils.dart';
import '../../../models/commun_models/json_file_model.dart';
import '../../../models/commun_models/starline_bid_request_model.dart';
import '../../../models/commun_models/user_details_model.dart';
import '../../../models/starline_daily_market_api_response.dart';
import '../../../models/starline_game_modes_api_response_model.dart';
import '../../../routes/app_routes_name.dart';
import '../../Local Storage.dart';

class StarlineNewGamePageController extends GetxController {
  Rx<StarLineGameMod> gameMode = StarLineGameMod().obs;
  Rx<StarlineMarketData> marketData = StarlineMarketData().obs;
  RxString totalAmount = "00".obs;
  var getBIdType = "";
  bool getBidData = false;
  var argument = Get.arguments;
  JsonFileModel jsonModel = JsonFileModel();
  String spValue = "SP";
  String dpValue = "DP";
  String tpValue = "TP";
  RxBool spValue1 = false.obs;
  RxBool dpValue2 = false.obs;
  RxBool tpValue3 = false.obs;
  List<String> selectedValues = [];
  var coinController = TextEditingController();
  TextEditingController autoCompleteFieldController = TextEditingController();
  late FocusNode focusNode;
  Timer? _debounce;
  bool enteredDigitsIsValidate = false;
  String addedNormalBidValue = "";
  RxInt panaControllerLength = 2.obs;
  Rx<StarlineBidRequestModel> requestModel = StarlineBidRequestModel().obs;
//  Rx<StarlineMarketData> marketData = StarlineMarketData().obs;
  RxBool isBulkMode = false.obs;
  var spdptpList = [];
  var selectedBidsList = <StarLineBids>[].obs;
  var marketName = "".obs;
  List<String> _validationListForNormalMode = [];
  var apiUrl = "";
  RxBool oddbool = true.obs;
  RxBool evenbool = false.obs;
  var leftAnkController = TextEditingController();
  var rightAnkController = TextEditingController();
  var middleAnkController = TextEditingController();

  @override
  void onInit() {
    getArguments();
    super.onInit();
    focusNode = FocusNode();
  }

  @override
  void onClose() {
    requestModel.value.bids?.clear();
    selectedBidsList.clear();
  }

  @override
  void dispose() {
    leftAnkController.dispose();
    rightAnkController.dispose();
    middleAnkController.dispose();
    coinController.dispose();
    super.dispose();
  }

  void validateEnteredDigit(bool validate, String value) {
    enteredDigitsIsValidate = validate;
    addedNormalBidValue = value;
    if (value.length == panaControllerLength.value) {
      focusNode.nextFocus();
    }
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

  onTapAddOddEven() {
    for (var i = 0; i < 10; i++) {
      var bidNo = i.toString();
      var existingIndex =
          selectedBidsList.indexWhere((element) => element.bidNo == bidNo);
      var coins = int.parse(coinController.text);
      if (oddbool.value) {
        if (i % 2 != 0) {
          if (existingIndex != -1) {
            // If the bidNo already exists in selectedBidsList, update coins value.
            selectedBidsList[existingIndex].coins =
                (selectedBidsList[existingIndex].coins! + coins);
          } else {
            // If bidNo doesn't exist in selectedBidsList, add a new entry.
            selectedBidsList.add(
              StarLineBids(
                bidNo: bidNo,
                coins: coins,
                starlineGameId: gameMode.value.id,
                remarks:
                    "You invested At ${marketData.value.time} on $bidNo (${gameMode.value.name})",
              ),
            );
          }
          // selectedBidsList.add(
          //   StarLineBids(
          //     bidNo: i.toString(),
          //     coins: int.parse(coinController.text),
          //     starlineGameId: gameMode.value.id,
          //     //  gameModeName: gameMode.value.name,
          //     // subGameId: checkPanaType(),
          //     remarks:
          //         "You invested At ${marketName.value} on $i (${gameMode.value.name})",
          //   ),
          // );
        }
      } else {
        if (i % 2 == 0) {
          if (existingIndex != -1) {
            // If the bidNo already exists in selectedBidsList, update coins value.
            selectedBidsList[existingIndex].coins =
                (selectedBidsList[existingIndex].coins! + coins);
          } else {
            // If bidNo doesn't exist in selectedBidsList, add a new entry.
            selectedBidsList.add(
              StarLineBids(
                bidNo: bidNo,
                coins: coins,
                starlineGameId: gameMode.value.id,
                remarks:
                    "You invested At ${marketData.value.time} on $bidNo (${gameMode.value.name})",
              ),
            );
          }
          // selectedBidsList.add(
          //   StarLineBids(
          //     bidNo: i.toString(),
          //     coins: int.parse(coinController.text),
          //     starlineGameId: gameMode.value.id,
          //     // gameModeName: gameMode.value.name,
          //     // subGameId: checkPanaType(),
          //     remarks:
          //         "You invested At ${marketName.value} on $i (${gameMode.value.name})",
          //   ),
          // );
        }
      }
    }
    //autoCompleteFieldController.clear();
    coinController.clear();
    selectedBidsList.refresh();
    _calculateTotalAmount();
    //  focusNode.previousFcus();
  }

  void createMarketBidApi() async {
    print(marketData.value);
    ApiService()
        .createStarLineMarketBid(requestModel.value.toJson())
        .then((value) async {
      debugPrint("create starline bid api response :- $value");
      if (value['status']) {
        selectedBidsList.clear();
        Get.offAndToNamed(AppRoutName.dashBoardPage);
        if (value['data'] == false) {
          selectedBidsList.clear();
          Get.offAndToNamed(AppRoutName.dashBoardPage);
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
        final walletController = Get.find<WalletController>();
        walletController.getUserBalance();
        walletController.walletBalance.refresh();
      } else {
        AppUtils.showErrorSnackBar(
          bodyText: value['message'] ?? "",
        );
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
    gameMode.value = argument['gameMode'];
    marketData.value = argument['marketData'];
    requestModel.value.bids = argument['bidsList'];
    print("req model : ${requestModel.value.toJson()}");
    requestModel.refresh();
    _calculateTotalAmount();
    requestModel.value.dailyStarlineMarketId = marketData.value.id;
    var data = await LocalStorage.read(ConstantsVariables.userData);
    UserDetailsModel userData = UserDetailsModel.fromJson(data);
    requestModel.value.userId = userData.id;
    print(requestModel.value.toJson());
    print(getBIdType);
    await loadJsonFile();
    List<String> _tempValidationList = [];

    switch (gameMode.value.name) {
      case "Single Ank":
        // showNumbersLine.value = false;
        enteredDigitsIsValidate = true;
        panaControllerLength.value = 1;
        _tempValidationList = jsonModel.singleAnk!;
        // suggestionList.value = jsonModel.singleAnk!;
        // for (var e in jsonModel.singleAnk!) {
        //   singleAnkList.add(DigitListModelOffline.fromJson(e));
        // }
        // digitList.value = singleAnkList;
        //    initializeTextControllers();
        break;
      case "Single Pana":
        // showNumbersLine.value = false;
        // suggestionList.value = jsonModel.jodi!;
        panaControllerLength.value = 3;
        _tempValidationList = jsonModel.allSinglePana!;
        // for (var e in jsonModel.jodi!) {
        //   jodiList.add(DigitListModelOffline.fromJson(e));
        // }
        // digitList.value = jodiList;
        //   initializeTextControllers();
        break;
      case "Double Pana":
        panaControllerLength.value = 3;
        _tempValidationList = jsonModel.allDoublePana!;
        break;
      case "Tripple Pana":
        panaControllerLength.value = 3;
        _tempValidationList = jsonModel.triplePana!;
        break;
      case "Panel Group":
        panaControllerLength.value = 3;
        apiUrl = ApiUtils.panelGroup;
        break;
      case "SPDPTP":
        panaControllerLength.value = 1;

        apiUrl = ApiUtils.spdptp;
        break;
      case "Choice Pana SPDP":
        panaControllerLength.value = 1;
        apiUrl = ApiUtils.choicePanaSPDP;
        break;
      case "SP Motor":
        panaControllerLength.value = 9;
        apiUrl = ApiUtils.spMotor;
        break;
      case "DP Motor":
        panaControllerLength.value = 9;
        apiUrl = ApiUtils.dpMotor;
        break;
      case "Odd Even":
        panaControllerLength.value = 1;
        break;
      case "Two Digits Panel":
        apiUrl = ApiUtils.towDigitJodi;
        panaControllerLength.value = 2;
        break;
      //   case "Single Pana Bulk":
      //     digitRow.first.isSelected = true;
      //     showNumbersLine.value = true;
      //     panaControllerLength.value = 3;
      //     for (var e in jsonModel.singlePana!.single.l0!) {
      //       singlePanaList.add(DigitListModelOffline.fromJson(e));
      //     }
      //     digitList.value = singlePanaList;
      //     //  initializeTextControllers();
      //     break;
      //   case "Double Pana Bulk":
      //     digitRow.first.isSelected = true;
      //     showNumbersLine.value = true;
      //     panaControllerLength.value = 3;
      //     for (var e in jsonModel.doublePana!.single.l0!) {
      //       doublePanaList.add(DigitListModelOffline.fromJson(e));
      //     }
      //     digitList.value = doublePanaList;
      //     //  initializeTextControllers();
      //     break;
      //   case "Tripple Pana":
      //     showNumbersLine.value = false;
      //     suggestionList.value = jsonModel.triplePana!;
      //     panaControllerLength.value = 3;
      //     for (var e in jsonModel.triplePana!) {
      //       triplePanaList.add(DigitListModelOffline.fromJson(e));
      //     }
      //     digitList.value = triplePanaList;
      //     // initializeTextControllers();
      //     break;
    }
    _validationListForNormalMode.addAll(_tempValidationList);
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
    // LocalStorage.write(ConstantsVariables.bidsList,
    //     requestModel.value.bids!.map((v) => v.toJson()).toList());
    selectedBidsList.refresh();
    _calculateTotalAmount();
  }

  void onTapOfAddButton() {
    // FocusManager.instance.primaryFocus?.unfocus();
    isBulkMode.value = false;
    print(requestModel.value.dailyStarlineMarketId);
    if (!isBulkMode.value) {
      if (_validationListForNormalMode.contains(addedNormalBidValue) == false) {
        AppUtils.showErrorSnackBar(
          bodyText: "Please enter valid ${gameMode.value.name!.toLowerCase()}",
        );
        autoCompleteFieldController.clear();
        coinController.clear();
        selectedBidsList.refresh();
        focusNode.previousFocus();
      } else if (coinController.text.trim().isEmpty ||
          int.parse(coinController.text.trim()) < 1) {
        AppUtils.showErrorSnackBar(
          bodyText: "Please enter valid points",
        );
      } else if (int.parse(coinController.text) > 10000) {
        AppUtils.showErrorSnackBar(
          bodyText: "You can not add more than 10000 points",
        );
        autoCompleteFieldController.clear();
        coinController.clear();
        selectedBidsList.refresh();
        focusNode.previousFocus();
      } else {
        if (spdptpList.isEmpty) {
          // selectedBidsList.add(
          //   StarLineBids(
          //     bidNo: addedNormalBidValue,
          //     coins: int.parse(coinController.text),
          //     starlineGameId: gameMode.value.id,
          //     // subGameId: gameMode.value.id,
          //     // gameModeName: gameMode.value.name,
          //     remarks:
          //         "You invested At ${marketName.value} on $addedNormalBidValue (${gameMode.value.name})",
          //   ),
          // );
          var existingIndex = selectedBidsList
              .indexWhere((element) => element.bidNo == addedNormalBidValue);
          if (existingIndex != -1) {
            // If the bidNo already exists in selectedBidsList, update coins value.
            selectedBidsList[existingIndex].coins =
                (selectedBidsList[existingIndex].coins! +
                    int.parse(coinController.text));
          } else {
            // If bidNo doesn't exist in selectedBidsList, add a new entry.
            selectedBidsList.add(
              StarLineBids(
                bidNo: addedNormalBidValue,
                coins: int.parse(coinController.text),
                starlineGameId: gameMode.value.id,
                remarks:
                    "You invested At ${marketData.value.time} on $addedNormalBidValue (${gameMode.value.name})",
              ),
            );
          }
        } else {
          var existingIndex = selectedBidsList
              .indexWhere((element) => element.bidNo == addedNormalBidValue);
          if (existingIndex != -1) {
            // If the bidNo already exists in selectedBidsList, update coins value.
            selectedBidsList[existingIndex].coins =
                (selectedBidsList[existingIndex].coins! +
                    int.parse(coinController.text));
          } else {
            // If bidNo doesn't exist in selectedBidsList, add a new entry.
            selectedBidsList.add(
              StarLineBids(
                bidNo: addedNormalBidValue,
                coins: int.parse(coinController.text),
                starlineGameId: gameMode.value.id,
                remarks:
                    "You invested At ${marketData.value.time} on $addedNormalBidValue (${gameMode.value.name})",
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
        autoCompleteFieldController.clear();
        coinController.clear();
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
        autoCompleteFieldController.clear();
        coinController.clear();
        selectedBidsList.refresh();
        focusNode.previousFocus();
      } else {
        var existingIndex = selectedBidsList
            .indexWhere((element) => element.bidNo == addedNormalBidValue);
        if (existingIndex != -1) {
          // If the bidNo already exists in selectedBidsList, update coins value.
          selectedBidsList[existingIndex].coins =
              (selectedBidsList[existingIndex].coins! +
                  int.parse(coinController.text));
        } else {
          // If bidNo doesn't exist in selectedBidsList, add a new entry.
          selectedBidsList.add(
            StarLineBids(
              bidNo: addedNormalBidValue,
              coins: int.parse(coinController.text),
              starlineGameId: gameMode.value.id,
              remarks:
                  "You invested At ${marketData.value.time} on $addedNormalBidValue (${gameMode.value.name})",
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

  Future<Map> spdptpbody() async {
    String panaType = selectedValues.join(',');
    print(panaType);
    final a = {"digit": autoCompleteFieldController.text, "panaType": panaType};
    final b = {"pana": autoCompleteFieldController.text};
    final c = {
      "left": leftAnkController.text,
      "middle": middleAnkController.text,
      "right": rightAnkController.text,
      "panaType": panaType,
    };
    if (gameMode.value.name == "Panel Group") {
      return b;
    } else if (gameMode.value.name!.toUpperCase() == "CHOICE PANA SPDP") {
      return c;
    } else {
      return a;
    }
  }

  void getspdptp() async {
    if (gameMode.value.name == "Choice Pana SPDP") {
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
                      // If bidNo doesn't exist in selectedBidsList, add a new entry.
                      selectedBidsList.add(
                        StarLineBids(
                          bidNo: addedNormalBidValue,
                          coins: int.parse(coinController.text),
                          starlineGameId: gameMode.value.id,
                          remarks:
                              "You invested At ${marketData.value.time} on ${spdptpList[i]} (${gameMode.value.name})",
                        ),
                      );
                    }
                  }
                }
                _calculateTotalAmount();
              }
            } else {
              AppUtils.showErrorSnackBar(
                bodyText: value['message'] ?? "",
              );
            }
            autoCompleteFieldController.clear();
            leftAnkController.clear();
            rightAnkController.clear();
            middleAnkController.clear();
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
                // print("===== spdptpList empty =================");
                // print(spdptpList);
                // for (var i = 0; i < spdptpList.length; i++) {
                //   selectedBidsList.add(
                //     StarLineBids(
                //       bidNo: addedNormalBidValue,
                //       coins: int.parse(coinController.text),
                //       starlineGameId: gameMode.value.id,
                //       // gameModeName: gameMode.value.name,
                //       // subGameId: gameMode.value.id,
                //       remarks:
                //           "You invested At ${marketName.value} on $addedNormalBidValue (${gameMode.value.name})",
                //     ),
                //   );
                // }
              } else {
                print("======= List not empty =====");
                // print(spdptpList);
                //  var gameArr = gameModeList;
                // print("Jevin");
                // print(gameModeList);
//               for (var i = 0; i < spdptpList.length; i++) {
//                 print("spdptpList${spdptpList[i]}");
//                 //     Roshan
//                 //   int checkPanaType(String digit) {
//                 //     int count = 1;
//                 //     for (int i = 0; i < digit.length; i++) {
//                 //       if (digit.lastIndexOf(digit[i]) != i) {
//                 //         count += 1;
//                 //       }
//                 //     }
//                 //     return count;
//                 //   }

//                 //   String determinePanaType(String digit) {
//                 //     int panaType = checkPanaType(digit);
//                 //     if (panaType == 1) {
//                 //       return 'singlePana';
//                 //     } else if (panaType == 2) {
//                 //       return 'doublePana';
//                 //     } else {
//                 //       return 'tripplePana';
//                 //     }
//                 //   }

//                 // check pana type
//                 // var count = 1;
//                 // for (var i = 0; i < spdptpList.length; i++) {
//                 //   if (spdptpList.lastIndexOf(spdptpList[i]) != i) {
//                 //     count += 1;
//                 //   }
//                 // }
//                 // if (count == 1) {
//                 //   // singlePana
//                 // } else if (count == 2) {
//                 //   // doublePana
//                 // } else {
//                 //   // tripplePana
//                 // }
//                 // }
//                 //   print(spdptpList[i].toString());
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
                    // If bidNo doesn't exist in selectedBidsList, add a new entry.
                    selectedBidsList.add(
                      StarLineBids(
                        bidNo: addedNormalBidValue,
                        coins: int.parse(coinController.text),
                        starlineGameId: gameMode.value.id,
                        remarks:
                            "You invested At ${marketData.value.time} on ${spdptpList[i]} (${gameMode.value.name})",
                      ),
                    );
                  }
                }
              }
              _calculateTotalAmount();
            }
          } else {
            AppUtils.showErrorSnackBar(
              bodyText: value['message'] ?? "",
            );
          }
          autoCompleteFieldController.clear();
          leftAnkController.clear();
          rightAnkController.clear();
          middleAnkController.clear();
          coinController.clear();
          selectedBidsList.refresh();
        },
      );
    }
  }
}


// ,
//         {
//             "starlineGameId": 2,
//             "bidNo": "895",
//             "coins": 10,
//             "remarks": "Starline 18:00:00 859 (Single Pana)"
//         }