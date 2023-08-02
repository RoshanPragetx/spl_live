// ignore_for_file: unused_import

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:spllive/helper_files/common_utils.dart';
import 'package:spllive/helper_files/custom_text_style.dart';
import 'package:spllive/models/daily_market_api_response_model.dart';
import 'package:spllive/screens/home_screen/controller/homepage_controller.dart';
import '../../../helper_files/app_colors.dart';
import '../../../helper_files/constant_image.dart';
import '../../../helper_files/dimentions.dart';

class HomeScreenUtils {
  var controller = Get.put(HomePageController());
  Widget buildResult(
      {required bool isOpenResult,
      required bool resultDeclared,
      required int result}) {
    if (resultDeclared && result != 0 && result.toString().isNotEmpty) {
      int sum = 0;
      for (int i = result; i > 0; i = (i / 10).floor()) {
        sum += (i % 10);
      }
      return Text(
        isOpenResult ? "$result - ${sum % 10}" : "${sum % 10} - $result",
        style: CustomTextStyle.textPTsansBold.copyWith(
          fontSize: Dimensions.h13,
          fontWeight: FontWeight.bold,
          color: AppColors.redColor,
          letterSpacing: 1,
        ),
      );
    } else {
      return SvgPicture.asset(
        isOpenResult ? ConstantImage.openStarsSvg : ConstantImage.closeStarsSvg,
        width: Dimensions.w60,
      );
    }
  }

