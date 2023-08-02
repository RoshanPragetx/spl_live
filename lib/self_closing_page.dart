import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppLifecycleController extends GetxController
    with WidgetsBindingObserver {
  Timer? _timer;
  bool _isActive = true;

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    //  startTimer();
    super.onInit();
  }

  @override
  void onClose() {
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  void resetTimer() {
    _timer?.cancel();
    startTimer();
  }

  void startTimer() {
    _isActive = false;
    _timer = Timer(const Duration(minutes: 3), () {
      if (!_isActive) {
        ///  Get.close(1); // Close the app entirely.
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // if (state == AppLifecycleState.inactive) {
    //   resetTimer();
    // } else {
    //   startTimer();
    //   print("hello");
    // }
  }
}
