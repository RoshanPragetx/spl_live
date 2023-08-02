// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper_files/app_colors.dart';
import '../../../helper_files/custom_text_style.dart';
import '../../../helper_files/dimentions.dart';
import '../../../helper_files/ui_utils.dart';
import 'controller/game_rate_page_controller.dart';

class GameRatePage extends StatelessWidget {
  GameRatePage({super.key});

  var controller = Get.put(GameRatePageController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppUtils().simpleAppbar(appBarTitle: "GAME RATES"),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(Dimensions.r8),
                  child: Container(
                    height: size.height / 2,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(Dimensions.r5),
                      border: Border.all(width: 0.2, color: AppColors.grey),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  Dimensions.r15,
                                  Dimensions.r15,
                                  Dimensions.r15,
                                  Dimensions.r10),
                              child: Text(
                                "MARKETGAMEWINRATIO".tr,
                                style:
                                    CustomTextStyle.textPTsansMedium.copyWith(
                                  color: AppColors.appbarColor,
                                  fontSize: Dimensions.h18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        marketWinRatio()
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(Dimensions.r8),
                  height: size.height / 3.1,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(Dimensions.r5),
                      border: Border.all(
                          width: 0.2,
                          color: const Color.fromARGB(255, 214, 209, 209))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(Dimensions.r15,
                            Dimensions.r25, Dimensions.r15, Dimensions.r15),
                        child: Text(
                          "STARLINEGAMEWINRATIO".tr,
                          style: CustomTextStyle.textPTsansMedium.copyWith(
                              color: AppColors.appbarColor,
                              fontSize: Dimensions.h18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      starlineGameWinRatio()
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget marketWinRatio() {
    return Obx(
      () => Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.normalMarketModel.value.data?.length,
          itemBuilder: (context, index) {
            return listTile(
              titleText: controller.normalMarketModel.value.data
                      ?.elementAt(index)
                      .name ??
                  "",
              trailing:
                  "${controller.normalMarketModel.value.data?.elementAt(index).baseRate ?? ""} KA ${controller.normalMarketModel.value.data?.elementAt(index).rate ?? ""}",
            );
          },
        ),
      ),
    );
  }

  Widget starlineGameWinRatio() {
    return Obx(
      () => Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.starlineMarketModel.value.data?.length,
          itemBuilder: (context, index) {
            return listTile(
              titleText: controller.starlineMarketModel.value.data
                      ?.elementAt(index)
                      .name ??
                  '',
              trailing:
                  "${controller.starlineMarketModel.value.data?.elementAt(index).baseRate ?? ""} KA ${controller.starlineMarketModel.value.data?.elementAt(index).rate ?? ""}",
            );
          },
        ),
      ),
    );
  }

  Widget listTile({required String titleText, required String trailing}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(Dimensions.h9),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  titleText,
                  style: CustomTextStyle.textPTsansMedium.copyWith(
                    color: AppColors.black,
                    fontSize: Dimensions.h18,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  trailing,
                  style: CustomTextStyle.textPTsansMedium.copyWith(
                    color: AppColors.grey,
                    fontSize: Dimensions.h15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// class starline2 extends StatelessWidget {
//   final String text1;
//   final String value1;
//   const starline2({
//     super.key,
//     required this.text1,
//     required this.value1,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => ListView.builder(
//         shrinkWrap: true,
//         physics: NeverScrollableScrollPhysics(),
//         itemCount: controller.gamerateModel.value.data?.length ?? 0,
//         itemBuilder: (context, index) {
//           final item = controller.gamerateModel.value.data?[index];
//           return Column(
//             children: [
//               Row(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(Dimensions.r5),
//                     child: Text(
//                       item?.name ?? "",
//                       style: CustomTextStyle.textPTsansMedium.copyWith(
//                         color: AppColors.black,
//                         fontSize: Dimensions.h18,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: Dimensions.w30,
//                   ),
//                   Text(
//                     '${item?.baseRate.toString() ?? ""} KA ${item?.rate.toString()}  ',
//                     style: CustomTextStyle.textPTsansMedium.copyWith(
//                       color: AppColors.grey,
//                       fontSize: Dimensions.h15,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           );
//         }));
//   }

  

