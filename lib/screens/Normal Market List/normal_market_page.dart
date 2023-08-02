import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/custom_text_style.dart';
import 'package:spllive/helper_files/ui_utils.dart';

import '../../Custom Controllers/wallet_controller.dart';
import '../../helper_files/app_colors.dart';
import '../../helper_files/constant_image.dart';
import '../../helper_files/dimentions.dart';
import '../../routes/app_routes_name.dart';

class NormalMarketPage extends StatelessWidget {
  NormalMarketPage({super.key});
  var walletController = Get.put(WalletController());
  var verticalSpace = SizedBox(
    height: Dimensions.h10,
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppUtils().simpleAppbar(
        appBarTitle: "NormalMarket",
        actions: [
          InkWell(
            onTap: () => Get.offAndToNamed(AppRoutName.transactionPage),
            child: Row(
              children: [
                SizedBox(
                  height: Dimensions.w22,
                  width: Dimensions.w25,
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
                      right: Dimensions.r10),
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
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            verticalSpace,
            SizedBox(
              width: size.width,
              height: Dimensions.h41,
              child: Row(
                children: [
                  openCloseMarket(),
                  openCloseMarket(),
                ],
              ),
            ),
            verticalSpace,
            Expanded(child: marketList(size))
          ],
        ),
      ),
    );
  }

  Widget marketList(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 160,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemCount: 10,
        itemBuilder: (context, index) {
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
        },
      ),
    );
  }

  openCloseMarket() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: Dimensions.h41,
          decoration: BoxDecoration(
            color: AppColors.appbarColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "OPEN : 09:05 PM",
                  style: CustomTextStyle.textRobotoSansMedium
                      .copyWith(color: AppColors.wpColor2),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
