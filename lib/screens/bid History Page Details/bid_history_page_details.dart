import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/common_utils.dart';
import 'package:spllive/helper_files/dimentions.dart';

import '../../helper_files/app_colors.dart';
import '../../helper_files/constant_image.dart';
import '../../helper_files/custom_text_style.dart';
import '../../helper_files/ui_utils.dart';
import 'controller/bid_history_page_details_controller.dart';

// ignore: must_be_immutable
class BidHistoryDetailsNewPage extends StatelessWidget {
  BidHistoryDetailsNewPage({super.key});
  var controller = Get.put(BidHistoryPageDetailsController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppUtils().simpleAppbar(
          appBarTitle: "Bid For ${controller.marketName.toString()}"),
      body: Obx(
        () => Container(
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    radioButtonWidget(
                        onTapContainer: () {
                          print("${controller.openCloseRadioValue.value}");
                          if (controller.openCloseRadioValue.value != 0) {
                            controller.openCloseRadioValue.value = 0;
                            controller.getPassBookData(lazyLoad: false);
                          }
                        },
                        onChanged: (val) {
                          if (controller.openBiddingOpen.value) {
                            controller.openCloseRadioValue.value = val!;
                            controller.getPassBookData(lazyLoad: false);
                          }
                        },
                        opasity: 1,
                        controller: controller,
                        radioButtonValue: 0,
                        buttonText: "OPENBID".tr),
                    const SizedBox(
                      width: 11,
                    ),
                    radioButtonWidget(
                      onTapContainer: () {
                        print(" ${controller.openCloseRadioValue.value}");

                        if (controller.openCloseRadioValue.value != 1) {
                          controller.openCloseRadioValue.value = 1;
                          controller.getPassBookData(lazyLoad: false);
                        }
                      },
                      onChanged: (val) {
                        print("${controller.openCloseRadioValue.value}");
                        controller.openCloseRadioValue.value = val!;
                        controller.getPassBookData(lazyLoad: false);
                      },
                      opasity: 1,
                      controller: controller,
                      radioButtonValue: 1,
                      buttonText: "CLOSEBID".tr,
                    )
                  ],
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        ConstantImage.openStarsSvg,
                        height: Dimensions.h17,
                      ),
                      SvgPicture.asset(
                        ConstantImage.closeStarsSvg,
                        height: Dimensions.h17,
                      ),
                    ],
                  ),
                ),
                Expanded(child: bidHistoryList()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bidHistoryList() {
    return Obx(
      () => ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: Dimensions.h10),
        itemCount: controller.bidHistoryData.length,
        itemBuilder: (context, index) {
          // var data = controller.marketHistoryList.elementAt(index);

          return listveiwTransaction(
            coins: "${controller.bidHistoryData[index].balance.toString()}",
            closeTime: controller.bidHistoryData[index].bidNo.toString(),
            marketName: controller.bidHistoryData[index].game!.name.toString(),
            closeResult: controller.bidHistoryData[index].winAmount.toString(),
            time: CommonUtils().convertUtcToIst(
              controller.bidHistoryData[index].bidTime.toString(),
            ),
          );

          // ${controller.bidHistoryData[index].bidType.toString()}
          // } else {
          //   return listveiwTransaction(
          //     coins:
          //         "${controller.bidHistoryData[index].balance.toString()} ===== ${controller.bidHistoryData[index].bidType.toString()}",
          //     closeTime: controller.bidHistoryData[index].bidNo.toString(),
          //     marketName:
          //         controller.bidHistoryData[index].game!.name.toString(),
          //     closeResult:
          //         controller.bidHistoryData[index].winAmount.toString(),
          //     time: CommonUtils().convertUtcToIst(
          //       controller.bidHistoryData[index].bidTime.toString(),
          //     ),
          //   );
          // }
        },
      ),
    );
  }

  Widget listveiwTransaction({
    required String marketName,
    required String closeTime,
    required String coins,
    required String closeResult,
    required String time,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimensions.h5),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              color: AppColors.grey.withOpacity(0.8),
              blurRadius: 5,
              offset: const Offset(4, 4),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Row(
                      children: [
                        Text(
                          // "446-47-359",
                          "WON $closeResult",
                          style: CustomTextStyle.textRobotoSansBold,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "BID $closeTime",
                    style: CustomTextStyle.textRobotoSansLight,
                  ),
                  const Expanded(child: SizedBox()),
                  SizedBox(
                    width: Dimensions.w5,
                  ),
                  Text(
                    "Points",
                    style: CustomTextStyle.textRobotoSansLight,
                  ),
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
                ],
              ),
            ),
            Container(
              height: Dimensions.h30,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 188, 185, 185),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6)),
              ),
              child: Center(
                child: Text(
                  "Play time : $time",
                  style: CustomTextStyle.textRobotoSansLight.copyWith(
                    fontSize: Dimensions.h12,
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget radioButtonWidget(
      {required BidHistoryPageDetailsController controller,
      required int radioButtonValue,
      required String buttonText,
      required double opasity,
      required Function(int?) onChanged,
      required Function() onTapContainer}) {
    return Expanded(
      child: Opacity(
        opacity: opasity,
        child: GestureDetector(
          onTap: onTapContainer,
          child: Container(
            color: AppColors.grey.withOpacity(0.2),
            // color: Colors.amber,
            child: Row(
              children: [
                Radio(
                  value: radioButtonValue,
                  fillColor: MaterialStatePropertyAll(
                    controller.openCloseRadioValue.value == radioButtonValue
                        ? AppColors.buttonColorDarkGreen
                        : AppColors.appbarColor,
                  ),
                  activeColor: AppColors.buttonColorDarkGreen,
                  groupValue: controller.openCloseRadioValue.value,
                  onChanged: onChanged,
                ),
                SizedBox(
                  width: Dimensions.w20,
                ),
                Text(
                  buttonText,
                  style: CustomTextStyle.textRobotoSansMedium.copyWith(
                    color:
                        controller.openCloseRadioValue.value == radioButtonValue
                            ? AppColors.buttonColorDarkGreen
                            : AppColors.appbarColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
