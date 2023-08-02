// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/app_colors.dart';
import 'package:spllive/helper_files/constant_image.dart';
import 'package:spllive/helper_files/custom_text_style.dart';
import 'package:spllive/helper_files/dimentions.dart';
import 'package:spllive/helper_files/ui_utils.dart';
import 'package:spllive/screens/gamemode_pages/controller/game_pages_controller.dart';
import '../../components/simple_button_with_corner.dart';
import '../../routes/app_routes_name.dart';
import 'utils/game_mode_utils.dart';

// ignore: must_be_immutable
class GameModePage extends StatelessWidget {
  GameModePage({super.key});
  var controller = Get.put(GameModePagesController());
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:
          AppUtils().simpleAppbar(appBarTitle: "GAMEMODES_TEXT".tr, actions: [
        InkWell(
          onTap: () {},
          child: const Icon(Icons.wallet),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: Dimensions.h14, horizontal: Dimensions.h15),
          child: Text(
            "40".tr,
            style: TextStyle(
              fontSize: Dimensions.h14,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
        ),
      ]),
      body: Obx(
        () {
          return SizedBox(
            //height: size.height,
            child: Column(
              children: [
                controller.openBiddingOpen.value
                    ? SizedBox(
                        height: Dimensions.h11,
                      )
                    : Container(
                        decoration: BoxDecoration(color: AppColors.redColor),
                        height: Dimensions.h50,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "BIDDINGFOROPENISCLOSED".tr,
                            style: CustomTextStyle.textPTsansMedium.copyWith(
                                color: AppColors.white,
                                fontSize: Dimensions.h15),
                          ),
                        ),
                      ),
                GameModeUtils().rowWidget(
                  marketName: controller.marketValue.value.market.toString(),
                  date: controller.removeTimeStampFromDateString(
                    controller.marketValue.value.date.toString(),
                  ),
                ),
                SizedBox(
                  height: Dimensions.h5,
                ),
                GameModeUtils().rowWidget2(
                  openBid: controller.marketValue.value.openTime.toString(),
                  closeBid: controller.marketValue.value.closeTime.toString(),
                ),
                Row(
                  children: [
                    radioButtonWidget(
                        onTapContainer: () {
                          if (controller.openBiddingOpen.value &&
                              controller.openCloseRadioValue.value != 0) {
                            controller.openCloseRadioValue.value = 0;
                            controller.callGetGameModes();
                          }
                        },
                        onChanged: (val) {
                          if (controller.openBiddingOpen.value) {
                            controller.openCloseRadioValue.value = val!;
                            controller.callGetGameModes();
                          }
                        },
                        opasity: controller.openBiddingOpen.value ? 1 : 0.5,
                        controller: controller,
                        radioButtonValue: 0,
                        buttonText: "OPENBID".tr),
                    const SizedBox(
                      width: 11,
                    ),
                    radioButtonWidget(
                        onTapContainer: () {
                          if (controller.openCloseRadioValue.value != 1) {
                            controller.openCloseRadioValue.value = 1;
                            controller.callGetGameModes();
                          }
                        },
                        onChanged: (val) {
                          controller.openCloseRadioValue.value = val!;
                          controller.callGetGameModes();
                        },
                        opasity: 1,
                        controller: controller,
                        radioButtonValue: 1,
                        buttonText: "CLOSEBID".tr)
                  ],
                ),
                cardWidget(controller),
                SizedBox(
                  height: Dimensions.h20,
                ),
                // RoundedCornerButton(
                //   text: "VIEWBIDS".tr,
                //   color: AppColors.greenShade,
                //   borderColor: AppColors.greenShade,
                //   fontSize: Dimensions.h14,
                //   fontWeight: FontWeight.w500,
                //   fontColor: AppColors.white,
                //   letterSpacing: 0,
                //   borderRadius: Dimensions.r5,
                //   borderWidth: 1,
                //   textStyle: CustomTextStyle.textPTsansBold,
                //   onTap: () {
                //     Get.offAndToNamed(AppRoutName.selectedBidsPage);
                //   },
                //   height: Dimensions.h30,
                //   width: Dimensions.w100,
                // )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget cardWidget(GameModePagesController controller) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller.gameModesList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: Dimensions.h100,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => controller.onTapOfGameModeTile(index),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: AppColors.blueAccent.withOpacity(0.7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      //color: Colors.amber,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 90,
                            child: Opacity(
                              opacity: 0.3,
                              // child: CachedNetworkImage(
                              //   imageUrl: controller.gameModesList
                              //       .elementAt(index)
                              //       .image
                              //       .toString(),
                              //   height: Dimensions.h45,
                              //   progressIndicatorBuilder:
                              //       (context, url, progress) =>
                              //           CircularProgressIndicator(),
                              //   errorWidget: (context, url, error) =>
                              //       Icon(Icons.error),
                              // ),
                              child: controller.gameModesList
                                          .elementAt(index)
                                          .image !=
                                      null
                                  ? Image.network(
                                      controller.gameModesList
                                          .elementAt(index)
                                          .image
                                          .toString(),
                                      height: Dimensions.h45,
                                    )
                                  : const Icon(Icons.error),
                            ),
                          ),
                          Positioned(
                            left: 60,
                            child: controller.gameModesList
                                        .elementAt(index)
                                        .image !=
                                    null
                                ? Image.network(
                                    controller.gameModesList
                                        .elementAt(index)
                                        .image
                                        .toString(),
                                    height: Dimensions.h45,
                                  )
                                : const Icon(Icons.error),
                          ),
                          Positioned(
                            left: 30,
                            child: Opacity(
                              opacity: 0.3,
                              child: controller.gameModesList
                                          .elementAt(index)
                                          .image !=
                                      null
                                  ? Image.network(
                                      controller.gameModesList
                                          .elementAt(index)
                                          .image
                                          .toString(),
                                      height: Dimensions.h45,
                                    )
                                  : const Icon(Icons.error),
                            ),
                          ), // Bottom image
                          Opacity(
                            opacity: 0.0,
                            child: Image.asset(
                              ConstantImage.diceImage,
                              height: Dimensions.h45,
                            ),
                          )
                        ],
                      ),
                    ),
                    // Image(image: AssetImage(ConstantImage.diceImage)),
                    Text(
                      controller.gameModesList.elementAt(index).name ?? "",
                      style: CustomTextStyle.textPTsansMedium.copyWith(
                        color: AppColors.black,
                        fontSize: Dimensions.h15,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget radioButtonWidget(
    {required GameModePagesController controller,
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
        child: SizedBox(
          // color: Colors.amber,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
              Text(
                buttonText,
                style: TextStyle(
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
