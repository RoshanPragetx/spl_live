import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:spllive/helper_files/app_colors.dart';
import 'package:spllive/helper_files/constant_image.dart';
import 'package:spllive/helper_files/custom_text_style.dart';
import 'package:spllive/helper_files/dimentions.dart';
import 'package:spllive/helper_files/ui_utils.dart';
import '../../Custom Controllers/wallet_controller.dart';
import '../../components/edit_text_field_with_icon.dart';
import '../../components/new_auto_complete_text_field_with_suggetion.dart';
import '../../components/new_edit_text_field_with_icon.dart';
import '../../components/simple_button_with_corner.dart';
import 'controller/game_page_controller.dart';

class SingleAnkPage extends StatelessWidget {
  SingleAnkPage({super.key});
  final controller = Get.find<GamePageController>();
  final walletController = Get.put(WalletController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(
      () => Scaffold(
        appBar: AppUtils().simpleAppbar(
          appBarTitle: controller.marketName.toString(),
          // appBarTitle: "TIMEBAZAAR".tr,
          actions: [
            Row(
              children: [
                SvgPicture.asset(
                  ConstantImage.walletAppbar,
                  height: Dimensions.h18,
                  color: AppColors.white,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w11),
                  child: Text(
                    walletController.walletBalance.value,
                    style: CustomTextStyle.textPTsansMedium.copyWith(
                      color: AppColors.white,
                      fontSize: Dimensions.h18,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        backgroundColor: AppColors.white,
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.h10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Dimensions.h10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${controller.gameMode.name}".toUpperCase(),
                            // controller.gameMode.name!
                            //         .toUpperCase()
                            //         .contains("JODI")
                            //     ? " ${controller.gameMode.name}".toUpperCase(),
                            // : " ${controller.gameMode.name}".toUpperCase(),
                            style: CustomTextStyle.textRobotoSansBold.copyWith(
                                color: AppColors.appbarColor,
                                fontSize: Dimensions.h18),
                            // style: TextStyle(
                            //     color: AppColors.appbarColor,
                            //     fontWeight: FontWeight.bold,
                            //     fontSize: Dimensions.h18),
                          ),
                          Text(
                            controller.biddingType.value.toUpperCase(),
                            style: CustomTextStyle.textRobotoSansBold.copyWith(
                                color: AppColors.appbarColor,
                                fontSize: Dimensions.h18),
                            // style: TextStyle(
                            //     color: AppColors.appbarColor,
                            //     fontWeight: FontWeight.bold,
                            //     fontSize: Dimensions.h18),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.h5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Dimensions.r10)),
                                color: AppColors.white,
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, 4),
                                    blurRadius: 3,
                                    spreadRadius: 0.2,
                                    color: AppColors.grey.withOpacity(0.7),
                                  ),
                                ],
                              ),
                              child: RoundedCornerEditTextWithIcon2(
                                formatter: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                tapTextStyle: AppColors.black,
                                hintTextColor: AppColors.black.withOpacity(0.5),
                                //textAlign: TextAlign.center,
                                hintTextStyle: CustomTextStyle
                                    .textRobotoSansMedium
                                    .copyWith(
                                  color: AppColors.black.withOpacity(0.5),
                                  fontSize: Dimensions.h15,
                                  fontWeight: FontWeight.bold,
                                ),
                                textStyle: CustomTextStyle.textRobotoSansMedium
                                    .copyWith(
                                  color: AppColors.black.withOpacity(0.8),
                                  fontSize: Dimensions.h15,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLength: 5,
                                width: size.width / 2,
                                onChanged: (val) {
                                  if (val != null) {
                                    if (val.characters.characterAt(0) ==
                                        Characters("0")) {
                                      print("22222222222222");
                                      // we need to remove the first char
                                      controller.coinController.text =
                                          val.substring(1);
                                      // we need to move the cursor
                                      controller.coinController.selection =
                                          TextSelection.collapsed(
                                        offset: controller
                                            .coinController.text.length,
                                      );
                                    } else if (int.parse(val) >= 1) {
                                      print("333333333333333   ${val.length}");
                                      controller.validCoinsEntered.value = true;
                                      controller.isEnable.value = true;
                                    } else if (int.parse(val) > 10000) {
                                      AppUtils.showErrorSnackBar(
                                          bodyText:
                                              "You can not add more than 10000 points");
                                      controller.validCoinsEntered.value =
                                          false;
                                      controller.isEnable.value = true;
                                    } else {
                                      print(
                                          "444444444444444444   ${val.length}");
                                      controller.ondebounce();
                                      controller.validCoinsEntered.value =
                                          false;
                                      controller.isEnable.value = false;
                                    }
                                  } else {
                                    controller.validCoinsEntered.value = false;
                                    controller.isEnable.value = false;
                                  }
                                  controller.update();
                                },
                                controller: controller.coinController,
                                hintText: "Enter Points",
                                imagePath: "",
                                textAlign: TextAlign.center,
                                contentPadding:
                                    const EdgeInsets.only(right: 40),
                                containerBackColor: AppColors.transparent,
                                height: Dimensions.h35,
                                keyboardType: TextInputType.number,
                              ),
                              // child: RoundedCornerEditTextWithIcon(
                              //   tapTextStyle: AppColors.appbarColor,
                              //   hintTextColor:
                              //       AppColors.appbarColor.withOpacity(0.5),
                              //   width: size.width / 2,
                              //   textAlign: TextAlign.center,
                              //   controller: controller.coinController,
                              //   textStyle:
                              //       CustomTextStyle.textPTsansMedium.copyWith(
                              //     color: AppColors.black.withOpacity(0.8),
                              //     fontWeight: FontWeight.bold,
                              //     fontSize: Dimensions.h15,
                              //   ),
                              //   hintTextStyle: CustomTextStyle
                              //       .textRobotoSansMedium
                              //       .copyWith(
                              //     color: AppColors.black.withOpacity(0.5),
                              //     fontSize: Dimensions.h15,
                              //     fontWeight: FontWeight.bold,
                              //   ),
                              //   formatter: [
                              //     FilteringTextInputFormatter.digitsOnly
                              //   ],
                              //   onChanged: (val) {
                              //     if (val != null) {
                              //       print("111111111111");

                              //       if (val.characters.characterAt(0) ==
                              //           Characters("0")) {
                              //         print("22222222222222");
                              //         // we need to remove the first char
                              //         controller.coinController.text =
                              //             val.substring(1);
                              //         // we need to move the cursor
                              //         controller.coinController.selection =
                              //             TextSelection.collapsed(
                              //           offset: controller
                              //               .coinController.text.length,
                              //         );
                              //       } else if (int.parse(val) >= 1) {
                              //         print(
                              //             "333333333333333   ${val.length}");
                              //         controller.validCoinsEntered.value =
                              //             true;
                              //         controller.isEnable.value = true;
                              //       } else if (int.parse(val) > 10000) {
                              //         AppUtils.showErrorSnackBar(
                              //             bodyText:
                              //                 "You can not add more than 10000 points");
                              //         controller.validCoinsEntered.value =
                              //             false;
                              //         controller.isEnable.value = true;
                              //       } else {
                              //         print(
                              //             "444444444444444444   ${val.length}");
                              //         controller.ondebounce();
                              //         controller.validCoinsEntered.value =
                              //             false;
                              //         controller.isEnable.value = true;
                              //       }
                              //     } else {
                              //       controller.validCoinsEntered.value =
                              //           false;
                              //       controller.isEnable.value = false;
                              //     }
                              //   },
                              //   autofocus: true,
                              //   maxLength: 5,
                              //   hintText: "Enter Points",
                              //   contentPadding:
                              //       const EdgeInsets.only(right: 40),
                              //   imagePath: "",
                              //   containerBackColor: AppColors.black,
                              //   iconColor: AppColors.white,
                              //   height: Dimensions.h35,
                              //   keyboardType: TextInputType.number,
                              // ),
                            ),
                          ),
                          SizedBox(
                            width: Dimensions.w10,
                          ),
                          Expanded(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Dimensions.r10)),
                                color: AppColors.white,
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, 4),
                                    blurRadius: 3,
                                    spreadRadius: 0.2,
                                    color: AppColors.grey.withOpacity(0.7),
                                  ),
                                ],
                              ),
                              child: RoundedCornerEditTextWithIcon2(
                                formatter: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                tapTextStyle: AppColors.black,
                                hintTextColor: AppColors.black.withOpacity(0.5),
                                //textAlign: TextAlign.center,
                                hintTextStyle: CustomTextStyle
                                    .textRobotoSansMedium
                                    .copyWith(
                                  color: AppColors.black.withOpacity(0.5),
                                  fontSize: Dimensions.h15,
                                  fontWeight: FontWeight.bold,
                                ),
                                textStyle: CustomTextStyle.textRobotoSansMedium
                                    .copyWith(
                                  color: AppColors.black.withOpacity(0.8),
                                  fontSize: Dimensions.h15,
                                  fontWeight: FontWeight.bold,
                                ),
                                width: size.width / 2,
                                onChanged: (value) {
                                  if (value == '') {
                                    controller.matches.clear();
                                    return const Iterable<String>.empty();
                                  } else {
                                    controller.matches.clear();
                                    controller.matches
                                        .addAll(controller.suggestionList);
                                    controller.matches.retainWhere((s) {
                                      return s.toLowerCase().contains(
                                            value!.toLowerCase(),
                                          );
                                    });
                                    for (var i = 0;
                                        i < controller.matches.length;
                                        i++) {
                                      print(controller.matches[i]);
                                    }
                                  }
                                  controller.update();
                                },
                                controller: controller.searchController,
                                hintText: "SEARCH_TEXT".tr,
                                imagePath: ConstantImage.serchZoomIcon,
                                containerBackColor: AppColors.transparent,
                                height: Dimensions.h35,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: Dimensions.h11,
              ),
              numberLine(controller: controller),
              Obx(
                () => controller.matches.isNotEmpty
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 50,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: controller.matches.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.r10),
                                onTap: () => controller.isEnable.value
                                    ? controller.onTapNumberList(index)
                                    : null,
                                child: Opacity(
                                  opacity: controller.validCoinsEntered.value
                                      ? 1
                                      : 0.5,
                                  child: numberRedioButton(
                                      textColor: controller.digitList[index]
                                                  .isSelected ??
                                              false
                                          ? AppColors.green
                                          : AppColors.appbarColor,
                                      container: controller.digitList[index]
                                                  .isSelected ??
                                              false
                                          ? Container(
                                              height: Dimensions.h15,
                                              width: Dimensions.h15,
                                              decoration: BoxDecoration(
                                                color: AppColors.green,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                border: Border.all(
                                                  color: AppColors.green,
                                                  width: Dimensions.w2,
                                                ),
                                              ),
                                              child: Center(
                                                child: FittedBox(
                                                  fit: BoxFit.fitWidth,
                                                  child: Icon(Icons.check,
                                                      size: 13,
                                                      color: AppColors.white),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              height: Dimensions.h15,
                                              width: Dimensions.w15,
                                              decoration: BoxDecoration(
                                                color: AppColors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                border: Border.all(
                                                  color: AppColors.appbarColor,
                                                  width: Dimensions.w2,
                                                ),
                                              ),
                                            ),
                                      color: controller.digitList[index]
                                                  .isSelected ??
                                              false
                                          ? AppColors.green
                                          : AppColors.transparent,
                                      controller.matches[index].toString(),
                                      controller: controller),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 50,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: controller.digitList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.r10),
                                onTap: () => controller.isEnable.value
                                    ? controller.onTapNumberList(index)
                                    : null,
                                child: Opacity(
                                  opacity: controller.validCoinsEntered.value
                                      ? 1
                                      : 0.5,
                                  child: numberRedioButton(
                                      textColor: controller.digitList[index]
                                                  .isSelected ??
                                              false
                                          ? AppColors.green
                                          : AppColors.appbarColor,
                                      container: controller.digitList[index]
                                                  .isSelected ??
                                              false
                                          ? Container(
                                              height: Dimensions.h15,
                                              width: Dimensions.h15,
                                              decoration: BoxDecoration(
                                                color: AppColors.green,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                border: Border.all(
                                                  color: AppColors.green,
                                                  width: Dimensions.w2,
                                                ),
                                              ),
                                              child: Center(
                                                child: FittedBox(
                                                  fit: BoxFit.fitWidth,
                                                  child: Icon(Icons.check,
                                                      size: 13,
                                                      color: AppColors.white),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              height: Dimensions.h15,
                                              width: Dimensions.w15,
                                              decoration: BoxDecoration(
                                                color: AppColors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                border: Border.all(
                                                  color: AppColors.appbarColor,
                                                  width: Dimensions.w2,
                                                ),
                                              ),
                                            ),
                                      color: controller.digitList[index]
                                                  .isSelected ??
                                              false
                                          ? AppColors.green
                                          : AppColors.transparent,
                                      controller.digitList[index].value ?? "",
                                      controller: controller),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
              )
              //  buttonContainer(size),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          width: size.width,
          height: Dimensions.h45,
          color: AppColors.appbarColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              nameColumn(
                  titleText: "Bids",
                  subText: controller.selectedBidsList.length.toString(),
                  textColor: AppColors.white,
                  textColor2: AppColors.white),
              nameColumn(
                  titleText: "Points",
                  subText: controller.totalAmount.value.toString(),
                  textColor: AppColors.white,
                  textColor2: AppColors.white),
              const Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: RoundedCornerButton(
                  text: "SAVE".tr.toUpperCase(),
                  color: AppColors.white,
                  borderColor: AppColors.white,
                  fontSize: Dimensions.h11,
                  fontWeight: FontWeight.w600,
                  fontColor: AppColors.black,
                  letterSpacing: 1,
                  borderRadius: Dimensions.r5,
                  borderWidth: 0.2,
                  textStyle: CustomTextStyle.textRobotoSansBold,
                  onTap: () {
                    controller.onTapOfSaveButton();
                    // controller.coinsFocusNode.unfocus();
                    // controller.openFocusNode.requestFocus();
                    // controller.onTapOfAddBidButton();
                  },
                  height: Dimensions.h25,
                  width: Dimensions.w100,
                ),
              ),
            ],
          ),
        ),
        //  bottomNavigationBar: bottomNavigationBar(controller.totalAmount.value),
      ),
    );
  }

  Widget nameColumn(
      {required String titleText,
      required String subText,
      required Color textColor,
      required Color textColor2}) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 2,
      ),
      child: SizedBox(
        // color: AppColors.balanceCoinsColor,
        width: Dimensions.w95,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Column(
            children: [
              Text(
                textAlign: TextAlign.center,
                titleText,
                style: CustomTextStyle.textRobotoSansBold.copyWith(
                  color: textColor,
                  fontSize: Dimensions.h13,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  textAlign: TextAlign.center,
                  subText,
                  style: CustomTextStyle.textRobotoSansBold.copyWith(
                    color: textColor2,
                    fontSize: Dimensions.h13,
                  ),
                ),
              )
            ],
          ),
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
                style: CustomTextStyle.textRobotoSansMedium.copyWith(
                  color: AppColors.white,
                  fontSize: Dimensions.h18,
                ),
                // style: TextStyle(
                // color: AppColors.white,
                // fontSize: Dimensions.h18,
                // ),
              ),
            ),
            Row(
              children: [
                Container(
                  height: Dimensions.h25,
                  width: Dimensions.h25,
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

  Widget numberRedioButton(text,
      {required GamePageController controller,
      required Color color,
      required Widget container,
      required Color textColor}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(Dimensions.r10),
        border: Border.all(
          color: color,
          width: Dimensions.w2,
        ),
      ),
      height: Dimensions.h40,
      width: Dimensions.w130,
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              // child: widgetContainer,
              child: container),
          SizedBox(
            width: Dimensions.w20,
          ),
          Text(
            text,
            style: CustomTextStyle.textPTsansMedium.copyWith(
              fontSize: Dimensions.h15,
              color: textColor,
            ),
          )
        ],
      ),
    );
  }

  // buttonContainer(size) {
  //   return Container(
  //     color: AppColors.grey.withOpacity(0.15),
  //     height: Dimensions.h60,
  //     child: Center(
  //       child: Padding(
  //         padding: EdgeInsets.symmetric(
  //           horizontal: Dimensions.h30,
  //         ),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Expanded(
  //               child: ButtonWidget(
  //                 onTap: () => Get.back(),
  //                 text: "CANCEL_TEXT".tr,
  //                 buttonColor: AppColors.buttonColorOrange,
  //                 height: Dimensions.h30,
  //                 width: size.width / 2,
  //                 radius: Dimensions.h3,
  //               ),
  //             ),
  //             SizedBox(
  //               width: Dimensions.w10,
  //             ),
  //             Expanded(
  //               child: ButtonWidget(
  //                 onTap: () => controller.onTapOfSaveButton(),
  //                 text: "SAVE_TEXT".tr,
  //                 buttonColor: AppColors.appbarColor,
  //                 height: Dimensions.h30,
  //                 width: size.width / 2,
  //                 radius: Dimensions.h3,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  numberLine({required GamePageController controller}) {
    return controller.showNumbersLine.value
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
                      return Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: GestureDetector(
                          onTap: () {
                            controller.onTapOfNumbersLine(index);
                            controller.selectedIndexOfDigitRow = index;
                          },
                          child: Container(
                            width: Dimensions.w30,
                            height: Dimensions.w30,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: controller.digitRow[index].isSelected!
                                      ? AppColors.numberListContainer
                                      : AppColors.wpColor1,
                                  width: 1),
                              borderRadius: BorderRadius.circular(4),
                              color: controller.digitRow[index].isSelected!
                                  ? AppColors.white
                                  : AppColors.wpColor1,
                            ),
                            child: Center(
                              child: Text(
                                controller.digitRow[index].value ?? "",
                                style: TextStyle(
                                    color:
                                        controller.digitRow[index].isSelected ??
                                                false
                                            ? AppColors.black
                                            : AppColors.white,
                                    fontSize: Dimensions.h15,
                                    fontWeight: FontWeight.bold),
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
        : const SizedBox();
  }
}
