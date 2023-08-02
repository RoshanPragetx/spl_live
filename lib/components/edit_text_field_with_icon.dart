import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spllive/helper_files/app_colors.dart';

import '../helper_files/custom_text_style.dart';
import '../helper_files/dimentions.dart';

// ignore: must_be_immutable
class RoundedCornerEditTextWithIcon extends StatelessWidget {
  RoundedCornerEditTextWithIcon({
    Key? key,
    required this.controller,
    this.maxLines,
    this.minLines,
    required this.hintText,
    required this.imagePath,
    required this.height,
    this.isEnabled = true,
    this.width = double.infinity,
    this.formatter,
    required this.keyboardType,
    this.onChanged,
    this.maxLength,
    this.iconColor,
    this.containerBackColor,
    this.textAlign,
    this.contentPadding,
    this.tapTextStyle,
    this.hintTextColor,
    this.textStyle,
    this.onEditingComplete,
    this.onTapOutside,
    this.hintTextStyle,
    this.autofocus,
    this.focusNode,
  }) : super(key: key);

  final TextEditingController controller;

  int? maxLength;
  int? maxLines;
  bool? autofocus;
  int? minLines;
  String hintText;
  String imagePath;
  FocusNode? focusNode;
  bool isEnabled;
  double height;
  double? width;
  Color? iconColor;
  Color? containerBackColor;
  List<TextInputFormatter>? formatter;
  TextInputType keyboardType;
  Function(String?)? onChanged;
  TextAlign? textAlign;
  Color? hintTextColor;
  EdgeInsetsGeometry? contentPadding;
  Color? tapTextStyle;
  TextStyle? textStyle;
  Function()? onEditingComplete;
  Function(PointerDownEvent?)? onTapOutside;
  TextStyle? hintTextStyle;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(Dimensions.r10)),
      child: SizedBox(
        height: height,
        width: width,
        child: TextFormField(
          autofocus: autofocus ?? false,
          enabled: isEnabled,
          controller: controller,
          maxLength: maxLength,
          focusNode: focusNode,
          maxLines: maxLines,
          minLines: minLines,
          onTapOutside: onTapOutside,
          onEditingComplete: onEditingComplete,
          keyboardType: keyboardType,
          inputFormatters: formatter,
          cursorColor: AppColors.black,
          style: textStyle ??
              CustomTextStyle.textPTsansMedium.copyWith(
                color: tapTextStyle ?? AppColors.black,
                fontWeight: FontWeight.normal,
                fontSize: Dimensions.h15,
              ),
          textAlign: textAlign ?? TextAlign.start,
          decoration: InputDecoration(
            contentPadding: contentPadding == null
                ? imagePath.isEmpty
                    ? EdgeInsets.symmetric(horizontal: Dimensions.w12)
                    : EdgeInsets.zero
                : contentPadding,
            focusColor: AppColors.appbarColor,
            filled: true,
            fillColor: AppColors.grey.withOpacity(0.2),
            counterText: "",
            focusedBorder: decoration,
            border: decoration,
            errorBorder: decoration,
            disabledBorder: decoration,
            enabledBorder: decoration,
            errorMaxLines: 0,
            hintText: hintText,
            hintStyle: hintTextStyle ??
                CustomTextStyle.textRobotoSansLight.copyWith(
                  color: hintTextColor ?? AppColors.grey,
                  fontSize: Dimensions.h15,
                  // fontWeight: FontWeight.bold,
                ),
            prefixIcon: imagePath.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: containerBackColor,
                          borderRadius: BorderRadius.circular(50)),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: Dimensions.h4, bottom: Dimensions.h4),
                        child: SvgPicture.asset(
                          imagePath,
                          color: iconColor ?? AppColors.appbarColor,
                          height: 5,
                        ),
                      ),
                    ),
                  )
                : null,
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }

  final decoration = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimensions.r10),
    borderSide: const BorderSide(
      color: Colors.transparent,
    ),
  );
}
