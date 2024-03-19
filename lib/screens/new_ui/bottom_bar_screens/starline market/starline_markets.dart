import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spllive/Custom%20Controllers/wallet_controller.dart';
import 'package:spllive/components/common_appbar.dart';
import 'package:spllive/controller/starline_market_controller.dart';
import 'package:spllive/helper_files/app_colors.dart';
import 'package:spllive/helper_files/constant_image.dart';
import 'package:spllive/helper_files/custom_text_style.dart';
import 'package:spllive/helper_files/dimentions.dart';
import 'package:spllive/helper_files/ui_utils.dart';
import 'package:spllive/routes/app_routes_name.dart';
import 'package:spllive/screens/new_ui/bottom_bar_screens/starline%20market/starline_bid_history.dart';
import 'package:spllive/screens/new_ui/bottom_bar_screens/starline%20market/starline_chart.dart';
import 'package:spllive/screens/new_ui/bottom_bar_screens/starline%20market/starline_result_history.dart';

class StarlineDailyMarketData extends StatefulWidget {
  const StarlineDailyMarketData({super.key});

  @override
  State<StarlineDailyMarketData> createState() => _StarlineDailyMarketDataState();
}

class _StarlineDailyMarketDataState extends State<StarlineDailyMarketData> {
  final starlineCon = Get.put<StarlineMarketController>(StarlineMarketController());
  // final homeCon = Get.put<HomeController>(HomeController());
  final walletCon = Get.put<WalletController>(WalletController());

