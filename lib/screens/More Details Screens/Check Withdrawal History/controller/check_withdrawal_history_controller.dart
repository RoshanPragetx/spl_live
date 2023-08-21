import 'package:get/get.dart';
import 'package:spllive/models/commun_models/withdrawal_request_model.dart';

import '../../../../Custom Controllers/wallet_controller.dart';
import '../../../../api_services/api_service.dart';
import '../../../../helper_files/constant_variables.dart';
import '../../../../helper_files/ui_utils.dart';
import '../../../../models/commun_models/user_details_model.dart';
import '../../../Local Storage.dart';

class CheckWithdrawalPageController extends GetxController {
  RxList<WithdrawalRequestList> withdrawalRequestList =
      <WithdrawalRequestList>[].obs;
  UserDetailsModel userData = UserDetailsModel();
  int? userId = 0;

  var walletController = Get.put(WalletController());
  @override
  void onInit() {
    getUserData();
    super.onInit();
  }

  Future<void> getUserData() async {
    var data = await LocalStorage.read(ConstantsVariables.userData);
    userData = UserDetailsModel.fromJson(data);
    userId = userData.id;
    getWithdrawalHistoryByUserId(lazyLoad: false);
    walletController.walletBalance.refresh();
  }

  void getWithdrawalHistoryByUserId({required bool lazyLoad}) async {
    print("============== On init ==============  $userId");
    await ApiService()
        .getWithdrawalHistoryByUserId(
      userId: userId,
    )
        .then(
      (value) async {
        if (value['status']) {
          if (value['data'] != null) {
            WithdrawalRequestResponseModel model =
                WithdrawalRequestResponseModel.fromJson(value);
            lazyLoad
                ? withdrawalRequestList
                    .addAll(model.data ?? <WithdrawalRequestList>[])
                : withdrawalRequestList.value =
                    model.data ?? <WithdrawalRequestList>[];
            print(
                "============== Get withdrawal history ==============  :- ${withdrawalRequestList.toJson()}");
          } else {
            AppUtils.showErrorSnackBar(
              bodyText: value['message'] ?? "",
            );
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
