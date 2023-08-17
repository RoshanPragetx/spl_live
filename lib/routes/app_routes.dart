// ignore_for_file: unused_import

import 'package:get/get.dart';
import 'package:spllive/models/commun_models/starline_bid_request_model.dart';
import 'package:spllive/screens/More%20Details%20Screens/About%20Page/about_page.dart';
import 'package:spllive/screens/More%20Details%20Screens/Change%20Mpin/binding/change_mpin_page_binding.dart';
import 'package:spllive/screens/More%20Details%20Screens/Notification%20Page/binding/notification_details_page_binding.dart';
import 'package:spllive/screens/More%20Details%20Screens/myProfile/binding/myprofile_page_binding.dart';
import 'package:spllive/screens/More%20Details%20Screens/myProfile/myprofile_page.dart';
import 'package:spllive/screens/New%20GameModes/binding/new_gamemode_page_bindings.dart';
import 'package:spllive/screens/New%20GameModes/new_gamemodes_page.dart';
import 'package:spllive/screens/Normal%20Market%20List/binding/normal_market_page_binding.dart';
import 'package:spllive/screens/Normal%20Market%20List/normal_market_page.dart';
import 'package:spllive/screens/Sangam%20Page/binding/snagam_page_binding.dart';
import 'package:spllive/screens/Sangam%20Page/controller/sangam_page_controller.dart';
import 'package:spllive/screens/Starline%20Bid%20Page/bidings/starline_bids_bidings.dart';
import 'package:spllive/screens/game_pages/game_pages.dart';
import 'package:spllive/screens/gamemode_pages/gamemode_page.dart';
import 'package:spllive/screens/sign_in_screen/bindings/sign_in_screen_binding.dart';
import 'package:spllive/screens/sign_up_screen/bindings/sing_up_screen_bindings.dart';
import 'package:spllive/screens/sign_up_screen/sign_up_screen.dart';
import 'package:spllive/screens/slash_screen/bindings/splash_screen_bindings.dart';
import 'package:spllive/screens/slash_screen/splash_screen.dart';
import '../screens/Forgot Password/binding/forgot_password_page_binding.dart';
import '../screens/Forgot Password/forgot_password_page.dart';
import '../screens/MPIN Page/binding/mpin_page_binding.dart';
import '../screens/MPIN Page/mpin_page_view.dart';
import '../screens/Market Bid History/binding/market_bid_history_binding.dart';
import '../screens/Market Bid History/market_bid_history_page.dart';
import '../screens/More Details Screens/About Page/binding/about_page_biding.dart';
import '../screens/More Details Screens/Change Mpin/change_mpin_page.dart';
import '../screens/More Details Screens/Change Password/bidding/change_password_bidings.dart';
import '../screens/More Details Screens/Change Password/change_password.dart';
import '../screens/More Details Screens/Check Withdrawal History/binding/check_withdrawal_history_binding.dart';
import '../screens/More Details Screens/Check Withdrawal History/check_withdrawal_history.dart';
import '../screens/More Details Screens/Create Withdrawal Page/binding/create_withdrawal_page_bidings.dart';
import '../screens/More Details Screens/Create Withdrawal Page/create_withdrawal_page.dart';
import '../screens/More Details Screens/Digit Based Jodi/binding/digit_based_page_binding.dart';
import '../screens/More Details Screens/Digit Based Jodi/digit_based_jodi.dart';
import '../screens/More Details Screens/Game Rate Page/binding/game_rate_page_binding.dart';
import '../screens/More Details Screens/Game Rate Page/game_rate_page.dart';
import '../screens/More Details Screens/Give Feedback Page/binding/give_feedback_page_binding.dart';
import '../screens/More Details Screens/Give Feedback Page/give_feedback_page.dart';
import '../screens/More Details Screens/My Account Page/binding/myaccount_page_bindings.dart';
import '../screens/More Details Screens/My Account Page/myaccount_page.dart';
import '../screens/More Details Screens/Notification Page/notification_details.dart';
import '../screens/More Details Screens/Odd Even Page/binding/odd_even_page_binding.dart';
import '../screens/More Details Screens/Odd Even Page/odd_even_page.dart';
import '../screens/More Details Screens/Starline Terms Page/binding/starline_terms_page_binding.dart';
import '../screens/More Details Screens/Starline Terms Page/starline_terms_page.dart';
import '../screens/More Details Screens/Withdrawal Page/binding/withdrawal_page_binding.dart';
import '../screens/More Details Screens/Withdrawal Page/withdrawal_page.dart';
import '../screens/Normal Game Pages/binding/normal_game_page_controller.dart';
import '../screens/Normal Game Pages/normal_game_pages.dart';
import '../screens/Reset Password Page/binding/reset_password_binding.dart';
import '../screens/Reset Password Page/reset_password.dart';
import '../screens/Sangam Page/sangampages.dart';
import '../screens/Select Bid Page/binding/selectbid_page_bindings.dart';
import '../screens/Select Bid Page/selectbid_page.dart';
import '../screens/Set MPIN Page/binding/set_mpin_page_binding.dart';
import '../screens/Set MPIN Page/set_mpin_page.dart';
import '../screens/StarLine Game Mode Page/binding/starline_game_modes_page_binding.dart';
import '../screens/StarLine Game Mode Page/starline_game_modes_page.dart';
import '../screens/Starline Bid Page/starline_bids.dart';
import '../screens/Starline Game Page/binding/starline_game_page_binding.dart';
import '../screens/Starline Game Page/starline_game_page.dart';
import '../screens/Starline New Game Page/bindings/starline_new_game_page_binding.dart';
import '../screens/Starline New Game Page/controller/starline_new_game_page_controller.dart';
import '../screens/Starline New Game Page/starline_new_game_page.dart';
import '../screens/User Details Page/binding/user_details_page_binding.dart';
import '../screens/User Details Page/user_details_page.dart';
import '../screens/Verify OTP Page/binding/verify_otp_binding.dart';
import '../screens/Verify OTP Page/verify_otp.dart';
import '../screens/game_pages/bindings/game_mode_page_binding.dart';
import '../screens/gamemode_pages/bindings/game_mode_page_binding.dart';
import '../screens/home_screen/binding/home_screen_binding.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/notification_page/notification.dart';
import '../screens/sign_in_screen/sign_in_screen_page.dart';
import '../screens/transaction_page/binding/transaction_page_binding.dart';
import '../screens/transaction_page/transaction.dart';
import '../screens/welcome_screen/bindings/welcome_screen_bindings.dart';
import '../screens/welcome_screen/welcome_screen.dart';
import 'app_routes_name.dart';

