import 'package:get/get.dart';

import '../controller/starline_new_game_page_controller.dart';

class StarlineNewGamePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StarlineNewGamePageController());
  }
}
