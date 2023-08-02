import 'package:flutter/material.dart';
import 'package:spllive/helper_files/app_colors.dart';
import 'package:spllive/helper_files/custom_text_style.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {super.key,
      required this.text,
      required this.buttonColor,
      required this.height,
      required this.width,
      this.radius,
      required this.onTap});
  final String text;
  final Color buttonColor;
  final double height, width;
  final double? radius;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(radius ?? 0),
        ),
        child: Center(
          child: Text(
            text,
            style: CustomTextStyle.textRobotoSansMedium.copyWith(
              color: AppColors.white,
              wordSpacing: 1,
            ),
            // style: TextStyle(
            //   color: AppColors.white,
            //   fontWeight: FontWeight.bold,
            // ),
          ),
        ),
      ),
    );
  }
}
