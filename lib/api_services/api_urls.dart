class ApiUtils {
  //static String baseURL = "http://43.205.145.101:9867";
  // static String getTransactionHistory = '$baseURL/bid/getByUserId';
  // base urls
  //
  // // live url
  // static String baseURL = "http://43.205.145.101:9867";
  // static String baseURL = "http://65.0.132.151:9869";
  static String baseURL = "http://35.154.94.107:9869";
  // local url
  //static String baseURL = "http://192.168.1.5:8082";

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
  static String getBankDetails = '$baseURL/bank/getByUserId/';
  static String editBankDetails = '$baseURL/bank/createOrUpdate';
  static String getDailyMarkets = '$baseURL/market/getDailyMarket';
  static String getGameModes =
      '$baseURL/market/getGameModeForMarket/'; //pass 0 for open 1 for close then pass market id like 0/4
  static String getStarLineGameModes =
      '$baseURL/starline/getGameModeForStarlineMarket/'; //pass 0 for open 1 for close then pass market id like 0/4
  static String createMarketBid = '$baseURL/bid/marketBidcreate';
  static String createStarLineMarketBid = '$baseURL/bid/starlineBidCreate';
  static String getDailyStarLineMarkets =
      '$baseURL/starline/getDailyStarlineMarket';
  static String createWithdrawalRequest = '$baseURL/withdraw/createRequest';
  static String getWithdrawalRequestTime = '$baseURL/withdraw/getRequestTime';
  static String getWithdrawalHistoryByUserId =
      '$baseURL/withdraw/getRequestByUserId/';
  static String getStarlineGameRates = '$baseURL/game/getAll/';
  static String createFeedback = '$baseURL/feedback/create';
  static String getFeedbackAndRatingsById = '$baseURL/feedback/getById/';
  static String getTransactionHistory = '$baseURL/bid/getByUserId';
  static String verifyMPIN = '$baseURL/auth/mPin/verify';
  static String forgotMPIN = '$baseURL/auth/mPin/forgot';

  // new api endpoints
  static String setUserDetails = '$baseURL/auth/setUserDetails';
  static String setDeviceDetails = '$baseURL/auth/setDeviceDetails';
  static String setMPIN = '$baseURL/auth/mPin/set';
  static String getBalance = '$baseURL/wallet/getBalance';
  static String normalMarketBidHistory = '$baseURL/bid/getByUserId';
  static String starlineMarketBidHistory = '$baseURL/bid/starline/getByUserId';
  static String changeMPIN = "$baseURL/auth/mPin/change";
  static String webStarLinechar = "$baseURL/web/starlineChart";
  static String dailyStarlineMarketBidHistory =
      "$baseURL/bid/getAllBidByDailyStarlineMarketId";
}
