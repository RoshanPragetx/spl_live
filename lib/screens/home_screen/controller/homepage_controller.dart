// ignore_for_file: unused_import, invalid_use_of_protected_member, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:spllive/helper_files/app_colors.dart';
import 'package:spllive/screens/bottum_navigation_screens/spl_wallet.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../api_services/api_service.dart';
import '../../../helper_files/constant_variables.dart';
import '../../../helper_files/dimentions.dart';
import '../../../helper_files/ui_utils.dart';
import '../../../models/commun_models/user_details_model.dart';
import '../../../models/daily_market_api_response_model.dart';
import '../../../models/normal_market_bid_history_response_model.dart';
import '../../../models/starline_daily_market_api_response.dart';
import '../../../routes/app_routes_name.dart';
import '../../Local Storage.dart';
import '../../bottum_navigation_screens/bid_history.dart';
import '../../bottum_navigation_screens/moreoptions.dart';
import '../utils/home_screen_utils.dart';

class HomePageController extends GetxController {
  TextEditingController dateinput = TextEditingController();
  RxBool isStarline = false.obs;
  RxBool market = false.obs;
  RxBool bidHistory = false.obs;
  RxBool resultHistory = false.obs;
  RxBool chart = false.obs;
  RxBool addFund = false.obs;
  RxInt widgetContainer = 0.obs;
  RxInt pageWidget = 0.obs;
  RxInt appBarWidget = 0.obs;
  RxInt currentIndex = 0.obs;
  var position = 0;
  var spaceBeetween = const SizedBox(height: 10);
  RxList<MarketData> normalMarketList = <MarketData>[].obs;
  RxList<StarlineMarketData> starLineMarketList = <StarlineMarketData>[].obs;
  RxBool noMarketFound = false.obs;
  RxList<StarlineMarketData> marketList = <StarlineMarketData>[].obs;
  RxList<StarlineMarketData> marketListForResult = <StarlineMarketData>[].obs;

  // UserDetailsModel userData = UserDetailsModel();
  // RxList<NormalMarketHistoryModel> marketHistoryList =
  //     <NormalMarketHistoryModel>[].obs;
  // RxBool isStarline2 = false.obs;
  // int offset = 0;
  @override
  void onInit() {
    setboolData();
    callMarketsApi();
    getDailyStarLineMarkets();
    // getUserData();
    super.onInit();
  }

  void setboolData() async {
    await LocalStorage.write(ConstantsVariables.boolData, false);
  }

  void callMarketsApi() {
    getDailyMarkets();
    getStarLineMarkets();
  }

  @override
  void dispose() {
    // marketHistoryList.clear();
    // scrollController.removeListener(_scrollListner);
    // scrollController.dispose();
    super.dispose();
  }

  // Future<void> onSwipeRefresh() async {
  //   offset = 0;
  //   getMarketBidsByUserId(lazyLoad: false);
  // }

  // Future<void> getUserData() async {
  //   var data = await LocalStorage.read(ConstantsVariables.userData);
  //   userData = UserDetailsModel.fromJson(data);
  //   getMarketBidsByUserId(lazyLoad: false);
  // }

  void getStarLineMarkets() async {
    ApiService().getDailyStarLineMarkets().then((value) async {
      debugPrint("Get Daily Starline Markets Api Response :- $value");
      if (value['status']) {
        StarLineDailyMarketApiResponseModel responseModel =
            StarLineDailyMarketApiResponseModel.fromJson(value);
        starLineMarketList.value = responseModel.data ?? <StarlineMarketData>[];
        if (starLineMarketList.isNotEmpty) {
          var biddingOpenMarketList = starLineMarketList
              .where((element) => element.isBidOpen == true)
              .toList();
          var biddingClosedMarketList = starLineMarketList
              .where((element) => element.isBidOpen == false)
              .toList();
          var tempFinalMarketList = <StarlineMarketData>[];
          biddingOpenMarketList.sort((a, b) {
            DateTime dateTimeA =
                DateFormat('hh:mm a').parse(a.time ?? "00:00 AM");
            DateTime dateTimeB =
                DateFormat('hh:mm a').parse(b.time ?? "00:00 AM");
            return dateTimeA.compareTo(dateTimeB);
          });
          tempFinalMarketList = biddingOpenMarketList;
          biddingClosedMarketList.sort((a, b) {
            DateTime dateTimeA =
                DateFormat('hh:mm a').parse(a.time ?? "00:00 AM");
            DateTime dateTimeB =
                DateFormat('hh:mm a').parse(b.time ?? "00:00 AM");
            return dateTimeA.compareTo(dateTimeB);
          });
          tempFinalMarketList.addAll(biddingClosedMarketList);
          starLineMarketList.value = tempFinalMarketList;
        }
      } else {
        AppUtils.showErrorSnackBar(
          bodyText: value['message'] ?? "",
        );
      }
    });
  }

