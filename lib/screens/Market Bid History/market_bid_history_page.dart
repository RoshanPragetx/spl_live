import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/dimentions.dart';
import 'package:spllive/helper_files/ui_utils.dart';
import 'package:spllive/screens/Market%20Bid%20History/controller/marketbidhistory_controller.dart';

import '../../helper_files/app_colors.dart';
import '../../helper_files/constant_image.dart';
import '../../helper_files/custom_text_style.dart';

// ignore: must_be_immutable
class MarketBidHistory extends StatefulWidget {
  MarketBidHistory({super.key, this.marketId, this.marketname});
  String? marketId;
  String? marketname;

  @override
  State<MarketBidHistory> createState() => _MarketBidHistoryState();
}

class _MarketBidHistoryState extends State<MarketBidHistory> {
  final markethistory = Get.put(MarketBidHistoryController());

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // markethistory.markettime(marketId: widget.marketId ?? "");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppUtils().simpleAppbar(appBarTitle: "Bid For SUPREME DAY"),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(Dimensions.h8),
            child: Row(
              children: [
                radioButtonWidget(
                    onTapContainer: () {
                      if (markethistory.openCloseRadioValue.value != 0) {
                        markethistory.openCloseRadioValue();
                        markethistory.openBiddingOpen();
                        // markethistory.openCloseRadioValue.value = 0;
                      }
                    },
                    onChanged: (val) {
                      if (markethistory.openCloseRadioValue.value) {
                        // markethistory.openCloseRadioValue.value = val!;
                        markethistory.openCloseRadioValue();
                        markethistory.openCloseValue();
                      }
                    },
                    controller: markethistory,
                    opasity: 1,
                    radioButtonValue: 0,
                    buttonText: "OPEN"),
                SizedBox(
                  width: Dimensions.w10,
                ),
                radioButtonWidget(
                    controller: markethistory,
                    onTapContainer: () {
                      if (markethistory.openCloseRadioValue.value != 1) {
                        // markethistory.openCloseRadioValue.value = 1;
                        markethistory.openCloseRadioValue();
                        markethistory.openBiddingOpen();
                      }
                    },
                    onChanged: (val) {
                      // markethistory.openCloseRadioValue.value = val!;
                      markethistory.openCloseRadioValue();
                      markethistory.closeBiddingOpen();
                    },
                    opasity: 1,
                    radioButtonValue: 0,
                    buttonText: "Close"),
              ],
            ),
          ),
          SizedBox(
            height: Dimensions.h25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  ConstantImage.openStarsSvg,
                  width: Dimensions.w100,
                ),
              ),
              SvgPicture.asset(
                ConstantImage.closeStarsSvg,
                width: Dimensions.w100,
              ),
            ],
          ),
          SizedBox(
            height: Dimensions.h20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.h5, vertical: Dimensions.h10),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 1,
                    color: AppColors.grey,
                    blurRadius: 10,
                    offset: const Offset(7, 4),
                  ),
                ],
                border: Border.all(width: 0.4),
                color: AppColors.white,
                borderRadius: BorderRadius.circular(Dimensions.r8),
              ),
              child: Obx(() {
                if (markethistory.bidModel.isNull) {
                  return Center(
                    child: Text(
                      "NO Bid History Found",
                      style: CustomTextStyle.textPTsansMedium.copyWith(
                        fontSize: Dimensions.h17,
                        color: AppColors.appbarColor,
                      ),
                    ),
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.h10,
                            vertical: Dimensions.h5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${markethistory.bidModel.value.data?.rows?.first?.game?.name ?? ""}',
                              style: CustomTextStyle.textRobotoSansLight
                                  .copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'WON  ${markethistory.bidModel.value.data?.rows?.first?.winAmount.toString() ?? ""}',
                              style:
                                  CustomTextStyle.textRobotoSansLight.copyWith(
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Dimensions.h5),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimensions.h15,
                            horizontal: Dimensions.h15),
                        child: Row(
                          children: [
                            Text(
                              'BID  ${markethistory.bidModel.value.data?.rows?.first?.bidNo.toString() ?? ""}',
                              style: CustomTextStyle.textRobotoSansLight
                                  .copyWith(fontSize: 15),
                            ),

                            // Text(markethistory
                            //         .bidModel.value.data?.rows?.first?.bidNo
                            //         .toString() ??
                            //     ""),
                            SizedBox(
                              width: Dimensions.w5,
                            ),
                            // Text(markethistory.bidModel.value.data?.rows
                            //         ?.first?.balance
                            //         .toString() ??
                            //     ""),
                            const Expanded(child: SizedBox()),
                            Text(
                              'COINS  ${markethistory.bidModel.value.data?.rows?.first?.coins.toString() ?? ""}',
                              style: CustomTextStyle.textRobotoSansLight
                                  .copyWith(fontSize: 17),
                            ),
                            // Text(
                            //   markethistory
                            //           .bidModel.value.data?.rows?.first?.coins
                            //           .toString() ??
                            //       "",
                            //   style: CustomTextStyle.textRobotoSansLight
                            //       .copyWith(fontSize: 15),
                            // ),
                          ],
                        ),
                      ),
                      Container(
                        height: Dimensions.h35,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 188, 185, 185),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(6),
                              bottomRight: Radius.circular(6)),
                        ),
                        child: Center(
                          // child: Text(
                          //   CommonUtils().convertUtcToIst(markethistory
                          //           .bidModel.value.data?.rows
                          //           ?.elementAt(0)
                          //           ?.bidTime
                          //           .toString() ??
                          //       ""),
                          //   style: CustomTextStyle.textRobotoSansLight
                          //       .copyWith(fontSize: 15),
                          // ),
                          child: const Center(
                            child: Text("Play time : Aug 09, 2023, 04:27 PM"),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}

Widget radioButtonWidget(
    {required MarketBidHistoryController controller,
    required int radioButtonValue,
    required String buttonText,
    required double opasity,
    required Function(Object?) onChanged,
    required Function() onTapContainer}) {
  return Expanded(
    child: Opacity(
      opacity: opasity,
      child: GestureDetector(
        onTap: onTapContainer,
        child: SizedBox(
          // color: Colors.amber,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio(
                value: radioButtonValue,
                fillColor: MaterialStatePropertyAll(
                  controller.openCloseRadioValue.value == radioButtonValue
                      ? AppColors.buttonColorDarkGreen
                      : AppColors.appbarColor,
                ),
                activeColor: AppColors.buttonColorDarkGreen,
                groupValue: controller.openCloseRadioValue.value,
                onChanged: onChanged,
              ),
              Text(
                buttonText,
                style: CustomTextStyle.textRobotoSansMedium.copyWith(
                  color:
                      controller.openCloseRadioValue.value == radioButtonValue
                          ? AppColors.buttonColorDarkGreen
                          : AppColors.appbarColor,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:spllive/helper_files/ui_utils.dart';
// import 'package:spllive/screens/slash_screen/splash_screen.dart';

// import '../../helper_files/app_colors.dart';
// import '../../helper_files/custom_text_style.dart';
// import '../../helper_files/dimentions.dart';

// class MarketBidHistory extends StatelessWidget {
//   const MarketBidHistory({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppUtils().simpleAppbar(appBarTitle: "Bid For SUPREMEDAY"),
//         body: Padding(
//           padding: EdgeInsets.symmetric(vertical: Dimensions.h5),
//           child: InkWell(
//             onTap: () {
//               Get.to(SplashScreen());
//             },
//             child: Container(
//               height: 140,
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     spreadRadius: 1,
//                     color: AppColors.grey,
//                     blurRadius: 10,
//                     offset: const Offset(7, 4),
//                   ),
//                 ],
//                 border: Border.all(width: 0.6),
//                 color: AppColors.white,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 10, vertical: 5),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Single Ank -',
//                             style: CustomTextStyle.textRobotoSansBold
//                                 .copyWith(fontSize: Dimensions.h14),
//                           ),
//                           Text(
//                             // "446-47-359",
//                             'WON 0',
//                             style: CustomTextStyle.textRobotoSansBold,
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         children: [
//                           SizedBox(
//                             width: Dimensions.w5,
//                           ),

//                           SizedBox(
//                             width: Dimensions.w5,
//                           ),
//                           Text(
//                             'BID 0',
//                             style: CustomTextStyle.textRobotoSansLight.copyWith(
//                               fontSize: Dimensions.h14,
//                               color: AppColors.balanceCoinsColor,
//                             ),
//                           ),
//                           const Expanded(child: SizedBox()),

//                           SizedBox(
//                             width: Dimensions.w5,
//                           ),
//                           // Image.asset(
//                           //   ConstantImage.ruppeeBlueIcon,
//                           //   height: 25,
//                           //   width: 25,
//                           // ),
//                           SizedBox(
//                             width: Dimensions.w5,
//                           ),
//                           Text(
//                             'COINS 10 ',
//                             style: CustomTextStyle.textRobotoSansLight.copyWith(
//                               fontSize: Dimensions.h14,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       height: Dimensions.h30,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         color: AppColors.greywhite,
//                         borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(Dimensions.r8),
//                           bottomRight: Radius.circular(Dimensions.r8),
//                         ),
//                       ),
//                       child: Center(
//                         child: Text(
//                           "Play time : AUg, 10, 2023, 1: 04:09 PM",
//                           style: CustomTextStyle.textRobotoSansLight,
//                         ),
//                       ),
//                     ),
//                     // Container(
//                     //   height: 40,
//                     //   width: double.infinity,
//                     //   decoration: const BoxDecoration(
//                     //     color: Color.fromARGB(255, 188, 185, 185),
//                     //     borderRadius: BorderRadius.only(
//                     //       bottomLeft: Radius.circular(8),
//                     //       bottomRight: Radius.circular(8),
//                     //     ),
//                     //   ),
//                     //   child: Center(child: Text("Time: 29 June,2023, 5:26:11 PM")),
//                     // ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ));
//     // body: Padding(
//     //   padding: EdgeInsets.symmetric(vertical: Dimensions.h5),
//     //   child: Container(
//     //     decoration: BoxDecoration(
//     //       boxShadow: [
//     //         BoxShadow(
//     //           spreadRadius: 0.5,
//     //           color: AppColors.grey,
//     //           blurRadius: 5,
//     //           offset: const Offset(2, 4),
//     //         ),
//     //       ],
//     //       border: Border.all(width: 0.6),
//     //       color: AppColors.white,
//     //       borderRadius: BorderRadius.circular(8),
//     //     ),
//     //     child: Column(
//     //       mainAxisAlignment: MainAxisAlignment.start,
//     //       children: [
//     //         Padding(
//     //           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//     //           child: Row(
//     //             crossAxisAlignment: CrossAxisAlignment.start,
//     //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //             children: [
//     //               Text(
//     //                 'Single Ank -',
//     //                 style: CustomTextStyle.textRobotoSansBold
//     //                     .copyWith(fontSize: Dimensions.h15),
//     //               ),
//     //               Text(
//     //                 'WON  0',
//     //                 style: CustomTextStyle.textRobotoSansLight
//     //                     .copyWith(fontWeight: FontWeight.bold),
//     //               ),
//     //             ],
//     //           ),
//     //         ),
//     //         SizedBox(
//     //           height: Dimensions.h5,
//     //         ),
//     //         Row(
//     //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //           children: [
//     //             // Text(
//     //             //   "openTime | closeTime",
//     //             //   style: CustomTextStyle.textRobotoSansLight,
//     //             // ),
//     //             // Text(
//     //             //   " bidNo - (gameName)",
//     //             //   style: CustomTextStyle.textRobotoSansLight,
//     //             // )
//     //           ],
//     //         ),
//     //         Padding(
//     //           padding: const EdgeInsets.all(8.0),
//     //           child: Row(
//     //             children: [
//     //               Text(
//     //                 "BID",
//     //                 style: CustomTextStyle.textRobotoSansLight,
//     //               ),
//     //               SizedBox(
//     //                 width: Dimensions.w2,
//     //               ),
//     //               // Image.asset(
//     //               //   ConstantImage.ruppeeBlueIcon,
//     //               //   height: Dimensions.h25,
//     //               //   width: Dimensions.w25,
//     //               // ),
//     //               SizedBox(
//     //                 width: Dimensions.w5,
//     //               ),
//     //               Text("0"),
//     //               Expanded(child: SizedBox()),

//     //               SizedBox(
//     //                 width: Dimensions.w5,
//     //               ),
//     //               // Image.asset(
//     //               //   ConstantImage.ruppeeBlueIcon,
//     //               //   height: Dimensions.h25,
//     //               //   width: Dimensions.w25,
//     //               // ),
//     //               SizedBox(
//     //                 width: Dimensions.w5,
//     //               ),
//     //               Text('COINS 10',
//     //                   style: CustomTextStyle.textRobotoSansLight
//     //                       .copyWith(fontWeight: FontWeight.bold)),
//     //             ],
//     //           ),
//     //         ),
//     //         Container(
//     //           height: Dimensions.h30,
//     //           width: double.infinity,
//     //           decoration: BoxDecoration(
//     //             color: AppColors.greywhite,
//     //             borderRadius: BorderRadius.only(
//     //               bottomLeft: Radius.circular(Dimensions.r8),
//     //               bottomRight: Radius.circular(Dimensions.r8),
//     //             ),
//     //           ),
//     //           child: Center(
//     //             child: Text(
//     //               "Play time : AUg, 10, 2023, 1: 04:09 PM",
//     //               style: CustomTextStyle.textRobotoSansLight,
//     //             ),
//     //           ),
//     //         ),
//     //       ],
//     //     ),
//     //   ),
//     // ));
//   }
// }
