class TransactionHistoryApiResponseModel {
  TransactionHistoryApiResponseModel({
    String? message,
    bool? status,
    Data? data,
  }) {
    _message = message;
    _status = status;
    _data = data;
  }

  TransactionHistoryApiResponseModel.fromJson(dynamic json) {
    _message = json['message'];
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _message;
  bool? _status;
  Data? _data;
  TransactionHistoryApiResponseModel copyWith({
    String? message,
    bool? status,
    Data? data,
  }) =>
      TransactionHistoryApiResponseModel(
        message: message ?? _message,
        status: status ?? _status,
        data: data ?? _data,
      );
  String? get message => _message;
  bool? get status => _status;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// count : 216
/// resultArr : [{"BidType":"Open","BidNo":"60","Coins":10,"Balance":1940,"BidTime":"2023-07-19T03:25:42.236Z","GameMode":"Jodi Digit","MarketName":"MILAN MORNING","OpenTime":"10:00:00","CloseTime":"11:00:00","IsWin":false,"TransactionType":"Bid","Remarks":"You invested At MADHUR  on 60 (Jodi Digit)","IsResultDeclared":true},{"BidType":"Open","BidNo":"35","Coins":10,"Balance":1950,"BidTime":"2023-07-19T03:25:42.236Z","GameMode":"Jodi Digit","MarketName":"MILAN MORNING","OpenTime":"10:00:00","CloseTime":"11:00:00","IsWin":false,"TransactionType":"Bid","Remarks":"You invested At MADHUR  on 35 (Jodi Digit)","IsResultDeclared":true},{"BidType":"Open","BidNo":"69","Coins":10,"Balance":230,"BidTime":"2023-07-19T03:25:42.236Z","GameMode":"Jodi Digit","MarketName":"MILAN MORNING","OpenTime":"10:00:00","CloseTime":"11:00:00","IsWin":false,"TransactionType":"Bid","Remarks":"You invested At MADHUR  on 69 (Jodi Digit)","IsResultDeclared":true},{"BidType":"Open","BidNo":"60","Coins":10,"Balance":220,"BidTime":"2023-07-19T03:25:42.236Z","GameMode":"Jodi Digit","MarketName":"MILAN MORNING","OpenTime":"10:00:00","CloseTime":"11:00:00","IsWin":false,"TransactionType":"Bid","Remarks":"You invested At MADHUR  on 60 (Jodi Digit)","IsResultDeclared":true},{"BidType":"Open","BidNo":"63","Coins":10,"Balance":240,"BidTime":"2023-07-19T03:25:42.236Z","GameMode":"Jodi Digit","MarketName":"MILAN MORNING","OpenTime":"10:00:00","CloseTime":"11:00:00","IsWin":false,"TransactionType":"Bid","Remarks":"You invested At MADHUR  on 63 (Jodi Digit)","IsResultDeclared":true},{"BidType":"Open","BidNo":"31","Coins":10,"Balance":350,"BidTime":"2023-07-19T03:25:42.236Z","GameMode":"Jodi Digit","MarketName":"MILAN MORNING","OpenTime":"10:00:00","CloseTime":"11:00:00","IsWin":false,"TransactionType":"Bid","Remarks":"You invested At MADHUR  on 31 (Jodi Digit)","IsResultDeclared":true},{"BidType":"Open","BidNo":"21","Coins":10,"Balance":400,"BidTime":"2023-07-19T03:25:42.236Z","GameMode":"Jodi Digit","MarketName":"MILAN MORNING","OpenTime":"10:00:00","CloseTime":"11:00:00","IsWin":false,"TransactionType":"Bid","Remarks":"You invested At MADHUR  on 21 (Jodi Digit)","IsResultDeclared":true},{"BidType":"Open","BidNo":"45","Coins":10,"Balance":280,"BidTime":"2023-07-19T03:25:42.236Z","GameMode":"Jodi Digit","MarketName":"MILAN MORNING","OpenTime":"10:00:00","CloseTime":"11:00:00","IsWin":false,"TransactionType":"Bid","Remarks":"You invested At MADHUR  on 45 (Jodi Digit)","IsResultDeclared":true},{"BidType":"Open","BidNo":"49","Coins":10,"Balance":300,"BidTime":"2023-07-19T03:25:42.236Z","GameMode":"Jodi Digit","MarketName":"MILAN MORNING","OpenTime":"10:00:00","CloseTime":"11:00:00","IsWin":false,"TransactionType":"Bid","Remarks":"You invested At MADHUR  on 49 (Jodi Digit)","IsResultDeclared":true},{"BidType":"Open","BidNo":"55","Coins":10,"Balance":260,"BidTime":"2023-07-19T03:25:42.236Z","GameMode":"Jodi Digit","MarketName":"MILAN MORNING","OpenTime":"10:00:00","CloseTime":"11:00:00","IsWin":false,"TransactionType":"Bid","Remarks":"You invested At MADHUR  on 55 (Jodi Digit)","IsResultDeclared":true}]

class Data {
  Data({
    dynamic count,
    List<ResultArr>? resultArr,
  }) {
    _count = count;
    _resultArr = resultArr;
  }

  Data.fromJson(dynamic json) {
    _count = json['count'];
    if (json['rows'] != null) {
      _resultArr = [];
      json['rows'].forEach((v) {
        _resultArr?.add(ResultArr.fromJson(v));
      });
    } else {
      _resultArr = [];
    }
  }
  int? _count;
  List<ResultArr>? _resultArr;
  Data copyWith({
    int? count,
    List<ResultArr>? resultArr,
  }) =>
      Data(
        count: count ?? _count,
        resultArr: resultArr ?? _resultArr,
      );
  int? get count => _count;
  List<ResultArr>? get resultArr => _resultArr;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = _count;
    if (_resultArr != null) {
      map['rows'] = _resultArr?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// BidType : "Open"
/// BidNo : "60"
/// Coins : 10
/// Balance : 1940
/// BidTime : "2023-07-19T03:25:42.236Z"
/// GameMode : "Jodi Digit"
/// MarketName : "MILAN MORNING"
/// OpenTime : "10:00:00"
/// CloseTime : "11:00:00"
/// IsWin : false
/// TransactionType : "Bid"
/// Remarks : "You invested At MADHUR  on 60 (Jodi Digit)"
/// IsResultDeclared : true

class ResultArr {
  ResultArr({
    String? bidType,
    String? bidNo,
    int? coins,
    int? balance,
    String? bidTime,
    String? gameMode,
    String? marketName,
    String? openTime,
    String? closeTime,
    bool? isWin,
    String? transactionType,
    String? remarks,
    bool? isResultDeclared,
  }) {
    _bidType = bidType;
    _bidNo = bidNo;
    _coins = coins;
    _balance = balance;
    _bidTime = bidTime;
    _gameMode = gameMode;
    _marketName = marketName;
    _openTime = openTime;
    _closeTime = closeTime;
    _isWin = isWin;
    _transactionType = transactionType;
    _remarks = remarks;
    _isResultDeclared = isResultDeclared;
  }

  ResultArr.fromJson(dynamic json) {
    _bidType = json['BidType'];
    _bidNo = json['BidNo'];
    _coins = json['Coins'];
    _balance = json['Balance'];
    _bidTime = json['BidTime'];
    _gameMode = json['GameMode'];
    _marketName = json['MarketName'];
    _openTime = json['OpenTime'];
    _closeTime = json['CloseTime'];
    _isWin = json['IsWin'];
    _transactionType = json['TransactionType'];
    _remarks = json['Remarks'];
    _isResultDeclared = json['IsResultDeclared'];
  }
  String? _bidType;
  String? _bidNo;
  int? _coins;
  int? _balance;
  String? _bidTime;
  String? _gameMode;
  String? _marketName;
  String? _openTime;
  String? _closeTime;
  bool? _isWin;
  String? _transactionType;
  String? _remarks;
  bool? _isResultDeclared;
  ResultArr copyWith({
    String? bidType,
    String? bidNo,
    int? coins,
    int? balance,
    String? bidTime,
    String? gameMode,
    String? marketName,
    String? openTime,
    String? closeTime,
    bool? isWin,
    String? transactionType,
    String? remarks,
    bool? isResultDeclared,
  }) =>
      ResultArr(
        bidType: bidType ?? _bidType,
        bidNo: bidNo ?? _bidNo,
        coins: coins ?? _coins,
        balance: balance ?? _balance,
        bidTime: bidTime ?? _bidTime,
        gameMode: gameMode ?? _gameMode,
        marketName: marketName ?? _marketName,
        openTime: openTime ?? _openTime,
        closeTime: closeTime ?? _closeTime,
        isWin: isWin ?? _isWin,
        transactionType: transactionType ?? _transactionType,
        remarks: remarks ?? _remarks,
        isResultDeclared: isResultDeclared ?? _isResultDeclared,
      );
  String? get bidType => _bidType;
  String? get bidNo => _bidNo;
  int? get coins => _coins;
  int? get balance => _balance;
  String? get bidTime => _bidTime;
  String? get gameMode => _gameMode;
  String? get marketName => _marketName;
  String? get openTime => _openTime;
  String? get closeTime => _closeTime;
  bool? get isWin => _isWin;
  String? get transactionType => _transactionType;
  String? get remarks => _remarks;
  bool? get isResultDeclared => _isResultDeclared;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['BidType'] = _bidType;
    map['BidNo'] = _bidNo;
    map['Coins'] = _coins;
    map['Balance'] = _balance;
    map['BidTime'] = _bidTime;
    map['GameMode'] = _gameMode;
    map['MarketName'] = _marketName;
    map['OpenTime'] = _openTime;
    map['CloseTime'] = _closeTime;
    map['IsWin'] = _isWin;
    map['TransactionType'] = _transactionType;
    map['Remarks'] = _remarks;
    map['IsResultDeclared'] = _isResultDeclared;
    return map;
  }
}
