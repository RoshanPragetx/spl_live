import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spllive/helper_files/app_colors.dart';

import '../helper_files/custom_text_style.dart';
import '../helper_files/dimentions.dart';

// ignore: must_be_immutable
class PasswordFieldWithIcon extends StatelessWidget {
  PasswordFieldWithIcon({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.imagePath,
    required this.keyBoardType,
    required this.suffixIconColor,
    required this.suffixIcon,
    required this.hidePassword,
    required this.height,
  }) : super(key: key);

  final TextEditingController controller;

  String hintText;
  String imagePath;
  TextInputType? keyBoardType;
  Widget suffixIcon;
  Color suffixIconColor;
  bool hidePassword;
  double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(Dimensions.r10)),
      child: SizedBox(
        height: height,
        child: TextFormField(
          keyboardType: keyBoardType,
          autofocus: false,
          controller: controller,
          obscureText: !hidePassword,
          cursorColor: AppColors.black,
          style: CustomTextStyle.textRobotoSlabMedium.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.normal,
            fontSize: Dimensions.h16,
          ),
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: EdgeInsets.all(Dimensions.w12),
              child: SvgPicture.asset(
                imagePath,
                color: AppColors.appbarColor,
              ),
            ),
            prefixIconColor: AppColors.black,
            suffixIcon: suffixIcon,
            suffixIconColor: suffixIconColor,
            focusColor: AppColors.black,
            filled: true,
            fillColor: AppColors.grey.withOpacity(0.2),
            counterText: "",
            focusedBorder: decoration,
            border: decoration,
            errorBorder: decoration,
            disabledBorder: decoration,
            enabledBorder: decoration,
            errorMaxLines: 4,
            hintText: hintText,
            hintStyle: CustomTextStyle.textPTsansMedium.copyWith(
              color: AppColors.grey,
              fontSize: Dimensions.h14,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  final decoration = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimensions.r10),
    borderSide: const BorderSide(
      width: 1,
      style: BorderStyle.solid,
      color: Colors.transparent,
    ),
  );
}
