import 'package:get/get.dart';
import 'package:spllive/helper_files/ui_utils.dart';
import 'package:spllive/routes/app_routes_name.dart';
import '../helper_files/constant_variables.dart';
import '../screens/Local Storage.dart';
import 'api_urls.dart';
import 'network_info.dart';

class ApiService extends GetConnect implements GetxService {
  Map<String, String>? headers = {};
  Map<String, String>? headersWithToken = {};
  String contentType = "";
  String authToken = '';
  final allowAutoSignedCert = true;
  @override
  void onInit() {
    allowAutoSignedCert = true;
    super.onInit();
  }

  Future<void> initApiService() async {
    authToken = await LocalStorage.read(ConstantsVariables.authToken) ?? "";
    await NetworkInfo.checkNetwork().whenComplete(() async {
      print("Auth Token from API service is :- $authToken");
      headers = {"Accept": "application/json"};
      headersWithToken = {
        "Accept": "application/json",
        "Authorization": "Bearer $authToken"
      };
    });
  }

  Future<dynamic> signUpAPI(body) async {
    AppUtils.showProgressDialog(isCancellable: false);
    await initApiService();
    final response = await post(
      ApiUtils.signUP,
      body,
      headers: headers,
      // contentType: contentType,
    );

    if (response.status.hasError) {
      AppUtils.hideProgressDialog();
      AppUtils.showErrorSnackBar(
        bodyText: response.status.code.toString() + response.toString(),
      );
      print(response.status.code.toString() + response.toString());
      return Future.error(response.statusText!);
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> signInAPI(body) async {
    AppUtils.showProgressDialog(isCancellable: false);
    await initApiService();
    final response = await post(
      ApiUtils.signIN,
      body,
      headers: headers,
      // contentType: contentType,
    );

    if (response.status.hasError) {
      AppUtils.hideProgressDialog();
      AppUtils.showErrorSnackBar(
        bodyText: response.status.code.toString() + response.toString(),
      );
      print(response.status.code.toString() + response.toString());
      return Future.error(response.statusText!);
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> verifyUser(body) async {
    print("=====================${ApiUtils.verifyUSER}");
    AppUtils.showProgressDialog(isCancellable: false);
    await initApiService();
    final response = await post(
      ApiUtils.verifyUSER,
      body,
      headers: headers,
      // contentType: contentType,
    );

    if (response.status.hasError) {
      AppUtils.hideProgressDialog();
      AppUtils.showErrorSnackBar(
        bodyText: response.status.code.toString() + response.toString(),
      );
      print(response.status.code.toString() + response.toString());
      return Future.error(response.statusText!);
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> logout() async {
    AppUtils.showProgressDialog(isCancellable: false);
    await initApiService();
    final response = await post(
      ApiUtils.logout,
      {},
      headers: headersWithToken,
      // contentType: contentType,
    );

    if (response.status.hasError) {
      AppUtils.hideProgressDialog();
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      print(response.status.code.toString() + response.toString());
      return Future.error(response.statusText!);
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> forgotPassword(body) async {
    AppUtils.showProgressDialog(isCancellable: false);
    await initApiService();
    final response = await post(
      ApiUtils.forgotPassword,
      body,
      headers: headers,
      // contentType: contentType,
    );

    if (response.status.hasError) {
      AppUtils.hideProgressDialog();
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      print(response.status.code.toString() + response.toString());
      return Future.error(response.statusText!);
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> resetPassword(body) async {
    AppUtils.showProgressDialog(isCancellable: false);
    await initApiService();
    final response = await post(
      ApiUtils.resetPassword,
      body,
      headers: headersWithToken,
      // contentType: contentType,
    );

    if (response.status.hasError) {
      AppUtils.hideProgressDialog();
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      print(response.status.code.toString() + response.toString());
      return Future.error(response.statusText!);
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> getBankDetails(String userId) async {
    print("${ApiUtils.getBankDetails}/$userId");
    AppUtils.showProgressDialog(isCancellable: false);
    await initApiService();
    final response = await get(
      "${ApiUtils.getBankDetails}/$userId",
      headers: headersWithToken,
    );
    if (response.status.hasError) {
      AppUtils.hideProgressDialog();
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      return Future.error(response.statusText!);
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> editBankDetails(body) async {
    AppUtils.showProgressDialog(isCancellable: false);
    await initApiService();
    final response = await post(
      ApiUtils.editBankDetails,
      body,
      headers: headersWithToken,
    );

    if (response.status.hasError) {
      AppUtils.hideProgressDialog();
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      print(response.status.code.toString() + response.toString());
      return Future.error(response.statusText!);
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> getDailyMarkets() async {
    Future.delayed(const Duration(milliseconds: 2), () {
      AppUtils.showProgressDialog(isCancellable: false);
    });

    await initApiService();
    final response = await get(
      ApiUtils.getDailyMarkets,
      headers: headersWithToken,
    );
    if (response.status.hasError) {
      AppUtils.hideProgressDialog();
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      return Future.error(response.statusText!);
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> getGameModes(
      {required String openCloseValue, required int marketID}) async {
    Future.delayed(const Duration(milliseconds: 2), () {
      AppUtils.showProgressDialog(isCancellable: false);
    });

    await initApiService();
    final response = await get(
      "${ApiUtils.getGameModes}$openCloseValue/$marketID",
      headers: headersWithToken,
    );
    if (response.status.hasError) {
      AppUtils.hideProgressDialog();
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      return Future.error(response.statusText!);
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> createMarketBid(body) async {
    AppUtils.showProgressDialog(isCancellable: false);
    await initApiService();
    final response = await post(
      ApiUtils.createMarketBid,
      body,
      headers: headersWithToken,
      // contentType: contentType,
    );

    if (response.status.hasError) {
      AppUtils.hideProgressDialog();
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      print(response.status.code.toString() + response.toString());
      return Future.error(response.statusText!);
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> createStarLineMarketBid(body) async {
    AppUtils.showProgressDialog(isCancellable: false);
    await initApiService();
    print("Starline body $body");
    final response = await post(
      ApiUtils.createStarLineMarketBid,
      body,
      headers: headersWithToken,
      // contentType: contentType,
    );

    if (response.status.hasError) {
      AppUtils.hideProgressDialog();
      AppUtils.showErrorSnackBar(
        bodyText: response.status.code.toString() + response.toString(),
      );
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      print(response.status.code.toString() + response.toString());
      return Future.error(response.statusText!);
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> createWithdrawalRequest(body) async {
    AppUtils.showProgressDialog(isCancellable: false);
    await initApiService();
    final response = await post(
      ApiUtils.createWithdrawalRequest,
      body,
      headers: headersWithToken,
      // contentType: contentType,
    );

    if (response.status.hasError) {
      AppUtils.hideProgressDialog();
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      print(response.status.code.toString() + response.toString());
      return Future.error(response.statusText!);
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> getDailyStarLineMarkets(
      {required String startDate, required String endDate}) async {
    Future.delayed(const Duration(milliseconds: 2), () {
      AppUtils.showProgressDialog(isCancellable: false);
    });
    print(
      "##starline###${ApiUtils.getDailyStarLineMarkets}?startDate=$startDate&endDate=$endDate",
    );
    await initApiService();
    final response = await get(
      "${ApiUtils.getDailyStarLineMarkets}?startDate=$startDate&endDate=$endDate",
      headers: headersWithToken,
    );

    if (response.status.hasError) {
      AppUtils.hideProgressDialog();
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      return Future.error(response.statusText!);
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> getStarLineGameModes({required int marketID}) async {
    Future.delayed(const Duration(milliseconds: 2), () {
      AppUtils.showProgressDialog(isCancellable: false);
    });

    await initApiService();
    final response = await get(
      "${ApiUtils.getStarLineGameModes}$marketID",
      headers: headersWithToken,
    );
    if (response.status.hasError) {
      AppUtils.hideProgressDialog();
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      return Future.error(response.statusText!);
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> getTransactionHistoryById(
      {required int userId, required int offset}) async {
    Future.delayed(const Duration(milliseconds: 2), () {
      AppUtils.showProgressDialog(isCancellable: false);
    });

    await initApiService();
    final response = await get(
      "${ApiUtils.getTransactionHistory}?id=$userId&limit=100&offset=$offset",
      headers: headersWithToken,
    );
    if (response.status.hasError) {
      AppUtils.hideProgressDialog();
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      return Future.error(response.statusText!);
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> getFeedbackAndRatingsById({required int? userId}) async {
    Future.delayed(const Duration(milliseconds: 2), () {
      AppUtils.showProgressDialog(isCancellable: false);
    });

    await initApiService();
    print("${ApiUtils.getFeedbackAndRatingsById}$userId");
    final response = await get(
      "${ApiUtils.getFeedbackAndRatingsById}$userId",
      headers: headersWithToken,
    );
    if (response.status.hasError) {
      AppUtils.hideProgressDialog();
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      return Future.error(response.statusText!);
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> getWithdrawalHistoryByUserId({required int? userId}) async {
    Future.delayed(const Duration(milliseconds: 2), () {
      AppUtils.showProgressDialog(isCancellable: false);
    });

    await initApiService();
    print("================================");
    print("${ApiUtils.getWithdrawalHistoryByUserId}$userId");
    print(headersWithToken);
    final response = await get(
      "${ApiUtils.getWithdrawalHistoryByUserId}$userId",
      headers: headersWithToken,
    );

    if (response.status.hasError) {
      AppUtils.hideProgressDialog();
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      return Future.error(response.statusText!);
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> getWithdrawalRequestTime() async {
    Future.delayed(const Duration(milliseconds: 2), () {
      AppUtils.showProgressDialog(isCancellable: false);
    });

    await initApiService();
    final response = await get(
      ApiUtils.getWithdrawalRequestTime,
      headers: headersWithToken,
    );
    if (response.status.hasError) {
      AppUtils.hideProgressDialog();
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      return Future.error(response.statusText!);
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> getStarlineGameRates() async {
    Future.delayed(const Duration(milliseconds: 2), () {
      AppUtils.showProgressDialog(isCancellable: false);
    });

    await initApiService();
    final response = await get(
      "${ApiUtils.getStarlineGameRates}true",
      headers: headersWithToken,
    );
    if (response.status.hasError) {
      AppUtils.hideProgressDialog();
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      return Future.error(response.statusText!);
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> getGameRates({required bool forStarlineGameModes}) async {
    Future.delayed(const Duration(milliseconds: 2), () {
      AppUtils.showProgressDialog(isCancellable: false);
    });

    await initApiService();
    final response = await get(
      "${ApiUtils.getStarlineGameRates}$forStarlineGameModes",
      headers: headersWithToken,
    );
    if (response.status.hasError) {
      AppUtils.hideProgressDialog();
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      return Future.error(response.statusText!);
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> createFeedback(body) async {
    AppUtils.showProgressDialog(isCancellable: false);
    await initApiService();
    final response = await post(
      ApiUtils.createFeedback,
      body,
      headers: headersWithToken,
      // contentType: contentType,
    );

    if (response.status.hasError) {
      AppUtils.hideProgressDialog();
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      print(response.status.code.toString() + response.toString());
      return Future.error(response.statusText!);
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> resendOTP(body) async {
    AppUtils.showProgressDialog(isCancellable: false);
    await initApiService();
    final response = await post(
      ApiUtils.resendOTP,
      body,
      headers: headersWithToken,
    );

    if (response.status.hasError) {
      AppUtils.hideProgressDialog();
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      print(response.status.code.toString() + response.toString());
      return response.body;
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> verifyMPIN(body) async {
    AppUtils.showProgressDialog(isCancellable: false);
    await initApiService();
    final response = await post(
      ApiUtils.verifyMPIN,
      body,
      headers: headersWithToken,
    );

    if (response.status.hasError) {
      AppUtils.hideProgressDialog();
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      print(response.status.code.toString() + response.toString());
      return response.body;
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> forgotMPIN() async {
    AppUtils.showProgressDialog(isCancellable: false);
    await initApiService();
    final response = await get(
      ApiUtils.forgotMPIN,
      headers: headersWithToken,
    );
    if (response.status.hasError) {
      AppUtils.hideProgressDialog();
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      return Future.error(response.statusText!);
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  // new api functions

  Future<dynamic> setUserDetails(body) async {
    //  AppUtils.showProgressDialog(isCancellable: false);
    await initApiService();
    final response = await post(
      ApiUtils.setUserDetails,
      body,
      headers: headersWithToken,
    );

    if (response.status.hasError) {
      //  AppUtils.hideProgressDialog();
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      print(response.status.code.toString() + response.toString());
      return response.body;
    } else {
      //   AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> setDeviceDetails(body) async {
    AppUtils.showProgressDialog(isCancellable: false);
    await initApiService();
    final response = await post(
      ApiUtils.setDeviceDetails,
      body,
      headers: headersWithToken,
    );

    if (response.status.hasError) {
      AppUtils.hideProgressDialog();
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      print(response.status.code.toString() + response.toString());
      return response.body;
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> setMPIN(body) async {
    AppUtils.showProgressDialog(isCancellable: false);
    await initApiService();
    final response = await post(
      ApiUtils.setMPIN,
      body,
      headers: headersWithToken,
    );
    if (response.status.hasError) {
      AppUtils.hideProgressDialog();
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      print(response.status.code.toString() + response.toString());
      return response.body;
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<void> tokenExpired() async {
    await LocalStorage.remove(ConstantsVariables.authToken);
    AppUtils.showErrorSnackBar(bodyText: "Session timeout, sign in again");
    Get.offAllNamed(AppRoutName.signInPage);
  }

  Future<dynamic> verifyOTP(body) async {
    print(ApiUtils.verifyOTP);
    AppUtils.showProgressDialog(isCancellable: false);
    await initApiService();
    final response = await post(
      ApiUtils.verifyOTP,
      body,
      headers: headersWithToken,
      // contentType: contentType,
    );

    if (response.status.hasError) {
      AppUtils.hideProgressDialog();
      AppUtils.showErrorSnackBar(
        bodyText: response.status.code.toString() + response.toString(),
      );
      print(response.status.code.toString() + response.toString());
      return Future.error(response.statusText!);
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> getBalance() async {
    await initApiService();
    final response = await get(
      ApiUtils.getBalance,
      headers: headersWithToken,
    );
    if (response.status.hasError) {
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      return Future.error(response.statusText!);
    } else {
      return response.body;
    }
  }

  Future<dynamic> getBidHistoryByUserId({
    required String userId,
    required String limit,
    required String offset,
    required bool isStarline,
    required String? startDate,
    required String? endDate,
  }) async {
    print(
        "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^${isStarline ? ApiUtils.starlineMarketBidHistory : ApiUtils.normalMarketBidHistory}?id=$userId&limit=$limit&offset=$offset&startDate=$startDate&endDate=$endDate");
    AppUtils.showProgressDialog(isCancellable: false);
    await initApiService();
    final response = await get(
      "${isStarline ? ApiUtils.starlineMarketBidHistory : ApiUtils.normalMarketBidHistory}?id=$userId&limit=$limit&offset=$offset&startDate=$startDate&endDate=$endDate",
      headers: headersWithToken,
    );
    if (response.status.hasError) {
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      AppUtils.hideProgressDialog();
      return Future.error(response.statusText!);
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> changePassword(body) async {
    // AppUtils.showProgressDialog(isCancellable: false);
    await initApiService();
    final response = await post(
      ApiUtils.changePassword,
      body,
      headers: headersWithToken,
    );

    if (response.status.hasError) {
      // AppUtils.hideProgressDialog();
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      print(response.status.code.toString() + response.body.toString());
      return response.body;
    } else {
      // AppUtils.hideProgressDialog();
      print("response2 ${response.body}");
      print("change pass2 ${response.status.code}");
      return response.body;
    }
  }

  Future<dynamic> changeMPIN(body) async {
    AppUtils.showProgressDialog(isCancellable: false);
    await initApiService();
    final response = await put(
      ApiUtils.changeMPIN,
      body,
      headers: headersWithToken,
    );

    if (response.status.hasError) {
      AppUtils.hideProgressDialog();
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      print(response.status.code.toString() + response.toString());
      return response.body;
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> getStarlineChar() async {
    Future.delayed(const Duration(milliseconds: 2), () {
      AppUtils.showProgressDialog(isCancellable: false);
    });

    await initApiService();
    final response = await get(
      ApiUtils.webStarLinechar,
      headers: headersWithToken,
    );
    if (response.status.hasError) {
      AppUtils.hideProgressDialog();
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      return Future.error(response.statusText!);
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> getStarLineBidHistoryByUserId({
    required String userId,
    required String limit,
    required String offset,
  }) async {
    AppUtils.showProgressDialog(isCancellable: false);
    await initApiService();
    final response = await get(
      "${ApiUtils.dailyStarlineMarketBidHistory}?id=$userId&limit=$limit&offset=$offset",
      headers: headersWithToken,
    );
    if (response.status.hasError) {
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      AppUtils.hideProgressDialog();

      return Future.error(response.statusText!);
    } else {
      AppUtils.hideProgressDialog();

      return response.body;
    }
  }

  Future<dynamic> newGameModeApi(body, url) async {
    AppUtils.showProgressDialog(isCancellable: false);
    await initApiService();
    final response = await post(
      url,
      body,
      //  headers: headersWithToken,
    );

    if (response.status.hasError) {
      AppUtils.hideProgressDialog();
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      print(response.status.code.toString() + response.toString());
      return response.body;
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> getPassBookData({
    required String userId,
    required bool isAll,
    required String limit,
    required String offset,
  }) async {
    print(
        "${ApiUtils.passBookApi}/$userId?isAll=$isAll&limit=$limit&offset=$offset");
    // AppUtils.showProgressDialog(isCancellable: false);
    await initApiService();
    final response = await get(
      "${ApiUtils.passBookApi}/$userId?isAll=$isAll&limit=$limit&offset=$offset",
      //  "${ApiUtils.dailyStarlineMarketBidHistory}?id=$userId&limit=$limit&offset=$offset",
      headers: headersWithToken,
    );
    if (response.status.hasError) {
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      AppUtils.hideProgressDialog();

      return Future.error(response.statusText!);
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> bidHistoryByUserId({
    required String userId,
  }) async {
    print(
        "==== Jevin  bhai from service =======================================");
    AppUtils.showProgressDialog(isCancellable: false);
    await initApiService();
    // final response = await get(
    //   "${ApiUtils.marketbidHistory}/$userId",
    //   headers: headersWithToken,
    // );
    final response = await get(
      "${ApiUtils.bidHistory}?id=$userId&limit=5000&offset=0",
      headers: headersWithToken,
    );

    if (response.status.hasError) {
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      AppUtils.hideProgressDialog();

      return Future.error(response.statusText!);
    } else {
      AppUtils.hideProgressDialog();
      print(
          "================================ API Call Response =================================");
      print(response.body);
      return response.body;
    }
  }

  // Future<dynamic> getNewMarketBidlistData({
  //   required String dailyMarketId,
  //   required String limit,
  //   required String offset,
  //   required String bidType,
  // }) async {
  //   print(
  //       "${ApiUtils.marketBidNewLists}?dailyMarketId=$dailyMarketId&limit=$limit&offset=$offset&bidType=$bidType");
  //   // AppUtils.showProgressDialog(isCancellable: false);
  //   await initApiService();

  //   final response = await get(
  //     "${ApiUtils.marketBidNewLists}?dailyMarketId=$dailyMarketId&limit=$limit&offset=$offset&bidType=$bidType",
  //     //  "${ApiUtils.dailyStarlineMarketBidHistory}?id=$userId&limit=$limit&offset=$offset",
  //     headers: headersWithToken,
  //   );
  //   if (response.status.hasError) {
  //     if (response.status.code != null && response.status.code == 401) {
  //       tokenExpired();
  //     }
  //     AppUtils.hideProgressDialog();

  //     return Future.error(response.statusText!);
  //   } else {
  //     AppUtils.hideProgressDialog();
  //     return response.body;
  //   }
  // }
  ///////// Notifications ///////////

  Future<dynamic> getNotificationCount() async {
    await initApiService();
    final response = await get(
      ApiUtils.getNotificationCount,
      headers: headersWithToken,
    );
    if (response.status.hasError) {
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      AppUtils.hideProgressDialog();
      return Future.error(response.statusText!);
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> getAllNotifications() async {
    await initApiService();
    final response = await get(
      ApiUtils.getAllNotifications,
      headers: headersWithToken,
    );
    if (response.status.hasError) {
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      AppUtils.hideProgressDialog();
      return Future.error(response.statusText!);
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> resetNotification() async {
    await initApiService();
    final response = await get(
      ApiUtils.resetNotificationCount,
      headers: headersWithToken,
    );
    if (response.status.hasError) {
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      AppUtils.hideProgressDialog();
      return Future.error(response.statusText!);
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> rateApp(body) async {
    AppUtils.showProgressDialog(isCancellable: false);
    await initApiService();
    final response = await post(
      ApiUtils.rateAppApi,
      body,
      headers: headersWithToken,
      // contentType: contentType,
    );

    if (response.status.hasError) {
      AppUtils.hideProgressDialog();
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      print(response.status.code.toString() + response.toString());
      return Future.error(response.statusText!);
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> marketNotifications(body) async {
    AppUtils.showProgressDialog(isCancellable: false);
    await initApiService();
    final response = await put(
      ApiUtils.marketNotification,
      body,
      headers: headersWithToken,
      // contentType: contentType,
    );

    if (response.status.hasError) {
      AppUtils.hideProgressDialog();
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      print(response.status.code.toString() + response.toString());
      return Future.error(response.statusText!);
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> getBennerData() async {
    // print(ApiUtils.bennerApi);
    AppUtils.showProgressDialog(isCancellable: false);
    await initApiService();
    final response = await get(
      ApiUtils.bennerApi,
      headers: headersWithToken,
    );
    if (response.status.hasError) {
      AppUtils.hideProgressDialog();
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      return Future.error(response.statusText!);
    } else {
      AppUtils.hideProgressDialog();
      return response.body;
    }
  }

  Future<dynamic> fcmToken(body) async {
    // AppUtils.showProgressDialog(isCancellable: false);
    await initApiService();
    final response = await post(
      ApiUtils.fcmToken,
      body,
      headers: headersWithToken,
    );

    if (response.status.hasError) {
      //  AppUtils.hideProgressDialog();
      if (response.status.code != null && response.status.code == 401) {
        tokenExpired();
      }
      print(
          "FCM Token : ${response.status.code.toString() + response.body.toString()}");
      return response.body;
    } else {
      //  AppUtils.hideProgressDialog();
      print("response2 ${response.body}");
      print("change pass2 ${response.status.code}");
      return response.body;
    }
  }

  Future<dynamic> appKilledStateApi() async {
    //AppUtils.showProgressDialog(isCancellable: false);
    await initApiService();
    final response = await get(
      ApiUtils.appKillApi,
      headers: headersWithToken,
    );
    if (response.status.hasError) {
      // AppUtils.hideProgressDialog();s
      return response.body;
    } else {
      // AppUtils.hideProgressDialog();
      // print("response2 ${response.body}");
      // print("change pass2 ${response.status.code}");
      return response.body;
    }
  }

  Future<dynamic> getAppVersion() async {
    //AppUtils.showProgressDialog(isCancellable: false);
    await initApiService();
    final response = await get(
      ApiUtils.getVersion,
    );

    if (response.status.hasError) {
      // AppUtils.hideProgressDialog();s
      return response.body;
    } else {
      // AppUtils.hideProgressDialog();
      // print("response2 ${response.body}");
      // print("change pass2 ${response.status.code}");
      return response.body;
    }
  }
}
