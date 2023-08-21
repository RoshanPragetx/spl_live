import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:spllive/routes/app_routes_name.dart';

import '../../../helper_files/constant_variables.dart';
import '../../../models/commun_models/user_details_model.dart';
import '../../Local Storage.dart';

class SplashController extends GetxController {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  UserDetailsModel _userDetailsModel = UserDetailsModel();

  @override
  void onInit() {
    checkLogin();
    super.onInit();
  }

  Future<void> checkLogin() async {
    bool alreadyLoggedIn = await getStoredUserData();
    bool isActive =
        await LocalStorage.read(ConstantsVariables.isActive) ?? false;

    print(isActive);
    bool isVerified =
        await LocalStorage.read(ConstantsVariables.isVerified) ?? false;
    bool hasMPIN =
        await LocalStorage.read(ConstantsVariables.isMpinSet) ?? false;
    //print(LocalStorage.read(ConstantsVariables.authToken.));

    await Future.delayed(const Duration(seconds: 2));

    if (alreadyLoggedIn) {
      if (!isActive && !isVerified) {
        Future.delayed(const Duration(seconds: 2), () {
          Get.offAllNamed(AppRoutName.verifyOTPPage);
        });
      } else if (isVerified && !isActive) {
        Future.delayed(const Duration(seconds: 2), () {
          Get.offAllNamed(AppRoutName.userDetailsPage);
        });
      } else {
        if (hasMPIN) {
          Get.offAllNamed(AppRoutName.mPINPage,
              arguments: {"id": _userDetailsModel.id});
        } else {
          Get.offAllNamed(AppRoutName.signInPage,
              arguments: {"id": _userDetailsModel.id});
        }
      }
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        // Get.offAllNamed(AppRoutes.dashboardPage);
        Get.offAllNamed(AppRoutName.walcomeScreen);
      });
    }
  }

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
}
