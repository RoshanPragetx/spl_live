import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../Custom Controllers/wallet_controller.dart';
import '../../components/simple_button_with_corner.dart';
import '../../helper_files/app_colors.dart';
import '../../helper_files/constant_image.dart';
import '../../helper_files/custom_text_style.dart';
import '../../helper_files/dimentions.dart';
import '../../helper_files/ui_utils.dart';
import 'controller/starline_bids_controller.dart';

class StarlineBidsPage extends StatelessWidget {
  StarlineBidsPage({super.key});
  var controller = Get.put(StarlineBidsController());
  final walletController = Get.find<WalletController>();
  @override
  Widget build(BuildContext context) {
    // print(controller.requestModel.value.bids!.length);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppUtils().simpleAppbar(
        appBarTitle: "STARLINEGAME".tr,
        actions: [
          Row(
            children: [
              SvgPicture.asset(
                ConstantImage.walletAppbar,
                height: Dimensions.h25,
                color: AppColors.white,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w11),
                child: Text(
                  walletController.walletBalance.toString(),
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
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Obx(
              () => controller.requestModel.value.bids != null &&
                      controller.requestModel.value.bids!.isNotEmpty
                  ? Column(
                      children: [
                        SizedBox(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                controller.requestModel.value.bids?.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius:
                                          BorderRadius.circular(Dimensions.h5)),
                                  child: ListTile(
                                    dense: true,
                                    visualDensity:
                                        const VisualDensity(vertical: -2),
                                    title: Text(
                                      "Single Digit - Open  ",
                                      style: CustomTextStyle.textRobotoSansLight
                                          .copyWith(fontSize: Dimensions.h12),
                                    ),
                                    subtitle: Text(
                                      "Bid no.: ${controller.requestModel.value.bids?.elementAt(index).starlineGameId}, Coins :${controller.requestModel.value.bids?.elementAt(index).coins}",
                                      style: CustomTextStyle.textRobotoSansLight
                                          .copyWith(fontSize: Dimensions.h12),
                                    ),
                                    trailing: InkWell(
                                      onTap: () {
                                        controller.onDeleteBids(index);
                                      },
                                      child: Container(
                                        color: AppColors.transparent,
                                        height: Dimensions.h30,
                                        width: Dimensions.w30,
                                        child: SvgPicture.asset(
                                          ConstantImage.trashIcon,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        // Row(
                        //   children: [
                        //     RoundedCornerButton(
                        //       text: "SUBMIT".tr,
                        //       color: AppColors.appbarColor,
                        //       borderColor: AppColors.appbarColor,
                        //       fontSize: Dimensions.h12,
                        //       fontWeight: FontWeight.w600,
                        //       fontColor: AppColors.white,
                        //       letterSpacing: 1,
                        //       borderRadius: Dimensions.r5,
                        //       borderWidth: 0.2,
                        //       textStyle: CustomTextStyle.textPTsansMedium,
                        //       onTap: () {
                        //         controller.showConfirmationDialog(context);
                        //       },
                        //       // onTap: () =>
                        //       //     controller.createMarketBidApi(),
                        //       height: Dimensions.h40,
                        //       width: size.width / 1.8,
                        //     ),
                        //     Padding(
                        //       padding: EdgeInsets.only(left: Dimensions.h10),
                        //       child: Container(
                        //         height: Dimensions.h40,
                        //         width: size.width / 3,
                        //         color: AppColors.grey.withOpacity(0.2),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.start,
                        //           children: [
                        //             SizedBox(
                        //               width: Dimensions.w11,
                        //             ),
                        //             Container(
                        //               height: Dimensions.h30,
                        //               width: Dimensions.w30,
                        //               decoration: BoxDecoration(
                        //                   color: AppColors.appbarColor,
                        //                   borderRadius:
                        //                       BorderRadius.circular(25)),
                        //               child: Padding(
                        //                 padding: const EdgeInsets.all(8.0),
                        //                 child: SvgPicture.asset(
                        //                   ConstantImage.rupeeImage,
                        //                   fit: BoxFit.contain,
                        //                   color: AppColors.white,
                        //                 ),
                        //               ),
                        //             ),
                        //             Padding(
                        //               padding: EdgeInsets.symmetric(
                        //                 horizontal: Dimensions.h10,
                        //               ),
                        //               child: Text(
                        //                 controller.totalAmount.value,
                        //                 style: CustomTextStyle
                        //                     .textRobotoSansBold
                        //                     .copyWith(fontSize: 18),
                        //               ),
                        //             )
                        //           ],
                        //         ),
                        //       ),
                        //     )
                        //   ],
                        // )
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(Dimensions.w5),
                                child: RoundedCornerButton(
                                  text: "PLAYMORE".tr,
                                  color: AppColors.white,
                                  borderColor: AppColors.redColor,
                                  fontSize: Dimensions.h14,
                                  fontWeight: FontWeight.w500,
                                  fontColor: AppColors.redColor,
                                  letterSpacing: 0,
                                  borderRadius: Dimensions.r5,
                                  borderWidth: 2,
                                  textStyle:
                                      CustomTextStyle.textRobotoSansMedium,
                                  onTap: () => controller.playMore(),
                                  height: Dimensions.h30,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(Dimensions.w5),
                                child: RoundedCornerButton(
                                  text: "SUBMIT".tr,
                                  color: AppColors.appbarColor,
                                  borderColor: AppColors.appbarColor,
                                  fontSize: Dimensions.h14,
                                  fontWeight: FontWeight.w500,
                                  fontColor: AppColors.white,
                                  letterSpacing: 0,
                                  borderRadius: Dimensions.r5,
                                  borderWidth: 1,
                                  textStyle:
                                      CustomTextStyle.textRobotoSansMedium,
                                  onTap: () {
                                    controller.showConfirmationDialog(context);
                                    controller.requestModel.value.bids?.clear();
                                    controller.totalAmount.value = "0";
                                  },
                                  //onTap: () {},
                                  height: Dimensions.h30,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Container(
                      height: 50,
                      width: 100,
                      color: AppColors.appbarColor,
                    ),
            ),
          ],
        ),
      ),
      bottomSheet: Obx(() => bottomNavigationBar(controller.totalAmount.value)),
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
                style: CustomTextStyle.textRobotoSansMedium
                    .copyWith(color: AppColors.white, fontSize: Dimensions.h18),
                // style: TextStyle(
                // color: AppColors.white,
                // fontSize: Dimensions.h18,
                // // ),
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