  @override
  void initState() {
    super.initState();
    starlineCon.getStarlineBanner();
    starlineCon.getUserData();
    starlineCon.getDailyStarLineMarkets();
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    return WillPopScope(
      onWillPop: () async {
        for (var e in starlineCon.starlineButtonList) {
          e.isSelected.value = false;
        }
        if (starlineCon.selectedIndex.value == null) {
          Get.offAllNamed(AppRoutName.dashBoardPage);
        }
        starlineCon.selectedIndex.value = null;
        return false;
      },
      child: RefreshIndicator(
        onRefresh: () async {
          starlineCon.getStarlineBanner();
          starlineCon.getDailyStarLineMarkets();
        },
        child: Scaffold(
          appBar: CommonAppBar(
            title: "SPL Starline",
            walletBalance: "${walletCon.walletBalance ?? " "}",
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.h7),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Obx(
                    () => starlineCon.selectedIndex.value != null
                        ? Container()
                        : starlineCon.bannerLoad.value
                            ? Center(
                                child: CircularProgressIndicator(color: AppColors.appbarColor),
                              )
                            : Image(
                                image: NetworkImage(starlineCon.bannerImage.value),
                                errorBuilder: (context, error, stackTrace) => const SizedBox(
                                  height: 100,
                                  child: Center(
                                    child: Icon(Icons.error_outline),
                                  ),
                                ),
                              ),
                    // : CarouselSlider(
                    //     items: homeCon.bannerData.map((element) {
                    //       return Builder(
                    //         builder: (context) {
                    //           return Container();
                    //           // return CachedNetworkImage(
                    //           //   imageUrl: element.banner ?? "",
                    //           //   placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    //           //   errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                    //           // );
                    //         },
                    //       );
                    //     }).toList(),
                    //     options: CarouselOptions(
                    //       height: Dimensions.h90,
                    //       enlargeCenterPage: true,
                    //       autoPlay: true,
                    //       aspectRatio: 15 / 4,
                    //       autoPlayCurve: Curves.fastOutSlowIn,
                    //       enableInfiniteScroll: true,
                    //       autoPlayAnimationDuration: const Duration(milliseconds: 600),
                    //       viewportFraction: 1,
                    //     ),
                    //   ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: starlineCon.starlineButtonList
                        .map(
                          (e) => Expanded(
                            child: GestureDetector(
                              onTap: () {
                                for (var e in starlineCon.starlineButtonList) {
                                  e.isSelected.value = false;
                                }
                                e.isSelected.value = true;
                                if (e.isSelected.value) {
                                  if (e.name?.toLowerCase() == "bid history") {
                                    starlineCon.selectedIndex.value = 0;
                                  }
                                  if (e.name?.toLowerCase() == "result history") {
                                    starlineCon.selectedIndex.value = 1;
                                  }
                                  if (e.name?.toLowerCase() == "chart") {
                                    starlineCon.selectedIndex.value = 2;
                                  }
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    // color: e.isSelected.value ? AppColors.grey : AppColors.appbarColor,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        spreadRadius: 0.8722222447395325,
                                        blurRadius: 6.97777795791626,
                                        offset: const Offset(0, 0),
                                        color: AppColors.black.withOpacity(0.25),
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Obx(
                                        () => SvgPicture.asset(
                                          e.image ?? "",
                                          height: Dimensions.h22,
                                          width: Dimensions.w22,
                                          color: e.isSelected.value ? AppColors.appbarColor : AppColors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Obx(
                                        () => Text(
                                          e.name ?? "",
                                          style: CustomTextStyle.textPTsansMedium.copyWith(
                                              color: e.isSelected.value ? AppColors.appbarColor : AppColors.black,
                                              letterSpacing: 1,
                                              fontWeight: FontWeight.w600,
                                              fontSize: e.name?.toLowerCase() == "result history"
                                                  ? MediaQuery.of(context).size.width > 360
                                                      ? Dimensions.h10
                                                      : 10.5
                                                  : Dimensions.h10),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 10),
                  Obx(
                    () => starlineCon.selectedIndex.value != null
                        ? currentWidget(starlineCon.selectedIndex.value)
                        : GridView.builder(
                            padding: EdgeInsets.all(Dimensions.h5),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: Get.width / 2,
                                mainAxisExtent: Get.width / 2.5,
                                crossAxisSpacing: 7,
                                mainAxisSpacing: Dimensions.h10),
                            itemCount: starlineCon.starLineMarketList.length ?? 0,
                            itemBuilder: (context, i) {
                              return InkWell(
                                onTap: () {
                                  if (starlineCon.starLineMarketList[i].isBidOpen ?? false) {
                                    if (starlineCon.starLineMarketList[i].isBidOpen ?? false) {
                                      Get.toNamed(AppRoutName.starLineGameModesPage,
                                          arguments: starlineCon.starLineMarketList[i]);
                                    } else {
                                      AppUtils.showErrorSnackBar(bodyText: "Bidding is Closed!!!!");
                                    }
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        spreadRadius: 0.2,
                                        color: AppColors.grey,
                                        blurRadius: 2.5,
                                        offset: const Offset(2, 3),
                                      )
                                    ],
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(Dimensions.h10),
                                    border: Border.all(color: Colors.red, width: 1),
                                  ),
                                  child: Column(
                                    //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(height: Dimensions.h5),
                                      SizedBox(height: Dimensions.h5),
                                      Text(
                                        starlineCon.starLineMarketList[i].time ?? "",
                                        style: CustomTextStyle.textRobotoSansMedium.copyWith(
                                          color: AppColors.black,
                                          fontSize: Dimensions.h15,
                                        ),
                                      ),
                                      SizedBox(height: Dimensions.h5),
                                      buildResult(
                                        isOpenResult: true,
                                        resultDeclared: starlineCon.starLineMarketList[i].isResultDeclared ?? false,
                                        result: starlineCon.starLineMarketList[i].result ?? 0,
                                      ),
                                      SizedBox(height: Dimensions.h5),
                                      Container(
                                        height: Dimensions.h25,
                                        width: Dimensions.w80,
                                        decoration: BoxDecoration(
                                            color: AppColors.blueButton, borderRadius: BorderRadius.circular(25)),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            FittedBox(
                                              child: Padding(
                                                padding: EdgeInsets.only(left: Dimensions.w15, bottom: 2),
                                                child: Text(
                                                  "PLAY2".tr,
                                                  style: TextStyle(
                                                    color: AppColors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            FittedBox(
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 3.0),
                                                child: Icon(
                                                  Icons.play_circle_fill,
                                                  color: AppColors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(child: SizedBox(height: Dimensions.h5)),
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
                                            starlineCon.starLineMarketList[i].isBidOpen ?? false
                                                ? "Bidding is Open"
                                                : "Bidding is Closed",
                                            style: starlineCon.starLineMarketList[i].isBidOpen ?? false
                                                ? CustomTextStyle.textPTsansMedium.copyWith(color: AppColors.greenShade)
                                                : CustomTextStyle.textPTsansMedium.copyWith(color: AppColors.redColor),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildResult({required bool isOpenResult, required bool resultDeclared, required int result}) {
    if (resultDeclared && result != 0 && result.toString().isNotEmpty) {
      int sum = 0;
      for (int i = result; i > 0; i = (i / 10).floor()) {
        sum += (i % 10);
      }
      return Text(
        isOpenResult ? "$result - ${sum % 10}" : "${sum % 10} - $result",
        style: CustomTextStyle.textRobotoSansMedium.copyWith(
          fontSize: Dimensions.h13,
          fontWeight: FontWeight.bold,
          color: AppColors.redColor,
          letterSpacing: 1,
        ),
      );
    } else if (result == 0 && result.toString().isNotEmpty && resultDeclared) {
      return Text(
        isOpenResult ? "000 - $result" : "$result - 000",
        style: CustomTextStyle.textRobotoSansMedium.copyWith(
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

  currentWidget(index) {
    switch (index) {
      case 0:
        return const StarlineBidHistory();
      case 1:
        return const StarlineResultHistory();
      case 2:
        return const StarlineChart();
    }
  }
}
