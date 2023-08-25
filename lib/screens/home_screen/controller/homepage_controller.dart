import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:share_plus/share_plus.dart';
import 'package:spllive/helper_files/app_colors.dart';
import 'package:spllive/helper_files/custom_text_style.dart';
import 'package:spllive/screens/More%20Details%20Screens/Withdrawal%20Page/withdrawal_page.dart';
import 'package:spllive/screens/bottum_navigation_screens/spl_wallet.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Custom Controllers/wallet_controller.dart';
import '../../../api_services/api_service.dart';
import '../../../helper_files/constant_variables.dart';
import '../../../helper_files/dimentions.dart';
import '../../../helper_files/ui_utils.dart';
import '../../../models/bid_history_model_new.dart';
import '../../../models/commun_models/bid_request_model.dart';
import '../../../models/commun_models/starline_bid_request_model.dart';
import '../../../models/commun_models/user_details_model.dart';
import '../../../models/daily_market_api_response_model.dart';
import '../../../models/market_bid_history.dart';
import '../../../models/normal_market_bid_history_response_model.dart';
import '../../../models/notifiaction_models/get_all_notification_model.dart';
import '../../../models/notifiaction_models/notification_count_model.dart';
import '../../../models/passbook_page_model.dart';
import '../../../models/starline_chart_model.dart';
import '../../../models/starline_daily_market_api_response.dart';
import '../../../routes/app_routes_name.dart';
import '../../Local Storage.dart';
import '../../Notification MSG Page/controller/notification_controller.dart';
import '../../bottum_navigation_screens/bid_history.dart';
import '../../bottum_navigation_screens/moreoptions.dart';
import '../../bottum_navigation_screens/passbook_page.dart';
import '../utils/home_screen_utils.dart';

class HomePageController extends GetxController {
  TextEditingController dateinput = TextEditingController();
  TextEditingController dateinputForResultHistory = TextEditingController();
  DateTime bidHistotyDate = DateTime.now();
  RxBool isStarline = false.obs;
  var arguments = Get.arguments;
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
  RxList<Data2> starlineChartDate = <Data2>[].obs;
  RxList<Time> starlineChartTime = <Time>[].obs;
  UserDetailsModel userData = UserDetailsModel();
  RxList<ResultArr> marketHistoryList = <ResultArr>[].obs;
  RxList<ResultArr> starLineMarketHistoryList = <ResultArr>[].obs;
  RxList<Rows> passBookModelData = <Rows>[].obs;
  RxList<Rows> passBookModelData2 = <Rows>[].obs;
  RxInt passbookCount = 0.obs;
  RxBool isStarline2 = false.obs;
  RxInt offset = 0.obs;
  RxList<Bids> selectedBidsList = <Bids>[].obs;
  RxList<StarLineBids> bidList = <StarLineBids>[].obs;
  RxList<BidHistoryNew> marketbidhistory = <BidHistoryNew>[].obs;
  RxList<MarketBidHistory> marketbidhistory1 = <MarketBidHistory>[].obs;
  RxList<dynamic> result = [].obs;
  Rx<Bidhistorymodel> bidMarketModel = Bidhistorymodel().obs;
  Rx<MarketBidHistory> marketBidHistory = MarketBidHistory().obs;
  RxList<MarketBidHistoryList> marketBidHistoryList =
      <MarketBidHistoryList>[].obs;
  DateTime startEndDate = DateTime.now();

  RxList<NotificationData> notificationData = <NotificationData>[].obs;
  var walletController = Get.put(WalletController());
  RxString walletBalance = "00".obs;
  RxInt getNotifiactionCount = 0.obs;

  @override
  void onInit() {
    setboolData();
    callMarketsApi();

    getUserData();
    getUserBalance();
    getNotificationCount();
    getNotificationsData();
    super.onInit();
  }

