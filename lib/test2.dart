import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/ui_utils.dart';

import 'helper_files/app_colors.dart';
import 'helper_files/custom_text_style.dart';
import 'helper_files/dimentions.dart';

void main() {
  runApp(GetMaterialApp(
    home: Bid(),
  ));
}

class Bid extends StatelessWidget {
  const Bid({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppUtils().simpleAppbar(appBarTitle: "Your Market"),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  spreadRadius: 0.5,
                  color: AppColors.grey,
                  blurRadius: 5,
                  offset: const Offset(2, 4),
                ),
              ],
              border: Border.all(width: 0.3),
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "SUPREME DAY",
                        style: CustomTextStyle.textRobotoSansBold
                            .copyWith(fontSize: 15),
                      ),
                      Text(
                        "200 - 22 - 679",
                        style: CustomTextStyle.textRobotoSansLight
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "3:30 PM - 5:30 PM",
                        style: CustomTextStyle.textRobotoSansLight,
                      ),
                      // Text(
                      //   " bidNo - (gameName)",
                      //   style: CustomTextStyle.textRobotoSansLight,
                      // )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "COINS",
                        style: CustomTextStyle.textRobotoSansLight,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      // Image.asset(
                      //   ConstantImage.ruppeeBlueIcon,
                      //   height: Dimensions.h25,
                      //   width: Dimensions.w25,
                      // ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("100"),
                      Expanded(child: SizedBox()),
                      // Text("Balance"),
                      SizedBox(
                        width: 5,
                      ),
                      // Image.asset(
                      //   ConstantImage.ruppeeBlueIcon,
                      //   height: Dimensions.h25,
                      //   width: Dimensions.w25,
                      // ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '0',
                        style: CustomTextStyle.textRobotoSansLight,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                      )
                    ],
                    color: AppColors.greywhite,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  // child: Center(
                  //   child: Text(
                  //     // "Time : timeDate",
                  //     // style: CustomTextStyle.textRobotoSansLight,
                  //   ),
                  // ),
                ),
              ],
            ),
          ),
        ));
  }
}
