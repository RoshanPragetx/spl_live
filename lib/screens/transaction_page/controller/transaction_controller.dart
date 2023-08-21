// ignore_for_file: unused_local_variable

import 'package:get/get.dart';
import '../../../api_services/api_service.dart';
import '../../../helper_files/constant_variables.dart';
import '../../../helper_files/ui_utils.dart';
import '../../../models/commun_models/user_details_model.dart';
import '../../../models/transaction_history_api_response_model.dart';
import '../../Local Storage.dart';

class TransactionHistoryPageController extends GetxController {
  // TransactionHistoryApiResponseModel transactionModel = TransactionHistoryApiResponseModel();
  RxList<ResultArr> transactionList = <ResultArr>[].obs;
  UserDetailsModel userDetailsModel = UserDetailsModel();
  int offset = 0;
  Future<void> onSwipeRefresh() async {
    if (userDetailsModel.id != null) {
      getTransactionHistory(offset: offset);
    } else {
      AppUtils.showErrorSnackBar(
        bodyText: "SOMETHINGWENTWRONG".tr,
      );
    }
  }

  @override
  void onInit() {
    fetchUserData();
    super.onInit();
  }

  Future<void> fetchUserData() async {
    var userData = await LocalStorage.read(ConstantsVariables.userData);
    userDetailsModel = UserDetailsModel.fromJson(userData);
    if (userDetailsModel.id != null) {
      print("_______________________");
      getTransactionHistory(offset: offset);
    } else {
      AppUtils.showErrorSnackBar(
        bodyText: "SOMETHINGWENTWRONG".tr,
      );
    }
  }

  void getTransactionHistory({required int offset}) async {
    ApiService()
        .getTransactionHistoryById(
            userId: userDetailsModel.id ?? 0, offset: offset)
        .then(
      (value) async {
        print("Get transaction history Api Response :- $value");
        if (value['status']) {
          TransactionHistoryApiResponseModel transactionModel =
              TransactionHistoryApiResponseModel.fromJson(value);

          if (transactionModel.data?.resultArr != null &&
              transactionModel.data!.resultArr!.isNotEmpty) {
            transactionList.value =
                transactionModel.data!.resultArr as List<ResultArr>;
          } else {
            transactionList.value = <ResultArr>[];
            print(transactionList.value);
          }
        } else {
          AppUtils.showErrorSnackBar(
            bodyText: value['message'] ?? "",
          );
        }
      },
    );
  }
}
