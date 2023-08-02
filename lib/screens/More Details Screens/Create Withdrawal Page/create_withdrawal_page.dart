// ignore_for_file: unused_import, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:spllive/routes/app_routes_name.dart';
import 'package:spllive/screens/More%20Details%20Screens/Create%20Withdrawal%20Page/controller/create_withdrawal_page_controller.dart';

import '../../../components/edit_text_field_with_icon.dart';
import '../../../components/simple_button_with_corner.dart';
import '../../../helper_files/app_colors.dart';
import '../../../helper_files/constant_image.dart';
import '../../../helper_files/custom_text_style.dart';
import '../../../helper_files/dimentions.dart';
import '../../../helper_files/ui_utils.dart';

class CreatewithDrawalPage extends StatelessWidget {
  CreatewithDrawalPage({super.key});
  var controller = Get.put(CreateWithDrawalPageController());

  @override
  Widget build(BuildContext context) {
    var verticalSpace = SizedBox(
      height: Dimensions.h10,
    );
    return Scaffold(
      appBar: AppUtils().simpleAppbar(
        appBarTitle: "Request Admin",
        leading: Container(),
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
                Row(
                  children: [
                    Expanded(
                      child: RoundedCornerEditTextWithIcon(
                        height: Dimensions.h40,
                        controller: controller.amountText,
                        keyboardType: TextInputType.phone,
                        hintText: "Enter Amount",
                        imagePath: "",
                        maxLines: 1,
                        minLines: 1,
                        isEnabled: true,
                        maxLength: 10,
                        formatter: [FilteringTextInputFormatter.digitsOnly],
                      ),
                    ),
                  ],
                ),
                verticalSpace,
                listTileDetails(
                  text: "Bank:",
                  value: "",
                ),
                listTileDetails(
                  text: "Acc Name:",
                  value: "",
                ),
                listTileDetails(
                  text: "Acc No.:",
                  value: "",
                ),
                listTileDetails(
                  text: "IFSC Code:",
                  value: "",
                ),
                verticalSpace,
                verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: RoundedCornerButton(
                    text: "CONTINUE".tr,
                    color: AppColors.appbarColor,
                    borderColor: AppColors.appbarColor,
                    fontSize: Dimensions.h15,
                    fontWeight: FontWeight.w500,
                    fontColor: AppColors.white,
                    letterSpacing: 0,
                    borderRadius: Dimensions.r25,
                    borderWidth: 1,
                    textStyle: CustomTextStyle.textRobotoSlabBold,
                    onTap: () {},
                    height: Dimensions.h35,
                    width: double.infinity,
                  ),
                ),
              ],
            ),
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
