import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/common_utils.dart';
import 'package:spllive/helper_files/custom_text_style.dart';
import 'package:spllive/helper_files/dimentions.dart';
import 'package:spllive/helper_files/ui_utils.dart';

import '../../helper_files/app_colors.dart';
import 'controller/transaction_controller.dart';

// ignore: must_be_immutable
class TransactionPage extends StatelessWidget {
  TransactionPage({super.key});
  var controller = Get.put(TransactionHistoryPageController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppUtils().simpleAppbar(appBarTitle: "TRANSACTIONS".tr),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.h5),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Obx(
              () {
                return controller.transactionList.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.transactionList.length,
                        itemBuilder: (context, index) {
                          var data = controller.transactionList[index];
                          return listveiwTransaction(
                            containerColor: data.isWin == true
                                ? AppColors.greenAccent.withOpacity(0.65)
                                : AppColors.white,
                            bid: data.isWin == true ? "Earning" : "Bid",
                            timeDate: CommonUtils().formatStringToDDMMYYYYHHMMA(
                                data.bidTime ?? ""),
                            ballance: data.balance.toString(),
                            coins: data.coins.toString(),
                            bidNo: data.bidNo ?? "",
                            gameName: data.gameMode ?? "",
                            closeTime: CommonUtils()
                                .formatStringToHHMMA(data.openTime ?? ""),
                            openTime: CommonUtils()
                                .formatStringToHHMMA(data.openTime ?? ""),
                            marketName: data.marketName ?? "",
                          );
                        },
                      )
                    : SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: SizedBox(
                          height: size.height - 100,
                          width: size.width,
                          // color: AppColors.appbarColor,
                          child: Center(
                            child: Text(
                              "There is no Transaction History",
                              style:
                                  CustomTextStyle.textRobotoSansLight.copyWith(
                                fontSize: Dimensions.h13,
                              ),
                            ),
                          ),
                        ),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget listveiwTransaction(
      {required String marketName,
      required String openTime,
      required String closeTime,
      required String gameName,
      required String bidNo,
      required String ballance,
      required String coins,
      required String timeDate,
      required String bid,
      required Color containerColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimensions.h5),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              spreadRadius: 0.5,
              color: AppColors.grey,
              blurRadius: 5,
              offset: const Offset(2, 4),
            ),
          ],
          border: Border.all(width: 0.6),
          color: containerColor,
          borderRadius: BorderRadius.circular(Dimensions.r8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    bid,
                    style: CustomTextStyle.textRobotoSansBold
                        .copyWith(fontSize: Dimensions.h15),
                  ),
                  Text(
                    marketName,
                    style: CustomTextStyle.textRobotoSansLight,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Dimensions.h5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$openTime | $closeTime",
                    style: CustomTextStyle.textRobotoSansLight,
                  ),
                  Text(
                    " $bidNo - ($gameName)",
                    style: CustomTextStyle.textRobotoSansLight,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "Points",
                    style: CustomTextStyle.textRobotoSansLight,
                  ),
                  SizedBox(
                    width: Dimensions.w5,
                  ),
                  // Image.asset(
                  //   ConstantImage.ruppeeBlueIcon,
                  //   height: Dimensions.h25,
                  //   width: Dimensions.w25,
                  // ),
                  SizedBox(
                    width: Dimensions.w5,
                  ),
                  Text("10"),
                  Expanded(child: SizedBox()),
                  Text("Balance"),
                  SizedBox(
                    width: Dimensions.w5,
                  ),
                  // Image.asset(
                  //   ConstantImage.ruppeeBlueIcon,
                  //   height: Dimensions.h25,
                  //   width: Dimensions.w25,
                  // ),
                  SizedBox(
                    width: Dimensions.w5,
                  ),
                  Text(
                    ballance,
                    style: CustomTextStyle.textRobotoSansLight,
                  ),
                ],
              ),
            ),
            Container(
              height: Dimensions.h30,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.greywhite,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Dimensions.r8),
                  bottomRight: Radius.circular(Dimensions.r8),
                ),
              ),
              child: Center(
                child: Text(
                  "Time : $timeDate",
                  style: CustomTextStyle.textRobotoSansLight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
