import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spllive/Custom%20Controllers/wallet_controller.dart';

import '../../../helper_files/app_colors.dart';
import '../../../helper_files/common_utils.dart';
import '../../../helper_files/constant_image.dart';
import '../../../helper_files/custom_text_style.dart';
import '../../../helper_files/dimentions.dart';
import '../../../helper_files/ui_utils.dart';
import '../../../routes/app_routes_name.dart';
import 'controller/check_withdrawal_history_controller.dart';

// ignore: must_be_immutable
class CheckWithdrawalPage extends StatelessWidget {
  CheckWithdrawalPage({super.key});
  var controller = Get.put(CheckWithdrawalPageController());

  var walletController = Get.put(WalletController());

  @override
  Widget build(BuildContext context) {
    print("====== Page called =================");
    var verticalSpace = SizedBox(
      height: Dimensions.h10,
    );
    return Scaffold(
      appBar: AppUtils().simpleAppbar(
        appBarTitle: "Withdrawal",
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.offAllNamed(AppRoutName.withdrawalpage);
            },
            icon: const Icon(Icons.close),
          )
        ],
        leadingWidht: Dimensions.w110,
        leading: Row(
          children: [
            Container(
              width: Dimensions.w38,
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 4.0, left: 8.0, bottom: 4.0),
                child: SvgPicture.asset(
                  ConstantImage.walletAppbar,
                  color: AppColors.white,
                ),
              ),
            ),
            SizedBox(width: Dimensions.w10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                walletController.walletBalance.toString(),
                style: CustomTextStyle.textRobotoSansMedium
                    .copyWith(fontSize: Dimensions.h16),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: withdrawalHistoryList(),
          ),
        ],
      ),
    );
  }

  withdrawalHistoryList() {
    return Obx(
      () => controller.withdrawalRequestList.isEmpty
          ? Center(
              child: Text(
                "NOHISTORYAVAILABLEFORLAST7DAYS".tr,
                style: CustomTextStyle.textPTsansMedium.copyWith(
                  fontSize: Dimensions.h13,
                  color: AppColors.black,
                ),
              ),
            )
          : ListView.builder(
              padding:
                  EdgeInsets.symmetric(vertical: 5, horizontal: Dimensions.h10),
              itemCount: controller.withdrawalRequestList.length,
              itemBuilder: (context, index) {
                // var data = controller.marketHistoryList.elementAt(index);
                // print(")))))))))))))))))))))))))))))))))))))))))))))))))) $data");
                return listveiwTransaction(
                  requestId: controller.withdrawalRequestList[index].requestId
                      .toString(),
                  requestProcessedAt: controller
                      .withdrawalRequestList[index].requestProcessedAt
                      .toString(),
                  requestTime: CommonUtils().formatStringToDDMMMYYYYHHMMSSA(
                      controller.withdrawalRequestList[index].requestTime
                          .toString()),
                  requestedAmount: controller
                      .withdrawalRequestList[index].requestedAmount
                      .toString(),
                  status:
                      controller.withdrawalRequestList[index].status.toString(),
                  // timeDate: CommonUtils().formatStringToDDMMYYYYHHMMA(
                  //   controller.marketBidHistoryList[index].bidTime
                  //       .toString(),
                  // ),
                  // openResut:
                  //     homePageController.marketBidHistoryList[index].openTime ==
                  //             null
                  //         ? ""
                  //         : homePageController
                  //             .getResult(
                  //               true,
                  //               homePageController
                  //                       .marketBidHistoryList[index].openTime ??
                  //                   0,
                  //             )
                  //             .toString(),
                  // marketName: controller
                  //         .marketBidHistoryList[index].transactionType ??
                  //     "",
                  // containerColor:
                  //     controller.marketBidHistoryList[index].isWin ==
                  //             true
                  //         ? AppColors.greenAccent.withOpacity(0.65)
                  //         : AppColors.white,

                  // gameMode:
                  //     controller.marketBidHistoryList[index].gameMode ??
                  //         "",

                  // bidType:
                  //     controller.marketBidHistoryList[index].bidType ??
                  //         "",
                  // closeResult:
                  //     homePageController.marketBidHistoryList[index].closeResult ==
                  //             null
                  //         ? ""
                  //         : homePageController
                  //             .reverse(homePageController.getResult(
                  //               true,
                  //               homePageController
                  //                       .marketBidHistoryList[index].closeResult ??
                  //                   0,
                  //             ))
                  //             .toString(),
                  // onTap: () {
                  //   Get.toNamed(AppRoutName.newBidHistorypage, arguments: {
                  //     "marketData": homePageController.marketBidHistoryList.value,
                  //     "marketId": homePageController.marketBidHistoryList[index].id
                  //         .toString(),
                  //     "marketName":
                  //         homePageController.marketBidHistoryList[index].marketName,
                  //   });
                  // },
                );
              },
            ),
    );
  }

  Widget listveiwTransaction({
    required String requestedAmount,
    required String requestId,
    required String status,
    required String requestProcessedAt,
    required String requestTime,
    // required String closeResult,
    // required Function() onTap,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimensions.h5),
      child: InkWell(
        // onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                spreadRadius: 1,
                color: AppColors.grey,
                blurRadius: 10,
                offset: Offset(7, 4),
              ),
            ],
            border: Border.all(width: 0.2),
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "RequestId : $requestId",
                      style: CustomTextStyle.textRobotoSansLight
                          .copyWith(fontSize: Dimensions.h14),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Row(
                        children: [
                          Text(
                            requestedAmount,
                            style: CustomTextStyle.textRobotoSansLight,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(Dimensions.h8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Status",
                      style: CustomTextStyle.textRobotoSansBold,
                    ),
                    Text(
                      "Request On",
                      style: CustomTextStyle.textRobotoSansBold,
                    ),
                    // Text(
                    //   bidType,
                    //   style: CustomTextStyle.textRobotoSansLight,
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      status,
                      style: CustomTextStyle.textRobotoSansLight,
                    ),
                    SizedBox(
                      width: Dimensions.w5,
                    ),
                    const Expanded(child: SizedBox()),
                    SizedBox(
                      width: Dimensions.w5,
                    ),
                    SizedBox(
                      width: Dimensions.w5,
                    ),
                    Text(
                      requestTime,
                      style: CustomTextStyle.textRobotoSansLight,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
