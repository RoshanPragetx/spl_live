import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/ui_utils.dart';

import '../../helper_files/app_colors.dart';

import '../../helper_files/common_utils.dart';
import '../../helper_files/custom_text_style.dart';
import '../../helper_files/dimentions.dart';
import '../home_screen/controller/homepage_controller.dart';
import 'controller/bottum_navigation_controller.dart';
import 'package:spllive/models/passbook_page_model.dart';

class PassBook extends StatelessWidget {
  PassBook({super.key});
  var verticalSpace = SizedBox(
    width: Dimensions.w3,
  );
  var homeController = Get.put(HomePageController());
  var controller = Get.put(MoreListController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      //width: double.infinity,
      child: Column(
        children: [
          AppUtils().simpleAppbar(
            appBarTitle: "",
            leadingWidht: 900,
            leading: SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: Dimensions.w15),
                  Text(
                    "Passbook",
                    style: CustomTextStyle.textRobotoSansMedium
                        .copyWith(fontSize: Dimensions.h20),
                  ),
                  const Expanded(child: SizedBox()),
                  GestureDetector(
                    onTap: () {
                      if (homeController.pageWidget.value == 3 &&
                          homeController.currentIndex.value == 3) {
                        if (MediaQuery.of(context).orientation ==
                            Orientation.portrait) {
                          SystemChrome.setPreferredOrientations(
                              [DeviceOrientation.landscapeLeft]);
                        } else {
                          SystemChrome.setPreferredOrientations(
                              [DeviceOrientation.portraitUp]);
                        }
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.all(Dimensions.h8),
                      child: Icon(
                        Icons.flip,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: table(),
              ),
            ),
          ),
          Obx(
            () => Row(
              children: [
                pageWidget(
                  "previous",
                  onTap: () {
                    print("previous");
                    homeController.prevPage();
                  },
                ),
                pageWidget(
                  "(${homeController.offset} / ${homeController.calculateTotalPages().toString()})",
                ),
                pageWidget(
                  "NEXT",
                  onTap: () {
                    print("next");
                    homeController.nextPage();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Expanded pageWidget(String text, {Function()? onTap}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: Dimensions.h35,
            decoration: BoxDecoration(
              color: AppColors.wpColor1,
            ),
            child: Center(
              child: Text(
                text.toUpperCase(),
                style: CustomTextStyle.textRobotoSansMedium.copyWith(
                  color: AppColors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  table() {
    print(homeController.passBookModelData.toJson());
    return Obx(
      () => DataTable(
        headingRowHeight: Dimensions.h45,
        dataRowHeight: Dimensions.h45,
        horizontalMargin: 0,
        decoration: BoxDecoration(color: AppColors.white),
        // columnSpacing: 30,
        columns: [
          dataColumns(
            text: "Transaction Date",
            width: Dimensions.w150,
          ),
          dataColumns(
            text: "Particulers",
            width: Dimensions.w300,
          ),
          dataColumns(
            text: "Previous Amount",
            width: Dimensions.w150,
          ),
          dataColumns(text: "Transaction Amount", width: Dimensions.w150),
          dataColumns(text: "Current Amount", width: Dimensions.w150),
        ],
        columnSpacing: 1,

        rows: List.generate(
          homeController.passBookModelData.length,
          (index) {
            var data = homeController.passBookModelData.elementAt(index);
            return DataRow(cells: [
              dataCells(
                width: Dimensions.w150,
                textColor: AppColors.black,
                text: CommonUtils().formatStringToDDMMYYYYHHMMA(
                  data.createdAt.toString(),
                ),
              ),
              dataCells(
                  width: Dimensions.w300,
                  textColor: AppColors.black,
                  text: data.marketName == null
                      ? "${data.transactionType ?? ""} (${data.marketTime ?? ""}) : ${data.id ?? ""}"
                      : "${data.transactionType ?? ""} (${data.marketOpenTime ?? ""} : ${data.marketName ?? ""} : ${data.bidType ?? ""} ) : ${data.id ?? ""}"),
              dataCells(
                width: Dimensions.w150,
                textColor: AppColors.black,
                text: data.previousAmount.toString(),
              ),
              dataCells(
                width: Dimensions.w150,
                textColor: data.createdAt == "" ||
                        data.createdAt == "null" ||
                        data.createdAt == null
                    ? AppColors.black
                    : AppColors.redColor,
                text: data.createdAt == "" ||
                        data.createdAt == "null" ||
                        data.createdAt == null
                    ? data.createdAt.toString()
                    : "-${data.debit.toString()}",
              ),
              dataCells(
                width: Dimensions.w150,
                textColor: AppColors.black,
                text: data.balance.toString(),
              ),
            ]);
          },
        ).toList(),
        showBottomBorder: true,
      ),
    );
  }

  DataColumn dataColumns({required String text, required double width}) {
    return DataColumn(
      label: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          height: Dimensions.h45,
          width: width,
          decoration: BoxDecoration(
            color: AppColors.wpColor1,
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                spreadRadius: 0.2,
                offset: const Offset(0, 2),
                color: AppColors.grey,
              )
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: CustomTextStyle.textRobotoSansMedium,
            ),
          ),
        ),
      ),
      numeric: true,
    );
  }

  DataCell dataCells(
      {required String text, required Color textColor, required double width}) {
    return DataCell(
      Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          height: Dimensions.h45,
          width: width,
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                spreadRadius: 0.2,
                offset: const Offset(0, 2),
                color: AppColors.grey,
              )
            ],
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  style: CustomTextStyle.textRobotoSansMedium
                      .copyWith(color: textColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Row(
//   children: [
//     BottomPage(
//       text: "PREVIOUS",
//     ),
//     const SizedBox(
//       width: 50,
//     ),
//     BottomPage(
//       text: "(1/0)",
//     ),
//     const SizedBox(
//       width: 50,
//     ),
//     BottomPage(
//       text: "NEXT",
//     ),
//   ],
// )

//   timeColumn() {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: DataTable(
//         headingRowHeight: Dimensions.h45,
//         dataRowHeight: Dimensions.h45,
//         horizontalMargin: 0,
//         headingRowColor: MaterialStateColor.resolveWith(
//           (states) => Colors.white,
//         ),
//         rows: List<DataRow>.generate(
//           homeController.passBookModelData.length,
//           (i) {
//             return DataRow(
//                 color: MaterialStateColor.resolveWith(
//                   (states) => Colors.white,
//                 ),
//                 cells: List<DataCell>.generate(
//                   homeController.passBookModelData.length,
//                   (j) {
//                     return DataCell(
//                       Padding(
//                         padding: const EdgeInsets.all(1.0),
//                         child: Container(
//                           height: Dimensions.h45,
//                           width: Dimensions.w200,
//                           decoration: BoxDecoration(
//                             color: AppColors.white,
//                             boxShadow: [
//                               BoxShadow(
//                                 blurRadius: 2,
//                                 spreadRadius: 0.2,
//                                 offset: Offset(0, 2),
//                                 color: AppColors.grey,
//                               )
//                             ],
//                           ),
//                           child: Center(
//                             child: Text(
//                               "***-*",
//                               textAlign: TextAlign.center,
//                               // style: CustomTextStyle.textGothamLight.copyWith(
//                               //   color: ColorConstant.textColorMain,
//                               //   fontWeight: FontWeight.normal,
//                               //   fontSize: Dimensions.sp16,
//                               // ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ));
//           },
//         ),
//         columnSpacing: 0,
//         columns: List<DataColumn>.generate(
//           homeController.passBookModelData.length,
//           (index) {
//             return DataColumn(
//               label: Container(
//                 height: Dimensions.h45,
//                 width: Dimensions.w200,
//                 decoration: BoxDecoration(
//                     color: AppColors.wpColor1,
//                     border: Border.all(color: AppColors.white)),
//                 child: Center(
//                   child: Text(
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: AppColors.white),
//                     // style: CustomTextStyle.textGothamMedium.copyWith(
//                     //   color: ColorConstant.white,
//                     //   fontWeight: FontWeight.normal,
//                     //   fontSize: Dimensions.sp14,
//                     // ),5
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// ignore: camel_case_types

// //  ignore: must_be_immutable
// class Amount extends StatelessWidget {
//   Amount({super.key, required this.text});
//   String text;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 2.0),
//       child: Container(
//         height: Dimensions.h40,
//         width: Dimensions.w210,
//         decoration: BoxDecoration(
//             color: AppColors.white,
//             borderRadius: BorderRadius.circular(0),
//             boxShadow: [
//               BoxShadow(
//                 blurRadius: 2,
//                 spreadRadius: 0.2,
//                 offset: Offset(0, 2),
//                 color: AppColors.grey,
//               )
//             ]),
//         child: Center(
//           child: FittedBox(
//             fit: BoxFit.fitWidth,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               child: Text(
//                 text,
//                 style: CustomTextStyle.textRobotoSansLight
//                     .copyWith(color: AppColors.black),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
