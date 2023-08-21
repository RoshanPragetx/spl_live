class MarketBidHistoryModel {
  MarketBidHistoryModel({
    String? message,
    bool? status,
    MarketBidHistory? data,
  }) {
    _message = message;
    _status = status;
    _data = data;
  }

  MarketBidHistoryModel.fromJson(dynamic json) {
    _message = json['message'];
    _status = json['status'];
    if (json['data'] != null) {
      _data = MarketBidHistory.fromJson(json['data']);
    }
  }
  String? _message;
  bool? _status;
  MarketBidHistory? _data;
  MarketBidHistoryModel copyWith({
    String? message,
    bool? status,
    MarketBidHistory? data,
  }) =>
      MarketBidHistoryModel(
        message: message ?? _message,
        status: status ?? _status,
        data: data ?? _data,
      );
  String? get message => _message;
  bool? get status => _status;
  MarketBidHistory? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.toJson();
    } else {
      map['data'] = null;
    }
    return map;
  }
}

/// count : 1
/// rows : [{"id":"448","BidType":"Close","BidNo":"1","Coins":3,"Remarks":"You invested At MILAN MORNING on 1 (Single Ank)","Balance":155,"WinAmount":0,"IsWin":false,"BidTime":"2023-08-10T04:50:35.090Z","Game":{"Name":"Single Ank"}}]

class MarketBidHistory {
  MarketBidHistory({
    dynamic count,
    List<MarketBidHistoryList>? rows,
  }) {
    _count = count;
    _rows = rows;
  }

  MarketBidHistory.fromJson(dynamic json) {
    _count = json['count'];
    if (json['rows'] != null) {
      _rows = [];
      json['rows'].forEach((v) {
        _rows?.add(MarketBidHistoryList.fromJson(v));
      });
    }
  }
  dynamic _count;
  List<MarketBidHistoryList>? _rows;
  MarketBidHistory copyWith({
    dynamic count,
    List<MarketBidHistoryList>? rows,
  }) =>
      MarketBidHistory(
        count: count ?? _count,
        rows: rows ?? _rows,
      );
  dynamic get count => _count;
  List<MarketBidHistoryList>? get rows => _rows;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = _count;
    if (_rows != null) {
      map['rows'] = _rows?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}


class MarketBidHistoryList {
  MarketBidHistoryList({
    String? id,
    String? bidType,
    String? bidNo,
    num? coins,
    String? remarks,
    num? balance,
    num? winAmount,
    bool? isWin,
    String? bidTime,
    String? gameMode,
    String? marketName,
    String? openTime,
    String? closeTime,
    String? transactionType,
    bool? isResultDeclared,

  }) {
    _id = id;
    _bidType = bidType;
    _bidNo = bidNo;
    _coins = coins;
    _remarks = remarks;
    _balance = balance;
    _winAmount = winAmount;
    _isWin = isWin;
    _bidTime = bidTime;
    _gameMode = gameMode;
    _marketName = marketName;
    _openTime = openTime;
    _closeTime = closeTime;
    _transactionType = transactionType;
    _isResultDeclared = isResultDeclared;

  }

  MarketBidHistoryList.fromJson(dynamic json) {
    _id = json['id'];
    _bidType = json['BidType'];
    _bidNo = json['BidNo'];
    _coins = json['Coins'];
    _remarks = json['Remarks'];
    _balance = json['Balance'];
    _winAmount = json['WinAmount'];
    _isWin = json['IsWin'];
    _bidTime = json['BidTime'];
    _gameMode = json['GameMode'];
    _marketName = json['MarketName'];
    _openTime = json['OpenTime'];
    _closeTime = json['CloseTime'];
    _transactionType = json['TransactionType'];
    _isResultDeclared = json['IsResultDeclared'];

  }
  String? _id;
  String? _bidType;
  String? _bidNo;
  num? _coins;
  String? _remarks;
  num? _balance;
  num? _winAmount;
  bool? _isWin;
  String? _bidTime;
  String? _gameMode;
  String? _marketName;
  String? _openTime;
  String? _closeTime;
  String? _transactionType;
  bool? _isResultDeclared;

  MarketBidHistoryList copyWith({
    String? id,
    String? bidType,
    String? bidNo,
    num? coins,
    String? remarks,
    num? balance,
    num? winAmount,
    bool? isWin,
    String? bidTime,
    String? gameMode,
    String? marketName,
    String? openTime,
    String? closeTime,
    String? transactionType,
    
  }) =>
      MarketBidHistoryList(
        id: id ?? _id,
        bidType: bidType ?? _bidType,
        bidNo: bidNo ?? _bidNo,
        coins: coins ?? _coins,
        remarks: remarks ?? _remarks,
        balance: balance ?? _balance,
        winAmount: winAmount ?? _winAmount,
        isWin: isWin ?? _isWin,
        bidTime: bidTime ?? _bidTime,
        gameMode: gameMode?? _gameMode,
        marketName: marketName?? _marketName,
        openTime: openTime?? _openTime,
        closeTime: closeTime?? _closeTime,
        transactionType: transactionType?? _transactionType,
        
      );
  String? get id => _id;
  String? get bidType => _bidType;
  String? get bidNo => _bidNo;
  num? get coins => _coins;
  String? get remarks => _remarks;
  num? get balance => _balance;
  num? get winAmount => _winAmount;
  bool? get isWin => _isWin;
  String? get bidTime => _bidTime;
  String? get gameMode => _gameMode;
  String? get marketName => _marketName;
  String? get openTime => _openTime;
  String? get closeTime => _closeTime;
  String? get transactionType => _transactionType;
  bool? get isResultDeclared => _isResultDeclared;
  
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['BidType'] = _bidType;
    map['BidNo'] = _bidNo;
    map['Coins'] = _coins;
    map['Remarks'] = _remarks;
    map['Balance'] = _balance;
    map['WinAmount'] = _winAmount;
    map['IsWin'] = _isWin;
    map['BidTime'] = _bidTime;
    map['GameMode'] = _gameMode;
    map['MarketName'] = _marketName;
    map['OpenTime'] = _openTime;
    map['CloseTime'] = _closeTime;
    map['TransactionType'] = _transactionType;
    map['IsResultDeclared'] = _isResultDeclared;
    
    return map;
  }
}
