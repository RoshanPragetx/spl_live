import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spllive/helper_files/app_colors.dart';
import 'package:spllive/helper_files/custom_text_style.dart';

import '../helper_files/dimentions.dart';

// ignore: must_be_immutable
class AutoCompleteTextField extends StatelessWidget {
  AutoCompleteTextField({
    Key? key,
    required this.hintText,
    required this.height,
    required this.controller,
    required this.keyboardType,
    required this.optionsBuilder,
    required this.validateValue,
    required this.suggestionWidth,
    this.width = double.infinity,
    this.isBulkMode = true,
    this.autoFocus = false,
    this.focusNode,
    this.maxLength = 2,
    this.formatter,
    this.hintTextColor,
    this.textStyle,
  }) : super(key: key);

  double height, suggestionWidth;
  double? width;
  int? maxLength;
  String hintText;
  bool? isBulkMode;
  bool? autoFocus;
  List<TextInputFormatter>? formatter;
  TextInputType keyboardType;
  FocusNode? focusNode;
  TextEditingController controller;
  Color? hintTextColor;
  TextStyle? textStyle;
  FutureOr<Iterable<String>> Function(TextEditingValue) optionsBuilder;
  Function(bool, String) validateValue;

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(2, 2),
            blurRadius: 5,
            spreadRadius: 0.2,
            color: AppColors.grey)
      ]),
      height: height,
      width: width,
      child: RawAutocomplete(
        textEditingController: controller,
        focusNode: FocusNode(),
        optionsBuilder: optionsBuilder,
        fieldViewBuilder:
            (context, textEditingController, focusNod, onFieldSubmitted) {
          return TextFormField(
            textInputAction: TextInputAction.next,
            style: textStyle ??
                CustomTextStyle.textPTsansMedium.copyWith(
                  color: AppColors.appbarColor,
                  fontWeight: FontWeight.normal,
                  fontSize: Dimensions.h16,
                ),
            cursorColor: AppColors.appbarColor,
            controller: textEditingController,
            focusNode: focusNode,
            autofocus: autoFocus!,
            inputFormatters: formatter,
            maxLength: maxLength,
            onFieldSubmitted: (String value) {
              if (isBulkMode ?? false) {
                textEditingController.clear();
              } else {
                onFieldSubmitted;
              }
            },
            keyboardType: keyboardType,
            onChanged: (val) {
              validateValue(false, val);
            },
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(right: Dimensions.w40),
              focusColor: AppColors.black,
              filled: true,
              fillColor: AppColors.white,
              counterText: "",
              focusedBorder: border,
              border: border,
              errorBorder: border,
              disabledBorder: border,
              enabledBorder: border,
              errorMaxLines: 0,
              hintText: hintText,
              hintStyle: CustomTextStyle.textRobotoSansMedium.copyWith(
                color: hintTextColor ?? AppColors.grey,
                fontSize: Dimensions.h16,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<String> onSelected,
            Iterable<String> options) {
          return Container();
          // return Align(
          //   alignment: Alignment.topLeft,
          //   child: Material(
          //     elevation: 4.0,
          //     child: SizedBox(
          //       width: suggestionWidth,
          //       child: ListView.builder(
          //         shrinkWrap: true,
          //         padding: const EdgeInsets.all(8.0),
          //         itemCount: options.length,
          //         itemBuilder: (BuildContext context, int index) {
          //           final String option = options.elementAt(index);
          //           return GestureDetector(
          //             onTap: () {
          //               FocusManager.instance.primaryFocus?.unfocus();
          //               validateValue(true, option);
          //               onSelected(option);
          //             },
          //             child: Container(
          //               padding: EdgeInsets.all(Dimensions.h5),
          //               height: Dimensions.h30,
          //               child: Text(
          //                 option,
          //                 style: CustomTextStyle.textPTsansMedium.copyWith(
          //                   color: AppColors.appbarColor,
          //                   fontWeight: FontWeight.normal,
          //                   fontSize: Dimensions.h16,
          //                 ),
          //               ),
          //             ),
          //           );
          //         },
          //       ),
          //     ),
          //   ),
          // );
        },
        onSelected: (String selection) {
          debugPrint(
              'Selected Suggestion of auto complete text field is $selection');
        },
      ),
    );
  }
}
