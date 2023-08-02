// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/ui_utils.dart';
import 'package:spllive/screens/Starline%20Game%20Page/controller/starline_game_page_controller.dart';

import '../../Custom Controllers/wallet_controller.dart';
import '../../components/button_widget.dart';
import '../../helper_files/app_colors.dart';
import '../../helper_files/constant_image.dart';
import '../../helper_files/custom_text_style.dart';
import '../../helper_files/dimentions.dart';

// ignore: must_be_immutable
class StarLineGamePage extends StatelessWidget {
  StarLineGamePage({super.key});

  var controller = Get.put(StarLineGamePageController());
  final walletController = Get.put(WalletController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var verticalSpace = SizedBox(
      height: Dimensions.h10,
    );
    return Scaffold(
      appBar: AppUtils().simpleAppbar(
        appBarTitle: "MARKETTEXT".tr,
        actions: [
          Row(
            children: [
              SvgPicture.asset(
                ConstantImage.walletAppbar,
                height: Dimensions.h20,
                color: AppColors.white,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w11),
                child: Text(
                  walletController.walletBalance.value,
                  style: CustomTextStyle.textPTsansMedium.copyWith(
                    color: AppColors.white,
                    fontSize: Dimensions.h17,
                  ),
                ),
              )
            ],
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(Dimensions.h8),
              child: textListWidget(
                size,
                text:
                    "Starline Market :- ${controller.marketData.value.time}".tr,
                fontSize: Dimensions.h17,
              ),
            ),
            verticalSpace,
            numberLine(
              controller: controller,
            ),
            Expanded(
              child: Obx(
                () => GridView.builder(
                  itemCount: controller.digitList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    mainAxisExtent: Dimensions.h80,
                  ),
                  itemBuilder: (context, index) {
                    final FocusNode focusNode = FocusNode();
                    controller.focusNodes.add(focusNode);
                    // Color underLineColor = focusNode.hasFocus
                    //     ? AppColors.redColor
                    //     : AppColors.white;
                    final isLastTextField =
                        index == controller.digitList.length - 1;
                    return Focus(
                      focusNode: focusNode,
                      onFocusChange: (hasFocus) {
                        if (hasFocus) {
                          controller.setContainerBorderColor(AppColors.green);
                        } else {
                          controller.setContainerBorderColor(AppColors.black);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                controller.digitList[index].isSelected ?? false
                                    ? AppColors.green
                                    : AppColors.black,
                          ),
                          borderRadius: BorderRadius.circular(Dimensions.h5),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: Dimensions.h8,
                            ),
                            Text(
                              controller.digitList[index].value ?? "",
                              textAlign: TextAlign.center,
                              style: CustomTextStyle.textPTsansBold.copyWith(
                                color: AppColors.grey,
                                fontSize: Dimensions.h15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: Dimensions.w15),
                              child: TextField(
                                maxLines: 1,
                                minLines: 1,
                                controller: controller.coinController[index],
                                keyboardType: TextInputType.number,
                                cursorColor: AppColors.black,
                                textAlign: TextAlign.center,
                                //  focusNode: focusNode,
                                onChanged: (val) {
                                  if (val != null) {
                                    if (val.characters.characterAt(0) ==
                                            Characters("0") &&
                                        val.length > 1) {
                                      // we need to remove the first char
                                      controller.coinController[index].text =
                                          val.substring(1);
                                      // we need to move the cursor
                                      // controller.coinController.selection =
                                      //     TextSelection.collapsed(
                                      //         offset:
                                      //             controller.coinController.text.length);
                                    } else {
                                      if (val.length > 1) {
                                        controller.validCoinsEntered.value =
                                            true;
                                      } else if (int.parse(val) > 10000) {
                                        controller.validCoinsEntered.value =
                                            false;
                                      } else {
                                        controller.validCoinsEntered.value =
                                            false;
                                      }
                                    }
                                  }
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                onEditingComplete: () {
                                  controller.onTapOfDigitTile(index);
                                },
                                onSubmitted: (v) {
                                  if (!isLastTextField) {
                                    final nextFocusNode =
                                        controller.focusNodes[index + 1];
                                    FocusScope.of(context)
                                        .requestFocus(nextFocusNode);
                                    controller.update(controller.focusNodes);
                                  } else {
                                    focusNode.unfocus();
                                  }
                                  //controller.onTapOfDigitTile(index);
                                },
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.black,
                                    ), // Set custom underline color
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors
                                            .black), // Set custom underline color when focused
                                  ),
                                  hintText: "ENTERPOINTS_TEXT".tr,
                                  hintStyle:
                                      CustomTextStyle.textPTsansBold.copyWith(),
                                ),
                              ),
                            ),
                            Container(
                              height: Dimensions.h2,
                              decoration: BoxDecoration(
                                color: controller.containerBorderColor.value,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(Dimensions.r5),
                                  bottomRight: Radius.circular(Dimensions.h5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                    // return numberWithTextField(
                    //   textController:
                    //       controller.textControllers.elementAt(index),
                    //   index,
                    //   context,
                    //   onChanged: (value) {},
                    //   onSubmitted: (value) {
                    //     if (!isLastTextField) {
                    //       final nextFocusNode =
                    //           controller.focusNodes[index + 1];
                    //       FocusScope.of(context).requestFocus(nextFocusNode);
                    //     }
                    //   },
                    //   isLastTextField: isLastTextField,
                    //   underLinecolor: underLineColor,
                    // );
                  },
                ),
              ),
            ),
            buttonContainer(size),
          ],
        ),
      ),
      bottomNavigationBar:
          Obx(() => bottomNavigationBar(controller.totalAmount.value)),
    );
  }

  buttonContainer(size) {
    return Container(
      color: AppColors.grey.withOpacity(0.15),
      height: Dimensions.h70,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.h40,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ButtonWidget(
                  onTap: () => Get.back(),
                  text: "CANCEL_TEXT".tr,
                  buttonColor: AppColors.buttonColorOrange,
                  height: Dimensions.h30,
                  width: size.width / 2,
                  radius: Dimensions.h3,
                ),
              ),
              SizedBox(
                width: Dimensions.w10,
              ),
              Expanded(
                child: ButtonWidget(
                  onTap: () => controller.onTapOfSaveButton(),
                  // onTap: () {},
                  text: "SAVE_TEXT".tr,
                  buttonColor: AppColors.appbarColor,
                  height: Dimensions.h30,
                  width: size.width / 2,
                  radius: Dimensions.h3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget numberWithTextField(
    int index,
    context, {
    required Function(String) onChanged,
    Function()? onEditingComplete,
    required Function(String) onSubmitted,
    required Color underLinecolor,
    required TextEditingController textController,
    bool isLastTextField = false,
  }) {
    // final FocusNode focusNode = controller.focusNodes[index];
    // final TextEditingController textController =
    //     controller.textControllers[index];
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.black),
        borderRadius: BorderRadius.circular(Dimensions.h5),
      ),
      child: Column(
        children: [
          SizedBox(
            height: Dimensions.h8,
          ),
          Obx(
            () => Text(
              controller.digitList[index].value ?? "",
              textAlign: TextAlign.center,
              style: CustomTextStyle.textPTsansBold.copyWith(
                color: AppColors.grey,
                fontSize: Dimensions.h15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: 4.0, horizontal: Dimensions.w15),
            child: TextField(
              controller: textController,
              keyboardType: TextInputType.number,
              cursorColor: AppColors.black,
              textAlign: TextAlign.center,
              // focusNode: focusNode,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              onEditingComplete: onEditingComplete,

              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.black,
                  ), // Set custom underline color
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColors
                          .black), // Set custom underline color when focused
                ),
                hintText: "ENTERPOINTS_TEXT".tr,
                hintStyle: CustomTextStyle.textPTsansBold.copyWith(),
              ),
            ),
          ),
          Container(
            height: Dimensions.h2,
            decoration: BoxDecoration(
              color: underLinecolor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(Dimensions.r5),
                bottomRight: Radius.circular(Dimensions.h5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget textListWidget(
    Size size, {
    required String text,
    Widget? widget,
    required double fontSize,
  }) {
    return Container(
      height: Dimensions.h50,
      width: size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.r5),
          color: AppColors.grey.withOpacity(0.2)),
      child: Padding(
        padding: EdgeInsets.only(left: Dimensions.w20),
        child: Row(
          children: [
            Text(
              text,
              style: CustomTextStyle.textPTsansBold
                  .copyWith(color: AppColors.appbarColor, fontSize: fontSize),
            ),
          ],
        ),
      ),
    );
  }

  bottomNavigationBar(String totalAmount) {
    return SafeArea(
      child: Container(
        height: Dimensions.h50,
        color: AppColors.appbarColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.commonPaddingForScreen,
              ),
              child: Text(
                "TOTALCOIN".tr,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: Dimensions.h18,
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  height: Dimensions.h30,
                  width: Dimensions.w30,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      ConstantImage.rupeeImage,
                      fit: BoxFit.contain,
                      color: AppColors.appbarColor,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.commonPaddingForScreen,
                  ),
                  child: Text(
                    totalAmount,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: Dimensions.h18,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  numberLine({required StarLineGamePageController controller}) {
    return Obx(
      () => controller.showNumbersLine.value
          ? Column(
              children: [
                Container(
                  //color: Colors.amberAccent,
                  height: Dimensions.h33,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.digitRow.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            controller.onTapOfNumbersLine(index);
                            controller.selectedIndexOfDigitRow = index;
                          },
                          child: Container(
                            width: Dimensions.w35,
                            height: Dimensions.h30,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: controller.digitRow[index].isSelected!
                                      ? AppColors.appbarColor
                                      : AppColors.green,
                                  width: 1),
                              borderRadius: BorderRadius.circular(4),
                              color: controller.digitRow[index].isSelected!
                                  ? AppColors.white
                                  : AppColors.green,
                            ),
                            child: Center(
                              child: Text(
                                controller.digitRow[index].value ?? "",
                                style: TextStyle(
                                  color:
                                      controller.digitRow[index].isSelected ??
                                              false
                                          ? AppColors.appbarColor
                                          : AppColors.white,
                                  fontSize: Dimensions.h16,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: Dimensions.h10,
                ),
              ],
            )
          : const SizedBox(),
    );
  }
}
