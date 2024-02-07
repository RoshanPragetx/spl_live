import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spllive/controller/home_controller.dart';
import 'package:spllive/utils/constant.dart';

import '../../../Custom Controllers/wallet_controller.dart';
import '../../../api_services/api_service.dart';
import '../../../helper_files/ui_utils.dart';
import '../../../models/bid_history_model_new.dart';
import '../../../models/commun_models/bid_request_model.dart';
import '../../../models/commun_models/starline_bid_request_model.dart';
import '../../../models/commun_models/user_details_model.dart';
import '../../../models/daily_market_api_response_model.dart';
import '../../../models/market_bid_history.dart';
import '../../../models/normal_market_bid_history_response_model.dart';
import '../../../models/notifiaction_models/get_all_notification_model.dart';
import '../../../models/starline_daily_market_api_response.dart';
import '../../../models/starlinechar_model/new_starlinechart_model.dart';
import '../../Local Storage.dart';

class HomePageController extends GetxController {
  final homeCon = Get.put<HomeController>(HomeController());
  TextEditingController dateinput = TextEditingController();
  TextEditingController dateinputForResultHistory = TextEditingController();
  DateTime bidHistotyDate = DateTime.now();
  RxBool isStarline = false.obs;
  var arguments = Get.arguments;
  RxBool market = false.obs;
  RxBool bidHistory = false.obs;
  RxBool resultHistory = false.obs;
  RxBool chart = false.obs;
  RxInt widgetContainer = 0.obs;
  // RxInt pageWidget = 0.obs;
  // RxInt currentIndex = 0.obs;
  var position = 0;

  RxList<MarketData> normalMarketList = <MarketData>[].obs;
  RxList<StarlineMarketData> starLineMarketList = <StarlineMarketData>[].obs;
  RxBool noMarketFound = false.obs;
  RxList<StarlineMarketData> marketList = <StarlineMarketData>[].obs;
  RxList<StarlineMarketData> marketListForResult = <StarlineMarketData>[].obs;
  RxList<StarLineDateTime> starlineChartDateAndTime = <StarLineDateTime>[].obs;
  RxList<Markets> starlineChartTime = <Markets>[].obs;
  UserDetailsModel userData = UserDetailsModel();
  RxList<ResultArr> marketHistoryList = <ResultArr>[].obs;
  RxList<ResultArr> starLineMarketHistoryList = <ResultArr>[].obs;
  RxBool isStarline2 = false.obs;
  RxInt offset = 0.obs;
  RxList<Bids> selectedBidsList = <Bids>[].obs;
  RxList<StarLineBids> bidList = <StarLineBids>[].obs;
  RxList<BidHistoryNew> marketbidhistory = <BidHistoryNew>[].obs;
  RxList<MarketBidHistory> marketbidhistory1 = <MarketBidHistory>[].obs;
  RxList<dynamic> result = [].obs;
  Rx<Bidhistorymodel> bidMarketModel = Bidhistorymodel().obs;
  DateTime startEndDate = DateTime.now();
  RxList<NotificationData> notificationData = <NotificationData>[].obs;
  var walletController = Get.put(WalletController());
  RxString walletBalance = "00".obs;
  RxInt getNotifiactionCount = 0.obs;
  // RxList<BannerDataModel> bennerData = <BannerDataModel>[].obs;
  RxBool starlineCheck = false.obs;
  // @override
  // void onInit() {
  //   // setBoolData();
  //   super.onInit();
  // }

  callFcmApi(userId) async {
    var token = await LocalStorage.read(ConstantsVariables.fcmToken);
    Timer(const Duration(milliseconds: 200), () => fsmApiCall(userId, token));
  }

  fcmBody(userId, fcmToken) {
    var a = {
      "id": userId,
      "fcmToken": fcmToken,
    };
    return a;
  }