  marketIcon(
      {required Function() onTap,
      required String text,
      required String iconData,
      required Color iconColor}) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: Dimensions.h22,
              width: Dimensions.w22,
              child: SvgPicture.asset(
                iconData,
                color: iconColor ?? AppColors.black,
              ),
            ),
            // Icon(iconData),
            Text(
              text,
              style: CustomTextStyle.textPTsansMedium.copyWith(
                  color: iconColor ?? AppColors.black,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1),
            )
          ],
        ),
      ),
    );
  }

  iconsContainer({
    required Function() onTap1,
    required Function() onTap2,
    required Function() onTap3,
    required Color iconColor1,
    required Color iconColor2,
    required Color iconColor3,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SizedBox(
            // color: Colors.amber,
            width: Dimensions.w100,
            child: marketIcon(
              iconColor: iconColor1,
              onTap: onTap1,
              text: "MARKET".tr,
              iconData: ConstantImage.marketIcon,
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            // color: Colors.amber,
            width: Dimensions.w100,
            child: marketIcon(
                iconColor: iconColor2,
                onTap: onTap2,
                text: "STARLINE".tr,
                iconData: ConstantImage.starLineIcon),
          ),
        ),
        Expanded(
          child: SizedBox(
            // color: Colors.amber,
            width: Dimensions.w100,
            child: marketIcon(
              onTap: onTap3,
              iconColor: iconColor3,
              text: "ADD FUND".tr,
              iconData: ConstantImage.addFundIcon,
            ),
          ),
        ),
      ],
    );
  }

  iconsContainer2({
    required Function() onTap1,
    required Function() onTap2,
    required Function() onTap3,
    required Color iconColor1,
    required Color iconColor2,
    required Color iconColor3,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.h5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              // color: Colors.amber,
              width: Dimensions.w100,
              child: marketIcon(
                  iconColor: iconColor1,
                  onTap: onTap1,
                  text: "BIDHISTORY".tr,
                  iconData: ConstantImage.bidHistoryIcon),
            ),
          ),
          Expanded(
            child: SizedBox(
              // color: Colors.amber,
              width: Dimensions.w100,
              child: marketIcon(
                  onTap: onTap2,
                  iconColor: iconColor2,
                  text: "RESULTHISTORY".tr,
                  iconData: ConstantImage.resultHistoryIcons),
            ),
          ),
          Expanded(
            child: SizedBox(
              // color: Colors.amber,
              width: Dimensions.w100,
              child: marketIcon(
                  onTap: onTap3,
                  iconColor: iconColor3,
                  text: "CHART".tr,
                  iconData: ConstantImage.chartIcon),
            ),
          ),
          // Expanded(
          //     child: InkWell(
          //         onTap: onTap2,
          //         child: Container(
          //           // color: Colors.amber,
          //           width: Dimensions.w100,
          //           child: marketIcon(
          //               onTap: () {},
          //               text: "RESULT HISTORY",
          //               iconData: Icons.network_wifi),
          //         ))),
          // Expanded(
          //   child: InkWell(
          //     onTap: onTap3,
          //     child: Container(
          //       // color: Colors.amber,
          //       width: Dimensions.w100,
          //       child: marketIcon(
          //           onTap: () {}, text: "CHART", iconData: Icons.currency_rupee),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  gridColumn(
    size,
  ) {
    return Obx(() {
      return controller.normalMarketList.isNotEmpty
          ? GridView.builder(
              padding: EdgeInsets.all(Dimensions.h5),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: size.width / 2,
                mainAxisExtent: size.width / 2.4,
                crossAxisSpacing: 0,
                mainAxisSpacing: 10,
              ),
              itemCount: controller.normalMarketList.length,
              itemBuilder: (context, index) {
                MarketData marketData;
                marketData = controller.normalMarketList[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.h5),
                  child: GestureDetector(
                    onTap: marketData.isBidOpenForClose ?? false
                        ? () => controller.onTapOfNormalMarket(
                              controller.normalMarketList[index],
                            )
                        : null,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 0.2,
                            color: AppColors.grey,
                            blurRadius: 3.5,
                            offset: const Offset(2, 4),
                          )
                        ],
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(Dimensions.h10),
                        border: Border.all(color: AppColors.redColor, width: 1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: Dimensions.h10,
                          ),
                          Text(
                            "${marketData.openTime ?? " "} | ${marketData.closeTime ?? ""}",
                            style: CustomTextStyle.textPTsansMedium
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            controller.normalMarketList[index].market ?? "",
                            // "MADHUR DAY",
                            style: CustomTextStyle.textPTsansBold.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: Dimensions.h14,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              buildResult(
                                  isOpenResult: true,
                                  resultDeclared:
                                      marketData.isOpenResultDeclared ?? false,
                                  result: marketData.openResult ?? 0),
                              buildResult(
                                isOpenResult: false,
                                resultDeclared:
                                    marketData.isCloseResultDeclared ?? false,
                                result: marketData.closeResult ?? 0,
                              )
                            ],
                          ),
                          playButton(),
                          SizedBox(
                            height: Dimensions.h5,
                          ),
                          Container(
                            height: Dimensions.h30,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400.withOpacity(0.8),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                marketData.isBidOpenForClose ?? false
                                    ? "Bidding is Open"
                                    : "Bidding is Closed",
                                style: marketData.isBidOpenForClose ?? false
                                    ? CustomTextStyle.textPTsansMedium.copyWith(
                                        color: AppColors.greenShade,
                                        fontWeight: FontWeight.w500,
                                      )
                                    : CustomTextStyle.textPTsansMedium.copyWith(
                                        color: AppColors.redColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Container(child: Text("No Data Found")),
            );
    });
  }

  Container playButton() {
    return Container(
      height: Dimensions.h25,
      width: Dimensions.w80,
      decoration: BoxDecoration(
          color: AppColors.blueButton, borderRadius: BorderRadius.circular(25)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: Dimensions.w15, bottom: 2),
            child: Text(
              "PLAY2".tr,
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 3.0),
            child: Icon(
              Icons.play_circle_fill,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }

  banner() {
    return CarouselSlider(
      items: [
        imagewidget(
            "https://pbs.twimg.com/media/FKNlhKZUcAEd7FY?format=jpg&name=4096x4096"),
        imagewidget(
            "https://pbs.twimg.com/media/FKNlhKZUcAEd7FY?format=jpg&name=4096x4096"),
        imagewidget(
            "https://pbs.twimg.com/media/FKNqdqwXIAI3gHw?format=jpg&name=large"),
      ],
      options: CarouselOptions(
        height: Dimensions.h90,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 15 / 4,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 600),
        viewportFraction: 1,
      ),
    );
  }

  imagewidget(String imageText) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.h7),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageText),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  gridColumnForStarLine(size) {
    return Obx(() {
      return GridView.builder(
        padding: EdgeInsets.all(Dimensions.h5),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: size.width / 2,
            mainAxisExtent: size.width / 2.5,
            crossAxisSpacing: 7,
            mainAxisSpacing: Dimensions.h10),
        // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //   crossAxisCount: 2,
        //   crossAxisSpacing: 10,
        //   mainAxisSpacing: 10,
        // ),
        itemCount: controller.starLineMarketList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              controller
                  .onTapOfStarlineMarket(controller.starLineMarketList[index]);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.h10),
                border: Border.all(color: AppColors.redColor, width: 1),
              ),
              child: Column(
                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: Dimensions.h5,
                  ),
                  SizedBox(
                    height: Dimensions.h5,
                  ),
                  Text(
                      controller.starLineMarketList.elementAt(index).time ?? "",
                      style: CustomTextStyle.textPTsansBold.copyWith(
                          color: AppColors.black, fontSize: Dimensions.h15)),
                  SizedBox(
                    height: Dimensions.h5,
                  ),
                  buildResult(
                      isOpenResult: true,
                      resultDeclared: controller
                              .starLineMarketList[index].isResultDeclared ??
                          false,
                      result: controller.starLineMarketList[index].result ?? 0),
                  SizedBox(
                    height: Dimensions.h5,
                  ),
                  playButton(),
                  Expanded(
                    child: SizedBox(
                      height: Dimensions.h5,
                    ),
                  ),
                  Container(
                    height: Dimensions.h30,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400.withOpacity(0.8),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        controller.starLineMarketList[index].isBidOpen ?? false
                            ? "Bidding is Open"
                            : "Bidding is Closed",
                        style: controller.starLineMarketList[index].isBidOpen ??
                                false
                            ? CustomTextStyle.textPTsansMedium
                                .copyWith(color: AppColors.greenShade)
                            : CustomTextStyle.textPTsansMedium
                                .copyWith(color: AppColors.redColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  bidHistory() {
    return Column(
      children: [
        SizedBox(
          height: Dimensions.h10,
        ),
        Container(
          height: Dimensions.h35,
          color: Colors.grey.withOpacity(0.1),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Icon(
                Icons.calendar_month,
                color: AppColors.appbarColor,
              ),
              SizedBox(
                width: Dimensions.w10,
              ),
              Text(
                "03-07-2023",
                style: TextStyle(
                  color: AppColors.appbarColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: Dimensions.h11,
        ),
        Container(
          height: Dimensions.h35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey.shade300,
            boxShadow: [
              BoxShadow(
                spreadRadius: 0.2,
                color: AppColors.grey,
                blurRadius: 1,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: Center(
            child: Text(
              "NOBIDHISTORY".tr,
              style: TextStyle(
                fontSize: Dimensions.h16,
                fontWeight: FontWeight.normal,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  resultHistory(context) {
    return RefreshIndicator(
      onRefresh: controller.onSwipeRefresh,
      child: Obx(
        () => Column(
          children: [
            SizedBox(
              height: Dimensions.h11,
            ),
            TextField(
              controller: controller.dateinput,
              decoration: InputDecoration(
                hintText: "18-07-2023",
                hintStyle: TextStyle(color: AppColors.appbarColor),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                prefixIcon: Icon(Icons.calendar_month_sharp,
                    color: AppColors.appbarColor),
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101));

                if (pickedDate != null) {
                  String formattedDate =
                      // .formatDateStringToDDMMMMMYYYY(pickedDate.toString());
                      DateFormat('dd-MM-yyyy').format(pickedDate);
                  controller.dateinput.text = formattedDate;
                } else {}
              },
            ),
            // Container(
            //   height: Dimensions.h35,
            //   color: Colors.grey.withOpacity(0.1),
            //   child: Row(
            //     children: [
            //       const SizedBox(
            //         width: 10,
            //       ),
            //       Icon(
            //         Icons.calendar_month,
            //         color: AppColors.appbarColor,
            //       ),
            //       const SizedBox(
            //         width: 10,
            //       ),
            //       Text(
            //         "03-07-2023",
            //         style: TextStyle(
            //           color: AppColors.appbarColor,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: Dimensions.h11,
            ),
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.marketListForResult.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    height: Dimensions.h40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 0.2,
                          color: AppColors.grey,
                          blurRadius: 1,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: Dimensions.w10,
                        ),
                        Icon(Icons.watch, color: AppColors.black),
                        SizedBox(
                          width: Dimensions.w10,
                        ),
                        Text(controller.marketListForResult.value[index].time ??
                            "00:00 AM"),
                        Expanded(
                          child: SizedBox(
                            width: Dimensions.w10,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: Dimensions.h50),
                          child: Text(
                            controller.getResult(
                                controller.marketListForResult.value[index]
                                        .isResultDeclared ??
                                    false,
                                controller.marketListForResult[index].result ??
                                    0),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyTable1 extends StatelessWidget {
  final int numberOfRows;

  const MyTable1({super.key, required this.numberOfRows});

  @override
  Widget build(BuildContext context) {
    List<DataRow> rows = List<DataRow>.generate(numberOfRows, (index) {
      return const DataRow(
        cells: [
          DataCell(
            Center(
              child: Text(
                '03/07/2023',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      );
    });

    return DataTable(
      horizontalMargin: 0,
      columnSpacing: 0,
      showBottomBorder: false,
      headingRowHeight: Dimensions.h30,
      dataRowHeight: Dimensions.h30,
      columns: [
        DataColumn(
          label: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Container(
              height: Dimensions.h30,
              width: Dimensions.w100,
              decoration: BoxDecoration(
                  color: AppColors.appbarColor,
                  border: Border.all(color: AppColors.white)),
              child: Center(
                child: Text(
                  'Date',
                  style: TextStyle(color: AppColors.white),
                ),
              ),
            ),
          ),
        ),
      ],
      rows: rows,
    );
  }
}

class MyTable2 extends StatelessWidget {
  final int numberOfHours;
  final int numberOfRows;

  const MyTable2(
      {super.key, required this.numberOfHours, required this.numberOfRows});

  @override
  Widget build(BuildContext context) {
    List<DataColumn> columns = [];

    for (int i = 0; i <= numberOfHours; i++) {
      columns.add(
        DataColumn(
          label: Container(
            height: Dimensions.h30,
            width: Dimensions.w100,
            decoration: BoxDecoration(
                color: AppColors.appbarColor,
                border: Border.all(color: AppColors.white)),
            child: Center(
              child: Text(
                '10:00 AM',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.white),
                // style: CustomTextStyle.textGothamMedium.copyWith(
                //   color: ColorConstant.white,
                //   fontWeight: FontWeight.normal,
                //   fontSize: Dimensions.sp14,
                // ),
              ),
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowHeight: Dimensions.h30,
        dataRowHeight: Dimensions.h30,
        horizontalMargin: 0,
        headingRowColor: MaterialStateColor.resolveWith(
          (states) => AppColors.white,
        ),
        columnSpacing: 0,
        columns: columns,
        rows: List<DataRow>.generate(
          numberOfRows,
          (index) {
            return DataRow(
              color: MaterialStateColor.resolveWith(
                (states) => AppColors.white,
              ),
              cells: [
                for (int i = 0; i <= numberOfHours; i++)
                  DataCell(
                    Container(
                      height: Dimensions.h30,
                      width: Dimensions.w100,
                      decoration: BoxDecoration(
                        // borderRadius: i == 1
                        //     ? BorderRadius.only(
                        //         topRight: Radius.circular(4),
                        //         bottomRight: Radius.circular(4),
                        //       )
                        //     : null,
                        border:
                            Border.all(color: AppColors.grey.withOpacity(0.2)),
                      ),
                      child: Center(
                        child: Text(
                          '288 -8',
                          textAlign: TextAlign.center,
                          // style: CustomTextStyle.textGothamLight.copyWith(
                          //   color: ColorConstant.textColorMain,
                          //   fontWeight: FontWeight.normal,
                          //   fontSize: Dimensions.sp16,
                          // ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
