// ignore_for_file: unnecessary_null_comparison

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Dimensions {
  /// Text scale factor function
  static double sf = 0;

  static initDimension(context) {
    sf = MediaQuery.of(context).textScaleFactor;
    if (sf != null) {
      sf = sf > 1
          ? 0.85
          : sf < 1
              ? 1.2
              : 1;
      debugPrint("Text Scale Factor is :- $sf");
    } else {
      sf = MediaQuery.of(context).textScaleFactor;
    }
  }

  static double getDevicePpi() {
    final mediaQuery =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    final size = mediaQuery.size;
    final diagonalInches =
        sqrt(size.width * size.width + size.height * size.height);
    final diagonalPixels = diagonalInches * mediaQuery.devicePixelRatio;
    final ppi = diagonalPixels / diagonalInches;
    return ppi;
  }

  static double w1 = 1.w;
  static double w2 = 2.w;
  static double w3 = 3.w;
  static double w4 = 4.w;
  static double w5 = 5.w;
  static double w6 = 6.w;
  static double w7 = 7.w;
  static double w8 = 8.w;
  static double w9 = 9.w;
  static double w10 = 10.w;
  static double w11 = 11.w;
  static double w12 = 12.w;
  static double w13 = 13.w;
  static double w14 = 14.w;
  static double w15 = 15.w;
  static double w16 = 16.w;
  static double w16dot5 = 16.5.w;
  static double w17 = 17.w;
  static double w18 = 18.w;
  static double w19 = 19.w;
  static double w20 = 20.w;
  static double w21 = 21.w;
  static double w22 = 22.w;
  static double w23 = 23.w;
  static double w24 = 24.w;
  static double w25 = 25.w;
  static double w26 = 26.w;
  static double w27 = 27.w;
  static double w28 = 28.w;
  static double w29 = 29.w;
  static double w30 = 30.w;
  static double w31 = 31.w;
  static double w32 = 32.w;
  static double w33 = 33.w;
  static double w34 = 34.w;
  static double w35 = 35.w;
  static double w36 = 36.w;
  static double w37 = 37.w;
  static double w38 = 38.w;
  static double w39 = 39.w;
  static double w40 = 40.w;
  static double w41 = 41.w;
  static double w42 = 42.w;
  static double w43 = 43.w;
  static double w44 = 44.w;
  static double w45 = 45.w;
  static double w46 = 46.w;
  static double w47 = 47.w;
  static double w48 = 48.w;
  static double w49 = 49.w;
  static double w50 = 50.w;
  static double w51 = 51.w;
  static double w52 = 52.w;
  static double w53 = 53.w;
  static double w54 = 54.w;
  static double w55 = 55.w;
  static double w56 = 56.w;
  static double w57 = 57.w;
  static double w58 = 58.w;
  static double w59 = 59.w;
  static double w60 = 60.w;
  static double w61 = 61.w;
  static double w62 = 62.w;
  static double w63 = 63.w;
  static double w64 = 64.w;
  static double w65 = 65.w;
  static double w66 = 66.w;
  static double w67 = 67.w;
  static double w68 = 68.w;
  static double w69 = 69.w;
  static double w70 = 70.w;
  static double w71 = 71.w;
  static double w72 = 72.w;
  static double w72dot5 = 72.5.w;
  static double w73 = 73.w;
  static double w74 = 74.w;
  static double w75 = 75.w;
  static double w76 = 76.w;
  static double w77 = 77.w;
  static double w78 = 78.w;
  static double w79 = 79.w;
  static double w80 = 80.w;
  static double w81 = 81.w;
  static double w82 = 82.w;
  static double w83 = 83.w;
  static double w84 = 84.w;
  static double w85 = 85.w;
  static double w86 = 86.w;
  static double w87 = 87.w;
  static double w88 = 88.w;
  static double w89 = 89.w;
  static double w90 = 90.w;
  static double w91 = 91.w;
  static double w92 = 92.w;
  static double w93 = 93.w;
  static double w94 = 94.w;
  static double w95 = 95.w;
  static double w96 = 96.w;

  static double w97 = 97.w;

  static double w98 = 98.w;

  static double w99 = 99.w;

  static double w100 = 100.w;

  static double w105 = 105.w;

  static double w110 = 110.w;

  static double w113 = 113.w;

  static double w115 = 115.w;

  static double w120 = 120.w;

  static double w123 = 123.w;

  static double w125 = 125.w;

  static double w130 = 130.w;
  static double w132 = 132.w;
  static double w135 = 135.w;

  static double w140 = 140.w;

  static double w141 = 141.w;

  static double w145 = 145.w;

  static double w149 = 149.w;

  static double w150 = 150.w;
  static double w155 = 155.w;

  static double w165 = 165.w;

  static double w170 = 170.w;

  static double w175 = 175.w;

  static double w180 = 180.w;
  static double w185 = 185.w;
  static double w188 = 188.w;
  static double w190 = 190.w;
  static double w199 = 199.w;
  static double w200 = 200.w;
  static double w205 = 205.w;
  static double w210 = 210.w;
  static double w211 = 211.w;
  static double w220 = 220.w;
  static double w230 = 230.w;
  static double w248 = 248.w;
  static double w250 = 250.w;
  static double w256 = 256.w;
  static double w255 = 255.w;
  static double w267 = 267.w;
  static double w275 = 275.w;
  static double w285 = 285.w;
  static double w295 = 295.w;
  static double w300 = 300.w;
  static double w335 = 335.w;
  static double w340 = 340.w;
  static double w350 = 350.w;
  static double w400 = 400.w;
  static double w500 = 500.w;

  static double h0 = 0.h;
  static double h0dot5 = 7.086.h;
  static double h1 = 1.h;
  static double h2 = 2.h;
  static double h2_5 = 2.5.h;
  static double h3 = 3.h;
  static double h4 = 4.h;
  static double h5 = 5.h;
  static double h6 = 6.h;
  static double h7 = 7.h;
  static double h8 = 8.h;
  static double h9 = 9.h;
  static double h10 = 10.h;
  static double h11 = 11.h;
  static double h12 = 12.h;
  static double h13 = 13.h;
  static double h14 = 14.h;
  static double h15 = 15.h;
  static double h16 = 16.h;
  static double h17 = 17.h;
  static double h18 = 18.h;
  static double h19 = 19.h;
  static double h20 = 20.h;
  static double h21 = 21.h;
  static double h22 = 22.h;
  static double h23 = 23.h;
  static double h24 = 24.h;
  static double h25 = 25.h;
  static double h26 = 26.h;
  static double h27 = 27.h;
  static double h28 = 28.h;
  static double h29 = 29.h;
  static double h30 = 30.h;
  static double h31 = 31.h;
  static double h31dot5 = 31.5.h;
  static double h32 = 32.h;
  static double h33 = 33.h;
  static double h34 = 34.h;
  static double h35 = 35.h;
  static double h36 = 36.h;
  static double h37 = 37.h;
  static double h38 = 38.h;
  static double h39 = 39.h;
  static double h40 = 40.h;
  static double h41 = 41.h;
  static double h42 = 42.h;
  static double h43 = 43.h;
  static double h44 = 44.h;
  static double h45 = 45.h;
  static double h46 = 46.h;
  static double h47 = 47.h;
  static double h48 = 48.h;
  static double h49 = 49.h;
  static double h50 = 50.h;
  static double h51 = 51.h;
  static double h52 = 52.h;
  static double h53 = 53.h;
  static double h54 = 54.h;
  static double h55 = 55.h;
  static double h56 = 56.h;
  static double h57 = 57.h;
  static double h58 = 58.h;
  static double h59 = 59.h;
  static double h60 = 60.h;
  static double h61 = 61.h;
  static double h62 = 62.h;
  static double h63 = 63.h;
  static double h64 = 64.h;
  static double h65 = 65.h;
  static double h66 = 66.h;
  static double h67 = 67.h;
  static double h68 = 68.h;
  static double h69 = 69.h;
  static double h70 = 70.h;
  static double h71 = 71.h;
  static double h72 = 72.h;
  static double h73 = 73.h;
  static double h74 = 74.h;
  static double h75 = 75.h;
  static double h76 = 76.h;
  static double h77 = 77.h;
  static double h78 = 78.h;
  static double h79 = 79.h;
  static double h80 = 80.h;
  static double h81 = 81.h;
  static double h82 = 82.h;
  static double h83 = 83.h;
  static double h84 = 84.h;
  static double h85 = 85.h;
  static double h86 = 86.h;
  static double h87 = 87.h;
  static double h88 = 88.h;
  static double h89 = 89.h;
  static double h90 = 90.h;
  static double h91 = 91.h;
  static double h92 = 92.h;
  static double h93 = 93.h;
  static double h94 = 94.h;
  static double h95 = 95.h;
  static double h96 = 96.h;
  static double h97 = 97.h;
  static double h98 = 98.h;
  static double h99 = 99.h;
  static double h100 = 100.h;
  static double h104 = 104.h;
  static double h106 = 106.h;
  static double h107 = 107.h;
  static double h108 = 108.h;
  static double h110 = 110.h;
  static double h111 = 111.h;
  static double h112 = 112.h;
  static double h114 = 114.h;
  static double h115 = 115.h;
  static double h117 = 117.h;
  static double h120 = 120.h;
  static double h123 = 123.h;
  static double h124 = 124.h;
  static double h125 = 125.h;
  static double h127 = 127.h;
  static double h130 = 130.h;
  static double h135 = 135.h;
  static double h140 = 140.h;
  static double h142 = 142.h;
  static double h150 = 150.h;
  static double h158 = 159.h;
  static double h160 = 160.h;
  static double h165 = 165.h;
  static double h170 = 170.h;
  static double h175 = 175.h;

  static double h181 = 181.h;
  static double h185 = 185.h;
  static double h180 = 180.h;
  static double h190 = 190.h;
  static double h196 = 196.h;
  static double h200 = 200.h;
  static double h204 = 204.h;
  static double h220 = 220.h;
  static double h228 = 228.h;
  static double h230 = 230.h;
  static double h235 = 235.h;
  static double h251 = 251.h;
  static double h265 = 265.h;
  static double h275 = 275.h;
  static double h300 = 300.h;
  static double h307 = 307.h;
  static double h320 = 320.h;
  static double h335 = 335.h;
  static double h340 = 340.h;
  static double h350 = 350.h;
  static double h385 = 385.h;
  static double h400 = 400.h;
  static double h425 = 425.h;
  static double h447 = 447.h;
  static double h500 = 500.h;
  static double h576 = 576.h;

  static double sp3dot5 = 3.3.sp * sf;
  static double sp7 = 7.sp * sf;
  static double sp8 = 8.sp * sf;
  static double sp9 = 9.sp * sf;
  static double sp10 = 10.sp * sf;
  static double sp11 = 11.sp * sf;
  static double sp12 = 12.sp * sf;
  static double sp12dot5 = 12.5.sp * sf;
  static double sp13 = 13.sp * sf;
  static double sp14 = 14.sp * sf;
  static double sp15 = 15.sp * sf;
  static double sp16dot5 = 16.5.sp * sf;
  static double sp16 = 16.sp * sf;
  static double sp17 = 17.sp * sf;
  static double sp18 = 18.sp * sf;
  static double sp19 = 19.sp * sf;
  static double sp20 = 20.sp * sf;
  static double sp21 = 21.sp * sf;
  static double sp22 = 22.sp * sf;
  static double sp23 = 23.sp * sf;
  static double sp24 = 24.sp * sf;
  static double sp25 = 25.sp * sf;
  static double sp26 = 26.sp * sf;
  static double sp27 = 27.sp * sf;
  static double sp28 = 28.sp * sf;
  static double sp30 = 30.sp * sf;
  static double sp32 = 32.sp * sf;
  static double sp36 = 36.sp * sf;
  static double sp38 = 38.sp * sf;
  static double sp42 = 42.sp * sf;
  static double sp50 = 50.sp * sf;
  static double sp56 = 56.sp * sf;
  static double sp68 = 68.sp * sf;
  static double sp72 = 72.sp * sf;
  static double sp74 = 74.sp * sf;
  static double sp80 = 80.sp * sf;
  static double sp90 = 90.sp * sf;
  static double sp100 = 100.sp * sf;

  static double r2 = 2.r;
  static double r3 = 3.r;
  static double r4 = 4.r;
  static double r5 = 5.r;
  static double r6 = 6.r;
  static double r7 = 7.r;
  static double r8 = 8.r;
  static double r9 = 9.r;
  static double r10 = 10.r;
  static double r11 = 11.r;
  static double r12 = 12.r;
  static double r13 = 13.r;
  static double r14 = 14.r;
  static double r15 = 15.r;
  static double r16 = 16.r;
  static double r17 = 17.r;
  static double r18 = 18.r;
  static double r19 = 19.r;
  static double r20 = 20.r;
  static double r21 = 21.r;
  static double r22 = 22.r;
  static double r24 = 24.r;
  static double r25 = 25.r;
  static double r26 = 26.r;
  static double r28 = 28.r;
  static double r29 = 29.r;
  static double r30 = 30.r;
  static double r32 = 32.r;
  static double r33 = 33.r;
  static double r35 = 35.r;
  static double r38 = 38.r;
  static double r40 = 40.r;
  static double r45 = 45.r;
  static double r50 = 50.r;
  static double r55 = 55.r;
  static double r60 = 60.r;
  static double r64 = 64.r;
  static double r70 = 70.r;
  static double r75 = 75.r;
  static double r76 = 76.r;
  static double r80 = 80.r;
  static double r85 = 85.r;
  static double r90 = 90.r;
  static double r100 = 100.r;
  static double r110 = 110.r;
  static double r120 = 120.r;
  static double r130 = 130.r;
  static double r140 = 140.r;
  static double r141 = 141.r;
  static double r150 = 150.r;
  static double r152 = 152.r;
  static double r180 = 180.r;
  static double r200 = 300.r;
  static double r300 = 300.r;
  static double r335 = 335.r;
  static double r340 = 340.r;
  static double r350 = 350.r;
  static double r400 = 400.r;
  static double r450 = 450.r;
  static double r500 = 500.r;

  static double commonPaddingForScreen = Dimensions.w20;

  // static double getSafeAreaBottomHeight() {
  //   return MediaQuery.of(NavigationService.instance.appContext).padding.bottom;
  // }
  //
  // static double getBottomButtonHeight() {
  //   return 52.0 +
  //       MediaQuery.of(NavigationService.instance.appContext).padding.bottom;
  // }
  //
  // static double getImagePaddingFromTopHeight() {
  //   return h20 +
  //       MediaQuery.of(NavigationService.instance.appContext).padding.top;
  // }
  //
  // static double getSafeAreaTopHeight() {
  //   return MediaQuery.of(NavigationService.instance.appContext).padding.top;
  // }
  //
  // static double bottomPadding() {
  //   return buttonHeight() +
  //       MediaQuery.of(NavigationService.instance.appContext).padding.bottom;
  // }
  //
  // static double screenWidth() {
  //   return MediaQuery.of(NavigationService.instance.appContext).size.width;
  // }
  //
  // static double screenHeight() {
  //   return MediaQuery.of(NavigationService.instance.appContext).size.height;
  // }
  //
  // static double getKeyBoardHeight() {
  //   return MediaQuery.of(NavigationService.instance.appContext)
  //       .viewInsets
  //       .bottom;
  // }

  static double buttonHeight() {
    return AppBar().preferredSize.height;
  }
}
