import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spllive/Custom%20Controllers/wallet_controller.dart';
import 'package:spllive/helper_files/app_colors.dart';
import 'package:spllive/helper_files/constant_image.dart';
import 'package:spllive/helper_files/custom_text_style.dart';
import 'package:spllive/helper_files/dimentions.dart';
import 'package:spllive/helper_files/ui_utils.dart';
import 'package:spllive/screens/gamemode_pages/controller/game_pages_controller.dart';
import '../../routes/app_routes_name.dart';

// ignore: must_be_immutable
class GameModePage extends StatelessWidget {
  GameModePage({super.key});
  var controller = Get.put(GameModePagesController());
  var walletController = Get.put(WalletController());
  @override
  Widget build(BuildContext context) {
    controller.checkBids();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppUtils().simpleAppbar(
        appBarTitle: "GAMEMODES_TEXT".tr,
        leading: IconButton(
          onPressed: () => controller.onBackButton(),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          InkWell(
            // onTap: () => Get.offAndToNamed(AppRoutName.transactionPage),
            child: Row(
              children: [
                SizedBox(
                  height: Dimensions.w20,
                  width: Dimensions.w20,
                  child: SvgPicture.asset(
                    ConstantImage.walletAppbar,
                    color: AppColors.white,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: Dimensions.r8,
                    bottom: Dimensions.r10,
                    left: Dimensions.r15,
                    right: Dimensions.r10,
                  ),
                  child: Obx(
                    () => Text(
                      walletController.walletBalance.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Obx(
        () {
          return SizedBox(
            //height: size.height,
            child: Column(
              children: [
                // controller.openBiddingOpen.value
                //     ? SizedBox(
                //         height: Dimensions.h10,
                //       )
                //     : Column(
                //         children: [
                //           Container(
                //             decoration:
                //                 BoxDecoration(color: AppColors.redColor),
                //             height: Dimensions.h40,
                //             width: double.infinity,
                //             child: Center(
                //               child: Text(
                //                 "BIDDINGFOROPENISCLOSED".tr,
                //                 style: CustomTextStyle.textPTsansMedium
                //                     .copyWith(
                //                         color: AppColors.white,
                //                         fontSize: Dimensions.h15),
                //               ),
                //             ),
                //           ),
                //           SizedBox(
                //             height: Dimensions.h5,
                //           ),
                //         ],
                //       ),
                // GameModeUtils().rowWidget(
                //   marketName: controller.marketValue.value.market.toString(),
                //   date: controller.removeTimeStampFromDateString(
                //     controller.marketValue.value.date.toString(),
                //   ),
                // ),
                // SizedBox(
                //   height: Dimensions.h5,
                // ),
                // GameModeUtils().rowWidget2(
                //   openBid: controller.marketValue.value.openTime.toString(),
                //   closeBid: controller.marketValue.value.closeTime.toString(),
                // ),
                // Row(
                //   children: [
                //     radioButtonWidget(
                //         onTapContainer: () {
                //           if (controller.openBiddingOpen.value &&
                //               controller.openCloseRadioValue.value != 0) {
                //             controller.openCloseRadioValue.value = 0;
                //             controller.callGetGameModes();
                //           }
                //         },
                //         onChanged: (val) {
                //           if (controller.openBiddingOpen.value) {
                //             controller.openCloseRadioValue.value = val!;
                //             controller.callGetGameModes();
                //           }
                //         },
                //         opasity: controller.openBiddingOpen.value ? 1 : 0.5,
                //         controller: controller,
                //         radioButtonValue: 0,
                //         buttonText: "OPENBID".tr),
                //     const SizedBox(
                //       width: 11,
                //     ),
                //     radioButtonWidget(
                //         onTapContainer: () {
                //           if (controller.openCloseRadioValue.value != 1) {
                //             controller.openCloseRadioValue.value = 1;
                //             controller.callGetGameModes();
                //           }
                //         },
                //         onChanged: (val) {
                //           controller.openCloseRadioValue.value = val!;
                //           controller.callGetGameModes();
                //         },
                //         opasity: 1,
                //         controller: controller,
                //         radioButtonValue: 1,
                //         buttonText: "CLOSEBID".tr)
                //   ],
                // ),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => Row(
                    children: [
                      openCloseMarket(
                        textColor:
                            controller.openCloseValue.value == "OPENBID".tr
                                ? AppColors.white
                                : AppColors.black,
                        "${"OPENBID".tr.toUpperCase()} : ${controller.marketValue.value.openTime.toString()}",
                        onTap: () {
                          if (controller.openBiddingOpen.value &&
                              controller.openCloseValue.value != "OPENBID".tr) {
                            controller.openCloseValue.value = "OPENBID".tr;
                            controller.callGetGameModes();
                          }
                          //                      controller.onTapOpenClose;
                        },
                        // if (controller.openBiddingOpen.value &&
                        //     controller.openCloseRadioValue.value !=
                        //         "OPENBID".tr) {
                        //   controller.openCloseRadioValue.value = "OPENBID".tr;
                        //   controller.callGetGameModes();
                        // }

                        containerColor:
                            controller.openCloseValue.value == "OPENBID".tr
                                ? AppColors.appbarColor
                                : AppColors.openclose,
                      ),
                      openCloseMarket(
                        "${"CLOSEBID".tr.toUpperCase()} : ${controller.marketValue.value.closeTime.toString()}",
                        onTap: () {
                          print("sfdasdsa");
                          if (controller.openCloseValue.value !=
                              "CLOSEBID".tr) {
                            controller.openCloseValue.value = "CLOSEBID".tr;
                            controller.callGetGameModes();
                          }
                          controller.onTapOpenClose;
                        },
                        containerColor:
                            controller.openCloseValue.value == "CLOSEBID".tr
                                ? AppColors.appbarColor
                                : AppColors.openclose,
                        textColor:
                            controller.openCloseValue.value == "CLOSEBID".tr
                                ? AppColors.white
                                : AppColors.black,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                cardWidget(controller, size),
                // controller.playmore == false
                //     ? Container()
                //     : Padding(
                //         padding: const EdgeInsets.all(15.0),
                //         child: RoundedCornerButton(
                //           text: "VIEWBIDS".tr,
                //           color: AppColors.greenShade,
                //           borderColor: AppColors.greenShade,
                //           fontSize: Dimensions.h14,
                //           fontWeight: FontWeight.w500,
                //           fontColor: AppColors.white,
                //           letterSpacing: 0,
                //           borderRadius: Dimensions.r5,
                //           borderWidth: 1,
                //           textStyle: CustomTextStyle.textPTsansBold,
                //           onTap: () {
                //             Get.offAndToNamed(AppRoutName.selectedBidsPage);
                //           },
                //           height: Dimensions.h30,
                //           width: Dimensions.w100,
                //         ),
                //       ),
              ],
            ),
          );
        },
      ),
    );
  }

  openCloseMarket(
    String text, {
    required Function() onTap,
    Color? containerColor,
    required Color textColor,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.zero,
            height: Dimensions.h35,
            decoration: BoxDecoration(
              color: containerColor,
              boxShadow: [
                BoxShadow(
                  spreadRadius: 0.2,
                  blurRadius: 0.8,
                  color: AppColors.grey.withOpacity(0.6),
                  offset: const Offset(0, 4),
                )
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            // decoration: BoxDecoration(
            //   color: containerColor,
            //   borderRadius: BorderRadius.circular(10),
            // ),
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    text,
                    style: CustomTextStyle.textRobotoSansMedium
                        .copyWith(color: textColor, fontSize: Dimensions.h10),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget cardWidget(GameModePagesController controller, Size size) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        // physics: const NeverScrollableScrollPhysics(),
        // shrinkWrap: true,
        itemCount: controller.gameModesList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: Dimensions.h160,
            crossAxisSpacing: 5,
            mainAxisSpacing: 2),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
            child: InkWell(
              onTap: () {
                controller.onTapOfGameModeTile(index);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 4,
                      color: AppColors.grey.withOpacity(0.5),
                      offset: const Offset(0, 0),
                    )
                  ],
                  borderRadius: BorderRadius.circular(Dimensions.r15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: Dimensions.w80,
                      width: Dimensions.w80,
                      decoration: BoxDecoration(
                        color: AppColors.wpColor1,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(17.0),
                        child: Image.network(
                          controller.gameModesList
                              .elementAt(index)
                              .image
                              .toString(),
                          height: Dimensions.h10,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error);
                          },
                        ),
                      ),
                    ),
                    // CircleAvatar(
                    //     backgroundColor: AppColors.wpColor1,
                    //     maxRadius: Dimensions.r35,
                    //     backgroundImage:),
                    SizedBox(
                      height: Dimensions.h17,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: SizedBox(
                        width: size.width,
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              controller.gameModesList.elementAt(index).name ??
                                  "",
                              style: CustomTextStyle.textRobotoSansBold
                                  .copyWith(fontSize: Dimensions.h14),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
  // return InkWell(
  //   onTap: () => controller.onTapOfGameModeTile(index),
  //   child: Card(
  //     elevation: 5,
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Container(
  //         color: AppColors.blueAccent.withOpacity(0.7),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             SizedBox(
  //               //color: Colors.amber,
  //               width: double.infinity,
  //               child: Stack(
  //                 children: [
  //                   Positioned(
  //                     left: 90,
  //                     child: Opacity(
  //                       opacity: 0.3,
  //                       // child: CachedNetworkImage(
  //                       //   imageUrl: controller.gameModesList
  //                       //       .elementAt(index)
  //                       //       .image
  //                       //       .toString(),
  //                       //   height: Dimensions.h45,
  //                       //   errorWidget: (context, url, error) =>
  //                       //       const Icon(Icons.error),
  //                       // ),
  //                       child: Image.network(
  //                         controller.gameModesList
  //                             .elementAt(index)
  //                             .image
  //                             .toString(),
  //                         height: Dimensions.h45,
  //                         errorBuilder: (context, error, stackTrace) {
  //                           return const Icon(Icons.error);
  //                         },
  //                       ),
  //                     ),
  //                   ),
  //                   Positioned(
  //                     left: 60,
  //                     child: Image.network(
  //                       controller.gameModesList
  //                           .elementAt(index)
  //                           .image
  //                           .toString(),
  //                       height: Dimensions.h45,
  //                       errorBuilder: (context, error, stackTrace) {
  //                         return const Icon(Icons.error);
  //                       },
  //                     ),
  //                   ),
  //                   Positioned(
  //                     left: 30,
  //                     child: Opacity(
  //                         opacity: 0.3,
  //                         child: Image.network(
  //                           controller.gameModesList
  //                               .elementAt(index)
  //                               .image
  //                               .toString(),
  //                           errorBuilder: (context, error, stackTrace) {
  //                             return const Icon(Icons.error);
  //                           },
  //                           height: Dimensions.h45,
  //                         )),
  //                   ), // Bottom image
  //                   Opacity(
  //                     opacity: 0.0,
  //                     child: Image.asset(
  //                       ConstantImage.diceImage,
  //                       height: 45,
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //             Text(
  //               controller.gameModesList.elementAt(index).name ?? "",
  //               style: CustomTextStyle.textPTsansBold.copyWith(
  //                 color: AppColors.black,
  //                 fontSize: Dimensions.h15,
  //                 height: 2,
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   ),
  // );
  //     },
  //   ),
  // );
}
// }

// Widget radioButtonWidget(
//     {required GameModePagesController controller,
//     required int radioButtonValue,
//     required String buttonText,
//     required double opasity,
//     required Function(int?) onChanged,
//     required Function() onTapContainer}) {
//   return Expanded(
//     child: Opacity(
//       opacity: opasity,
//       child: GestureDetector(
//         onTap: onTapContainer,
//         child: SizedBox(
//           // color: Colors.amber,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Radio(
//                 value: radioButtonValue,
//                 fillColor: MaterialStatePropertyAll(
//                   controller.openCloseRadioValue.value == radioButtonValue
//                       ? AppColors.buttonColorDarkGreen
//                       : AppColors.appbarColor,
//                 ),
//                 activeColor: AppColors.buttonColorDarkGreen,
//                 groupValue: controller.openCloseRadioValue.value,
//                 onChanged: onChanged,
//               ),
//               Text(
//                 buttonText,
//                 style: CustomTextStyle.textRobotoSansMedium.copyWith(
//                   color:
//                       controller.openCloseRadioValue.value == radioButtonValue
//                           ? AppColors.buttonColorDarkGreen
//                           : AppColors.appbarColor,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }
