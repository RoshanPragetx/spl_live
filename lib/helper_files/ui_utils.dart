// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/app_colors.dart';
import 'package:spllive/helper_files/constant_image.dart';
import 'package:spllive/helper_files/custom_text_style.dart';
import 'package:spllive/helper_files/dimentions.dart';

class AppUtils {
  static bool isProgressVisible = false;
  static SystemUiOverlayStyle toolBarStyleLight = SystemUiOverlayStyle(
    statusBarColor: AppColors.transparent,
    // <-- SEE HERE
    statusBarIconBrightness: Brightness.light,
    //<-- For Android SEE HERE (dark icons)
    statusBarBrightness: Brightness.light, //<-- For iOS SEE HERE (dark icons)
  );

  //common method for dark toolbar theme
  static SystemUiOverlayStyle toolBarStyleDark = SystemUiOverlayStyle(
    statusBarColor: AppColors.transparent,
    // <-- SEE HERE
    statusBarIconBrightness: Brightness.dark,
    //<-- For Android SEE HERE (dark icons)
    statusBarBrightness: Brightness.dark, //<-- For iOS SEE HERE (dark icons)
  );

  AppBar simpleAppbar(
      {required String appBarTitle,
      List<Widget>? actions,
      Widget? leading,
      double? leadingWidht}) {
    return AppBar(
      backgroundColor: AppColors.appbarColor,
      shadowColor: AppColors.white,
      elevation: 0,
      leading: leading,
      leadingWidth: leadingWidht,
      title: Text(
        appBarTitle,
        style: CustomTextStyle.textPTsansBold,
        // style: GoogleFonts.aclonica(
        //     color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
      ),
      actions: actions,
    );
  }

