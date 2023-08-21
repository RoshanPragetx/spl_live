import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../api_services/api_service.dart';
import '../../../helper_files/ui_utils.dart';
import '../../../models/bid_history_market_model.dart';
import '../../../models/bid_history_model_new.dart';

class BidHistoryPageDetailsController extends GetxController {
  var openBiddingOpen = true.obs;
  var openCloseValue = "OPENBID".tr.obs;
  RxBool closeBiddingOpen = true.obs;
  RxInt openCloseRadioValue = 0.obs;
  RxInt bidHistoryCount = 0.obs;
  RxList<Rows> bidHistoryData = <Rows>[].obs;
  var arguments = Get.arguments;
  String limit = "20";
  RxList<BidHistoryNew> marketbidhistory = <BidHistoryNew>[].obs;
  RxString id = "".obs;
  RxString marketName = "".obs;
  Iterable<Rows>? openBid;
  Iterable<Rows>? closeBid;
  RxList<Rows> openBidList = <Rows>[].obs;
  RxList<Rows> closeBidList = <Rows>[].obs;
  RxString openResult = "".obs;
  RxString closeResult = "".obs;

  @override
  void onInit() {
    marketbidhistory.value = arguments["marketData"];
    for (var i = 0; i < marketbidhistory.value.length; i++) {
      print(marketbidhistory[i].toJson());
    }
    id.value = arguments["marketId"];
    marketName.value = arguments["marketName"];
    getPassBookData(lazyLoad: false);
    super.onInit();
  }

  // openClose() {
  //   print("@@@@@@@@@@@@${openCloseRadioValue.value}");
  //   if (openCloseRadioValue.value == 0) {
  //     openBidList.value = openBid!.toList();
  //     getPassBookData(lazyLoad: false);
  //     // print("########################${openBidList.value}");
  //   } else {
  //     closeBidList.value = closeBid!.toList();

  //     print("12 ${closeBidList}");
  //   }
  // }

  void getPassBookData({required bool lazyLoad}) {
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@${openCloseRadioValue.value}");
    ApiService()
        .getNewMarketBidlistData(
      bidType: openCloseRadioValue.value == 0 ? "Open" : "Close",
      dailyMarketId: id.value.toString(),
      limit: limit,
      offset: "0",
    )
        .then((value) async {
      debugPrint(" Get passBook Data @@@@@@@@@@@@@@@@:- $value");
      if (value['status']) {
        if (value['data'] != null) {
          NewBidhistorypageModel model = NewBidhistorypageModel.fromJson(value);
          print("wqewewqewqewqewq ${model.data!.count.toString()}");
          bidHistoryCount.value = int.parse(model.data!.count!.toString());
          bidHistoryData.value = model.data?.rows ?? <Rows>[];
          bidHistoryData.refresh();
          // openBid = bidHistoryData.where((element) {
          //   return element.bidType == "Open";
          // });
          // closeBid = bidHistoryData.where((element) {
          //   return element.bidType == "Close";
          // });

          // openBidList.value = openBid!.toList();
          // closeBidList.value = closeBid!.toList();
          // print("=== Kaushal   open${openBidList.value}");
          // print("=== Kaushal    close ${closeBidList.value}");
          bidHistoryData.refresh();
          // closeBidList.refresh();
          // openBidList.refresh();
          // passBookList.value = model.data ?? <Data>[];
        } else {}
      } else {
        AppUtils.showErrorSnackBar(
          bodyText: value['message'] ?? "",
        );
      }
    });
  }
}
