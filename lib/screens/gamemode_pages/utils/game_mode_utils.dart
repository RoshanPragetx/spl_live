import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:get/get.dart';
import '../../../components/list_container.dart';
import '../../../helper_files/app_colors.dart';
import '../../../helper_files/dimentions.dart';

class GameModeUtils {
  Widget rowWidget({required String marketName, required String date}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.h8),
      child: Row(
        children: [
          Expanded(
              child: ListContainer(
            color: AppColors.appbarColor,
            title: marketName,
            // title: "SRIDEVI NIGHTS",
          )),
          SizedBox(
            width: Dimensions.w11,
          ),
          Expanded(
            child: ListContainer(
              color: AppColors.appbarColor,
              iconData: Icons.calendar_month, title: date,
              // title: "03-07-2023",
            ),
          ),
        ],
      ),
    );
  }

  Widget rowWidget2({required String openBid, required String closeBid}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.h8),
      child: Row(
        children: [
          Expanded(
              child: ListContainer(
            color: AppColors.redColor,
            title: "Open Bid : $openBid",
          )),
          const SizedBox(
            width: 11,
          ),
          Expanded(
            child: ListContainer(
              color: AppColors.redColor,
              title: "Close Bid : $closeBid",
            ),
          ),
        ],
      ),
    );
  }
}