  void getDailyMarkets() async {
    ApiService().getDailyMarkets().then((value) async {
      debugPrint("Get Daily Markets Api Response :- $value");
      if (value['status']) {
        DailyMarketApiResponseModel marketModel =
            DailyMarketApiResponseModel.fromJson(value);
        if (marketModel.data != null && marketModel.data!.isNotEmpty) {
          normalMarketList.value = marketModel.data!;
          noMarketFound.value = false;

          var biddingOpenMarketList = normalMarketList
              .where((element) =>
                  element.isBidOpenForClose == true ||
                  element.isBidOpenForOpen == true)
              .toList();
          var biddingClosedMarketList = normalMarketList
              .where((element) =>
                  element.isBidOpenForOpen == false &&
                  element.isBidOpenForClose == false)
              .toList();
          var tempFinalMarketList = <MarketData>[];
          biddingOpenMarketList.sort((a, b) {
            DateTime dateTimeA =
                DateFormat('hh:mm a').parse(a.openTime ?? "00:00 AM");
            DateTime dateTimeB =
                DateFormat('hh:mm a').parse(b.openTime ?? "00:00 AM");
            return dateTimeA.compareTo(dateTimeB);
          });
          tempFinalMarketList = biddingOpenMarketList;
          biddingClosedMarketList.sort((a, b) {
            DateTime dateTimeA =
                DateFormat('hh:mm a').parse(a.openTime ?? "00:00 AM");
            DateTime dateTimeB =
                DateFormat('hh:mm a').parse(b.openTime ?? "00:00 AM");
            return dateTimeA.compareTo(dateTimeB);
          });
          tempFinalMarketList.addAll(biddingClosedMarketList);
          normalMarketList.value = tempFinalMarketList;
        } else {
          noMarketFound.value = true;
        }
      } else {
        AppUtils.showErrorSnackBar(
          bodyText: value['message'] ?? "",
        );
      }
    });
  }

