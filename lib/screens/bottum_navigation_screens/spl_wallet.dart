// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/app_colors.dart';

import '../../components/button_widget.dart';
import '../../helper_files/constant_image.dart';
import '../../helper_files/dimentions.dart';
import '../../helper_files/ui_utils.dart';
import 'controller/bottum_navigation_controller.dart';

class SPLWallet extends StatelessWidget {
  SPLWallet({super.key});
  var controller = Get.put(MoreListController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      //  color: Colors.green,
      height: size.height,
      width: double.infinity,
      child: Column(children: [
        AppUtils().simpleAppbar(appBarTitle: "SPL_WALLET".tr),
        SafeArea(
          child: SizedBox(
            child: Column(
              children: [
                Text(
                  "WALLETBALANCE".tr,
                  style: TextStyle(fontSize: Dimensions.w30),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      ConstantImage.rupeeImageGreen,
                      height: Dimensions.h40,
                      width: Dimensions.w40,
                      fit: BoxFit.fitWidth,
                    ),
                    Obx(
                      () => Text(
                        controller.walletBalance.value,
                        style: TextStyle(
                            fontSize: Dimensions.h45,
                            color: AppColors.buttonColorDarkGreen,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: Dimensions.h20,
                ),
                Text(
                  "WALLET_TEXT".tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 22),
                ),
                SizedBox(
                  height: Dimensions.h20,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ButtonWidget(
                          onTap: () {},
                          text: "ADDFUND_TEXT".tr,
                          buttonColor: AppColors.buttonColorDarkGreen,
                          height: Dimensions.h30,
                          width: size.width / 2,
                          radius: Dimensions.h25,
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.w5,
                      ),
                      Expanded(
                        child: ButtonWidget(
                          onTap: () {},
                          text: "WITHDRAWAL_TXT".tr,
                          buttonColor: AppColors.buttonColorOrange,
                          height: Dimensions.h30,
                          width: size.width / 2,
                          radius: Dimensions.h25,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
