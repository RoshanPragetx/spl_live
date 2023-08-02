import 'package:get/get.dart';

import '../controller/digit_based_page_controller.dart';

class DigitBasedPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DigitBasedPageController());
  }
}
