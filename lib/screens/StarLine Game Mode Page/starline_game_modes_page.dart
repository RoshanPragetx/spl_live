import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spllive/Custom%20Controllers/wallet_controller.dart';
import 'package:spllive/helper_files/custom_text_style.dart';
import 'package:spllive/helper_files/ui_utils.dart';
import 'package:spllive/routes/app_routes_name.dart';

import '../../components/simple_button_with_corner.dart';
import '../../helper_files/app_colors.dart';
import '../../helper_files/constant_image.dart';
import '../../helper_files/dimentions.dart';
import 'controller/starline_game_modes_page_controller.dart';

class StarLineGameModesPage extends StatelessWidget {
  StarLineGameModesPage({super.key});
  var walletController = Get.put(WalletController());
  final controller = Get.put(StarLineGameModesPageController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var verticalSpace = SizedBox(
      height: Dimensions.h10,
    );
    return Scaffold(
      appBar: AppUtils().simpleAppbar(
        appBarTitle: "STARLINEGAME".tr,
        leading: GestureDetector(
          onTap: () {
            Get.offAndToNamed(AppRoutName.dashBoardPage);
          },
          child: const Icon(Icons.arrow_back),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: const Icon(Icons.wallet),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: Dimensions.h14, horizontal: Dimensions.h15),
            child: Obx(
              () => Text(
                walletController.walletBalance.toString(),
                style: TextStyle(
                  fontSize: Dimensions.h14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => SizedBox(
            height: size.height,
            width: size.width,
            child: controller.gameModesList.isEmpty
                ? _buildCustomAboutBoxDialog()
                : Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.w10, vertical: Dimensions.h10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textListWidget(
                            text: controller.formattedDate,
                            widget: const Icon(Icons.calendar_month),
                            fontSize: Dimensions.h14),
                        verticalSpace,
                        textListWidget(
                          text:
                              "Starline Market :- ${controller.marketData.value.time}"
                                  .tr,
                          fontSize: Dimensions.h16,
                        ),
                        verticalSpace,
                        Text(
                          "GAMETYPE".tr,
                          style: CustomTextStyle.textPTsansMedium
                              .copyWith(fontSize: Dimensions.h15),
                        ),
                        // controller.getBidData!
                        //     ? Container(
                        //         height: 30,
                        //         width: 100,
                        //         color: AppColors.appbarColor,
                        //       )
                        //     : Container(
                        //         height: 30,
                        //         width: 100,
                        //         color: AppColors.redColor,
                        //       ),
                        verticalSpace,
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.gameModesList.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: Dimensions.h50,
                                  crossAxisSpacing: Dimensions.w10,
                                  mainAxisSpacing: Dimensions.h10),
                          itemBuilder: (context, index) {
                            return gameTile(
                              controller.gameModesList[index].name ?? "",
                              onTap: () =>
                                  controller.onTapOfGameModeTile(index),
                            );
                          },
                        ),
                        Obx(
                          () => controller.requestModel.value.bids != null &&
                                  controller.requestModel.value.bids!.isNotEmpty
                              ? Column(
                                  children: [
                                    ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: controller
                                          .requestModel.value.bids?.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                border: Border.all(),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.h5)),
                                            child: ListTile(
                                              dense: true,
                                              visualDensity:
                                                  const VisualDensity(
                                                      vertical: -2),
                                              title: Text(
                                                "${controller.gameModesList[index].name} - Open  ",
                                                style: CustomTextStyle
                                                    .textPTsansMedium
                                                    .copyWith(
                                                        fontSize:
                                                            Dimensions.h12),
                                              ),
                                              subtitle: Text(
                                                "Bid no.: ${controller.requestModel.value.bids?.elementAt(index).starlineGameId}, Coins :${controller.requestModel.value.bids?.elementAt(index).coins}",
                                                style: CustomTextStyle
                                                    .textPTsansMedium
                                                    .copyWith(
                                                        fontSize:
                                                            Dimensions.h12),
                                              ),
                                              trailing: InkWell(
                                                onTap: () {
                                                  controller
                                                      .onDeleteBids(index);
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
                                    Row(
                                      children: [
                                        RoundedCornerButton(
                                          text: "SUBMIT".tr,
                                          color: AppColors.appbarColor,
                                          borderColor: AppColors.appbarColor,
                                          fontSize: Dimensions.h12,
                                          fontWeight: FontWeight.w600,
                                          fontColor: AppColors.white,
                                          letterSpacing: 1,
                                          borderRadius: Dimensions.r5,
                                          borderWidth: 0.2,
                                          textStyle:
                                              CustomTextStyle.textPTsansMedium,
                                          onTap: () =>
                                              controller.createMarketBidApi(),
                                          height: Dimensions.h40,
                                          width: size.width / 1.8,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: Dimensions.h10),
                                          child: Container(
                                            height: Dimensions.h40,
                                            width: size.width / 3,
                                            color:
                                                AppColors.grey.withOpacity(0.2),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: Dimensions.w11,
                                                ),
                                                Container(
                                                  height: Dimensions.h30,
                                                  width: Dimensions.w30,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          AppColors.appbarColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: SvgPicture.asset(
                                                      ConstantImage.rupeeImage,
                                                      fit: BoxFit.contain,
                                                      color: AppColors.white,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: Dimensions.h10,
                                                  ),
                                                  child: Text(
                                                    controller
                                                        .totalAmount.value,
                                                    style: CustomTextStyle
                                                        .textPTsansMedium
                                                        .copyWith(fontSize: 18),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              : Container(),
                        )
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget textListWidget({
    required String text,
    Widget? widget,
    required double fontSize,
  }) {
    return ListTile(
      tileColor: AppColors.grey.withOpacity(0.2),
      title: Row(
        children: [
          widget ?? Container(),
          widget != null
              ? SizedBox(
                  width: Dimensions.w10,
                )
              : const SizedBox(),
          Text(
            text,
            style: CustomTextStyle.textPTsansBold
                .copyWith(color: AppColors.appbarColor, fontSize: fontSize),
          )
        ],
      ),
    );
  }

  Widget gameTile(String listText, {required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
                color: AppColors.grey,
                offset: const Offset(2, 2),
                blurRadius: 10,
                spreadRadius: 5),
          ],
          border: Border.all(width: 0.8),
        ),
        child: Center(
          child: Text(
            listText,
            style: CustomTextStyle.textPTsansBold.copyWith(
              color: AppColors.appbarColor,
              fontSize: Dimensions.h15,
            ),
          ),
        ),
      ),
    );
  }

  void showCustomAboutBoxDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: AppColors.black.withOpacity(0.3), // Transparent background
      barrierDismissible:
          false, // Prevent users from dismissing the dialog by tapping outside
      builder: (context) => _buildCustomAboutBoxDialog(),
    );
  }

  Widget _buildCustomAboutBoxDialog() {
    return Dialog(
      backgroundColor: AppColors.transparent,
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            SizedBox(width: Dimensions.w10),
            Text(
              "PLEASEWAIT".tr,
              style: CustomTextStyle.textPTsansBold
                  .copyWith(fontSize: Dimensions.h15),
            ),
          ],
        ),
      ),
    );
  }
}
