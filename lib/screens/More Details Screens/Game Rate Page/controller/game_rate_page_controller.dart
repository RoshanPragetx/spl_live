import 'package:get/get.dart';
import 'package:spllive/helper_files/ui_utils.dart';

import '../../../../api_services/api_service.dart';
import '../../../../models/game_rates_api_response_model.dart';

class GameRatePageController extends GetxController {
  var normalMarketModel = MarketRatesApiResponseModel().obs;
  var starlineMarketModel = MarketRatesApiResponseModel().obs;

  @override
  void onInit() {
    super.onInit();
    getGameRates(forStarlineGameModes: true);
    getGameRates(forStarlineGameModes: false);
  }

  @override
  void onClose() {}

  @override
  void onReady() {}

  void getGameRates({required bool forStarlineGameModes}) {
    ApiService()
        .getGameRates(forStarlineGameModes: forStarlineGameModes)
        .then((value) async {
      print("Get GameRate Api Response :- $value");
      if (value['status']) {
        if (forStarlineGameModes) {
          starlineMarketModel.value =
              MarketRatesApiResponseModel.fromJson(value);
          print(starlineMarketModel.value);
        } else {
          normalMarketModel.value = MarketRatesApiResponseModel.fromJson(value);
          print(normalMarketModel.value);
        }
      } else {
        AppUtils.showErrorSnackBar(
          bodyText: value['message'] ?? "",
        );
      }
    });
  }

  Future<void> onSwipeRefresh() async {
    getGameRates(forStarlineGameModes: true);
    getGameRates(forStarlineGameModes: false);
  }
}
