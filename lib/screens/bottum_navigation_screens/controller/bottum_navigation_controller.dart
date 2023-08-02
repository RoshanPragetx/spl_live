import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/ui_utils.dart';
import 'package:spllive/routes/app_routes_name.dart';

import '../../../api_services/api_service.dart';
import '../../../helper_files/constant_variables.dart';
import '../../../models/commun_models/user_details_model.dart';
import '../../../models/get_feedback_by_id_api_response_model.dart';
import '../../../models/normal_market_bid_history_response_model.dart';
import '../../Local Storage.dart';

class MoreListController extends GetxController {
  UserDetailsModel userData = UserDetailsModel();
  RxList<ResultArr> marketHistoryList = <ResultArr>[].obs;
  RxBool isStarline = false.obs;
  int offset = 0;
  RxString walletBalance = "00".obs;
  double ratingValue = 0.00;

  @override
  void onInit() {
    //scrollController.addListener(_scrollListner);
    getUserData();
    getUserBalance();
    super.onInit();
  }

  @override
  void dispose() {
    marketHistoryList.clear();
    // scrollController.removeListener(_scrollListner);
    // scrollController.dispose();
    super.dispose();
  }

  Future<void> getUserData() async {
    var data = await LocalStorage.read(ConstantsVariables.userData);
    userData = UserDetailsModel.fromJson(data);
    getMarketBidsByUserId(lazyLoad: false);
  }

  void callLogout() async {
    ApiService().logout().then((value) async {
      debugPrint("Logout Api Response :- $value");
      if (value['status']) {
        AppUtils.showSuccessSnackBar(
            bodyText: value['message'] ?? "", headerText: "SUCCESSMESSAGE".tr);
        await LocalStorage.eraseBox();
        Get.offAllNamed(AppRoutName.walcomeScreen);
      } else {
        AppUtils.showErrorSnackBar(
          bodyText: value['message'] ?? "",
        );
      }
    });
  }

  void getMarketBidsByUserId({required bool lazyLoad}) {
    ApiService()
        .getBidHistoryByUserId(
            userId: userData.id.toString(),
            //  userId: "3",
            limit: "10",
            offset: offset.toString(),
            isStarline: isStarline.value)
        .then(
      (value) async {
        debugPrint("Get Market Api Response :- $value");
        if (value['status']) {
          if (value['data'] != null) {
            NormalMarketBidHistoryResponseModel model =
                NormalMarketBidHistoryResponseModel.fromJson(value);
            lazyLoad
                ? marketHistoryList
                    .addAll(model.data?.resultArr ?? <ResultArr>[])
                : marketHistoryList.value =
                    model.data?.resultArr ?? <ResultArr>[];
          }
        } else {
          AppUtils.showErrorSnackBar(
            bodyText: value['message'] ?? "",
          );
        }
      },
    );
  }

  void getUserBalance() {
    ApiService().getBalance().then((value) async {
      debugPrint("Forgot MPIN Api Response :- $value");
      if (value['status']) {
        var tempBalance = value['data']['Amount'] ?? 00;
        walletBalance.value = tempBalance.toString();
      } else {
        AppUtils.showErrorSnackBar(
          bodyText: value['message'] ?? "",
        );
      }
    });
  }

  // Rate Controller
  void onTapOfRateUs() async {
    await getFeedbackAndRatingsById();
  }

  Future<void> getFeedbackAndRatingsById() async {
    var tempRatings = 0.00;
    ApiService()
        .getFeedbackAndRatingsById(userId: 1)
        // .getFeedbackAndRatingsById(userId: userDetailsModel.value.id)
        .then(
      (value) async {
        debugPrint("Get Feed back and Ratings Api Response :- $value");
        if (value['status']) {
          var feedbackModel = GetFeedbackByIdApiResponseModel.fromJson(value);
          if (feedbackModel.data != null) {
            tempRatings = feedbackModel.data!.rating != null
                ? feedbackModel.data!.rating!.toDouble()
                : 0.00;
          } else {
            tempRatings = 0.00;
          }
        } else {
          AppUtils.showErrorSnackBar(
            bodyText: value['message'] ?? "",
          );
        }
        if (tempRatings > 0.00) {
          AppUtils().showRateUsBoxDailog((rat) {
            addFeedbackApi(rat);
          }, tempRatings);
        } else {
          AppUtils().showRateUsBoxDailog((rat) {
            addFeedbackApi(rat);
          }, 0);
        }
      },
    );
  }

  void addFeedbackApi(ratingValue) async {
    ApiService()
        .createFeedback(await createFeedbackBody(ratingValue))
        .then((value) async {
      debugPrint("Create Feedback Api Response :- $value");
      if (value['status']) {
        Get.back();
        AppUtils.showSuccessSnackBar(
            bodyText: value['message'] ?? "", headerText: "SUCCESSMESSAGE".tr);
      } else {
        AppUtils.showErrorSnackBar(
          bodyText: value['message'] ?? "",
        );
      }
    });
  }

  Future<Map> createFeedbackBody(rating) async {
    final createFeedbackBody = {
      "userId": 1,
      //  "userId": userDetailsModel.value.id,
      "feedback": "",
      "rating": rating,
    };
    debugPrint(createFeedbackBody.toString());
    return createFeedbackBody;
  }
}
