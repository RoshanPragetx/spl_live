import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/app_colors.dart';
import 'package:spllive/screens/home_screen/controller/homepage_controller.dart';

import '../../helper_files/common_utils.dart';
import '../../helper_files/constant_image.dart';
import '../../helper_files/custom_text_style.dart';
import '../../helper_files/dimentions.dart';
import '../../helper_files/ui_utils.dart';
// ignore: unused_import
import '../../models/normal_market_bid_history_response_model.dart';
import 'controller/bottum_navigation_controller.dart';

// ignore: must_be_immutable
class BidHistory extends StatelessWidget {
  BidHistory({
    super.key,
    required this.appbarTitle,
  });
  final String appbarTitle;
  var controller = Get.put(MoreListController());
  var homePageController = Get.put(HomePageController());
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        AppUtils().simpleAppbar(
          appBarTitle: "",
          leadingWidht: Dimensions.w200,
          leading: Container(
            child: Row(
              children: [
                SizedBox(width: Dimensions.w15),
                Text(
                  appbarTitle,
                  style: CustomTextStyle.textRobotoSansMedium
                      .copyWith(fontSize: Dimensions.h20),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: bidHistoryList(),
        ),
      ],
    );
  }

  bidHistoryList() {
    return Obx(
      () => controller.marketHistoryList.isEmpty
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
              itemCount: controller.marketHistoryList.length,
              itemBuilder: (context, index) {
                // var data = controller.marketHistoryList.elementAt(index);
                // print(")))))))))))))))))))))))))))))))))))))))))))))))))) $data");
                return listveiwTransaction(
                  ballance:
                      controller.marketHistoryList[index].balance.toString(),
                  coins: controller.marketHistoryList[index].coins.toString(),
                  closeTime: CommonUtils().formatStringToHHMMA(
                      controller.marketHistoryList[index].closeTime ?? ""),
                  openTime: CommonUtils().formatStringToHHMMA(
                      controller.marketHistoryList[index].openTime ?? ""),
                  bidNumber: controller.marketHistoryList[index].bidNo ?? "",
                  marketName:
                      controller.marketHistoryList[index].marketName ?? "",
                );
              },
            ),
    );
  }

  Widget listveiwTransaction({
    required String marketName,
    required String bidNumber,
    required String openTime,
    required String closeTime,
    required String coins,
    required String ballance,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimensions.h5),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              color: AppColors.grey,
              blurRadius: 10,
              offset: const Offset(7, 4),
            ),
          ],
          border: Border.all(width: 0.6),
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    marketName,
                    style: CustomTextStyle.textRobotoSansBold
                        .copyWith(fontSize: Dimensions.h14),
                  ),
                  Text(
                    // "446-47-359",
                    bidNumber,
                    style: CustomTextStyle.textRobotoSansBold,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$openTime - $closeTime",
                    style: CustomTextStyle.textRobotoSansLight,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "COINS",
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
                  Text(
                    coins,
                    style: CustomTextStyle.textRobotoSansLight.copyWith(
                      fontSize: Dimensions.h14,
                      color: AppColors.balanceCoinsColor,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  // Text(
                  //   "Balance",
                  //   style: CustomTextStyle.textRobotoSansLight,
                  // ),
                  SizedBox(
                    width: Dimensions.w5,
                  ),
                  // Image.asset(
                  //   ConstantImage.ruppeeBlueIcon,
                  //   height: 25,
                  //   width: 25,
                  // ),
                  SizedBox(
                    width: Dimensions.w5,
                  ),
                  Text(
                    ballance,
                    style: CustomTextStyle.textRobotoSansLight.copyWith(
                      fontSize: Dimensions.h14,
                      color: AppColors.balanceCoinsColor,
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   height: 40,
            //   width: double.infinity,
            //   decoration: const BoxDecoration(
            //     color: Color.fromARGB(255, 188, 185, 185),
            //     borderRadius: BorderRadius.only(
            //       bottomLeft: Radius.circular(8),
            //       bottomRight: Radius.circular(8),
            //     ),
            //   ),
            //   child: Center(child: Text("Time: 29 June,2023, 5:26:11 PM")),
            // ),
          ],
        ),
      ),
    );
  }
}
