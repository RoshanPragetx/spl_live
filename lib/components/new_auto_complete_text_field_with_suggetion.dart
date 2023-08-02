import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../helper_files/app_colors.dart';
import '../helper_files/custom_text_style.dart';
import '../helper_files/dimentions.dart';

class AutoTextFieldWithSuggetion extends StatelessWidget {
  AutoTextFieldWithSuggetion({
    super.key,
    required this.optionsBuilder,
    required this.height,
    required this.controller,
    this.focusNode,
    required this.hintText,
    required this.containerWidth,
    this.inputFormatters,
    this.maxLength,
    this.onChanged,
    this.textAlign,
  });

  final FutureOr<Iterable<String>> Function(TextEditingValue) optionsBuilder;
  final double height;
  final TextEditingController controller;
  final FocusNode? focusNode;
  Function(String)? onChanged;
  final String hintText;
  final double containerWidth;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    );
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 3,
            spreadRadius: 0.2,
            color: AppColors.grey.withOpacity(0.4),
          ),
        ],
      ),
      height: height,
      width: double.infinity,
      child: RawAutocomplete<String>(
        optionsBuilder: optionsBuilder,
        onSelected: (String selection) {
          debugPrint(
              'Selected Suggestion of auto complete text field is $selection');
        },
        fieldViewBuilder: (BuildContext context,
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted) {
          return TextFormField(
            cursorColor: AppColors.appbarColor,
            controller: controller,
            focusNode: focusNode,
            maxLength: maxLength,
            keyboardType: TextInputType.number,
            onChanged: onChanged,
            textAlign: textAlign ?? TextAlign.start,
            inputFormatters: inputFormatters,
            style: CustomTextStyle.textRobotoSansBold
                .copyWith(color: AppColors.appbarColor),
            decoration: InputDecoration(
              hintStyle: CustomTextStyle.textRobotoSansBold.copyWith(
                color: AppColors.black.withOpacity(0.65),
                fontSize: Dimensions.h15,
              ),
              counterText: "",
              filled: true,
              errorMaxLines: 0,
              contentPadding:
                  EdgeInsets.only(left: Dimensions.w10, right: Dimensions.w10),
              hintText: hintText,
              fillColor: AppColors.textFieldFillColor,
              focusedBorder: border,
              border: border,
              errorBorder: border,
              disabledBorder: border,
              enabledBorder: border,
            ),
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<String> onSelected,
            Iterable<String> options) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4.0,
              child: Container(
                width: containerWidth,
                child: ListView.builder(
                  padding: const EdgeInsets.all(15),
                  shrinkWrap: true,
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final String option = options.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        onSelected(option);
                        //  controller.coinsFocusNode.requestFocus();
                        //onSelected(option);
                      },
                      child: Container(
                        padding: EdgeInsets.all(Dimensions.h5),
                        height: Dimensions.h30,
                        child: Center(
                          child: Text(
                            option,
                            style:
                                CustomTextStyle.textRobotoSansMedium.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: Dimensions.h16,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
