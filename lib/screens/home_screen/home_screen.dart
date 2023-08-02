import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spllive/Custom%20Controllers/wallet_controller.dart';
import 'package:spllive/helper_files/ui_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/bottumnavigation/bottumnavigation.dart';
import 'controller/homepage_controller.dart';
import '../../helper_files/app_colors.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var controller = Get.put(HomePageController());
    var walletController = Get.put(WalletController());

    // var spaceBeetween = const SizedBox(height: 10);

    return Scaffold(
      // appBar: Obx(() => ),
      bottomNavigationBar: Obx(
        () => MyNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTapHome: () {
            controller.pageWidget.value = 0;
            //   appPosition = controller.pageWidget.value;
            controller.currentIndex.value = 0;
          },
          onTapBidHistory: () {
            controller.pageWidget.value = 1;
            controller.currentIndex.value = 1;
            //  appPosition = controller.pageWidget.value;
          },
          onTapWallet: () {
            controller.pageWidget.value = 2;
            controller.currentIndex.value = 2;
            //   appPosition = controller.pageWidget.value;
          },
          onTapPassbook: () {
            controller.pageWidget.value = 3;
            controller.currentIndex.value = 3;
            //   appPosition = controller.pageWidget.value;
          },
          onTapMore: () {
            controller.pageWidget.value = 4;
            //    appPosition = controller.pageWidget.value;
            controller.currentIndex.value = 4;
          },
        ),
      ),
      backgroundColor: AppColors.white,
      body: Obx(() => controller.getDashBoardPages(controller.pageWidget.value,
          size, context, walletController.walletBalance.value.toString())),
      // floatingActionButton: Obx(
      //   () => controller.pageWidget.value == 0
      //       ? AppUtils().flottingActionButton(
      //           onTap: () {
      //             launch(
      //               "https://wa.me/+917769826748/?text=hi",
      //             );
      //           },
      //         )
      //       : Container(),
      // ),
    );
  }
}
// HomeScreenUtils().gridColumnForStarLine()
