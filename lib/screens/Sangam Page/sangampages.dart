// ignore_for_file: unused_import, must_be_immutable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spllive/components/edit_text_field_with_roundedcorner.dart';
import 'package:spllive/components/simple_button_with_corner.dart';
import 'package:spllive/helper_files/custom_text_style.dart';
import 'package:spllive/helper_files/ui_utils.dart';
import 'package:spllive/screens/Sangam%20Page/controller/sangam_page_controller.dart';
import '../../Custom Controllers/wallet_controller.dart';
import '../../components/auto_complete_text_field_with_suggestion.dart';
import '../../helper_files/app_colors.dart';
import '../../helper_files/constant_image.dart';
import '../../helper_files/dimentions.dart';

class SangamPages extends StatelessWidget {
  SangamPages({super.key});
  var controller = Get.put(SangamPageController());
  final walletController = Get.put(WalletController());
  var value2 = true;
  @override
  Widget build(BuildContext context) {
    var decoration = const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
    var imagePath = ConstantImage.rupeeImage;
    Size size = MediaQuery.of(context).size;
    var verticalSpace = SizedBox(
      height: Dimensions.h11,
    );
    return Scaffold(
      appBar: AppUtils().simpleAppbar(
          appBarTitle: controller.marketData.value.market ?? '',
          actions: [
            InkWell(
              onTap: () {},
              child: const Icon(Icons.wallet),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Dimensions.h14, horizontal: Dimensions.h15),
              child: Text(
                walletController.walletBalance.toString(),
                style: TextStyle(
                  fontSize: Dimensions.h14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
            ),
          ]),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              verticalSpace,
              Text(
                controller.gameMode.value.name ?? "",
                style: CustomTextStyle.textPTsansBold.copyWith(
                  color: AppColors.appbarColor,
                  fontSize: Dimensions.h20,
                ),
              ),
              verticalSpace,
              RoundedCornerButton(
                text: "CHANGE".tr,
                color: AppColors.appbarColor,
                borderColor: AppColors.appbarColor,
                fontSize: Dimensions.h12,
                fontWeight: FontWeight.w600,
                fontColor: AppColors.white,
                letterSpacing: 1,
                borderRadius: Dimensions.r5,
                borderWidth: 0.2,
                textStyle: CustomTextStyle.textPTsansMedium,
                onTap: () {
                  value2 = !value2;
                  controller.onTapOfGameModeButton(value: value2);
                },
                height: Dimensions.h30,
                width: size.width / 2,
              ),
              verticalSpace,
              openCloseWidget(),
              verticalSpace,
              verticalSpace,
              verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              color: AppColors.grey,
                              spreadRadius: 2,
                              offset: const Offset(1, 2),
                            )
                          ],
                        ),
                        height: Dimensions.h40,
                        width: size.width / 1.8,
                        child: Center(
                          child: TextFormField(
                            autofocus: false,
                            enabled: true,
                            controller: controller.coinsController,
                            maxLength: 5,
                            maxLines: 1,
                            minLines: 1,
                            keyboardType: TextInputType.number,
                            // inputFormatters: [],
                            cursorColor: AppColors.black,
                            style: CustomTextStyle.textPTsansBold.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: Dimensions.h15,
                            ),
                            decoration: InputDecoration(
                              contentPadding: imagePath.isEmpty
                                  ? EdgeInsets.symmetric(
                                      horizontal: Dimensions.w12)
                                  : EdgeInsets.zero,
                              focusColor: AppColors.appbarColor,
                              filled: true,
                              fillColor: AppColors.white,
                              counterText: "",
                              focusedBorder: decoration,
                              border: decoration,
                              errorBorder: decoration,
                              disabledBorder: decoration,
                              enabledBorder: decoration,
                              errorMaxLines: 0,
                              hintText: "ENTERCOIN".tr,
                              hintStyle: CustomTextStyle.textPTsansBold
                                  .copyWith(
                                      color: AppColors.grey,
                                      fontSize: Dimensions.h15,
                                      fontWeight: FontWeight.bold),
                              prefixIcon: imagePath.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.appbarColor,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: Dimensions.h4,
                                              bottom: Dimensions.h4),
                                          child: SvgPicture.asset(
                                            imagePath,
                                            color: AppColors.white,
                                            height: 5,
                                          ),
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                            onChanged: (val) {
                              if (val != null) {
                                if (val.characters.characterAt(0) ==
                                        Characters("0") &&
                                    val.length > 1) {
                                  // we need to remove the first char
                                  controller.coinsController.text =
                                      val.substring(1);
                                  // we need to move the cursor
                                  controller.coinsController.selection =
                                      TextSelection.collapsed(
                                          offset: controller
                                              .coinsController.text.length);
                                }
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpace,
              verticalSpace,
              RoundedCornerButton(
                text: "PLUSADD".tr,
                color: AppColors.appbarColor,
                borderColor: AppColors.appbarColor,
                fontSize: Dimensions.h12,
                fontWeight: FontWeight.w600,
                fontColor: AppColors.white,
                letterSpacing: 1,
                borderRadius: Dimensions.r5,
                borderWidth: 0.2,
                textStyle: CustomTextStyle.textPTsansMedium,
                onTap: () => controller.onTapOfAddBidButton(),
                height: Dimensions.h30,
                width: size.width / 1.8,
              ),
              verticalSpace,
              listview(),
              Obx(() => controller.addedSangamList.isNotEmpty
                  ? RoundedCornerButton(
                      text: "SUBMIT".tr,
                      color: AppColors.appbarColor,
                      borderColor: AppColors.appbarColor,
                      fontSize: Dimensions.h12,
                      fontWeight: FontWeight.w600,
                      fontColor: AppColors.white,
                      letterSpacing: 1,
                      borderRadius: Dimensions.r5,
                      borderWidth: 0.2,
                      textStyle: CustomTextStyle.textPTsansMedium,
                      onTap: () => controller.onTapOfSaveButton(),
                      height: Dimensions.h30,
                      width: size.width / 1.8,
                    )
                  : Container())
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          Obx(() => bottomNavigationBar(controller.totalBiddingAmount.value)),
    );
  }

  listview() {
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.addedSangamList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: Dimensions.h10),
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(Dimensions.h5),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: AppColors.grey,
                      spreadRadius: 2,
                      offset: const Offset(1, 2),
                    )
                  ]),
              child: ListTile(
                visualDensity: const VisualDensity(vertical: -3),
                trailing: InkWell(
                  onTap: () {
                    // controller.totalBiddingAmount.value = controller
                    //     .requestModel.value.bids![index].coins
                    //     .toString();
                    controller.onDeleteBids(index);
                  },
                  child: Container(
                    color: AppColors.transparent,
                    height: Dimensions.w25,
                    width: Dimensions.w25,
                    child: SvgPicture.asset(
                      ConstantImage.trashIcon,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  "${controller.requestModel.value.bids![index].gameModeName} - ${controller.bidType}",
                  style: CustomTextStyle.textPTsansBold.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: Dimensions.h14,
                    color: AppColors.black,
                  ),
                ),
                subtitle: Text(
                  "Bid No.: ${controller.requestModel.value.bids![index].bidNo}, Coins : ${controller.requestModel.value.bids![index].coins}",
                  style: CustomTextStyle.textPTsansBold.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  openCloseWidget() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Obx(
                () => Text(
                  controller.openText.value,
                  // "OPEN DIGIT",
                  style: CustomTextStyle.textPTsansBold.copyWith(
                    color: AppColors.black,
                    fontSize: Dimensions.h14,
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.h10,
              ),
              // RoundedCornerEditText(
              //     controller: controller.openValueController,
              //     maxLines: 3,
              //     minLines: 1,

              //     hintText: controller.openFieldHint.value,
              //     keyboardType: keyboardType)
              Obx(
                () => AutoCompleteTextField(
                  controller: controller.openValueController,
                  height: Dimensions.h40,
                  width: double.infinity,
                  maxLength: 3,
                  isBulkMode: true,
                  suggestionWidth: Dimensions.w150,
                  hintText: controller.openFieldHint.value,
                  keyboardType: TextInputType.number,
                  validateValue: (validate, value) {
                    controller.validateEnteredOpenDigit(value);
                  },
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable<String>.empty();
                    } else {
                      List<String> matches = <String>[];
                      matches.addAll(controller.suggestionOpenList);

                      matches.retainWhere(
                        (s) {
                          return s.toLowerCase().contains(
                                textEditingValue.text.toLowerCase(),
                              );
                        },
                      );
                      return matches;
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: Dimensions.w10,
        ),
        Expanded(
          child: Column(
            children: [
              Obx(
                () => Text(
                  controller.closeText.value,
                  // "CLOSE PANNA",
                  style: CustomTextStyle.textPTsansBold.copyWith(
                    color: AppColors.black,
                    fontSize: Dimensions.h14,
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.h10,
              ),
              AutoCompleteTextField(
                controller: controller.closeValueController,
                height: Dimensions.h40,
                width: double.infinity,
                suggestionWidth: Dimensions.w150,
                hintText: "ENTERPANA".tr,
                maxLength: 3,
                isBulkMode: true,
                keyboardType: TextInputType.number,
                validateValue: (validate, value) {
                  controller.validateEnteredCloseDigit(value);
                },
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text == '') {
                    return const Iterable<String>.empty();
                  } else {
                    List<String> matches = <String>[];
                    matches.addAll(controller.suggestionCloseList);
                    matches.retainWhere(
                      (s) {
                        return s.toLowerCase().contains(
                              textEditingValue.text.toLowerCase(),
                            );
                      },
                    );
                    return matches;
                  }
                },
              ),
            ],
          ),
        )
      ],
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
                "TOTAL_COIN".tr,
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
}
