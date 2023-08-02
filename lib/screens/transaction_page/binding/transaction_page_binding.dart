import 'package:get/get.dart';

import '../controller/transaction_controller.dart';

class TransactionPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionHistoryPageController());
  }
}
