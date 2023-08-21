// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/ui_utils.dart';
import 'package:spllive/routes/app_routes_name.dart';

import '../../components/simple_button_with_corner.dart';
import '../../helper_files/app_colors.dart';
import '../../helper_files/constant_image.dart';
import '../../helper_files/custom_text_style.dart';
import '../../helper_files/dimentions.dart';
import 'controller/selectbid_page_controller.dart';

class SelectedBidsPage extends StatelessWidget {
  SelectedBidsPage({super.key});
  var controller = Get.put(SelectBidPageController());
  // var controller = Get.put(SelectBidPageController());
  @override
  Widget build(BuildContext context) {
    // controller.newBidListreaddata();
    return Obx(
      () => Scaffold(
        appBar: AppUtils().simpleAppbar(
          appBarTitle: controller.marketName.value,
          actions: [
            Row(
              children: [
                SvgPicture.asset(
                  ConstantImage.walletAppbar,
                  height: Dimensions.h25,
                  color: AppColors.white,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w11),
                  child: Text(
                    controller.walletController.walletBalance.toString(),
                    style: CustomTextStyle.textPTsansMedium.copyWith(
                      color: AppColors.white,
                      fontSize: Dimensions.h18,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(Dimensions.h10),
            child: Column(
              children: [
                SizedBox(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.requestModel.value.bids!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius:
                                  BorderRadius.circular(Dimensions.h5)),
                          child: ListTile(
                            dense: true,
                            visualDensity: const VisualDensity(vertical: -2),
                            title: Text(
                              "${controller.requestModel.value.bids![index].gameModeName} - ",
                              style: CustomTextStyle.textRobotoSansLight
                                  .copyWith(fontSize: Dimensions.h12),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Text(
                                "Bid no. : ${controller.requestModel.value.bids![index].bidNo} , Coins : ${controller.requestModel.value.bids![index].coins}",
                                style: CustomTextStyle.textRobotoSansLight
                                    .copyWith(fontSize: Dimensions.h12),
                              ),
                            ),
                            trailing: InkWell(
                              onTap: () {
                                controller.onDeleteBids(index);
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
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(Dimensions.w5),
                        child: RoundedCornerButton(
                          text: "PLAYMORE".tr,
                          color: AppColors.white,
                          borderColor: AppColors.redColor,
                          fontSize: Dimensions.h14,
                          fontWeight: FontWeight.w500,
                          fontColor: AppColors.redColor,
                          letterSpacing: 0,
                          borderRadius: Dimensions.r5,
                          borderWidth: 2,
                          textStyle: CustomTextStyle.textRobotoSansMedium,
                          onTap: () => controller.playMore(),
                          height: Dimensions.h30,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(Dimensions.w5),
                        child: RoundedCornerButton(
                          text: "SUBMIT".tr,
                          color: AppColors.appbarColor,
                          borderColor: AppColors.appbarColor,
                          fontSize: Dimensions.h14,
                          fontWeight: FontWeight.w500,
                          fontColor: AppColors.white,
                          letterSpacing: 0,
                          borderRadius: Dimensions.r5,
                          borderWidth: 1,
                          textStyle: CustomTextStyle.textRobotoSansMedium,
                          onTap: () {
                            controller.showConfirmationDialog(context);
                          },
                          //onTap: () {},
                          height: Dimensions.h30,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: bottomNavigationBar(controller.totalAmount.value),
      ),
    );
  }

  bottomNavigationBar(String totalAmount) {
    return SafeArea(
      child: Container(
        height: Dimensions.h50,
        color: AppColors.appbarColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.commonPaddingForScreen,
              ),
              child: Text(
                "TOTALCOIN".tr,
                style: CustomTextStyle.textRobotoSansMedium
                    .copyWith(color: AppColors.white, fontSize: Dimensions.h18),
                // style: TextStyle(
                // color: AppColors.white,
                // fontSize: Dimensions.h18,
                // // ),
              ),
            ),
            Row(
              children: [
                Container(
                  height: Dimensions.h30,
                  width: Dimensions.w30,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      ConstantImage.rupeeImage,
                      fit: BoxFit.contain,
                      color: AppColors.appbarColor,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.commonPaddingForScreen,
                  ),
                  child: Text(
                    totalAmount,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: Dimensions.h18,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
