import 'package:flutter/material.dart';
import 'package:spllive/helper_files/custom_text_style.dart';
import '../helper_files/app_colors.dart';
import '../helper_files/dimentions.dart';

class ListContainer extends StatelessWidget {
  const ListContainer({
    super.key,
    required this.title,
    this.iconData,
    required this.color,
  });
  final String title;
  final IconData? iconData;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.h35,
      color: Colors.grey.withOpacity(0.1),
      child: Row(
        children: [
          SizedBox(
            width: Dimensions.w10,
          ),
          iconData == null
              ? Container()
              : Icon(
                  iconData,
                  color: AppColors.appbarColor,
                ),
          const SizedBox(
            width: 10,
          ),
          FittedBox(
            fit: BoxFit.contain,
            child: Text(
              title,
              style: CustomTextStyle.textRobotoSansMedium.copyWith(
                color: color,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }
}
