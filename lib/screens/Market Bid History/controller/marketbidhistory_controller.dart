import 'package:get/get.dart';

import '../../../api_services/api_service.dart';
import '../model/bid_model.dart';

class MarketBidHistoryController extends GetxController {
  RxBool openCloseRadioValue = false.obs;
  var openBiddingOpen = true.obs;
  // var openCloseRadioValue = 0.obs;
  var openCloseValue = "OPENBID".tr.obs;
  var closeBiddingOpen = true.obs;
  ApiService apiService = ApiService();
  Rx<BidModel> bidModel = BidModel().obs;

  // Future<void> markettime({
  //   required String marketId,
  // }) async {
  //   var data = await apiService.markettime(marketId: marketId);

  //   bidModel.value = data;
  //   print(bidModel.value.data?.rows?.first.balance);
  //   print(bidModel.value.data?.rows?.first.bidNo);
  //   print("dk");
  // }

  onTapOpenClose() {
    if (openBiddingOpen.value && openCloseValue.value != "OPENBID".tr) {
      openCloseValue.value = "OPENBID".tr;
      openBiddingOpen();
    } else {
      openCloseValue();
    }
  }
  // Future<dynamic> BidHistoryByUserId({
  //   required String userId,
  // }) async {
  //   print("${ApiUtils.marketbidHistory}/$userId");
  //   AppUtils.showProgressDialog(isCancellable: false);
  //   await initApiService();
  //   final response = await get(
  //     "${ApiUtils.marketbidHistory}/$userId",
  //     headers: headersWithToken,
  //   );
  //   if (response.status.hasError) {
  //     if (response.status.code != null && response.status.code == 401) {
  //       tokenExpired();
  //     }
  //     AppUtils.hideProgressDialog();

  //     return Future.error(response.statusText!);
  //   } else {
  //     AppUtils.hideProgressDialog();

  //     return response.body;
  //   }
  // }
}
