import 'dart:async';

import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spllive/helper_files/app_colors.dart';
import 'package:spllive/helper_files/constant_image.dart';
import 'package:spllive/helper_files/ui_utils.dart';
import 'package:spllive/routes/app_routes_name.dart';

import '../../components/edit_text_field_with_icon.dart';
import '../../components/password_field_with_icon.dart';
import '../../components/simple_button_with_corner.dart';
import '../../helper_files/custom_text_style.dart';
import '../../helper_files/dimentions.dart';
import 'controller/sign_in_screen_controller.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final controller = Get.find<SignInPageController>();

  final verticalSpace = SizedBox(height: Dimensions.h20);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.appbarColor),
        systemOverlayStyle: AppUtils.toolBarStyleDark,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              verticalSpace,
              verticalSpace,
              verticalSpace,
              SizedBox(
                height: Dimensions.h70,
                width: Dimensions.w150,
                child: Image.asset(
                  ConstantImage.splLogo,
                  fit: BoxFit.contain,
                ),
              ),
              verticalSpace,
              Text(
                "WELCOMEBACK".tr,
                style: CustomTextStyle.textPTsansMedium.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: Dimensions.h12,
                  letterSpacing: 1,
                  color: AppColors.black.withAlpha(200),
                ),
              ),
              Text(
                "SIGNIN".tr,
                style: CustomTextStyle.textRobotoSlabBold.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.h20,
                  letterSpacing: 1,
                  color: AppColors.appbarColor,
                ),
              ),
              verticalSpace,
              _buildSignInForm()
            ],
          ),
        ),
      ),
    );
  }

  _buildMobileNumberField() {
    return Row(
      children: [
        // Container(
        //   height: Dimensions.h40,
        //   padding: EdgeInsets.zero,
        //   decoration: BoxDecoration(
        //     color: AppColors.grey.withOpacity(0.2),
        //     borderRadius: BorderRadius.all(
        //       Radius.circular(Dimensions.r10),
        //     ),
        //   ),
        //   child: CountryListPick(
        //     appBar: AppBar(
        //       backgroundColor: AppColors.appbarColor,
        //       title: const Text('Choose your country code'),
        //     ),
        //     pickerBuilder: (context, code) {
        //       return Padding(
        //         padding: EdgeInsets.symmetric(horizontal: Dimensions.h5),
        //         child: Row(
        //           children: [
        //             Text(
        //               code != null ? code.dialCode ?? "+91" : "91",
        //               style: CustomTextStyle.textRobotoSlabMedium.copyWith(
        //                 color: AppColors.appbarColor,
        //                 fontSize: Dimensions.h15,
        //               ),
        //             ),
        //             Padding(
        //               padding: EdgeInsets.only(
        //                 left: Dimensions.w7,
        //               ),
        //               child: SvgPicture.asset(
        //                 ConstantImage.dropDownArrowSVG,
        //                 color: AppColors.appbarColor,
        //               ),
        //             ),
        //           ],
        //         ),
        //       );
        //     },
        //     theme: CountryTheme(
        //       isShowFlag: false,
        //       isShowTitle: false,
        //       isShowCode: true,
        //       isDownIcon: true,
        //       showEnglishName: true,
        //       alphabetSelectedTextColor: AppColors.white,
        //       labelColor: AppColors.black,
        //       alphabetTextColor: AppColors.green,
        //     ),
        //     initialSelection: '+91',
        //     onChanged: (code) {
        //       String tempCountryCode =
        //           code != null ? code.dialCode ?? "+91" : "91";
        //       controller.onChangeCountryCode(tempCountryCode);
        //     },
        //     useUiOverlay: true,
        //     useSafeArea: false,
        //   ),
        // ),
        // SizedBox(
        //   width: Dimensions.w9,
        // ),
        Expanded(
          child: RoundedCornerEditTextWithIcon(
            height: Dimensions.h40,
            controller: controller.mobileNumberController,
            keyboardType: TextInputType.phone,
            hintText: "ENTERMOBILENUMBER".tr,
            imagePath: ConstantImage.phoneSVG,
            autofocus: true,
            onChanged: (v) {
              if (v?.length == 10) {
                controller.focusNode1.unfocus();
                controller.focusNode2.requestFocus();
                controller.cursorTimer?.cancel();
                controller.cursorTimer = Timer(Duration(milliseconds: 50), () {
                  controller.mobileNumberController.selection =
                      TextSelection.fromPosition(
                    TextPosition(
                        offset: controller.mobileNumberController.text.length),
                  );
                });
              }
            },
            hintTextStyle: CustomTextStyle.textRobotoSansLight.copyWith(
              color: AppColors.grey,
              fontSize: Dimensions.h14,
            ),
            maxLines: 1,
            focusNode: controller.focusNode1,
            minLines: 1,
            isEnabled: true,
            maxLength: 10,
            formatter: [FilteringTextInputFormatter.digitsOnly],
          ),
        ),
      ],
    );
  }

  _buildSignInForm() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.h20),
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: _buildMobileNumberField(),
            ),
            verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: _buildPasswordField(),
            ),
            verticalSpace,
            // GestureDetector(
            //   // onTap: () {},
            //   onTap: () =>
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: const [
            //       Text(
            //         "Forgot Password?",
            //         style: TextStyle(fontWeight: FontWeight.w500),
            //         // "${"FORGOTPASSWORD".tr}?",
            //         // style: CustomTextStyle.textRobotoSlabMedium.copyWith(
            //         //   fontSize: Dimensions.h12,
            //         //   letterSpacing: 1,
            //         //   color: AppColors.black,
            //         // ),
            //       ),
            //     ],
            //   ),
            // ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w15),
              child: RoundedCornerButton(
                text: "SIGNIN".tr,
                color: AppColors.appbarColor,
                borderColor: AppColors.appbarColor,
                fontSize: Dimensions.h12,
                fontWeight: FontWeight.w300,
                fontColor: AppColors.white,
                letterSpacing: 0,
                borderRadius: Dimensions.r25,
                borderWidth: 1,
                textStyle: CustomTextStyle.textRobotoSansLight,
                onTap: () => controller.onTapOfSignIn(),
                height: Dimensions.h30,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: orView(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w15),
              child: RoundedCornerButton(
                text: "FORGOTPASS".tr,
                color: AppColors.white,
                borderColor: AppColors.appbarColor,
                fontSize: Dimensions.h12,
                fontWeight: FontWeight.w300,
                fontColor: AppColors.appbarColor,
                letterSpacing: 0,
                borderRadius: Dimensions.r25,
                borderWidth: 1,
                textStyle: CustomTextStyle.textRobotoSansLight,
                onTap: () => Get.toNamed(AppRoutName.forgotPasswordPage),
                height: Dimensions.h30,
                width: double.infinity,
              ),
            ),
            // GestureDetector(
            //   onTap: () => Get.offAllNamed(AppRoutName.signUnPage),
            //   child: Container(
            //     padding:
            //         const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
            //     child: Text(
            //       "Don’t Have an Account? Register here.".tr,
            //       textAlign: TextAlign.center,
            //       style: CustomTextStyle.textRobotoSlabMedium.copyWith(
            //         fontSize: Dimensions.h12,
            //         letterSpacing: 1,
            //         height: 1.5,
            //         color: AppColors.black,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Row orView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            color: AppColors.greyShade.withOpacity(0.6),
            indent: Dimensions.w30,
            endIndent: Dimensions.w20,
            thickness: 2,
          ),
        ),
        Text(
          "OR",
          style: CustomTextStyle.textRobotoSlabMedium.copyWith(
              fontSize: Dimensions.h20,
              color: AppColors.greyShade.withOpacity(0.6),
              fontWeight: FontWeight.w300),
        ),
        Expanded(
          child: Divider(
            color: AppColors.greyShade.withOpacity(0.6),
            indent: Dimensions.w20,
            endIndent: Dimensions.w30,
            thickness: 2,
          ),
        ),
      ],
    );
  }

  _buildPasswordField() {
    return PasswordFieldWithIcon(
      focusNode: controller.focusNode2,
      height: Dimensions.h40,
      keyBoardType: TextInputType.visiblePassword,
      controller: controller.passwordController,
      hintText: "ENTERPASSWORDTEXT".tr,
      hidePassword: controller.visiblePassword.value,
      suffixIcon: InkWell(
        onTap: () {
          controller.onTapOfVisibilityIcon();
        },
        child: Icon(
          Icons.visibility,
          size: Dimensions.h15,
          color: controller.visiblePassword.value
              ? AppColors.appbarColor
              : AppColors.grey,
        ),
      ),
      suffixIconColor: AppColors.appbarColor,
      imagePath: ConstantImage.lockSVG,
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: Text(
//               "LOGIN",
//               style: TextStyle(
//                   fontSize: 25,
//                   color: Color.fromARGB(255, 42, 90, 173),
//                   fontWeight: FontWeight.bold),
//             ),
//           ),
//           SizedBox(
//             height: 25,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                     color: Color.fromARGB(255, 243, 240, 240),
//                     borderRadius: BorderRadius.circular(8.0)),
//                 child: DropdownButton<String>(
//                   icon: Icon(Icons.arrow_drop_down_outlined),
//                   elevation: 0,
//                   underline: Container(),
//                   dropdownColor: Color.fromARGB(255, 243, 240, 240),
//                   borderRadius: BorderRadius.circular(8.0),
//                   value: null,
//                   hint: Padding(
//                     padding: const EdgeInsets.fromLTRB(17, 0, 0, 0),
//                     child: Text(' +91'),
//                   ),
//                   onChanged: (value) {},
//                   items: [
//                     DropdownMenuItem<String>(
//                       value: 'Option 1',
//                       child: Text('Option 1'),
//                     ),
//                     DropdownMenuItem<String>(
//                       value: 'Option 2',
//                       child: Text('Option 2'),
//                     ),
//                     DropdownMenuItem<String>(
//                       value: 'Option 3',
//                       child: Text('Option 3'),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 50,
//                 width: 220,
//                 child: TextField(
//                   decoration: InputDecoration(
//                       fillColor: Color.fromARGB(255, 243, 240, 240),
//                       filled: true,
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                           borderSide: BorderSide.none),
//                       prefixIcon: Icon(
//                         Icons.phone,
//                         color:
//                             Color.fromARGB(255, 42, 90, 173).withOpacity(0.7),
//                       ),
//                       hintText: 'Enter Mobile Number',
//                       hintStyle: TextStyle(color: Colors.grey)),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 17,
//           ),
//           Container(
//             height: 55,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 25),
//               child: TextField(
//                 decoration: InputDecoration(
//                     fillColor: Color.fromARGB(255, 243, 240, 240),
//                     filled: true,
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                         borderSide: BorderSide.none),
//                     prefixIcon: Icon(
//                       Icons.lock,
//                       color: Color.fromARGB(255, 42, 90, 173).withOpacity(0.7),
//                     ),
//                     hintText: 'Enter Password',
//                     suffixIcon:
//                         Icon(Icons.remove_red_eye, color: Colors.blueGrey),
//                     hintStyle: TextStyle(color: Colors.grey)),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 15,
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(225, 0, 0, 0),
//             child: Text(
//               "Forgot Password?",
//               style: TextStyle(
//                 color: Color.fromARGB(255, 42, 90, 173),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 17,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 35,
//             ),
//             child: InkWell(
//               onTap: () {},
//               child: Container(
//                 width: double.infinity,
//                 height: 45,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Color.fromARGB(255, 42, 90, 173),
//                 ),
//                 child: Center(
//                   child: Text(
//                     'Login',
//                     style: TextStyle(
//                       fontSize: 17,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Text(
//             "Don't Have an Account? Register here.",
//             style: TextStyle(
//                 color: Color.fromARGB(255, 42, 90, 173), fontSize: 17),
//           ),
//         ],
//       ),
//     );
//   }
// }
