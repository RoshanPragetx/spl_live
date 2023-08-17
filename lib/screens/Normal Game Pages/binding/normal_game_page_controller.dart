import 'package:get/get.dart';
import '../controller/normal_game_page_controller.dart';

class NormalGamePageBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NormalGamePageController());
  }
}