class AppRoutes {
  var appRoutName = AppRoutName();
  static List<GetPage> pages = [
    GetPage(
      name: AppRoutName.splashScreen,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => SplashScreen(),
      bindings: [
        SplashScreenBinding(),
      ],
    ),
    GetPage(
      name: AppRoutName.walcomeScreen,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => const WelcomeScreen(),
      bindings: [
        WelcomeScreenBinding(),
      ],
    ),
    GetPage(
      name: AppRoutName.dashBoardPage,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => const DashBoardPage(),
      bindings: [
        HomePageBindings(),
      ],
    ),
    GetPage(
      name: AppRoutName.transactionPage,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => TransactionPage(),
      bindings: [
        TransactionPageBindings(),
      ],
    ),
    GetPage(
      name: AppRoutName.notificationPage,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => const NotificationPage(),
      // bindings: [
      //   DashBoardPage(),
      // ],
    ),
    GetPage(
      name: AppRoutName.gameModePage,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => GameModePage(),
      bindings: [
        GameModepageBinding(),
      ],
    ),

    GetPage(
      name: AppRoutName.signInPage,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => SignInScreen(),
      bindings: [SignInPageBinding()],
    ),
    GetPage(
      name: AppRoutName.signUnPage,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => SignUpScreen(),
      bindings: [SignUpPageBinding()],
    ),

    /// verifyOTPPage
    GetPage(
      name: AppRoutName.verifyOTPPage,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => VerifyOTPPage(),
      bindings: [
        VerifyOTPBinding(),
      ],
    ),

    /// UserDetailsPage
    GetPage(
      name: AppRoutName.userDetailsPage,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => UserDetailsPage(),
      bindings: [
        UserDetailsPageBinding(),
      ],
    ),

    /// SetMPINPage
    GetPage(
      name: AppRoutName.setMPINPage,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => SetMPINPage(),
      bindings: [
        SetMPINPageBinding(),
      ],
    ),

    // MPINPage
    GetPage(
      name: AppRoutName.mPINPage,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => MPINPageView(),
      bindings: [
        MPINPageBinding(),
      ],
    ),
    GetPage(
      name: AppRoutName.forgotPasswordPage,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => ForgotPasswordPage(),
      bindings: [
        ForgotPasswordPageBindings(),
      ],
    ),

    /// Reset Password Page
    GetPage(
      name: AppRoutName.resetPasswordPage,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => ResetPasswordPage(),
      bindings: [
        ResetPasswordBinding(),
      ],
    ),

    // profile page
    GetPage(
      name: AppRoutName.profilePage,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => ProfilePage(),
      bindings: [
        MyProfilePageBindings(),
      ],
    ),

    // game page's
    GetPage(
      name: AppRoutName.singleAnkPage,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => SingleAnkPage(),
      bindings: [
        GamepageBinding(),
      ],
    ),

    /// SelectedBidsPage
    GetPage(
      name: AppRoutName.selectedBidsPage,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => SelectedBidsPage(),
      bindings: [
        SelecteBidPageBinding(),
      ],
    ),

    /// SelectedBidsPage
    GetPage(
      name: AppRoutName.sangamPages,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => SangamPages(),
      bindings: [
        SangamPageBindings(),
      ],
    ),

    /// starLineGameModesPage
    GetPage(
      name: AppRoutName.starLineGameModesPage,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => StarLineGameModesPage(),
      bindings: [
        StarLineGameModesPageBindings(),
      ],
    ),

    /// starLineGamePage
    GetPage(
      name: AppRoutName.starLineGamePage,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => StarLineGamePage(),
      bindings: [
        StarLineGamePageBinding(),
      ],
    ),

    /// MyAccountPage
    GetPage(
      name: AppRoutName.myAccountPage,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => MyAccountPage(),
      bindings: [
        MyAccountPageBinding(),
      ],
    ),

    /// gameRatePage
    GetPage(
      name: AppRoutName.gameRatePage,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => GameRatePage(),
      bindings: [
        GameRatePageBinding(),
      ],
    ),

    /// notificationDetailspage
    GetPage(
      name: AppRoutName.notificationDetailsPage,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => NotificationDetailsPage(),
      bindings: [
        NotificationDetailsPageBindings(),
      ],
    ),

    /// withdrawal Page
    GetPage(
      name: AppRoutName.withdrawalpage,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => WithdrawalPage(),
      bindings: [
        WithdrawalPageBindings(),
      ],
    ),

    /// withdrawal Page
    GetPage(
      name: AppRoutName.feedBackPage,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => GiveFeedbackPage(),
      bindings: [
        GiveFeedbackPageBinding(),
      ],
    ),
    GetPage(
      name: AppRoutName.stalineTerms,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => StarlineTermsPage(),
      bindings: [
        StarlineTermsPageBindig(),
      ],
    ),
    //// About Us Page
    GetPage(
      name: AppRoutName.aboutPage,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => AboutUsPage(),
      bindings: [AboutUsPageBiding()],
    ),
    GetPage(
      name: AppRoutName.changePassPage,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => ChangePasswordPage(),
      bindings: [ChangePasswordPageBidings()],
    ),

    //// Change Mpin Page
    GetPage(
      name: AppRoutName.changeMpinPage,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => ChangeMpinPage(),
      bindings: [ChangeMpinPageBinding()],
    ),

    /// create WithDrawal Req Page
    GetPage(
      name: AppRoutName.createWithDrawalPage,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => CreatewithDrawalPage(),
      bindings: [CreateWithDrawalPageBiding()],
    ),
    GetPage(
      name: AppRoutName.checkWithDrawalPage,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => const CheckWithdrawalPage(),
      bindings: [CheckWithdrawalPageBinding()],
    ),
    GetPage(
      name: AppRoutName.normalMarketPage,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => NormalMarketPage(),
      bindings: [NormalMarketPageBinding()],
    ),
    GetPage(
      name: AppRoutName.newGameModePage,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => NewGameModePage(),
      bindings: [NewGamemodePageBindings()],
    ),
    GetPage(
      name: AppRoutName.newOddEvenPage,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => NormalGamePage(),
      bindings: [NormalGamePageBindings()],
    ),
    GetPage(
      name: AppRoutName.starlineBidpage,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => StarlineBidsPage(),
      bindings: [StarlineBidsBidings()],
    ),
    GetPage(
      name: AppRoutName.newStarlineGames,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => StarLineNewGamePage(),
      bindings: [StarlineNewGamePageBinding()],
    ),

    GetPage(
      name: AppRoutName.marketbidHistory,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => MarketBidHistory(),
      bindings: [MarketBidHistoryPageBindings()],
    )
  ];
}
