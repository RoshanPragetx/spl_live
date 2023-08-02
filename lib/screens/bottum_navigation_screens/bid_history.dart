import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/app_colors.dart';
import 'package:spllive/screens/home_screen/controller/homepage_controller.dart';

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
        AppUtils().simpleAppbar(appBarTitle: appbarTitle),
        Expanded(
          child: bidHistoryList(),
        ),
      ],
    );
  }

  bidHistoryList() {
    // return Obx(() => controller.marketHistoryList.isEmpty
    //     ?
    return Center(
      child: Text(
        "NOHISTORYAVAILABLEFORLAST7DAYS".tr,
        style: CustomTextStyle.textPTsansMedium.copyWith(
          fontSize: Dimensions.h13,
          color: AppColors.black,
        ),
      ),
    );
    // : ListView.builder(
    //     itemCount: 15,
    //     itemBuilder: (context, index) {
    //       // var data = controller.marketHistoryList.elementAt(index);
    //       // print(")))))))))))))))))))))))))))))))))))))))))))))))))) $data");
    //       return listveiwTransaction();
    //     },
    //   ));
  }

  Widget listveiwTransaction() {
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
                  const Text(
                    "Bid",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "446-47-359",
                    style: CustomTextStyle.textPTsansMedium,
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
                    "7:05 PM | 8:05 PM",
                    style: CustomTextStyle.textPTsansMedium,
                  ),
                  Text(
                    " 8 - (Single Ank)",
                    style: CustomTextStyle.textPTsansMedium,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text("Coins"),
                  SizedBox(
                    width: Dimensions.w5,
                  ),
                  Image.asset(
                    ConstantImage.ruppeeBlueIcon,
                    height: Dimensions.h25,
                    width: Dimensions.w25,
                  ),
                  SizedBox(
                    width: Dimensions.w5,
                  ),
                  const Text("10"),
                  const Expanded(child: SizedBox()),
                  const Text("Balance"),
                  SizedBox(
                    width: Dimensions.w5,
                  ),
                  Image.asset(
                    ConstantImage.ruppeeBlueIcon,
                    height: Dimensions.h25,
                    width: Dimensions.w25,
                  ),
                  SizedBox(
                    width: Dimensions.w5,
                  ),
                  const Text("50"),
                ],
              ),
            ),
            Container(
              height: Dimensions.h40,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.greywhite,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child:
                  const Center(child: Text("Time: 29 June,2023, 5:26:11 PM")),
            ),
          ],
        ),
      ),
    );
  }
}
