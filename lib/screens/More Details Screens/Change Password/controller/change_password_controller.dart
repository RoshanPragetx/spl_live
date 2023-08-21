// ignore_for_file: unused_import

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:spllive/helper_files/ui_utils.dart';
import 'package:spllive/routes/app_routes_name.dart';

import '../../../../api_services/api_service.dart';
import '../../../../helper_files/constant_variables.dart';
import '../../../../models/commun_models/user_details_model.dart';
import '../../../Local Storage.dart';

class ChangepasswordPageController extends GetxController {
  // final password = TextEditingController().obs;
  // final confirmpassword = TextEditingController().obs;
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  UserDetailsModel userDetailsModel = UserDetailsModel();
  RxBool value = true.obs;
  // final FocusNode oldMPASSWORDFocusNode = FocusNode();
  // final FocusNode newMPASSWORDFocusNode = FocusNode();
  // final FocusNode reEnterPASSWORDFocusNode = FocusNode();
  RxBool loading = false.obs;
  RxBool isObscureOldPassword = true.obs;
  RxBool isObscureNewPassword = true.obs;
  RxBool isObscureConfirmPassword = true.obs;
  RxBool isValidate = false.obs;
  RxString oldPasswordMessage = "".obs;
  RxString newPasswordMessage = "".obs;
  RxString confirmPasswordMessage = "".obs;

  @override
  void onInit() {
    fetchSavedData();
    super.onInit();
  }

  onChanged(String value) {
    if (value.isEmpty) {
      oldPasswordMessage.value = "";
    } else if (value.length < 6) {
      oldPasswordMessage.value = "Password cannot be less than 6 characters";
    } else {
      oldPasswordMessage.value = "";
    }
  }

  onChanged2(String value) {
    if (value.isEmpty) {
      newPasswordMessage.value = "";
    } else if (value.length < 6) {
      newPasswordMessage.value = "Password cannot be less than 6 characters";
    } else {
      newPasswordMessage.value = "";
    }
  }

  onChanged3(String value) {
    if (value.isEmpty) {
      confirmPasswordMessage.value = "Password is required";
    } else if (value.length < 6) {
      confirmPasswordMessage.value = "";

      // Password cannot be less than 6 characters
    } else if (value == newPassword.text) {
      isValidate.value = true;
      confirmPasswordMessage.value = "Password Matched";
    } else if (value != newPassword.text) {
      isValidate.value = false;
      confirmPasswordMessage.value = "Password does Not Matched";
    } else {
      confirmPasswordMessage.value = "";
    }
  }

  @override
  void dispose() {
    // oldPassword.dispose();
    // oldMPASSWORDFocusNode.dispose();
    // newMPASSWORDFocusNode.dispose();
    // reEnterPASSWORDFocusNode.dispose();
    newPassword.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>> changebody(
      {required String password, required String confirmpassword}) async {
    var veriftybody = {
      "oldPassword": "123456",
      "password": password,
      "confirmPassword": confirmpassword,
    };
    return veriftybody;
  }

  changePassBody() async {
    final verifyUserBody = {
      "oldPassword": oldPassword.text,
      "password": newPassword.text,
      "confirmPassword": confirmPassword.text,
    };
    debugPrint(verifyUserBody.toString());
    return verifyUserBody;
  }

  void changePasswordApi() async {
    ApiService().changePassword(await changePassBody()).then((value) async {
      debugPrint("Verify OTP Api Response :- $value");
      if (value['status']) {
        print(value['status']);
        AppUtils.showSuccessSnackBar(
            bodyText: value['message'] ?? "", headerText: "SUCCESSMESSAGE".tr);
        Get.offAndToNamed(AppRoutName.profilePage);
      } else {
        AppUtils.showErrorSnackBar(
          bodyText: value['message'] ?? "",
        );
      }
    });
  }

  void onTapConfirmPass() {
    FocusManager.instance.primaryFocus?.unfocus();
    Get.closeCurrentSnackbar();
    if (oldPassword.text.isEmpty) {
      // AppUtils.showErrorSnackBar(
      //   bodyText: "Enter Old Password",
      // );
      oldPasswordMessage.value = "Enter Old Password";
    }
    if (newPassword.text.isEmpty) {
      // AppUtils.showErrorSnackBar(
      //   bodyText: "Enter New Password",
      // );
      newPasswordMessage.value = "Enter New Password";
    } else if (confirmPassword.text.isEmpty) {
      // AppUtils.showErrorSnackBar(
      //   bodyText: "Enter Confirm Password",
      // );
      confirmPasswordMessage.value = "Enter Confirm Password";
    } else {
      changePasswordApi();
    }
  }

  Future<dynamic> fetchSavedData() async {
    var userData = await LocalStorage.read(ConstantsVariables.userData);
    userDetailsModel = UserDetailsModel.fromJson(userData);
    print("Get User Data ***********************${userDetailsModel.toJson()}");
  }
}

// // import 'package:get/get.dart';
// // import '../../../../models/commun_models/user_details_model.dart';

// // class ChangepasswordPageController extends GetxController {
// //   UserDetailsModel userDetailsModel = UserDetailsModel();
// //   RxBool value = true.obs;
// //   void navigateTo(context, routeString) {
// //     Get.toNamed(routeString);
// //   }
// // }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart';
// import '../../../../helper_files/constant_variables.dart';
// import '../../../../models/commun_models/user_details_model.dart';
// import '../../../Local Storage.dart';

// class ChangepasswordPageController extends GetxController {
//   TextEditingController password = TextEditingController();
//   TextEditingController confirmpassword = TextEditingController();
//   UserDetailsModel userDetailsModel = UserDetailsModel();
//   RxBool value = true.obs;

//   RxBool loading = false.obs;

//   @override
//   void onInit() {
//     fetchSavedData();
//     // TODO: implement onInit
//     super.onInit();
//   }

//   changebody() async {
//     var veriftybody = {
//       "oldPassword": "123456",
//       "password": password,
//       "confirmPassword": confirmpassword,
//     };
//     return veriftybody;
//   }

//   Future<dynamic> changepasswordapi() async {
//     print('Token name : ${userDetailsModel.token}');
//     loading.value = true;

//     try {
//       final response = await post(
//           Uri.parse('http://43.205.145.101:9867/auth/changePassword'),
//           headers: {"Authorization": "Bearer ${userDetailsModel.token}"},
//           body: changebody());
//       // ignore: unused_local_variable
//       var data = jsonDecode(response.body);
//       // var tokendata = data['data'];

//       if (response.statusCode == 200) {
//         loading.value = false;
//         Get.snackbar('Success Message', 'Change successfully',
//             colorText: Colors.black,
//             backgroundColor: const Color.fromARGB(255, 82, 183, 86));
//         // API call successful
//         print('API call successful');
//         print(response.body);
//         // print('Token : ${tokendata['Token']}');
//       } else {
//         loading.value = false;

//         // API call failed
//         print('API call failed');
//         print(response.statusCode);
//       }
//     } catch (error) {
//       loading.value = false;
//       // Error occurred during API call
//       print('Error: $error');
//     }
//   }

//   Future<dynamic> fetchSavedData() async {
//     var userData = await LocalStorage.read(ConstantsVariables.userData);
//     userDetailsModel = UserDetailsModel.fromJson(userData);
//     print("Get User Data ***********************${userDetailsModel.toJson()}");
//   }
// }