  Widget getDashBoardWidget(index, size, BuildContext context) {
    switch (index) {
      case 0:
        return HomeScreenUtils().gridColumn(
          size,
        );
      case 1:
        // Get.lazyPut(() => BidHistoryPageController());
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.h5),
            child: HomeScreenUtils().gridColumnForStarLine(size));
      case 2:
        return Container();
      case 3:
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.h10),
            child: HomeScreenUtils().bidHistory());
      case 4:
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.h10),
            child: HomeScreenUtils().resultHistory(context));
      case 5:
        return Column(
          children: [
            spaceBeetween,
            const Text(
              "Starline Chart",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: Dimensions.h5,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                children: const [
                  MyTable1(
                    numberOfRows: 50,
                  ),
                  Expanded(
                      child: MyTable2(
                    numberOfHours: 10,
                    numberOfRows: 50,
                  ))
                ],
              ),
            ),
          ],
        );
      default:
        return HomeScreenUtils().gridColumn(
          size,
        );
    }
  }

  Widget getDashBoardPages(
      index, size, BuildContext context, String walletText) {
    switch (index) {
      case 0:
        return SizedBox(
          // color: AppColors.grey,
          height: size.height,
          width: double.infinity,
          child: Column(
            children: [
              AppUtils().appbar(
                size,
                walletText: walletText,
                onTapTranction: () {
                  Get.toNamed(AppRoutName.transactionPage);
                },
                onTapNotifiaction: () {
                  Get.toNamed(AppRoutName.notificationPage);
                },
                onTapTelegram: () {
                  launchUrl(
                    Uri.parse("https://t.me/satta_matka_kalyan_bazar_milan"),
                  );
                },
                shareOntap: () {
                  Share.share("http://spl.live");
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      spaceBeetween,
                      HomeScreenUtils().banner(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.h10,
                            vertical: Dimensions.h5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 0.1,
                                color: AppColors.grey,
                                blurRadius: 10,
                                offset: const Offset(2, 3),
                              )
                            ],
                            borderRadius: BorderRadius.circular(Dimensions.h5),
                            border:
                                Border.all(color: AppColors.redColor, width: 1),
                          ),
                          //padding: const EdgeInsets.symmetric(horizontal: 60),
                          child: Column(
                            children: [
                              spaceBeetween,
                              HomeScreenUtils().iconsContainer(
                                iconColor1: widgetContainer.value == 0
                                    ? AppColors.appbarColor
                                    : AppColors.black,
                                iconColor2: widgetContainer.value == 1
                                    ? AppColors.appbarColor
                                    : AppColors.black,
                                iconColor3: widgetContainer.value == 2
                                    ? AppColors.appbarColor
                                    : AppColors.black,
                                onTap1: () {
                                  position = 0;
                                  widgetContainer.value = position;
                                  isStarline.value = false;
                                  print(widgetContainer.value);
                                },
                                onTap2: () {
                                  position = 1;
                                  isStarline.value = true;
                                  // HomeScreenUtils().iconsContainer2();
                                  widgetContainer.value = position;
                                  print(widgetContainer.value);
                                },
                                onTap3: () {
                                  position = 2;
                                  widgetContainer.value = position;
                                  isStarline.value = false;
                                },
                              ),
                              spaceBeetween,
                              Obx(() {
                                return isStarline.value
                                    ? HomeScreenUtils().iconsContainer2(
                                        iconColor1: widgetContainer.value == 3
                                            ? AppColors.appbarColor
                                            : AppColors.black,
                                        iconColor2: widgetContainer.value == 4
                                            ? AppColors.appbarColor
                                            : AppColors.black,
                                        iconColor3: widgetContainer.value == 5
                                            ? AppColors.appbarColor
                                            : AppColors.black,
                                        onTap1: () {
                                          position = 3;
                                          widgetContainer.value = position;
                                          print(widgetContainer.value);
                                        },
                                        onTap2: () {
                                          position = 4;
                                          widgetContainer.value = position;
                                          print(widgetContainer.value);
                                        },
                                        onTap3: () {
                                          position = 5;
                                          widgetContainer.value = position;
                                          print(widgetContainer.value);
                                        })
                                    : Container();
                              }),
                            ],
                          ),
                        ),
                      ),
                      Obx(
                        () => getDashBoardWidget(
                            widgetContainer.value, size, context),
                      ),
                      spaceBeetween
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      case 1:
        return BidHistory(
          appbarTitle: "Your Market",
        );
      case 2:
        return SPLWallet();
      case 3:
        return const MoreOptions();

      default:
        return SafeArea(
          child: SizedBox(
            // color: AppColors.grey,
            height: size.height,
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  spaceBeetween,
                  HomeScreenUtils().banner(),
                  spaceBeetween,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.h10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 1,
                            color: AppColors.grey,
                            blurRadius: 7,
                            offset: const Offset(6, 4),
                          )
                        ],
                        borderRadius: BorderRadius.circular(Dimensions.h5),
                        border: Border.all(color: AppColors.redColor, width: 1),
                      ),
                      //padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: Column(
                        children: [
                          spaceBeetween,
                          HomeScreenUtils().iconsContainer(
                            iconColor1: widgetContainer.value == 0
                                ? AppColors.appbarColor
                                : AppColors.black,
                            iconColor2: widgetContainer.value == 1
                                ? AppColors.appbarColor
                                : AppColors.black,
                            iconColor3: widgetContainer.value == 2
                                ? AppColors.appbarColor
                                : AppColors.black,
                            onTap1: () {
                              position = 0;
                              widgetContainer.value = position;
                              isStarline.value = false;
                              print(widgetContainer.value);
                            },
                            onTap2: () {
                              position = 1;
                              isStarline.value = true;
                              // HomeScreenUtils().iconsContainer2();
                              widgetContainer.value = position;
                              print(widgetContainer.value);
                            },
                            onTap3: () {
                              position = 2;
                              widgetContainer.value = position;
                              isStarline.value = false;
                            },
                          ),
                          spaceBeetween,
                          Obx(() {
                            return isStarline.value
                                ? HomeScreenUtils().iconsContainer2(
                                    iconColor1: widgetContainer.value == 3
                                        ? AppColors.appbarColor
                                        : AppColors.black,
                                    iconColor2: widgetContainer.value == 4
                                        ? AppColors.appbarColor
                                        : AppColors.black,
                                    iconColor3: widgetContainer.value == 5
                                        ? AppColors.appbarColor
                                        : AppColors.black,
                                    onTap1: () {
                                      position = 3;
                                      widgetContainer.value = position;
                                      print(widgetContainer.value);
                                    },
                                    onTap2: () {
                                      position = 4;
                                      widgetContainer.value = position;
                                      print(widgetContainer.value);
                                    },
                                    onTap3: () {
                                      position = 5;
                                      widgetContainer.value = position;
                                      print(widgetContainer.value);
                                    })
                                : Container();
                          }),
                          spaceBeetween
                        ],
                      ),
                    ),
                  ),
                  Obx(
                    () => Column(
                      children: [
                        getDashBoardWidget(
                            widgetContainer.value, size, context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
    }
  }

  // onTapMarketContaioner() {
  //   Get.toNamed(AppRoutName.gameModePage);
  // }

  onTapOfNormalMarket(MarketData market) {
    if (market.isBidOpenForClose ?? false) {
      Get.toNamed(AppRoutName.gameModePage, arguments: market);
    } else {
      Get.toNamed(AppRoutName.gameModePage, arguments: market);
      AppUtils.showErrorSnackBar(
        bodyText: "Bidding is Closed!!!!",
      );
    }
  }

  void onTapOfStarlineMarket(StarlineMarketData market) {
    if (market.isBidOpen ?? false) {
      Get.toNamed(AppRoutName.starLineGameModesPage, arguments: {
        "marketData": market,
      });
    } else {
      AppUtils.showErrorSnackBar(
        bodyText: "Bidding is Closed!!!!",
      );
    }
  }

  void getDailyStarLineMarkets() async {
    ApiService().getDailyStarLineMarkets().then((value) async {
      print("Get Daily Starline Markets Result Api Response :- $value");
      if (value['status']) {
        StarLineDailyMarketApiResponseModel responseModel =
            StarLineDailyMarketApiResponseModel.fromJson(value);
        marketList.value = responseModel.data ?? <StarlineMarketData>[];
        marketListForResult.value =
            responseModel.data ?? <StarlineMarketData>[];
        if (marketList.isNotEmpty) {
          var biddingOpenMarketList = marketList.value
              .where((element) => element.isBidOpen == true)
              .toList();
          var biddingClosedMarketList = marketList.value
              .where((element) => element.isBidOpen == false)
              .toList();
          var tempFinalMarketList = <StarlineMarketData>[];
          biddingOpenMarketList.sort((a, b) {
            DateTime dateTimeA =
                DateFormat('hh:mm a').parse(a.time ?? "00:00 AM");
            DateTime dateTimeB =
                DateFormat('hh:mm a').parse(b.time ?? "00:00 AM");
            return dateTimeA.compareTo(dateTimeB);
          });
          tempFinalMarketList = biddingOpenMarketList;
          biddingClosedMarketList.sort((a, b) {
            DateTime dateTimeA =
                DateFormat('hh:mm a').parse(a.time ?? "00:00 AM");
            DateTime dateTimeB =
                DateFormat('hh:mm a').parse(b.time ?? "00:00 AM");
            return dateTimeA.compareTo(dateTimeB);
          });
          tempFinalMarketList.addAll(biddingClosedMarketList);
          marketList.value = tempFinalMarketList;
          marketListForResult.value.sort((a, b) {
            DateTime dateTimeA =
                DateFormat('hh:mm a').parse(a.time ?? "00:00 AM");
            DateTime dateTimeB =
                DateFormat('hh:mm a').parse(b.time ?? "00:00 AM");
            return dateTimeA.compareTo(dateTimeB);
          });
        }
      } else {
        AppUtils.showErrorSnackBar(
          bodyText: value['message'] ?? "",
        );
      }
    });
  }

  String getResult(bool resultDeclared, int result) {
    if (resultDeclared != null && resultDeclared) {
      int sum = 0;
      for (int i = result; i > 0; i = (i / 10).floor()) {
        sum += (i % 10);
      }
      return "$result - ${sum % 10}";
    } else {
      return "***-*";
    }
  }

  Future<void> onSwipeRefresh() async {
    getDailyStarLineMarkets();
  }
}
