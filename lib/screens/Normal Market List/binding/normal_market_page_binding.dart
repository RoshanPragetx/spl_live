import 'package:get/get.dart';
import 'package:spllive/screens/Normal%20Market%20List/controller/normal_market_page_controller.dart';

class NormalMarketPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NormalMarketPageController());
  }
}
