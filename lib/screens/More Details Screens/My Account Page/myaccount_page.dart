// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper_files/app_colors.dart';
import '../../../helper_files/custom_text_style.dart';
import '../../../helper_files/dimentions.dart';
import '../../../helper_files/ui_utils.dart';
import 'controller/myaccount_page_controller.dart';

class MyAccountPage extends StatelessWidget {
  MyAccountPage({super.key});
  var controller = Get.put(MyAccountPageController());

  @override
  Widget build(BuildContext context) {
    var verticalSpace = SizedBox(
      height: Dimensions.h10,
    );
    return Scaffold(
      appBar: AppUtils().simpleAppbar(
        appBarTitle: "MYACCOUNT".tr,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                AppUtils.showErrorSnackBar(bodyText: "SNACKMSG_TEXT".tr);
              },
              child: Icon(
                Icons.note_alt_rounded,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Obx(
          () => Column(
            children: [
              verticalSpace,
              listTileDetails(
                text: "BANK_TEXT".tr,
                value: controller.bankName.value,
              ),
              listTileDetails(
                text: "ACNAME_TEXT".tr,
                value: controller.accountName.value,
              ),
              listTileDetails(
                text: "ACNO_TEXT".tr,
                value: controller.accountNumber.value,
              ),
              listTileDetails(
                text: "IFSC_TEXT".tr,
                value: controller.ifcsCode.value,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding listTileDetails({required String text, required String value}) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.w8),
      child: Container(
        height: Dimensions.h60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.grey, width: 0.5),
          borderRadius: BorderRadius.circular(Dimensions.r5),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: Dimensions.w10),
          child: Row(
            children: [
              Expanded(
                child: Text(text,
                    style: CustomTextStyle.textPTsansBold.copyWith(
                      color: AppColors.black,
                      fontSize: Dimensions.h16,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Expanded(
                child: Text(
                  value,
                  style: CustomTextStyle.textPTsansMedium.copyWith(
                    fontSize: Dimensions.h14,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
