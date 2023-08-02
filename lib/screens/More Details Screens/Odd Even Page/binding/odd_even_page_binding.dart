import 'package:get/get.dart';

import '../controller/odd_even_page_controller.dart';

class OddEvenPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OddEvenPageController());
  }
}
