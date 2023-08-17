import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/constant_image.dart';
import 'package:spllive/helper_files/dimentions.dart';
import 'package:spllive/screens/Local%20Storage.dart';

import 'helper_files/app_colors.dart';
import 'helper_files/constant_variables.dart';
import 'helper_files/custom_text_style.dart';
import 'models/commun_models/user_details_model.dart';
import 'routes/app_routes_name.dart';

class InactivityController extends GetxController {
  // Adjust the duration as needed
  // RxBool isActive = true.obs; // Whether the user is active
  // void _startTimer() {
  //   Future.delayed(const Duration(seconds: 215), () {
  //     if (isActive.value) {
  //       isActive.value = false;
  //       _showExitDialog();
  //     }
  //   });
  // }

  // void resetTimer() {
  //   isActive.value = true;
  //   _startTimer();
  // }

  // @override
  // void onInit() {
  //   super.onInit();
  //   WidgetsBinding.instance.addObserver(this);
  //   // _startTimer();
  //   // ever(isActive, (value) {
  //   //   if (value) {
  //   //     _startTimer();
  //   //   }
  //   // });
  // }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);
  //   print("================================");
  //   print(state);
  // }

  // @override
  // void onClose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.onClose();
  // }
  Timer? _inactivityTimer;
  final Duration _inactivityDuration = const Duration(seconds: 180);

  @override
  void onInit() {
    super.onInit();
    _resetInactivityTimer();
  }

  void _resetInactivityTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(_inactivityDuration, () {
      // Navigate to the home screen or do other actions
      _showExitDialog();
    });
  }

  void onUserInteraction(PointerEvent event) {
    print("state change");
    _resetInactivityTimer();
  }

  @override
  void onClose() {
    _inactivityTimer?.cancel();
    super.onClose();
  }

  UserDetailsModel _userDetailsModel = UserDetailsModel();

  Future<bool> getStoredUserData() async {
    String? authToken = await LocalStorage.read(ConstantsVariables.authToken);
    var userData = await LocalStorage.read(ConstantsVariables.userData);
    if (authToken != null && authToken.isNotEmpty) {
      if (userData != null) {
        _userDetailsModel = UserDetailsModel.fromJson(userData);
      }
      return true;
    } else {
      return false;
    }
  }

  void _showExitDialog() {
    Get.defaultDialog(
      barrierDismissible: false,
      title: "",
      content: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            child: SvgPicture.asset(
              ConstantImage.clockIcon,
              color: AppColors.appbarColor,
            ),
          ),
          SizedBox(
            height: Dimensions.h10,
          ),
          Text(
            "Session Timeout",
            style: CustomTextStyle.textRobotoSansMedium.copyWith(
              fontSize: Dimensions.h15,
            ),
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            bool alreadyLoggedIn = await getStoredUserData();
            bool isActive =
                await LocalStorage.read(ConstantsVariables.isActive) ?? false;
            print(isActive);
            bool isVerified =
                await LocalStorage.read(ConstantsVariables.isVerified) ?? false;
            if (alreadyLoggedIn) {
              if (isActive && isVerified) {
                Get.offAllNamed(AppRoutName.mPINPage,
                    arguments: {"id": _userDetailsModel.id});
              }
            }
          },
          child: Text(
            'OK',
            style: CustomTextStyle.textRobotoSansBold.copyWith(
              color: AppColors.appbarColor,
            ),
          ),
        ),
      ],
    );
  }
}

// void _relaunchApp() {
//   AndroidIntent intent = AndroidIntent(
//     action: 'action.MAIN',
//     category: 'category.LAUNCHER',
//     package: 'your.package.name', // Replace with your app's package name
//   );
//   intent.launch();
// }
// }

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';

// class AppLifecycleController extends GetxController
//     with WidgetsBindingObserver {
//   Timer? _timer;
//   bool _isActive = true;

//   @override
//   void onInit() {
//     WidgetsBinding.instance.addObserver(this);
//     //  startTimer();
//     super.onInit();
//   }

//   @override
//   void onClose() {
//     _timer?.cancel();
//     WidgetsBinding.instance.removeObserver(this);
//     super.onClose();
//   }

//   void resetTimer() {
//     _timer?.cancel();
//     startTimer();
//   }

//   void startTimer() {
//     _isActive = false;
//     _timer = Timer(const Duration(minutes: 3), () {
//       if (!_isActive) {
//         ///  Get.close(1); // Close the app entirely.
//         SystemChannels.platform.invokeMethod('SystemNavigator.pop');
//       }
//     });
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     // if (state == AppLifecycleState.inactive) {
//     //   resetTimer();
//     // } else {
//     //   startTimer();
//     // }
//   }
// }

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';

// class AppLifecycleController extends GetxController
//     with WidgetsBindingObserver {
//   ValueNotifier<bool> _appActiveNotifier = ValueNotifier<bool>(true);
//   Timer? _timer;
//   bool _isActive = true;

//   @override
//   void onInit() {
//     WidgetsBinding.instance.addObserver(this);
//     _appActiveNotifier.addListener(_handleAppActivityChange);

//     super.onInit();
//   }

//   void _handleAppActivityChange() {
//     if (_appActiveNotifier.value) {
//       _resetTimer();
//     }
//   }

//   @override
//   void onClose() {
//     _timer?.cancel();
//     _appActiveNotifier.removeListener(_handleAppActivityChange);
//     WidgetsBinding.instance.removeObserver(this);

//     super.onClose();
//   }

//   void _resetTimer() {
//     _timer?.cancel();
//     _timer = Timer(const Duration(minutes: 3), () {
//       Get.close(1); // Close the app entirely.
//       SystemChannels.platform.invokeMethod('SystemNavigator.pop');
//     });
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     print("================================");
//     print(state);
//     // if (state == AppLifecycleState.inactive) {
//     //   _appActiveNotifier.value = false;
//     // } else if (state == AppLifecycleState.resumed) {
//     //   _appActiveNotifier.value = true;
//     // }
//   }
// }
