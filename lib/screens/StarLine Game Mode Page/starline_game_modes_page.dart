// ignore_for_file: must_be_immutable

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
  var verticalSpace = SizedBox(
    height: Dimensions.h10,
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    controller.getBidListData();
    return Scaffold(
      appBar: AppUtils().simpleAppbar(
        // appBarTitle: "STARLINEGAME".tr,
        appBarTitle: controller.marketData.value.time.toString(),
        leading: IconButton(
          onPressed: () => controller.onBackButton(),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          InkWell(
            // onTap: () => Get.offAndToNamed(AppRoutName.transactionPage),
            child: Row(
              children: [
                SizedBox(
                  height: Dimensions.w20,
                  width: Dimensions.w20,
                  child: SvgPicture.asset(
                    ConstantImage.walletAppbar,
                    color: AppColors.white,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: Dimensions.r8,
                    bottom: Dimensions.r10,
                    left: Dimensions.r15,
                    right: Dimensions.r10,
                  ),
                  child: Obx(
                    () => Text(
                      walletController.walletBalance.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Obx(
        () => SizedBox(
          child: controller.gameModesList.isEmpty
              ? _buildCustomAboutBoxDialog()
              : Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.w10, vertical: Dimensions.h5),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: cardWidget(controller, size),
                        ),
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
      visualDensity: const VisualDensity(
        vertical: -2,
      ),
      tileColor: AppColors.grey.withOpacity(0.1),
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
            style: CustomTextStyle.textRobotoSansBold
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
                color: AppColors.grey.withOpacity(0.7),
                offset: const Offset(0, 0),
                blurRadius: 5,
                spreadRadius: 3.5),
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

  gamelist(Size size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Get.toNamed(AppRoutName.newGameModePage);
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 5,
                color: AppColors.grey.withOpacity(0.5),
                offset: const Offset(2, 2),
              )
            ],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: AppColors.wpColor1,
                maxRadius: Dimensions.r35,
              ),
              verticalSpace,
              SizedBox(
                width: size.width - 5,
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      "Single Ank",
                      style: CustomTextStyle.textRobotoSansBold
                          .copyWith(fontSize: Dimensions.h15),
                    ),
                  ),
                ),
              )
            ],
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

  Widget cardWidget(StarLineGameModesPageController controller, Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.gameModesList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: Dimensions.h160,
            crossAxisSpacing: 5,
            mainAxisSpacing: 2),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
            child: InkWell(
              onTap: () {
                controller.onTapOfGameModeTile(index);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 4,
                      color: AppColors.grey.withOpacity(0.5),
                      offset: const Offset(0, 0),
                    )
                  ],
                  borderRadius: BorderRadius.circular(Dimensions.r15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: Dimensions.w80,
                      width: Dimensions.w80,
                      decoration: BoxDecoration(
                        color: AppColors.wpColor1,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(17.0),
                        child: Image.network(
                          controller.gameModesList
                              .elementAt(index)
                              .image
                              .toString(),
                          height: Dimensions.h10,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error);
                          },
                        ),
                      ),
                    ),
                    // CircleAvatar(
                    //     backgroundColor: AppColors.wpColor1,
                    //     maxRadius: Dimensions.r35,
                    //     backgroundImage:),
                    SizedBox(
                      height: Dimensions.h17,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: SizedBox(
                        width: size.width,
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              controller.gameModesList.elementAt(index).name ??
                                  "",
                              style: CustomTextStyle.textRobotoSansBold
                                  .copyWith(fontSize: Dimensions.h14),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
