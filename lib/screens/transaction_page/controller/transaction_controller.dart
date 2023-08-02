// ignore_for_file: unused_local_variable

import 'package:get/get.dart';
import '../../../helper_files/constant_variables.dart';
import '../../../models/transaction_history_api_response_model.dart';
import '../../Local Storage.dart';

class TransactionHistoryPageController extends GetxController {
  var transactionModel = TransactionHistoryApiResponseModel();
  var transactionList = <TransactionData>[].obs;
  // UserData userDetailsModel = UserData();
  int offset = 1;
  // Future<void> onSwipeRefresh() async {
  //   if (userDetailsModel.id != null) {
  //     getTransactionHistory(offset: offset);
  //   } else {
  //     UIUtils.showErrorSnackBar(
  //       bodyText: "SOMETHINGWENTWRONG".tr,
  //     );
  //   }
  // }

  Future<void> fetchUserData() async {
    var userData = await LocalStorage.read(ConstantsVariables.userData);
    // userDetailsModel = UserData.fromJson(userData);
    // if (userDetailsModel.id != null) {
    //   getTransactionHistory(offset: offset);
    // } else {
    //   AppUtils.showErrorSnackBar(
    //     bodyText: "SOMETHINGWENTWRONG".tr,
    //   );
    // }
  }

  // void getTransactionHistory({required int offset}) async {
  //   ApiService()
  //       .getTransactionHistoryById(userId: 1, offset: offset)
  //       // userId: userDetailsModel.id ?? 0, offset: offset)
  //       .then((value) async {
  //     print("Get transaction history Api Response :- $value");
  //     if (value['status']) {
  //       transactionModel = TransactionHistoryApiResponseModel.fromJson(value);
  //       if (transactionModel.data != null &&
  //           transactionModel.data!.isNotEmpty) {
  //         transactionList.value = transactionModel.data!;
  //       } else {}
  //     } else {
  //       AppUtils.showErrorSnackBar(
  //         bodyText: value['message'] ?? "",
  //       );
  //     }
  //   });
  // }
}
