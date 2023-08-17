import 'package:get/get.dart';

import '../controller/starline_bids_controller.dart';

class StarlineBidsBidings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StarlineBidsController());
  }
}
