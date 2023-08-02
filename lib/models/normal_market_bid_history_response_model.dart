// class NormalMarketBidHistoryResponseModel {
//   String? message;
//   bool? status;
//   List<NormalMarketHistoryModel>? data;

//   NormalMarketBidHistoryResponseModel({this.message, this.status, this.data});

//   NormalMarketBidHistoryResponseModel.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     status = json['status'];
//     if (json['data'] != null) {
//       data = <NormalMarketHistoryModel>[];
//       json['data'].forEach((v) {
//         data!.add(NormalMarketHistoryModel.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['message'] = message;
//     data['status'] = status;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class NormalMarketHistoryModel {
//   String? bidType;
//   String? bidNo;
//   int? coins;
//   int? balance;
//   String? bidTime;
//   String? gameMode;
//   String? marketName;
//   String? openTime;
//   String? closeTime;
//   bool? isWin;
//   bool? isResultDeclared;
//   String? transactionType;
//   String? remarks;

//   NormalMarketHistoryModel(
//       {this.bidType,
//         this.bidNo,
//         this.coins,
//         this.balance,
//         this.bidTime,
//         this.gameMode,
//         this.marketName,
//         this.openTime,
//         this.closeTime,
//         this.isWin,
//         this.isResultDeclared,
//         this.transactionType,
//         this.remarks});

//   NormalMarketHistoryModel.fromJson(Map<String, dynamic> json) {
//     bidType = json['BidType'];
//     bidNo = json['BidNo'];
//     coins = json['Coins'];
//     balance = json['Balance'];
//     bidTime = json['BidTime'];
//     gameMode = json['GameMode'];
//     marketName = json['MarketName'];
//     openTime = json['OpenTime'];
//     closeTime = json['CloseTime'];
//     isWin = json['IsWin'];
//     isResultDeclared = json['IsResultDeclared'];
//     transactionType = json['TransactionType'];
//     remarks = json['Remarks'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['BidType'] = bidType;
//     data['BidNo'] = bidNo;
//     data['Coins'] = coins;
//     data['Balance'] = balance;
//     data['BidTime'] = bidTime;
//     data['GameMode'] = gameMode;
//     data['MarketName'] = marketName;
//     data['OpenTime'] = openTime;
//     data['CloseTime'] = closeTime;
//     data['IsWin'] = isWin;
//     data['IsResultDeclared'] = isResultDeclared;
//     data['TransactionType'] = transactionType;
//     data['Remarks'] = remarks;
//     return data;
//   }
// }

class NormalMarketBidHistoryResponseModel {
  final String? message;
  final bool? status;
  final dynamic data;

  NormalMarketBidHistoryResponseModel({
    this.message,
    this.status,
    this.data,
  });

  NormalMarketBidHistoryResponseModel.fromJson(Map<String, dynamic> json)
      : message = json['message'] as String?,
        status = json['status'] as bool?,
        data = (json['data']) != null ? Data.fromJson(json['data']) : null;

  Map<String, dynamic> toJson() =>
      {'message': message, 'status': status, 'data': data?.toJson()};
}

class Data {
  final int? count;
  final List<ResultArr>? resultArr;

  Data({
    this.count,
    this.resultArr,
  });

  Data.fromJson(Map<String, dynamic> json)
      : count = json['count'] as int?,
        resultArr = (json['resultArr'] as List?)
            ?.map((dynamic e) => ResultArr.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() =>
      {'count': count, 'resultArr': resultArr?.map((e) => e.toJson()).toList()};
}

class ResultArr {
  final String? bidType;
  final String? bidNo;
  final int? coins;
  final int? balance;
  final String? bidTime;
  final String? gameMode;
  final String? marketName;
  final String? openTime;
  final String? closeTime;
  final bool? isWin;
  final String? transactionType;
  final String? remarks;
  final bool? isResultDeclared;

  ResultArr({
    this.bidType,
    this.bidNo,
    this.coins,
    this.balance,
    this.bidTime,
    this.gameMode,
    this.marketName,
    this.openTime,
    this.closeTime,
    this.isWin,
    this.transactionType,
    this.remarks,
    this.isResultDeclared,
  });

  ResultArr.fromJson(Map<String, dynamic> json)
      : bidType = json['BidType'] as String?,
        bidNo = json['BidNo'] as String?,
        coins = json['Coins'] as int?,
        balance = json['Balance'] as int?,
        bidTime = json['BidTime'] as String?,
        gameMode = json['GameMode'] as String?,
        marketName = json['MarketName'] as String?,
        openTime = json['OpenTime'] as String?,
        closeTime = json['CloseTime'] as String?,
        isWin = json['IsWin'] as bool?,
        transactionType = json['TransactionType'] as String?,
        remarks = json['Remarks'] as String?,
        isResultDeclared = json['IsResultDeclared'] as bool?;

  Map<String, dynamic> toJson() => {
        'BidType': bidType,
        'BidNo': bidNo,
        'Coins': coins,
        'Balance': balance,
        'BidTime': bidTime,
        'GameMode': gameMode,
        'MarketName': marketName,
        'OpenTime': openTime,
        'CloseTime': closeTime,
        'IsWin': isWin,
        'TransactionType': transactionType,
        'Remarks': remarks,
        'IsResultDeclared': isResultDeclared
      };
}
