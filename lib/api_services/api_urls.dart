class ApiUtils {
  // Spl Production
  static String baseURL = "https://vishnulive.in:9870";
  // local url
  // static String baseURL = "http://192.168.29.153:8080";
  // static String baseURL = "http://10.0.0.201:8080";

  // endpoints
  static String signUP = '$baseURL/auth/signup';
  static String signIN = '$baseURL/auth/signin';
  static String verifyUSER = '$baseURL/auth/verifyUser';
  static String verifyOTP = '$baseURL/auth/verifyOtp';
  static String resendOTP = '$baseURL/auth/resendOtp';
  static String forgotPassword = '$baseURL/auth/forgotPassword';
  static String logout = '$baseURL/auth/logout';
  static String resetPassword = '$baseURL/auth/resetPassword';
  static String changePassword = '$baseURL/auth/changePassword';
  static String getBankDetails = '$baseURL/bank/getByUserId';
  static String editBankDetails = '$baseURL/bank/createOrUpdate';
  static String getDailyMarkets = '$baseURL/market/getDailyMarket';
  static String getGameModes =
      '$baseURL/market/getGameModeForMarket/'; //pass 0 for open 1 for close then pass market id like 0/4
  static String getStarLineGameModes =
      '$baseURL/starline/getGameModeForStarlineMarket/'; //pass 0 for open 1 for close then pass market id like 0/4
  static String createMarketBid = '$baseURL/bid/marketBidcreate';
  static String createStarLineMarketBid = '$baseURL/bid/starlineBidCreate';
  static String getDailyStarLineMarkets = '$baseURL/starline/getDailyStarlineMarket';
  static String createWithdrawalRequest = '$baseURL/withdraw/createRequest';
  // static String getWithdrawalRequestTime = '$baseURL/withdraw/getRequestTime';
  static String getWithdrawalHistoryByUserId = '$baseURL/withdraw/getRequestByUserId/';
  static String getStarlineGameRates = '$baseURL/game/getAll/';
  static String createFeedback = '$baseURL/feedback/create';
  static String getFeedbackAndRatingsById = '$baseURL/feedback/getById/';
  // static String getTransactionHistory = '$baseURL/bid/getByUserId';
  static String getTransactionHistory = '$baseURL/payment/getUserPayments';
  static String verifyMPIN = '$baseURL/auth/mPin/verify';
  static String forgotMPIN = '$baseURL/auth/mPin/forgot';
  // new api endpoints
  static String setUserDetails = '$baseURL/auth/setUserDetails';
  // static String setDeviceDetails = '$baseURL/auth/setDeviceDetails';
  static String setMPIN = '$baseURL/auth/mPin/set';
  static String getBalance = '$baseURL/wallet/getBalance';
  static String normalMarketBidHistory = '$baseURL/bid/getByUserId';
  static String starlineMarketBidHistory = '$baseURL/bid/starline/getByUserId';
  static String changeMPIN = "$baseURL/auth/mPin/change";
  static String webStarLinechar = "$baseURL/web/starlineChart";
  static String dailyStarlineMarketBidHistory = "$baseURL/bid/getAllBidByDailyStarlineMarketId";
  static String spdptp = "$baseURL/gameMode/getSPDPTPPana";
  static String panelGroup = "$baseURL/gameMode/getPanelGroupPana";
  static String spMotor = "$baseURL/gameMode/getSPMotorPana";
  static String dpMotor = "$baseURL/gameMode/getDPMotorPana";
  static String towDigitJodi = "$baseURL/gameMode/getTwoDigitPanelPana";
  static String groupJody = "$baseURL/gameMode/groupJodi";
  static String choicePanaSPDP = "$baseURL/gameMode/getChoicePanaSPDPTP";
  static String digitsBasedJodi = "$baseURL/gameMode/digitBasedJodi";
  static String passBookApi = "$baseURL/user/getUserPassbookDetails";
  // static String marketbidHistory = "$baseURL/bid/getBidHistory";
  static String bidHistory = "$baseURL/bid/getByUserId";
  static String marketBidNewLists = "$baseURL/bid/getBidHistoryByBidType";
  static String getNotificationCount = "$baseURL/notification/getNotificationCount";
  static String getAllNotifications = "$baseURL/notification/getAll?search=&limit=10&offset=0";
  static String resetNotificationCount = "$baseURL/notification/resetCount";

  /// new Rating Api
  static String rateAppApi = "$baseURL/feedback/createRating";

  // Notifiaction Api
  static String marketNotification = "$baseURL/notification/updateNotificationStatus";
  static String bennerApi = "$baseURL/banner/getAll";
  static String fcmToken = "$baseURL/auth/setFCMToken";
  static String getVersion = "$baseURL/auth/appVersion";
  static String appKillApi = "$baseURL/user/log/out";
  static String addFund = "$baseURL/payment/process";

  ///
  static String getWalletTransactionHistory = "$baseURL/payment/user";
  static String putWalletTransactionStatus = "$baseURL/payment/ReadPaymentNotification";
  static String getAllPackages = "$baseURL/payment/getAllPackages";
  static String checkUserName = "$baseURL/user/checkUsername";
  static String getApk = "$baseURL/public/apk/spl_live.apk";
}
