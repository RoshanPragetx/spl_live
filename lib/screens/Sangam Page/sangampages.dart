// ignore_for_file: unused_import, must_be_immutable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spllive/components/simple_button_with_corner.dart';
import 'package:spllive/helper_files/custom_text_style.dart';
import 'package:spllive/helper_files/ui_utils.dart';
import 'package:spllive/screens/Sangam%20Page/controller/sangam_page_controller.dart';
import '../../Custom Controllers/wallet_controller.dart';
import '../../components/auto_complete_text_field_with_suggestion.dart';
import '../../components/new_auto_complete_text_field_with_suggetion.dart';
import '../../helper_files/app_colors.dart';
import '../../helper_files/constant_image.dart';
import '../../helper_files/dimentions.dart';

class SangamPages extends StatelessWidget {
  SangamPages({super.key});
  var controller = Get.put(SangamPageController());
  final walletController = Get.put(WalletController());
  var value2 = true;
  List<String> matches = <String>[];
  var border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: Colors.transparent,
    ),
  );
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
          ]),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                verticalSpace,
                Text(
                  controller.gameMode.value.name!.toUpperCase(),
                  style: CustomTextStyle.textRobotoSansBold.copyWith(
                    color: AppColors.appbarColor,
                    fontSize: Dimensions.h18,
                  ),
                ),
                verticalSpace,
                // controller.gameMode.value.name!.toUpperCase() == "FULL SANGAM"
                //     ? Container()
                //     : RoundedCornerButton(
                //         text: "CHANGE".tr,
                //         color: AppColors.appbarColor,
                //         borderColor: AppColors.appbarColor,
                //         fontSize: Dimensions.h12,
                //         fontWeight: FontWeight.w500,
                //         fontColor: AppColors.white,
                //         letterSpacing: 1,
                //         borderRadius: Dimensions.r5,
                //         borderWidth: 0.2,
                //         textStyle: CustomTextStyle.textRobotoSansMedium,
                //         onTap: () {
                //           value2 = !value2;
                //           controller.onTapOfGameModeButton(value: value2);
                //         },
                //         height: Dimensions.h30,
                //         width: size.width / 2,
                //       ),

                openCloseWidget(size),
                verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 10),
                        child: AutoTextFieldWithSuggetion(
                          imagePath: "",
                          maxLength: 5,
                          enable: true,
                          focusNode: controller.coinsFocusNode,
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
                              } else if (int.parse(val) == 0) {
                                print("value == 0");
                                AppUtils.showErrorSnackBar(
                                  bodyText: "Please enter valid points",
                                );
                              } else if (int.parse(val) > 10000) {
                                print("value > 10000");
                                AppUtils.showErrorSnackBar(
                                  bodyText:
                                      "You can not add more than 10000 points",
                                );
                              }
                            }
                          },
                          height: Dimensions.h35,
                          controller: controller.coinsController,
                          hintText: "ENTERCOIN".tr,
                          containerWidth: double.infinity,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          validateValue: (validate, value) {
                            // controller.validateEnteredOpenDigit(value);
                            // if (controller.gameMode.value.name!.toUpperCase() ==
                            //     "FULL SANGAM") {
                            //   if (value.length == 3) {
                            //     controller.openFocusNode.unfocus();
                            //     controller.closeFocusNode.requestFocus();
                            //   }
                            // } else {
                            //   if (value.length == 1) {
                            //     controller.openFocusNode.unfocus();
                            //     controller.closeFocusNode.requestFocus();
                            //   }
                            // }
                          },
                          isBulkMode: false,
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            if (textEditingValue.text == '') {
                              return const Iterable<String>.empty();
                            } else {
                              // List<String> matches = <String>[];
                              // matches.addAll(controller.suggestionOpenList);
                              // matches.retainWhere(
                              //   (s) {
                              //     return s.toLowerCase().contains(
                              //           textEditingValue.text.toLowerCase(),
                              //         );
                              //   },
                              // );
                              return matches;
                            }
                          },
                        ),
                      ),
                    ),
                    // Expanded(
                    //   child: Center(
                    //     child: Container(
                    //       decoration: BoxDecoration(
                    //         color: AppColors.white,
                    //         boxShadow: [
                    //           BoxShadow(
                    //             blurRadius: 5,
                    //             color: AppColors.grey,
                    //             spreadRadius: 2,
                    //             offset: const Offset(1, 2),
                    //           )
                    //         ],
                    //       ),
                    //       height: Dimensions.h40,
                    //       width: size.width / 1.8,
                    //       child: Center(
                    //         child: TextFormField(
                    //           autofocus: false,
                    //           enabled: true,
                    //           controller: controller.coinsController,
                    //           maxLength: 5,
                    //           maxLines: 1,
                    //           minLines: 1,
                    //           keyboardType: TextInputType.number,
                    //           inputFormatters: [
                    //             FilteringTextInputFormatter.digitsOnly
                    //           ],
                    //           cursorColor: AppColors.appbarColor,
                    //           textAlign: TextAlign.center,
                    //           style:
                    //               CustomTextStyle.textRobotoSansBold.copyWith(
                    //             color: AppColors.appbarColor,
                    //             fontWeight: FontWeight.bold,
                    //             fontSize: Dimensions.h15,
                    //           ),
                    //           focusNode: controller.coinsFocusNode,
                    //           decoration: InputDecoration(
                    //             contentPadding: imagePath.isEmpty
                    //                 ? EdgeInsets.symmetric(
                    //                     horizontal: Dimensions.w12)
                    //                 : const EdgeInsets.only(left: 50),
                    //             focusColor: AppColors.appbarColor,
                    //             filled: true,
                    //             fillColor: AppColors.white,
                    //             counterText: "",
                    //             focusedBorder: decoration,
                    //             border: decoration,
                    //             errorBorder: decoration,
                    //             disabledBorder: decoration,
                    //             enabledBorder: decoration,
                    //             errorMaxLines: 0,
                    //             hintText: "ENTERCOIN".tr,
                    //             hintStyle: CustomTextStyle.textPTsansBold
                    //                 .copyWith(
                    //                     color: AppColors.appbarColor
                    //                         .withOpacity(0.5),
                    //                     fontSize: Dimensions.h15,
                    //                     fontWeight: FontWeight.bold),
                    //             prefixIcon: imagePath.isNotEmpty
                    //                 ? Padding(
                    //                     padding: const EdgeInsets.all(8.0),
                    //                     child: Container(
                    //                       decoration: BoxDecoration(
                    //                           color: AppColors.appbarColor,
                    //                           borderRadius:
                    //                               BorderRadius.circular(50)),
                    //                       child: Padding(
                    //                         padding: EdgeInsets.only(
                    //                             top: Dimensions.h4,
                    //                             bottom: Dimensions.h4),
                    //                         child: SvgPicture.asset(
                    //                           imagePath,
                    //                           color: AppColors.white,
                    //                           height: 5,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   )
                    //                 : null,
                    //           ),
                    //           onChanged: (val) {
                    //             if (val != null) {
                    //               if (val.characters.characterAt(0) ==
                    //                       Characters("0") &&
                    //                   val.length > 1) {
                    //                 // we need to remove the first char
                    //                 controller.coinsController.text =
                    //                     val.substring(1);
                    //                 // we need to move the cursor
                    //                 controller.coinsController.selection =
                    //                     TextSelection.collapsed(
                    //                         offset: controller
                    //                             .coinsController.text.length);
                    //               } else if (int.parse(val) == 0) {
                    //                 print("value == 0");
                    //                 AppUtils.showErrorSnackBar(
                    //                   bodyText: "Please enter valid points",
                    //                 );
                    //               } else if (int.parse(val) > 10000) {
                    //                 print("value > 10000");
                    //                 AppUtils.showErrorSnackBar(
                    //                   bodyText:
                    //                       "You can not add more than 10000 points",
                    //                 );
                    //               }
                    //             }
                    //           },
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 4),
                                blurRadius: 3,
                                spreadRadius: 0.2,
                                color: AppColors.grey.withOpacity(0.7),
                              ),
                            ],
                          ),
                          child: RoundedCornerButton(
                            text: "PLUSADD".tr,
                            color: AppColors.appbarColor,
                            borderColor: AppColors.appbarColor,
                            fontSize: Dimensions.h13,
                            fontWeight: FontWeight.w600,
                            fontColor: AppColors.white,
                            letterSpacing: 1,
                            borderRadius: Dimensions.r5,
                            borderWidth: 0.2,
                            textStyle: CustomTextStyle.textRobotoSansBold,
                            onTap: () {
                              controller.coinsFocusNode.unfocus();
                              controller.openFocusNode.requestFocus();
                              controller.onTapOfAddBidButton();
                            },
                            height: Dimensions.h35,
                            width: size.width / 1.8,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                verticalSpace,
                verticalSpace,
                verticalSpace,
                // listview(),
                bidList(size)
                // Obx(() => controller.addedSangamList.isNotEmpty
                //     ? Padding(
                //         padding: const EdgeInsets.only(bottom: 10.0),
                //         child: RoundedCornerButton(
                //           text: "SUBMIT".tr,
                //           color: AppColors.appbarColor,
                //           borderColor: AppColors.appbarColor,
                //           fontSize: Dimensions.h12,
                //           fontWeight: FontWeight.w600,
                //           fontColor: AppColors.white,
                //           letterSpacing: 1,
                //           borderRadius: Dimensions.r5,
                //           borderWidth: 0.2,
                //           textStyle: CustomTextStyle.textRobotoSansBold,
                //           onTap: () => controller.onTapOfSaveButton(),
                //           height: Dimensions.h30,
                //           width: size.width / 1.8,
                //         ),
                //       )
                //     : Container())
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => bottumNav(
          size,
          controller.totalBiddingAmount.toString(),
        ),
      ),
      // bottomNavigationBar:
      //     Obx(() => bottomNavigationBar(controller.totalBiddingAmount.value)),
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
                ],
              ),
              child: ListTile(
                visualDensity: const VisualDensity(vertical: -3),
                trailing: InkWell(
                  onTap: () {
                    // controller.totalBiddingAmount.value = controller
                    //     .requestModel.value.bids![index].coins
                    //     .toString();
                    //  controller.onDeleteSangamBid(index);
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
                  style: CustomTextStyle.textRobotoSansBold.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: Dimensions.h14,
                    color: AppColors.black,
                  ),
                ),
                subtitle: Text(
                  "Bid No. : ${controller.requestModel.value.bids![index].bidNo}, Coins : ${controller.requestModel.value.bids![index].coins}",
                  style: CustomTextStyle.textRobotoSansBold.copyWith(
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

  openCloseWidget(size) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Obx(
                () => Text(
                  controller.gameMode.value.name!.toUpperCase() ==
                          "HALF SANGAM B"
                      ? "CLOSEDIGIT".tr.toUpperCase()
                      : controller.openText.value.toUpperCase(),
                  // "OPEN DIGIT",
                  style: CustomTextStyle.textRobotoSansBold.copyWith(
                    color: AppColors.black,
                    fontSize: Dimensions.h13,
                  ),
                ),
              ),
              Obx(
                () => Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
                  child: AutoTextFieldWithSuggetion(
                    imagePath: "",
                    maxLength: controller.gameMode.value.name!.toUpperCase() ==
                            "FULL SANGAM"
                        ? 3
                        : 1,
                    autofocus: true,
                    focusNode: controller.openFocusNode,
                    onChanged: (val) {},
                    enable: true,
                    height: Dimensions.h35,
                    controller: controller.openValueController,
                    hintText: controller.openFieldHint.value,
                    containerWidth: double.infinity,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    validateValue: (validate, value) {
                      controller.validateEnteredOpenDigit(value);
                      if (controller.gameMode.value.name!.toUpperCase() ==
                          "FULL SANGAM") {
                        if (value.length == 3) {
                          controller.openFocusNode.unfocus();
                          controller.closeFocusNode.requestFocus();
                        }
                      } else {
                        if (value.length == 1) {
                          controller.openFocusNode.unfocus();
                          controller.closeFocusNode.requestFocus();
                        }
                      }
                    },
                    isBulkMode: false,
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<String>.empty();
                      } else {
                        // List<String> matches = <String>[];
                        // matches.addAll(controller.suggestionOpenList);
                        // matches.retainWhere(
                        //   (s) {
                        //     return s.toLowerCase().contains(
                        //           textEditingValue.text.toLowerCase(),
                        //         );
                        //   },
                        // );
                        return matches;
                      }
                    },
                  ),
                ),
              ),
              // Obx(
              //   () => AutoCompleteTextField(
              //     controller: controller.openValueController,
              //     height: Dimensions.h40,
              //     textStyle: CustomTextStyle.textRobotoSansMedium.copyWith(
              //         color: AppColors.appbarColor,
              //         fontWeight: FontWeight.bold,
              //         fontSize: Dimensions.h15,
              //         letterSpacing: 1),
              //     width: double.infinity,
              //     //   autoFocus: true,
              //     maxLength: controller.gameMode.value.name!.toUpperCase() ==
              //             "FULL SANGAM"
              //         ? 3
              //         : 1,

              //     focusNode: controller.openFocusNode,
              //     formatter: [FilteringTextInputFormatter.digitsOnly],
              //     isBulkMode: false,
              //     suggestionWidth: Dimensions.w150,
              //     hintText: controller.openFieldHint.value,
              //     hintTextColor: AppColors.appbarColor.withOpacity(0.5),
              //     keyboardType: TextInputType.number,
              //     validateValue: (validate, value) {
              //       controller.validateEnteredOpenDigit(value);
              //       if (controller.gameMode.value.name!.toUpperCase() ==
              //           "FULL SANGAM") {
              //         if (value.length == 3) {
              //           controller.openFocusNode.unfocus();
              //           controller.closeFocusNode.requestFocus();
              //         }
              //       } else {
              //         if (value.length == 1) {
              //           controller.openFocusNode.unfocus();
              //           controller.closeFocusNode.requestFocus();
              //         }
              //       }
              //     },

              //     optionsBuilder: (TextEditingValue textEditingValue) {
              //       if (textEditingValue.text == '') {
              //         return const Iterable<String>.empty();
              //       } else {
              //         // List<String> matches = <String>[];
              //         // matches.addAll(controller.suggestionOpenList);
              //         // matches.retainWhere(
              //         //   (s) {
              //         //     return s.toLowerCase().contains(
              //         //           textEditingValue.text.toLowerCase(),
              //         //         );
              //         //   },
              //         // );
              //         return matches;
              //       }
              //     },
              //   ),
              // ),
            ],
          ),
        ),
        SizedBox(
          width: Dimensions.w10,
        ),
        Obx(
          () => Expanded(
            child: Column(
              children: [
                Text(
                  controller.gameMode.value.name!.toUpperCase() ==
                          "HALF SANGAM B"
                      ? "OPENPANA".tr.toUpperCase()
                      : controller.closeText.value.toUpperCase(),
                  //  controller.closeText.value.toUpperCase(),
                  style: CustomTextStyle.textRobotoSansBold.copyWith(
                    color: AppColors.black,
                    fontSize: Dimensions.h13,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 4),
                          blurRadius: 3,
                          spreadRadius: 0.2,
                          color: AppColors.grey.withOpacity(0.7),
                        ),
                      ],
                    ),
                    height: Dimensions.h35,
                    width: double.infinity,
                    child: RawAutocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        // controller.closeValueController.text =
                        //     textEditingValue.text;
                        if (textEditingValue.text == '') {
                          matches.clear();
                          return const Iterable<String>.empty();
                        } else {
                          //    List<String> matches = <String>[];
                          matches.clear();
                          matches.addAll(
                            controller.gameMode.value.name!.toUpperCase() ==
                                    "HALF SANGAM B"
                                ? controller.suggestionOpenList
                                : controller.suggestionCloseList,
                          );
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
                      onSelected: (String selection) {
                        debugPrint(
                            'Selected Suggestion of auto complete text field is $selection');
                      },
                      fieldViewBuilder: (BuildContext context,
                          TextEditingController textEditingController,
                          FocusNode focusNode,
                          VoidCallback onFieldSubmitted) {
                        return TextFormField(
                          cursorColor: AppColors.appbarColor,
                          controller: textEditingController =
                              controller.closeValueController,
                          focusNode: controller.closeFocusNode = focusNode,
                          maxLength: 3,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            controller.validateEnteredCloseDigit(
                                false, controller.closeValueController.text);
                            if (controller.closeValueController.text.length ==
                                3) {
                              controller.closeFocusNode.unfocus();
                              controller.coinsFocusNode.requestFocus();
                            }
                          },
                          textAlign: TextAlign.start,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: CustomTextStyle.textRobotoSansMedium
                              .copyWith(color: AppColors.black),
                          decoration: InputDecoration(
                            hintStyle:
                                CustomTextStyle.textRobotoSansMedium.copyWith(
                              color: AppColors.black.withOpacity(0.65),
                              fontSize: Dimensions.h14,
                            ),
                            counterText: "",
                            filled: true,
                            errorMaxLines: 0,
                            contentPadding: const EdgeInsets.only(left: 10),
                            hintText: "ENTERPANA".tr,
                            fillColor: AppColors.textFieldFillColor,
                            focusedBorder: border,
                            border: border,
                            errorBorder: border,
                            disabledBorder: border,
                            enabledBorder: border,
                          ),
                        );
                      },
                      optionsViewBuilder: (BuildContext context,
                          AutocompleteOnSelected<String> onSelected,
                          Iterable<String> options) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            elevation: 4.0,
                            child: Container(
                              width: size.width / 2.2,
                              child: ListView.builder(
                                padding: const EdgeInsets.all(15),
                                shrinkWrap: true,
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final String option =
                                      options.elementAt(index);
                                  return GestureDetector(
                                    onTap: () {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      onSelected(option);
                                      controller.coinsFocusNode.requestFocus();
                                      // onSelected(option);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(Dimensions.h5),
                                      height: Dimensions.h30,
                                      child: Center(
                                        child: Text(
                                          option,
                                          style: CustomTextStyle
                                              .textRobotoSansMedium
                                              .copyWith(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: Dimensions.h16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // AutoCompleteTextField(
                //   controller: controller.closeValueController,
                //   height: Dimensions.h40,
                //   width: double.infinity,
                //   suggestionWidth: Dimensions.w150,
                //   hintText: "ENTERPANA".tr,
                //   maxLength: 3,
                //   isBulkMode: true,
                //   keyboardType: TextInputType.number,
                //   hintTextColor: AppColors.appbarColor.withOpacity(0.5),
                //   textStyle: CustomTextStyle.textRobotoSansBold
                //       .copyWith(color: AppColors.appbarColor),
                //   formatter: [FilteringTextInputFormatter.digitsOnly],
                //   validateValue: (validate, value) {
                //     controller.validateEnteredCloseDigit(validate, value);
                //   },
                //   // focusNode: FocusNode(),
                //   optionsBuilder: (TextEditingValue textEditingValue) {
                //     if (textEditingValue.text == '') {
                //       return const Iterable<String>.empty();
                //     } else {
                //       matches.addAll(controller.suggestionCloseList);
                //       matches.retainWhere(
                //         (s) {
                //           return s.toLowerCase().contains(
                //                 textEditingValue.text.toLowerCase(),
                //               );
                //         },
                //       );
                //       return matches;
                //     }
                //   },
                // ),
                // AutoCompleteTextField(
                //   controller: controller.closeValueController,
                //   height: Dimensions.h40,
                //   width: double.infinity,
                //   suggestionWidth: Dimensions.w150,
                //   hintText: "ENTERPANA".tr,
                //   maxLength: 3,
                //   focusNode: FocusNode(),
                //   hintTextColor: AppColors.appbarColor.withOpacity(0.5),
                //   isBulkMode: true,
                //   keyboardType: TextInputType.number,
                //   validateValue: (validate, value) {
                //     controller.validateEnteredCloseDigit(validate, value);
                //   },
                //   textStyle: CustomTextStyle.textRobotoSansBold
                //       .copyWith(color: AppColors.appbarColor),
                //   formatter: [FilteringTextInputFormatter.digitsOnly],
                //   optionsBuilder: (
                //     TextEditingValue textEditingValue,
                //   ) {
                //     if (textEditingValue.text == '') {
                //       return const Iterable<String>.empty();
                //     } else {
                //       List<String> matches = <String>[];
                //       // matches.clear();
                //       matches.addAll(controller.suggestionCloseList);
                //       matches.retainWhere(
                //         (s) {
                //           return s.toLowerCase().contains(
                //                 textEditingValue.text.toLowerCase(),
                //               );
                //         },
                //       );
                //       return matches;
                //     }
                //   },
                // ),
              ],
            ),
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
                "TOTALCOIN".tr,
                style: CustomTextStyle.textPTsansMedium.copyWith(
                  color: AppColors.white,
                  fontSize: Dimensions.h18,
                ),
                // style: TextStyle(
                //   color: AppColors.white,
                //   fontSize: Dimensions.h18,
                // ),
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

  bottumNav(Size size, String totalAmount) {
    return Container(
      width: size.width,
      height: Dimensions.h45,
      color: AppColors.appbarColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          nameColumn(
              titleText: "Bids",
              subText: "00",
              textColor: AppColors.white,
              textColor2: AppColors.white),
          nameColumn(
              titleText: "Points",
              subText: totalAmount,
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
            mainAxisAlignment: subText == ""
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              Text(
                textAlign: TextAlign.center,
                titleText,
                style: CustomTextStyle.textRobotoSansBold.copyWith(
                  color: textColor,
                  fontSize: Dimensions.h13,
                ),
              ),
              subText == ""
                  ? Container()
                  : Padding(
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

  bidList(Size size) {
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.addedSangamList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Container(
              height: Dimensions.h40,
              width: size.width,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1,
                    spreadRadius: 3,
                    color: AppColors.grey.withOpacity(0.2),
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      nameColumn(
                          subText: "",
                          titleText: controller.bidType,
                          textColor2: AppColors.black.withOpacity(0.5),
                          textColor: AppColors.black),
                      nameColumn(
                          subText: "",
                          titleText: controller
                                  .requestModel.value.bids![index].bidNo ??
                              "",
                          textColor2: AppColors.black.withOpacity(0.5),
                          textColor: AppColors.black),
                      nameColumn(
                          subText: "",
                          titleText: controller
                              .requestModel.value.bids![index].coins
                              .toString(),
                          textColor2: AppColors.black.withOpacity(0.5),
                          textColor: AppColors.black),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0, left: 0),
                    child: InkWell(
                      onTap: () {
                        controller.onDeleteBids(index);
                      },
                      child: Icon(
                        Icons.delete,
                        color: AppColors.redColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
