// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:spllive/helper_files/app_colors.dart';
import 'package:spllive/helper_files/constant_image.dart';
import 'package:spllive/helper_files/dimentions.dart';
import 'package:spllive/helper_files/ui_utils.dart';

class MyNavigationBar extends StatelessWidget {
  int? currentIndex;
  Function() onTapHome;
  Function() onTapBidHistory;
  Function() onTapWallet;
  Function() onTapMore;

  MyNavigationBar(
      {super.key,
      this.currentIndex = 0,
      required this.onTapBidHistory,
      required this.onTapHome,
      required this.onTapMore,
      required this.onTapWallet});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: Dimensions.h5),
      height: Dimensions.h45,
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AppUtils().nameIcons(
            width: size.width * 0.2,
            onTap: onTapHome,
            icon: ConstantImage.homeIcon,
            iconText: "Home",
            textColor: currentIndex == 0 ? AppColors.appbarColor : Colors.black,
            color: currentIndex == 0 ? AppColors.appbarColor : Colors.grey,
          ),
          AppUtils().nameIcons(
            width: size.width * 0.2,
            onTap: onTapBidHistory,
            icon: ConstantImage.bidHistoryListIcon,
            iconText: "Bid History",
            textColor: currentIndex == 1 ? AppColors.appbarColor : Colors.black,
            color: currentIndex == 1 ? AppColors.appbarColor : Colors.grey,
          ),
          AppUtils().nameIcons(
            width: size.width * 0.2,
            onTap: onTapWallet,
            icon: ConstantImage.walletAppbar,
            iconText: "Wallet",
            textColor: currentIndex == 2 ? AppColors.appbarColor : Colors.black,
            color: currentIndex == 2 ? AppColors.appbarColor : Colors.grey,
          ),
          AppUtils().nameIcons(
            width: size.width * 0.2,
            onTap: onTapMore,
            icon: ConstantImage.moreIcon,
            iconText: "More",
            textColor: currentIndex == 3 ? AppColors.appbarColor : Colors.black,
            color: currentIndex == 3 ? AppColors.appbarColor : Colors.grey,
          ),
        ],
      ),
    );
  }
}