  void getNotificationsData() async {
    ApiService().getAllNotifications().then((value) async {
      debugPrint("Notifiactions Data Api ------------- :- $value");
      if (value['status']) {
        GetAllNotificationsData model = GetAllNotificationsData.fromJson(value);
        notificationData.value = model.data!.rows as List<NotificationData>;
        if (model.message!.isNotEmpty) {
          // AppUtils.showSuccessSnackBar(
          //     bodyText: model.message, headerText: "SUCCESSMESSAGE".tr);
        }
      } else {
        AppUtils.showErrorSnackBar(
          bodyText: value['message'] ?? "",
        );
      }
    });
  }

  void setboolData() async {
    await LocalStorage.write(ConstantsVariables.boolData, false);
    await LocalStorage.write(ConstantsVariables.playMore, true);
    await LocalStorage.write(ConstantsVariables.bidsList, selectedBidsList);
    await LocalStorage.write(ConstantsVariables.starlineBidsList, bidList);
  }

  void callMarketsApi() {
    getDailyMarkets();
    marketBidHistoryList.refresh();
    passBookModelData.refresh();
    passBookModelData2.refresh();
    getStarLineMarkets(DateFormat('yyyy-MM-dd').format(startEndDate),
        DateFormat('yyyy-MM-dd').format(startEndDate));
  }

