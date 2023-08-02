import 'package:get/get.dart';
import 'package:spllive/screens/New%20GameModes/controller/new_gamemode_page_controller.dart';

class NewGamemodePageBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewGamemodePageController());
  }
}
