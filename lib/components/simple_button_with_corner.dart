import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RoundedCornerButton extends StatelessWidget {
  RoundedCornerButton(
      {Key? key,
      required this.text,
      required this.color,
      required this.borderColor,
      required this.fontSize,
      required this.fontWeight,
      required this.fontColor,
      required this.letterSpacing,
      required this.borderRadius,
      required this.borderWidth,
      required this.textStyle,
      required this.onTap,
      required this.height,
      required this.width})
      : super(key: key);
  String text;
  Color color;
  Color borderColor;
  Function onTap;
  double fontSize, letterSpacing, borderRadius, borderWidth, height, width;
  FontWeight fontWeight;
  Color fontColor;
  TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: borderWidth),
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
        height: height,
        width: width,
        child: Center(
          child: Text(
            text,
            style: textStyle.copyWith(
              color: fontColor,
              fontWeight: fontWeight,
              fontSize: fontSize,
              letterSpacing: letterSpacing,
            ),
          ),
        ),
      ),
    );
  }
}