  Future<void> handleRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setboolData();
    callMarketsApi();
    callGetStarLineChart();
    getUserData();
    getNotificationCount();
    getUserBalance();
  }

  @override
  void dispose() {
    marketHistoryList.clear();
    super.dispose();
  }

  ontapOfBidData() {
    Get.toNamed(AppRoutName.newBidHistorypage);
  }

  Future<void> getUserData() async {
    var data = await LocalStorage.read(ConstantsVariables.userData);
    userData = UserDetailsModel.fromJson(data);
    getMarketBidsByUserId(
        lazyLoad: false,
        startDate: DateFormat('yyyy-MM-dd').format(startEndDate),
        endDate: DateFormat('yyyy-MM-dd').format(startEndDate));
  }

  // onTapOficonButton() {
  //   if (pageWidget.value == 1 && currentIndex.value == 1) {
  //     marketBidsByUserId(lazyLoad: false);
  //   } else if (pageWidget.value == 2 && currentIndex.value == 2) {
  //   } else if (pageWidget.value == 3 && currentIndex.value == 3) {
  //     getPassBookData(lazyLoad: false, offset: offset.value.toString());
  //   }
  // }

  void getStarLineMarkets(String startDate, String endDate) async {
    ApiService()
        .getDailyStarLineMarkets(startDate: startDate, endDate: endDate)
        .then((value) async {
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
          print("Star ********************* ${starLineMarketList.toJson()}");
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
            child: HomeScreenUtils().bidHistory(context));
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
            starlineChartDate.isEmpty
                ? SizedBox(
                    height: size.height / 2.5,
                    child: Center(
                      child: Text(
                        "There is no Data in Starlin Chart",
                        style: CustomTextStyle.textRobotoSansMedium,
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Row(
                      children: [
                        HomeScreenUtils().dateColumn(),
                        Expanded(child: HomeScreenUtils().timeColumn())
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

  Widget getDashBoardPages(index, size, BuildContext context,
      {required String notifictionCount}) {
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
                walletText: walletBalance.toString(),
                onTapTranction: () {
                  // Get.toNamed(AppRoutName.transactionPage);
                },
                notifictionCount: notifictionCount,
                onTapNotifiaction: () {
                  Get.toNamed(AppRoutName.notificationPage);
                },
                onTapTelegram: () {
                  launch(
                    "https://t.me/satta_matka_kalyan_bazar_milan",
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
                                    : AppColors.iconColorMain,
                                iconColor2: widgetContainer.value == 1
                                    ? AppColors.appbarColor
                                    : AppColors.iconColorMain,
                                iconColor3: widgetContainer.value == 2
                                    ? AppColors.appbarColor
                                    : AppColors.iconColorMain,
                                onTap1: () {
                                  position = 0;
                                  widgetContainer.value = position;
                                  isStarline.value = false;
                                  print(widgetContainer.value);
                                },
                                onTap2: () {
                                  position = 1;
                                  isStarline.value = true;
                                  callGetStarLineChart();
                                  getDailyStarLineMarkets(
                                    DateFormat('yyyy-MM-dd')
                                        .format(startEndDate),
                                    DateFormat('yyyy-MM-dd')
                                        .format(startEndDate),
                                  );
                                  getMarketBidsByUserId(
                                      lazyLoad: false,
                                      endDate: DateFormat('yyyy-MM-dd')
                                          .format(startEndDate),
                                      startDate: DateFormat('yyyy-MM-dd')
                                          .format(startEndDate));
                                  // HomeScreenUtils().iconsContainer2();
                                  widgetContainer.value = position;
                                  print(
                                      "marketHistoryList :  ${marketHistoryList.toJson()}");
                                  // print(
                                  //     "${widgetContainer.value} ${isStarline.value}");
                                },
                                onTap3: () {
                                  position = 2;
                                  widgetContainer.value = position;
                                  isStarline.value = false;
                                  launch(
                                    "https://wa.me/+917769826748/?text=hi",
                                  );
                                },
                              ),
                              spaceBeetween,
                              Obx(() {
                                return isStarline.value
                                    ? HomeScreenUtils().iconsContainer2(
                                        iconColor1: widgetContainer.value == 3
                                            ? AppColors.appbarColor
                                            : AppColors.iconColorMain,
                                        iconColor2: widgetContainer.value == 4
                                            ? AppColors.appbarColor
                                            : AppColors.iconColorMain,
                                        iconColor3: widgetContainer.value == 5
                                            ? AppColors.appbarColor
                                            : AppColors.iconColorMain,
                                        onTap1: () {
                                          position = 3;
                                          widgetContainer.value = position;
                                          print(widgetContainer.value);
                                          getMarketBidsByUserId(
                                            lazyLoad: false,
                                            endDate: DateFormat('yyyy-MM-dd')
                                                .format(startEndDate),
                                            startDate:
                                                DateFormat('yyyy-MM-dd').format(
                                              startEndDate,
                                            ),
                                          );
                                        },
                                        onTap2: () {
                                          position = 4;
                                          widgetContainer.value = position;
                                          print(widgetContainer.value);
                                          getDailyStarLineMarkets(
                                            DateFormat('yyyy-MM-dd')
                                                .format(startEndDate),
                                            DateFormat('yyyy-MM-dd')
                                                .format(startEndDate),
                                          );
                                        },
                                        onTap3: () {
                                          position = 5;
                                          widgetContainer.value = position;
                                          print(widgetContainer.value);
                                          callGetStarLineChart();
                                        },
                                      )
                                    : Container();
                              }),
                            ],
                          ),
                        ),
                      ),
                      Obx(
                        () => getDashBoardWidget(
                          widgetContainer.value,
                          size,
                          context,
                        ),
                      ),
                      spaceBeetween,
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
        return PassBook();
      case 4:
        return const MoreOptions();
      case 5:
        return WithdrawalPage();
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
                                : AppColors.iconColorMain,
                            iconColor2: widgetContainer.value == 1
                                ? AppColors.appbarColor
                                : AppColors.iconColorMain,
                            iconColor3: widgetContainer.value == 2
                                ? AppColors.appbarColor
                                : AppColors.iconColorMain,
                            onTap1: () {
                              position = 0;
                              widgetContainer.value = position;
                              isStarline.value = false;
                              // print(widgetContainer.value);
                            },
                            onTap2: () {
                              position = 1;
                              isStarline.value = true;
                              widgetContainer.value = position;
                              //   print(widgetContainer.value);
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
                                        : AppColors.iconColorMain,
                                    iconColor2: widgetContainer.value == 4
                                        ? AppColors.appbarColor
                                        : AppColors.iconColorMain,
                                    iconColor3: widgetContainer.value == 5
                                        ? AppColors.appbarColor
                                        : AppColors.iconColorMain,
                                    onTap1: () {
                                      position = 3;
                                      widgetContainer.value = position;
                                      //   print(widgetContainer.value);
                                    },
                                    onTap2: () {
                                      position = 4;
                                      widgetContainer.value = position;
                                      print(
                                          " ************ ${widgetContainer.value}");
                                    },
                                    onTap3: () {
                                      position = 5;
                                      widgetContainer.value = position;
                                      // print(widgetContainer.value);
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
      AppUtils.showErrorSnackBar(
        bodyText: "Bidding is Closed!!!!",
      );
    }
  }

  void onTapOfStarlineMarket(StarlineMarketData market) {
    if (market.isBidOpen ?? false) {
      Get.toNamed(
        AppRoutName.starLineGameModesPage,
        arguments: market,
      );
    } else {
      AppUtils.showErrorSnackBar(
        bodyText: "Bidding is Closed!!!!",
      );
    }
  }

  void getDailyStarLineMarkets(String startDate, String endDate) async {
    ApiService()
        .getDailyStarLineMarkets(startDate: startDate, endDate: endDate)
        .then((value) async {
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
      print("$result - ${sum % 10}");
      return "$result - ${sum % 10}";
    } else {
      return "***-*";
    }
  }

  reverse(String originalString) {
    String reversedString = '';

    for (int i = originalString.length - 1; i >= 0; i--) {
      reversedString += originalString[i];
    }
    return reversedString;
  }

  Future<void> onSwipeRefresh() async {
    // getDailyStarLineMarkets();
  }

  void callGetStarLineChart() async {
    ApiService().getStarlineChar().then((value) async {
      debugPrint("Starline chart Api Response :- $value");
      if (value['status']) {
        // NewStarLineChartModel model = NewStarLineChartModel.fromJson(value);
        StarlineChartModel model = StarlineChartModel.fromJson(value);
        starlineChartDate.value = model.data!;
        for (var i = 0; i < model.data!.length; i++) {
          starlineChartTime.value = model.data![i].time!;
        }
        print(starlineChartTime);
        if (model.message!.isNotEmpty) {
          AppUtils.showSuccessSnackBar(
              bodyText: model.message, headerText: "SUCCESSMESSAGE".tr);
        }
      } else {
        AppUtils.showErrorSnackBar(
          bodyText: value['message'] ?? "",
        );
      }
    });
  }

  void getNotificationCount() async {
    ApiService().getNotificationCount().then((value) async {
      debugPrint("Notifiaction Count Api ------------- :- $value");
      if (value['status']) {
        NotifiactionCountModel model = NotifiactionCountModel.fromJson(value);
        getNotifiactionCount.value = model.data!.notificationCount!.toInt();
        if (model.message!.isNotEmpty) {
          AppUtils.showSuccessSnackBar(
              bodyText: model.message, headerText: "SUCCESSMESSAGE".tr);
        }
      } else {
        AppUtils.showErrorSnackBar(
          bodyText: value['message'] ?? "",
        );
      }
    });
  }

  void getMarketBidsByUserId({
    required bool lazyLoad,
    required String startDate,
    required String endDate,
  }) {
    ApiService()
        .getBidHistoryByUserId(
      userId: userData.id.toString(),
      startDate: startDate,
      endDate: endDate,
      limit: "10",
      offset: offset.value.toString(),
      isStarline: isStarline.value,
    )
        .then(
      (value) async {
        debugPrint("Get Market Api Response :- $value");
        if (value['status']) {
          if (value['data'] != null) {
            NormalMarketBidHistoryResponseModel model =
                NormalMarketBidHistoryResponseModel.fromJson(value);
            lazyLoad
                ? marketHistoryList
                    .addAll(model.data?.resultArr ?? <ResultArr>[])
                : marketHistoryList.value =
                    model.data?.resultArr ?? <ResultArr>[];
          }
        } else {
          AppUtils.showErrorSnackBar(
            bodyText: value['message'] ?? "",
          );
        }
      },
    );
  }

  final int itemLimit = 30;

  void getPassBookData({required bool lazyLoad, required String offset}) {
    ApiService()
        .getPassBookData(
      userId: userData.id.toString(),
      isAll: true,
      limit: itemLimit.toString(),
      offset: offset.toString(),
    )
        .then((value) async {
      debugPrint(" Get passBook Data @@@@@@@@@@@@@@@@:- $value");

      if (value['status']) {
        print(value['status']);
        if (value['data'] != null) {
          PassbookModel model = PassbookModel.fromJson(value);
          passbookCount.value = int.parse(model.data!.count!.toString());
          passBookModelData.value = model.data?.rows ?? <Rows>[];
          passBookModelData.refresh();
        }
      } else {
        AppUtils.showErrorSnackBar(
          bodyText: value['message'] ?? "",
        );
      }
    });
  }

  int calculateTotalPages() {
    var passbookValue = (passbookCount.value / itemLimit).ceil() - 1;
    var passbookValueZero = (passbookCount.value / itemLimit).ceil();
    if (passbookCount.value < 30) {
      return passbookValueZero;
    } else {
      return passbookValue;
    }
  }

  var num = 0;

  void nextPage() {
    if (offset.value < calculateTotalPages()) {
      ///  print("offset.value ${offset.value}");
      passBookModelData.clear();
      offset.value++;

      num = num + itemLimit;
      print("nextpage $num");
      //  print("offset.value ${offset.value}");
      getPassBookData(lazyLoad: false, offset: num.toString());
      //  print("offset.value ${offset.value}");
      // passBookModelData.refresh();
      update();
    }
  }

  void prevPage() {
    if (offset.value > 0) {
      passBookModelData.clear();
      offset.value--;
      num = num - itemLimit;
      print("prevPage : $num");
      //print("offset.value ${offset.value}");
      getPassBookData(lazyLoad: false, offset: num.toString());
      // print("offset.value ${offset.value}");
      passBookModelData.refresh();
      update();
    }
    print("prevPage : $num");
  }

  void marketBidsByUserId({required bool lazyLoad}) {
    ApiService()
        .bidHistoryByUserId(
      userId: userData.id.toString(),
    )
        .then(
      (value) async {
        print("Get Bid History New List  :- $value");
        if (value['status']) {
          if (value['data'] != null) {
            MarketBidHistory model = MarketBidHistory.fromJson(value['data']);
            print(
                "================================  model data =================================");
            print(model.toJson());
            lazyLoad
                ? marketBidHistoryList
                    .addAll(model.rows ?? <MarketBidHistoryList>[])
                : marketBidHistoryList.value =
                    model.rows ?? <MarketBidHistoryList>[];
          }
          marketBidHistoryList.refresh();
        } else {
          AppUtils.showErrorSnackBar(
            bodyText: value['message'] ?? "",
          );
        }
      },
    );
  }

  void getUserBalance() {
    ApiService().getBalance().then(
      (value) async {
        debugPrint("((((((((((((((((((((((((((()))))))))))))))))))))))))))");
        debugPrint("Wallet balance Api Response :- $value");
        if (value['status']) {
          var tempBalance = value['data']['Amount'] ?? 00;
          walletBalance.value = tempBalance.toString();
        } else {
          AppUtils.showErrorSnackBar(
            bodyText: value['message'] ?? "",
          );
        }
      },
    );
  }

  void resetNotificationCount() async {
    ApiService().resetNotification().then((value) async {
      debugPrint("Notifiaction Count Api ------------- :- $value");
      if (value['status']) {
        NotifiactionCountModel model = NotifiactionCountModel.fromJson(value);
        getNotifiactionCount.value = model.data!.notificationCount!.toInt();
        if (model.message!.isNotEmpty) {}
      } else {
        AppUtils.showErrorSnackBar(
          bodyText: value['message'] ?? "",
        );
      }
    });
  }
}