  void fsmApiCall(userId, fcmToken) async {
    ApiService().fcmToken(await fcmBody(userId, fcmToken)).then((value) async {
      if (value['status']) {
      } else {
        AppUtils.showErrorSnackBar(bodyText: value['message'] ?? "");
      }
    });
  }

  void getNotificationsData() async {
    ApiService().getAllNotifications().then((value) async {
      if (value['status']) {
        GetAllNotificationsData model = GetAllNotificationsData.fromJson(value);
        notificationData.value = model.data!.rows as List<NotificationData>;
      } else {
        AppUtils.showErrorSnackBar(bodyText: value['message'] ?? "");
      }
    });
  }

  // void setBoolData() async {
  //   GetStorage().write(ConstantsVariables.timeOut, true);
  //   GetStorage().write(ConstantsVariables.mPinTimeOut, false);
  //   GetStorage().write(ConstantsVariables.bidsList, selectedBidsList);
  //   GetStorage().write(ConstantsVariables.starlineBidsList, bidList);
  //   GetStorage().write(ConstantsVariables.totalAmount, "0");
  //   GetStorage().write(ConstantsVariables.marketName, "");
  //   GetStorage().write(ConstantsVariables.marketNotification, true);
  //   GetStorage().write(ConstantsVariables.starlineNotification, true);
  //   starlineCheck.value = GetStorage().read(ConstantsVariables.starlineConnect) ?? false;
  //   starlineCheck.value == true ? widgetContainer.value = 1 : widgetContainer.value;
  //   starlineCheck.value == true ? isStarline.value = true : isStarline.value;
  //   Timer(const Duration(seconds: 1), () => GetStorage().write(ConstantsVariables.starlineConnect, false));
  //   homeCon.getHomeData();
  // }

  void callMarketsApi() {
    //getStarLineMarkets(DateFormat('yyyy-MM-dd').format(startEndDate), DateFormat('yyyy-MM-dd').format(startEndDate));
  }

