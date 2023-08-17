import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../helper_files/app_colors.dart';
import '../../../helper_files/constant_image.dart';
import '../../../helper_files/custom_text_style.dart';
import '../../../helper_files/dimentions.dart';
import '../../../helper_files/ui_utils.dart';
import '../../../routes/app_routes_name.dart';

class CheckWithdrawalPage extends StatelessWidget {
  const CheckWithdrawalPage({super.key});

  @override
  Widget build(BuildContext context) {
    var verticalSpace = SizedBox(
      height: Dimensions.h10,
    );
    return Scaffold(
      appBar: AppUtils().simpleAppbar(
        appBarTitle: "Withdrawal",
        leading: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: Dimensions.w10,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: SvgPicture.asset(
                      ConstantImage.walletAppbar,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: Dimensions.w10,
              ),
              Text(
                "30".tr,
                style: CustomTextStyle.textPTsansBold
                    .copyWith(color: AppColors.white, fontSize: Dimensions.h18),
              ),
              const Expanded(child: SizedBox())
            ],
          ),
        ),
        leadingWidht: Dimensions.w100,
        actions: [
          Padding(
            padding: EdgeInsets.only(left: Dimensions.h10),
            child: IconButton(
                onPressed: () {
                  Get.offAndToNamed(AppRoutName.withdrawalpage);
                },
                icon: const Icon(Icons.close)),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.h5),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                verticalSpace,
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
              offset: Offset(7, 4),
            ),
          ],
          border: Border.all(width: 0.1),
          color: AppColors.white,
          borderRadius: BorderRadius.circular(Dimensions.h5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Request Id -osg2D",
                    style: CustomTextStyle.textPTsansBold
                        .copyWith(fontSize: Dimensions.h14),
                  ),
                  Row(
                    children: [
                      Image.asset(
                        ConstantImage.ruppeeBlueIcon,
                        height: Dimensions.h20,
                        width: Dimensions.w20,
                      ),
                      SizedBox(
                        width: Dimensions.w5,
                      ),
                      Text(
                        "500",
                        style: CustomTextStyle.textPTsansBold
                            .copyWith(fontSize: Dimensions.h14),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: Dimensions.h5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Status",
                    style: CustomTextStyle.textPTsansBold
                        .copyWith(fontSize: Dimensions.h14),
                  ),
                  Text(
                    "Request On",
                    style: CustomTextStyle.textPTsansBold
                        .copyWith(fontSize: Dimensions.h14),
                  )
                ],
              ),
              SizedBox(
                height: Dimensions.h8,
              ),
              Row(
                children: [
                  Text(
                    "New request",
                    style: CustomTextStyle.textPTsansMedium,
                  ),
                  SizedBox(
                    width: Dimensions.w5,
                  ),

                  SizedBox(
                    width: Dimensions.w5,
                  ),
                  Text(
                    "10",
                    style: CustomTextStyle.textPTsansMedium,
                  ),
                  Expanded(child: SizedBox()),
                  Text(
                    "  12/23/22, 5.33 PM",
                    style: CustomTextStyle.textPTsansMedium,
                  ),

                  // Image.asset(
                  //   ConstantImage.ruppeeBlueIcon,
                  //   height: 25,
                  //   width: 25,
                  // ),
                  SizedBox(
                    width: Dimensions.w5,
                  ),
                  // Text("50"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
