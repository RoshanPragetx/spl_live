import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../helper_files/app_colors.dart';
import '../helper_files/custom_text_style.dart';

class EdittextFieldwithvalidation extends StatelessWidget {
  const EdittextFieldwithvalidation({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.hintText,
    required this.onTap,
    required this.onChanged,
    this.maxLength,
    this.validator,
    this.inputFormatters,
    this.keyboardType,
    this.focusNode,
    this.autofocus,
  });

  final TextEditingController controller;
  final bool obscureText;
  final String hintText;
  final Function() onTap;
  final Function(String) onChanged;
  final int? maxLength;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final bool? autofocus;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      maxLength: maxLength,
      obscureText: obscureText,
      validator: validator,
      autofocus: autofocus ?? false,
      focusNode: focusNode,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        counterText: "",
        fillColor: AppColors.grey.withOpacity(0.2),
        filled: true,
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: CustomTextStyle.textPTsansMedium.copyWith(
          color: AppColors.appbarColor.withOpacity(0.5),
        ),
        suffixIcon: GestureDetector(
          onTap: onTap,
          child: obscureText
              ? Icon(Icons.remove_red_eye, color: AppColors.appbarColor)
              : Icon(Icons.visibility_off, color: AppColors.grey),
        ),
      ),
    );
  }
}