  Future<void> handleRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    // setBoolData();
    callMarketsApi();
    getUserData();
  }

  @override
  void dispose() async {
    marketHistoryList.clear();
    super.dispose();
  }
  //
  // RxBool load = false.obs;
  // getHomeData() async {
  //   try {
  //     load.value = true;
  //     final resp = await Future.wait([
  //       getBennearData(),
  //     ]);
  //     if (resp.isNotEmpty) {
  //       if (resp[0].runtimeType == StreamSongModel) {
  //         streamSongModel.value = resp[0] as StreamSongModel;
  //         if (streamSongModel.value.status ?? false) {
  //           streamList.value = streamSongModel.value.data ?? [];
  //           if (streamList.isNotEmpty) {
  //             currentPlaySongImage.value = streamList[0].image ?? "";
  //             currentPlaySongTitle.value = streamList[0].title ?? "";
  //             currentPlaySongArtist.value = streamList[0].artist ?? "";
  //             currentPlaySongDuration.value = streamList[0].duration ?? "";
  //             currentPlaySongYear.value = streamList[0].year ?? "";
  //
  //             streamList.removeAt(0);
  //           }
  //           load.value = false;
  //           count.value++;
  //         }
  //       }
  //       if (resp[1].runtimeType == HomeModel) {
  //         homeModel.value = resp[1] as HomeModel;
  //         if (homeModel.value.status ?? false) {
  //           dashboardlist.value = homeModel.value.data?.buzz?.rows ?? [];
  //           podCaslList.value = homeModel.value.data?.podcast?.rows ?? [];
  //         }
  //       }
  //       load.value = false;
  //     }
  //   } catch (e) {
  //     load.value = false;
  //   }
  // }

  ontapOfBidData() => Get.toNamed(AppRouteNames.newBidHistorypage);

  Future<void> getUserData() async {
    var data = await LocalStorage.read(ConstantsVariables.userData);
    userData = UserDetailsModel.fromJson(data);
    // getMarketBidsByUserId(
    //     lazyLoad: false,
    //     startDate: DateFormat('yyyy-MM-dd').format(startEndDate),
    //     endDate: DateFormat('yyyy-MM-dd').format(startEndDate));
    callFcmApi(userData.id);
  }

  // void getStarLineMarkets(String startDate, String endDate) async {
  //   ApiService().getDailyStarLineMarkets(startDate: startDate, endDate: endDate).then((value) async {
  //     if (value['status']) {
  //       StarLineDailyMarketApiResponseModel responseModel = StarLineDailyMarketApiResponseModel.fromJson(value);
  //       starLineMarketList.value = responseModel.data ?? <StarlineMarketData>[];
  //       if (starLineMarketList.isNotEmpty) {
  //         var biddingOpenMarketList =
  //             starLineMarketList.where((element) => element.isBidOpen == true && element.isBlocked == false).toList();
  //         var biddingClosedMarketList =
  //             starLineMarketList.where((element) => element.isBidOpen == false && element.isBlocked == false).toList();
  //         var tempFinalMarketList = <StarlineMarketData>[];
  //         biddingOpenMarketList.sort((a, b) {
  //           DateTime dateTimeA = DateFormat('hh:mm a').parse(a.time ?? "00:00 AM");
  //           DateTime dateTimeB = DateFormat('hh:mm a').parse(b.time ?? "00:00 AM");
  //           return dateTimeA.compareTo(dateTimeB);
  //         });
  //         tempFinalMarketList = biddingOpenMarketList;
  //         biddingClosedMarketList.sort((a, b) {
  //           DateTime dateTimeA = DateFormat('hh:mm a').parse(a.time ?? "00:00 AM");
  //           DateTime dateTimeB = DateFormat('hh:mm a').parse(b.time ?? "00:00 AM");
  //           return dateTimeA.compareTo(dateTimeB);
  //         });
  //         tempFinalMarketList.addAll(biddingClosedMarketList);
  //         starLineMarketList.value = tempFinalMarketList;
  //         // print("Star ********************* ${starLineMarketList.toJson()}");
  //       }
  //     } else {
  //       AppUtils.showErrorSnackBar(bodyText: value['message'] ?? "");
  //     }
  //   });
  // }

  // void getDailyMarkets() async {
  //   ApiService().getDailyMarkets().then((value) async {
  //     if (value['status']) {
  //       DailyMarketApiResponseModel marketModel = DailyMarketApiResponseModel.fromJson(value);
  //       if (marketModel.data != null && marketModel.data!.isNotEmpty) {
  //         normalMarketList.value = marketModel.data!;
  //         noMarketFound.value = false;
  //         var biddingOpenMarketList = normalMarketList
  //             .where((element) =>
  //                 (element.isBidOpenForClose == true || element.isBidOpenForOpen == true) && element.isBlocked == false)
  //             .toList();
  //         var biddingClosedMarketList = normalMarketList
  //             .where((element) =>
  //                 (element.isBidOpenForOpen == false && element.isBidOpenForClose == false) &&
  //                 element.isBlocked == false)
  //             .toList();
  //         var tempFinalMarketList = <MarketData>[];
  //         biddingOpenMarketList.sort((a, b) {
  //           DateTime dateTimeA = DateFormat('hh:mm a').parse(a.openTime ?? "00:00 AM");
  //           DateTime dateTimeB = DateFormat('hh:mm a').parse(b.openTime ?? "00:00 AM");
  //           return dateTimeA.compareTo(dateTimeB);
  //         });
  //         tempFinalMarketList = biddingOpenMarketList;
  //         biddingClosedMarketList.sort((a, b) {
  //           DateTime dateTimeA = DateFormat('hh:mm a').parse(a.openTime ?? "00:00 AM");
  //           DateTime dateTimeB = DateFormat('hh:mm a').parse(b.openTime ?? "00:00 AM");
  //           return dateTimeA.compareTo(dateTimeB);
  //         });
  //         tempFinalMarketList.addAll(biddingClosedMarketList);
  //         normalMarketList.value = tempFinalMarketList;
  //       } else {
  //         noMarketFound.value = true;
  //       }
  //     } else {
  //       AppUtils.showErrorSnackBar(bodyText: value['message'] ?? "");
  //     }
  //   });
  // }
  //
  // Widget getDashBoardPages(index, BuildContext context, {required String notificationCount}) {
  //   switch (index) {
  //     case 0:
  //       return const HomeScreen();
  //     case 1:
  //       return BidHistory(appbarTitle: "Your Market");
  //     case 2:
  //       return SPLWallet();
  //     case 3:
  //       return PassBook();
  //     case 4:
  //       return MoreOptions();
  //     case 5:
  //       return WithdrawalPage();
  //     default:
  //       return SafeArea(
  //         child: SizedBox(
  //           // color: AppColors.grey,
  //           height: Get.height,
  //           width: double.infinity,
  //           child: SingleChildScrollView(
  //             scrollDirection: Axis.vertical,
  //             child: Column(
  //               children: [
  //                 SizedBox(height: Dimensions.h10),
  //                 HomeScreenUtils().banner(),
  //                 SizedBox(height: Dimensions.h10),
  //                 Padding(
  //                   padding: EdgeInsets.symmetric(horizontal: Dimensions.h10),
  //                   child: Container(
  //                     decoration: BoxDecoration(
  //                       color: AppColors.white,
  //                       boxShadow: [
  //                         BoxShadow(
  //                           spreadRadius: 1,
  //                           color: AppColors.grey,
  //                           blurRadius: 7,
  //                           offset: const Offset(6, 4),
  //                         )
  //                       ],
  //                       borderRadius: BorderRadius.circular(Dimensions.h5),
  //                       border: Border.all(color: AppColors.redColor, width: 1),
  //                     ),
  //                     //padding: const EdgeInsets.symmetric(horizontal: 60),
  //                     child: Column(
  //                       children: [
  //                         SizedBox(height: Dimensions.h10),
  //                         HomeScreenUtils().iconsContainer(
  //                           iconColor1:
  //                               homeCon.widgetContainer.value == 0 ? AppColors.appbarColor : AppColors.iconColorMain,
  //                           iconColor2:
  //                               homeCon.widgetContainer.value == 1 ? AppColors.appbarColor : AppColors.iconColorMain,
  //                           iconColor3:
  //                               homeCon.widgetContainer.value == 2 ? AppColors.appbarColor : AppColors.iconColorMain,
  //                           onTap1: () {
  //                             homeCon.position = 0;
  //                             homeCon.widgetContainer.value = homeCon.position;
  //                             isStarline.value = false;
  //                             // print(widgetContainer.value);
  //                           },
  //                           onTap2: () {
  //                             homeCon.position = 1;
  //                             homeCon.isStarline.value = true;
  //                             homeCon.widgetContainer.value = homeCon.position;
  //                             //   print(widgetContainer.value);
  //                           },
  //                           onTap3: () {
  //                             homeCon.position = 2;
  //                             homeCon.widgetContainer.value = homeCon.position;
  //                             homeCon.isStarline.value = false;
  //                           },
  //                         ),
  //                         SizedBox(height: Dimensions.h10),
  //                         Obx(
  //                           () => homeCon.isStarline.value
  //                               ? HomeScreenUtils().iconsContainer2(
  //                                   iconColor1: homeCon.widgetContainer.value == 3
  //                                       ? AppColors.appbarColor
  //                                       : AppColors.iconColorMain,
  //                                   iconColor2: homeCon.widgetContainer.value == 4
  //                                       ? AppColors.appbarColor
  //                                       : AppColors.iconColorMain,
  //                                   iconColor3: homeCon.widgetContainer.value == 5
  //                                       ? AppColors.appbarColor
  //                                       : AppColors.iconColorMain,
  //                                   onTap1: () {
  //                                     homeCon.position = 3;
  //                                     homeCon.widgetContainer.value = homeCon.position;
  //                                     //   print(widgetContainer.value);
  //                                   },
  //                                   onTap2: () {
  //                                     homeCon.position = 4;
  //                                     homeCon.widgetContainer.value = homeCon.position;
  //                                   },
  //                                   onTap3: () {
  //                                     homeCon.position = 5;
  //                                     homeCon.widgetContainer.value = homeCon.position;
  //                                     // print(widgetContainer.value);
  //                                   })
  //                               : Container(),
  //                         ),
  //                         SizedBox(height: Dimensions.h10)
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //                 Obx(
  //                   () => Column(
  //                     children: [getDashBoardWidget(homeCon.widgetContainer.value, context)],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //   }
  // }

  // Widget getDashBoardWidget(index, BuildContext context) {
  //   switch (index) {
  //     case 0:
  //       return NormalMarketScreen();
  //     case 1:
  //       return Padding(
  //           padding: EdgeInsets.symmetric(horizontal: Dimensions.h5), child: HomeScreenUtils().gridColumnForStarLine());
  //     case 2:
  //       return Container();
  //     case 3:
  //       return Padding(
  //           padding: EdgeInsets.symmetric(horizontal: Dimensions.h10), child: HomeScreenUtils().bidHistory(context));
  //     case 4:
  //       return Padding(
  //           padding: EdgeInsets.symmetric(horizontal: Dimensions.h10), child: HomeScreenUtils().resultHistory(context));
  //     case 5:
  //       return Column(
  //         children: [
  //           SizedBox(
  //             height: Dimensions.h10,
  //           ),
  //           const Text("Starline Chart", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
  //           SizedBox(height: Dimensions.h5),
  //           // homeCon.starlineChartDateAndTime.isEmpty
  //           //     ? SizedBox(
  //           //         height: Get.height / 2.5,
  //           //         child: Center(
  //           //           child: Text(
  //           //             "There is no Data in Starlin Chart",
  //           //             style: CustomTextStyle.textRobotoSansMedium,
  //           //           ),
  //           //         ),
  //           //       )
  //           //     : SingleChildScrollView(
  //           //         scrollDirection: Axis.vertical,
  //           //         child: Row(
  //           //           children: [HomeScreenUtils().dateColumn(), Expanded(child: HomeScreenUtils().timeColumn())],
  //           //         ),
  //           //       ),
  //         ],
  //       );
  //     default:
  //       return HomeScreenUtils().gridColumn();
  //   }
  // }

  // onTapOfNormalMarket(MarketData market) {
  //   if (market.isBidOpenForClose ?? false) {
  //     Get.toNamed(AppRouteNames.gameModePage, arguments: market);
  //   } else {
  //     AppUtils.showErrorSnackBar(bodyText: "Bidding is Closed!!!!");
  //   }
  // }
  //
  // void onTapOfStarlineMarket(StarlineMarketData market) {
  //   if (market.isBidOpen ?? false) {
  //     Get.toNamed(
  //       AppRouteNames.starLineGameModesPage,
  //       arguments: market,
  //     );
  //   } else {
  //     AppUtils.showErrorSnackBar(bodyText: "Bidding is Closed!!!!");
  //   }
  // }

  // void getDailyStarLineMarkets(String startDate, String endDate) async {
  //   ApiService().getDailyStarLineMarkets(startDate: startDate, endDate: endDate).then((value) async {
  //     if (value['status']) {
  //       StarLineDailyMarketApiResponseModel responseModel = StarLineDailyMarketApiResponseModel.fromJson(value);
  //       marketList.value = responseModel.data ?? <StarlineMarketData>[];
  //       marketListForResult.value = responseModel.data ?? <StarlineMarketData>[];
  //       if (marketList.isNotEmpty) {
  //         var biddingOpenMarketList =
  //             marketList.where((element) => element.isBidOpen == true && element.isBlocked == false).toList();
  //         var biddingClosedMarketList =
  //             marketList.where((element) => element.isBidOpen == false && element.isBlocked == false).toList();
  //         var tempFinalMarketList = <StarlineMarketData>[];
  //         biddingOpenMarketList.sort((a, b) {
  //           DateTime dateTimeA = DateFormat('hh:mm a').parse(a.time ?? "00:00 AM");
  //           DateTime dateTimeB = DateFormat('hh:mm a').parse(b.time ?? "00:00 AM");
  //           return dateTimeA.compareTo(dateTimeB);
  //         });
  //         tempFinalMarketList = biddingOpenMarketList;
  //         biddingClosedMarketList.sort((a, b) {
  //           DateTime dateTimeA = DateFormat('hh:mm a').parse(a.time ?? "00:00 AM");
  //           DateTime dateTimeB = DateFormat('hh:mm a').parse(b.time ?? "00:00 AM");
  //           return dateTimeA.compareTo(dateTimeB);
  //         });
  //         tempFinalMarketList.addAll(biddingClosedMarketList);
  //         marketList.value = tempFinalMarketList;
  //         marketListForResult.sort((a, b) {
  //           DateTime dateTimeA = DateFormat('hh:mm a').parse(a.time ?? "00:00 AM");
  //           DateTime dateTimeB = DateFormat('hh:mm a').parse(b.time ?? "00:00 AM");
  //           return dateTimeA.compareTo(dateTimeB);
  //         });
  //       }
  //     } else {
  //       AppUtils.showErrorSnackBar(bodyText: value['message'] ?? "");
  //     }
  //   });
  // }

  // String getResult(bool resultDeclared, int result) {
  //   if (resultDeclared) {
  //     int sum = 0;
  //     for (int i = result; i > 0; i = (i / 10).floor()) {
  //       sum += (i % 10);
  //     }
  //     return "$result - ${sum % 10}";
  //   } else {
  //     return "***-*";
  //   }
  // }
  //
  // String getResult2(bool resultDeclared, int result) {
  //   if (resultDeclared) {
  //     int sum = 0;
  //     for (int i = result; i > 0; i = (i / 10).floor()) {
  //       sum += (i % 10);
  //     }
  //
  //     return "$result";
  //   } else {
  //     return "***";
  //   }
  // }
  //
  // String getResult3(bool resultDeclared, int result) {
  //   if (resultDeclared) {
  //     int sum = 0;
  //     for (int i = result; i > 0; i = (i / 10).floor()) {
  //       sum += (i % 10);
  //     }
  //     return "${sum % 10}";
  //   } else {
  //     return "*";
  //   }
  // }

  // reverse(String originalString) {
  //   String reversedString = '';
  //
  //   for (int i = originalString.length - 1; i >= 0; i--) {
  //     reversedString += originalString[i];
  //   }
  //   return reversedString;
  // }

  // var cellValue;
  // void callGetStarLineChart() async {
  //   ApiService().getStarlineChar().then((value) async {
  //     if (value['status']) {
  //       NewStarLineChartModel model = NewStarLineChartModel.fromJson(value);
  //       starlineChartDateAndTime.value = model.data!.data!;
  //       for (var i = 0; i < model.data!.markets!.length; i++) {
  //         starlineChartTime.value = model.data!.markets as List<Markets>;
  //       }
  //     } else {
  //       AppUtils.showErrorSnackBar(bodyText: value['message'] ?? "");
  //     }
  //   });
  // }

  // void getNotificationCount() async {
  //   ApiService().getNotificationCount().then((value) async {
  //     if (value['status']) {
  //       NotifiactionCountModel model = NotifiactionCountModel.fromJson(value);
  //       getNotifiactionCount.value = model.data!.notificationCount == null ? 0 : model.data!.notificationCount!.toInt();
  //       if (model.message!.isNotEmpty) {
  //         AppUtils.showSuccessSnackBar(bodyText: model.message, headerText: "SUCCESSMESSAGE".tr);
  //       }
  //     } else {
  //       AppUtils.showErrorSnackBar(bodyText: value['message'] ?? "");
  //     }
  //   });
  // }

  // final int itemLimit = 30;

  // void getPassBookData({required bool lazyLoad, required String offset}) {
  //   ApiService()
  //       .getPassBookData(
  //     userId: userData.id.toString(),
  //     isAll: true,
  //     limit: itemLimit.toString(),
  //     offset: offset.toString(),
  //   )
  //       .then((value) async {
  //     if (value['status']) {
  //       if (value['data'] != null) {
  //         PassbookModel model = PassbookModel.fromJson(value);
  //         passbookCount.value = int.parse(model.data!.count!.toString());
  //         passBookModelData.value = model.data?.rows ?? <Rows>[];
  //         passBookModelData.refresh();
  //       }
  //     } else {
  //       AppUtils.showErrorSnackBar(bodyText: value['message'] ?? "");
  //     }
  //   });
  // }

  // int calculateTotalPages() {
  //   var passbookValue = (passbookCount.value / itemLimit).ceil() - 1;
  //   var passbookValueZero = (passbookCount.value / itemLimit).ceil();
  //   if (passbookCount.value < 30) {
  //     return passbookValueZero;
  //   } else {
  //     return passbookValue;
  //   }
  // }
  //
  // var num = 0;
  //
  // void nextPage() {
  //   if (offset.value < calculateTotalPages()) {
  //     ///  print("offset.value ${offset.value}");
  //     passBookModelData.clear();
  //     offset.value++;
  //
  //     num = num + itemLimit;
  //
  //     //  print("offset.value ${offset.value}");
  //     getPassBookData(lazyLoad: false, offset: num.toString());
  //     //  print("offset.value ${offset.value}");
  //     // passBookModelData.refresh();
  //     update();
  //   }
  // }

  // void prevPage() {
  //   if (offset.value > 0) {
  //     passBookModelData.clear();
  //     offset.value--;
  //     num = num - itemLimit;
  //
  //     //print("offset.value ${offset.value}");
  //     getPassBookData(lazyLoad: false, offset: num.toString());
  //     // print("offset.value ${offset.value}");
  //     passBookModelData.refresh();
  //     update();
  //   }
  // }

  // void getUserBalance() {
  //   ApiService().getBalance().then(
  //     (value) async {
  //       if (value['status']) {
  //         if (value['data'] != null) {
  //           var tempBalance = value['data']['Amount'] ?? 00;
  //           walletBalance.value = tempBalance.toString();
  //         }
  //       } else {
  //         AppUtils.showErrorSnackBar(bodyText: value['message'] ?? "");
  //       }
  //     },
  //   );
  // }

  // void resetNotificationCount() async {
  //   ApiService().resetNotification().then((value) {
  //     debugPrint("Notifiaction Count Api ------------- :- $value");
  //     if (value['status']) {
  //       NotifiactionCountModel model = NotifiactionCountModel.fromJson(value);
  //       getNotifiactionCount.value = model.data!.notificationCount!.toInt();
  //       if (model.message!.isNotEmpty) {}
  //     } else {
  //       AppUtils.showErrorSnackBar(
  //         bodyText: value['message'] ?? "",
  //       );
  //     }
  //   });
  // }

  // void getBennerData() async {
  //   ApiService().getBennerData().then((value) async {
  //     debugPrint("benner Response Api ------------- :- $value");
  //     if (value['status']) {
  //       BannerModel model = BannerModel.fromJson(value);
  //       bennerData.value = model.data as List<BannerDataModel>;
  //       //  NotifiactionCountModel model = NotifiactionCountModel.fromJson(value);
  //       // getNotifiactionCount.value = model.data!.notificationCount!.toInt();
  //       // if (model.message!.isNotEmpty) {}
  //     } else {
  //       AppUtils.showErrorSnackBar(bodyText: value['message'] ?? "");
  //     }
  //   });
  // }
}