  Widget nameIcons(
      {required Function() onTap,
      required String icon,
      required String iconText,
      required double width,
      Color? textColor,
      Color? color}) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: Dimensions.w15,
              width: Dimensions.w15,
              child: SvgPicture.asset(
                icon,
                color: color ?? AppColors.grey,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                iconText,
                style: CustomTextStyle.textPTsansMedium.copyWith(
                    color: textColor ?? AppColors.black,
                    fontSize: Dimensions.h11),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar appbar(
    size, {
    required Function() onTapTranction,
    required Function() onTapNotifiaction,
    required Function() shareOntap,
    required Function() onTapTelegram,
    required String walletText,
  }) {
    var math;
    return AppBar(
      backgroundColor: AppColors.appbarColor,
      title: Center(
        child: Text(
          "SPL".tr,
          // style: GoogleFonts.aclonica(
          //     color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
        ),
      ),
      leading: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: Dimensions.w10,
            ),
            Expanded(
              child: InkWell(
                onTap: onTapTranction,
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
              walletText,
              style: CustomTextStyle.textPTsansBold
                  .copyWith(color: AppColors.white, fontSize: Dimensions.h18),
            ),
            const Expanded(child: SizedBox())
          ],
        ),
      ),
      leadingWidth: Dimensions.w100,
      // flexibleSpace: SafeArea(
      //   child: Padding(
      //     padding: EdgeInsets.only(left: size.width / 8, top: Dimensions.h13),
      //     child: Text(
      //       "50",
      //       style: CustomTextStyle.textPTsansBold
      //           .copyWith(color: AppColors.white, fontSize: Dimensions.h18),
      //     ),
      //   ),
      // ),
      // leading: InkWell(
      //     onTap: onTapTranction,
      //     child: const Icon(Icons.account_balance_wallet, color: Colors.white)),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: InkWell(
            onTap: onTapNotifiaction,
            child: Icon(
              Icons.notifications_active,
              color: AppColors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: InkWell(
            onTap: onTapTelegram,
            child: Container(
              width: Dimensions.w25,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(25)),
              child: Transform.rotate(
                angle: 180 * 3.14 / 48,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: Dimensions.h3,
                    left: Dimensions.h3,
                    top: Dimensions.h3,
                  ),
                  child: Icon(
                    Icons.send,
                    size: 15,
                    color: AppColors.appbarColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: InkWell(
            onTap: shareOntap,
            child: Container(
              width: Dimensions.w25,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(25)),
              child: Icon(
                Icons.share,
                size: 15,
                color: AppColors.appbarColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  flottingActionButton({required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: Dimensions.w50,
        width: Dimensions.w50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: AppColors.white.withOpacity(0.25),
            boxShadow: [
              BoxShadow(blurRadius: 10, spreadRadius: 2, color: AppColors.grey)
            ]),
        child: const Image(
          image: AssetImage(
            ConstantImage.whatsaapIcon,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

//common method for showing progress dialog
  static void showProgressDialog({isCancellable = false}) async {
    if (!isProgressVisible) {
      Get.dialog(
        Center(
          child: SizedBox(
            width: Dimensions.h80,
            height: Dimensions.h80,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: Dimensions.h40,
                  width: Dimensions.h40,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.green),
                    strokeWidth: 4,
                  ),
                ),
              ],
            ),
          ),
        ),
        barrierDismissible: isCancellable,
      );
      isProgressVisible = true;
    }
  }

  //common method for hiding progress dialog
  static void hideProgressDialog() {
    if (Get.isDialogOpen == true) {
      Get.closeAllSnackbars();
      Get.back();
    }
    isProgressVisible = false;
  }

  //common method for show error snack-bar
  static void showErrorSnackBar({required String bodyText}) {
    Get.closeCurrentSnackbar();
    Get.snackbar(
      "ERRORMESSAGE".tr,
      bodyText,
      snackPosition: SnackPosition.BOTTOM,
      isDismissible: true,
      backgroundColor: AppColors.redColor,
      onTap: null,
    );
  }

  //common method for show success snack-bar
  static void showSuccessSnackBar({headerText, bodyText}) {
    Get.closeCurrentSnackbar();
    Get.snackbar(
      headerText,
      bodyText,
      snackPosition: SnackPosition.BOTTOM,
      isDismissible: true,
      backgroundColor: AppColors.green,
      onTap: null,
    );
  }

  ///drawer
  Future<dynamic> showRateUsBoxDailog(
      callCreateRatingApi, double? givenRatings) async {
    double tempRatings = 0.00;
    IconData? selectedIcon;
    return Get.dialog(
      Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.w15, vertical: Dimensions.h220),
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.all(Radius.circular(Dimensions.r18))),
          child: Center(
            child: Material(
              color: AppColors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(Dimensions.r18),
              ),
              child: Padding(
                padding: EdgeInsets.all(Dimensions.h10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "RATESPLLIVEAPP".tr,
                      style: CustomTextStyle.textPTsansMedium.copyWith(
                          color: AppColors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: Dimensions.h20,
                          letterSpacing: 1.29),
                    ),
                    RatingBar.builder(
                      initialRating:
                          givenRatings != null && givenRatings != 0.00
                              ? givenRatings
                              : 0,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemSize: Dimensions.h37,
                      ignoreGestures: givenRatings != null &&
                              givenRatings.toDouble() != 0.00
                          ? true
                          : false,
                      glowColor: AppColors.appbarColor,
                      unratedColor: AppColors.grey,
                      itemPadding:
                          EdgeInsets.symmetric(horizontal: Dimensions.w4),
                      itemBuilder: (context, index) {
                        if (index >= tempRatings) {
                          // Unrated items
                          return Icon(
                            selectedIcon ?? Icons.star_border,
                            color: AppColors.grey,
                            size: 35,
                          );
                        } else {
                          // Rated items
                          return Icon(
                            selectedIcon ?? Icons.star,
                            color: AppColors.appbarColor,
                            size: 35,
                          );
                        }
                      },
                      onRatingUpdate: (rating) async {
                        tempRatings = rating;
                      },
                      //updateOnDrag: true,
                      tapOnlyMode: true,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () => Get.back(),
                          child: Container(
                            height: Dimensions.h50,
                            width: Dimensions.w130,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.h5),
                              border: Border.all(
                                color: AppColors.white,
                                width: 2.0,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "CANCEL_TEXT".tr,
                                style:
                                    CustomTextStyle.textPTsansMedium.copyWith(
                                  color: AppColors.redColor,
                                  fontSize: Dimensions.h18,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (givenRatings != null &&
                                givenRatings.toDouble() != 0.00) {
                              AppUtils.showErrorSnackBar(
                                  bodyText:
                                      "You can not add ratings multiple times!!!");
                            } else {
                              if (tempRatings < 1.00) {
                                AppUtils.showErrorSnackBar(
                                    bodyText: "Please Add Ratings");
                              } else {
                                callCreateRatingApi(tempRatings);
                              }
                            }
                          },
                          child: Container(
                            height: Dimensions.h50,
                            width: Dimensions.w130,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.h5),
                                color: AppColors.white),
                            child: Center(
                              child: Text("SUBMIT".tr,
                                  style:
                                      CustomTextStyle.textPTsansMedium.copyWith(
                                    color: AppColors.appbarColor,
                                    fontSize: Dimensions.h18,
                                  )),
                            ),
                          ),
                        ),
                        // TextButton(
                        //   onPressed: () {
                        //     if (givenRatings != null && givenRatings.toDouble() != 0.00) {
                        //       AppUtils.showErrorSnackBar(bodyText: "You can not add ratings multiple times!!!");
                        //     } else {
                        //       if (tempRatings < 1.00) {
                        //         AppUtils.showErrorSnackBar(bodyText: "Please Add Ratings");
                        //       } else {
                        //         callCreateRatingApi(tempRatings);
                        //       }
                        //     }
                        //   },
                        //   child: Text(
                        //     "Submit",
                        //     style: TextStyle(
                        //         color: givenRatings != null && givenRatings.toDouble() != 0.00 ? Colors.green[100] : Colors.green,
                        //         fontSize: Dimensions.sp18),
                        //   ),
                        // ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }
}
