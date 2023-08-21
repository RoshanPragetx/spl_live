import 'package:get/get.dart';
import '../controller/bid_history_page_details_controller.dart';

class BidHistoryPageDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BidHistoryPageDetailsController());
  }
}
