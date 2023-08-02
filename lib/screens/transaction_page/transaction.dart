import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/constant_image.dart';
import 'package:spllive/helper_files/dimentions.dart';
import 'package:spllive/helper_files/ui_utils.dart';

import '../../helper_files/app_colors.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppUtils().simpleAppbar(appBarTitle: "TRANSACTIONS".tr),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.h5),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                listveiwTransaction(),
                listveiwTransaction(),
                listveiwTransaction(),
                listveiwTransaction(),
                listveiwTransaction(),
                listveiwTransaction(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget listveiwTransaction() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimensions.h5),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              color: AppColors.grey,
              blurRadius: 10,
              offset: const Offset(7, 4),
            ),
          ],
          border: Border.all(width: 0.6),
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Bid",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text("SRIDEVI NIGHT"),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("7:05 PM | 8:05 PM"),
                  Text(" 8 - (Single Ank)")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text("Coins"),
                  SizedBox(
                    width: Dimensions.w5,
                  ),
                  Image.asset(
                    ConstantImage.ruppeeBlueIcon,
                    height: Dimensions.h25,
                    width: Dimensions.w25,
                  ),
                  SizedBox(
                    width: Dimensions.w5,
                  ),
                  const Text("10"),
                  const Expanded(child: SizedBox()),
                  const Text("Balance"),
                  SizedBox(
                    width: Dimensions.w5,
                  ),
                  Image.asset(
                    ConstantImage.ruppeeBlueIcon,
                    height: Dimensions.h25,
                    width: Dimensions.w25,
                  ),
                  SizedBox(
                    width: Dimensions.w5,
                  ),
                  const Text("50"),
                ],
              ),
            ),
            Container(
              height: Dimensions.h40,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.greywhite,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child:
                  const Center(child: Text("Time: 29 June,2023, 5:26:11 PM")),
            ),
          ],
        ),
      ),
    );
  }
}
