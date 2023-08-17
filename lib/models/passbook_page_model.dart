/// message : ""
/// status : true
/// data : {"count":21,"rows":[{"id":"59","UserId":2,"ProcessedBy":"admin","BidType":null,"BidNo":null,"TransactionType":"Debit","Debit":25,"Credit":null,"PreviousAmount":140,"Remarks":"Amount debited","MarketName":null,"MarketOpenTime":null,"MarketCloseTime":null,"ModeName":"","Balance":115,"createdAt":"2023-08-08T09:30:42.622Z"},{"id":"58","UserId":2,"ProcessedBy":"admin","BidType":null,"BidNo":null,"TransactionType":"Deposit","Debit":null,"Credit":5,"PreviousAmount":135,"Remarks":"Amount credited","MarketName":null,"MarketOpenTime":null,"MarketCloseTime":null,"ModeName":"","Balance":140,"createdAt":"2023-08-08T09:30:10.440Z"},{"id":"57","UserId":2,"ProcessedBy":"admin","BidType":null,"BidNo":null,"TransactionType":"Deposit","Debit":null,"Credit":55,"PreviousAmount":80,"Remarks":"Amount credited","MarketName":null,"MarketOpenTime":null,"MarketCloseTime":null,"ModeName":"","Balance":135,"createdAt":"2023-08-08T09:28:48.348Z"},{"id":"55","UserId":2,"ProcessedBy":"","BidType":"Open","BidNo":"8","TransactionType":"Bid","Debit":20,"Credit":null,"PreviousAmount":100,"Remarks":"You invested At Shridevi (Singal Ank)","MarketName":"MidNightMarket - 1","MarketOpenTime":"23:30:00","MarketCloseTime":"00:30:00","ModeName":"Jodi Digit","Balance":80,"createdAt":"2023-08-02T12:32:27.195Z"},{"id":"54","UserId":2,"ProcessedBy":"subadmin1","BidType":null,"BidNo":null,"TransactionType":"Deposit","Debit":null,"Credit":100,"PreviousAmount":0,"Remarks":"Amount credited","MarketName":null,"MarketOpenTime":null,"MarketCloseTime":null,"ModeName":"","Balance":100,"createdAt":"2023-08-02T12:12:31.849Z"},{"id":"53","UserId":2,"ProcessedBy":"","BidType":null,"BidNo":null,"TransactionType":"Withdraw","Debit":990,"Credit":null,"PreviousAmount":990,"Remarks":"Withdrawal of 990 coins On 02-08-2023","MarketName":null,"MarketOpenTime":null,"MarketCloseTime":null,"ModeName":"","Balance":0,"createdAt":"2023-08-02T12:08:24.118Z"},{"id":"52","UserId":2,"ProcessedBy":"","BidType":null,"BidNo":null,"TransactionType":"Withdraw","Debit":990,"Credit":null,"PreviousAmount":-10,"Remarks":"Withdrawal of 990 coins On 02-08-2023","MarketName":null,"MarketOpenTime":null,"MarketCloseTime":null,"ModeName":"","Balance":-1000,"createdAt":"2023-08-02T12:06:13.477Z"},{"id":"51","UserId":2,"ProcessedBy":"","BidType":null,"BidNo":null,"TransactionType":"Withdraw","Debit":990,"Credit":null,"PreviousAmount":260,"Remarks":"Withdrawal of 990 coins On 02-08-2023","MarketName":null,"MarketOpenTime":null,"MarketCloseTime":null,"ModeName":"","Balance":-730,"createdAt":"2023-08-02T12:03:36.139Z"},{"id":"50","UserId":2,"ProcessedBy":"","BidType":null,"BidNo":null,"TransactionType":"Withdraw","Debit":990,"Credit":null,"PreviousAmount":1260,"Remarks":"Withdrawal of 990 coins On 02-08-2023","MarketName":null,"MarketOpenTime":null,"MarketCloseTime":null,"ModeName":"","Balance":270,"createdAt":"2023-08-02T11:53:12.599Z"},{"id":"48","UserId":2,"ProcessedBy":"subadmin1","BidType":null,"BidNo":null,"TransactionType":"DebitToCredit","Debit":230,"Credit":null,"PreviousAmount":1270,"Remarks":"230 transferred to null","MarketName":null,"MarketOpenTime":null,"MarketCloseTime":null,"ModeName":"","Balance":1270,"createdAt":"2023-08-02T09:55:06.061Z"}]}

class PassbookModel {
  PassbookModel({
    String? message,
    bool? status,
    Data3? data,
  }) {
    _message = message;
    _status = status;
    _data = data;
  }

  PassbookModel.fromJson(dynamic json) {
    _message = json['message'];
    _status = json['status'];
    _data = json['data'] != null ? Data3.fromJson(json['data']) : null;
  }
  String? _message;
  bool? _status;
  Data3? _data;
  PassbookModel copyWith({
    String? message,
    bool? status,
    Data3? data,
  }) =>
      PassbookModel(
        message: message ?? _message,
        status: status ?? _status,
        data: data ?? _data,
      );
  String? get message => _message;
  bool? get status => _status;
  Data3? get data => _data;

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

/// count : 21
/// rows : [{"id":"59","UserId":2,"ProcessedBy":"admin","BidType":null,"BidNo":null,"TransactionType":"Debit","Debit":25,"Credit":null,"PreviousAmount":140,"Remarks":"Amount debited","MarketName":null,"MarketOpenTime":null,"MarketCloseTime":null,"ModeName":"","Balance":115,"createdAt":"2023-08-08T09:30:42.622Z"},{"id":"58","UserId":2,"ProcessedBy":"admin","BidType":null,"BidNo":null,"TransactionType":"Deposit","Debit":null,"Credit":5,"PreviousAmount":135,"Remarks":"Amount credited","MarketName":null,"MarketOpenTime":null,"MarketCloseTime":null,"ModeName":"","Balance":140,"createdAt":"2023-08-08T09:30:10.440Z"},{"id":"57","UserId":2,"ProcessedBy":"admin","BidType":null,"BidNo":null,"TransactionType":"Deposit","Debit":null,"Credit":55,"PreviousAmount":80,"Remarks":"Amount credited","MarketName":null,"MarketOpenTime":null,"MarketCloseTime":null,"ModeName":"","Balance":135,"createdAt":"2023-08-08T09:28:48.348Z"},{"id":"55","UserId":2,"ProcessedBy":"","BidType":"Open","BidNo":"8","TransactionType":"Bid","Debit":20,"Credit":null,"PreviousAmount":100,"Remarks":"You invested At Shridevi (Singal Ank)","MarketName":"MidNightMarket - 1","MarketOpenTime":"23:30:00","MarketCloseTime":"00:30:00","ModeName":"Jodi Digit","Balance":80,"createdAt":"2023-08-02T12:32:27.195Z"},{"id":"54","UserId":2,"ProcessedBy":"subadmin1","BidType":null,"BidNo":null,"TransactionType":"Deposit","Debit":null,"Credit":100,"PreviousAmount":0,"Remarks":"Amount credited","MarketName":null,"MarketOpenTime":null,"MarketCloseTime":null,"ModeName":"","Balance":100,"createdAt":"2023-08-02T12:12:31.849Z"},{"id":"53","UserId":2,"ProcessedBy":"","BidType":null,"BidNo":null,"TransactionType":"Withdraw","Debit":990,"Credit":null,"PreviousAmount":990,"Remarks":"Withdrawal of 990 coins On 02-08-2023","MarketName":null,"MarketOpenTime":null,"MarketCloseTime":null,"ModeName":"","Balance":0,"createdAt":"2023-08-02T12:08:24.118Z"},{"id":"52","UserId":2,"ProcessedBy":"","BidType":null,"BidNo":null,"TransactionType":"Withdraw","Debit":990,"Credit":null,"PreviousAmount":-10,"Remarks":"Withdrawal of 990 coins On 02-08-2023","MarketName":null,"MarketOpenTime":null,"MarketCloseTime":null,"ModeName":"","Balance":-1000,"createdAt":"2023-08-02T12:06:13.477Z"},{"id":"51","UserId":2,"ProcessedBy":"","BidType":null,"BidNo":null,"TransactionType":"Withdraw","Debit":990,"Credit":null,"PreviousAmount":260,"Remarks":"Withdrawal of 990 coins On 02-08-2023","MarketName":null,"MarketOpenTime":null,"MarketCloseTime":null,"ModeName":"","Balance":-730,"createdAt":"2023-08-02T12:03:36.139Z"},{"id":"50","UserId":2,"ProcessedBy":"","BidType":null,"BidNo":null,"TransactionType":"Withdraw","Debit":990,"Credit":null,"PreviousAmount":1260,"Remarks":"Withdrawal of 990 coins On 02-08-2023","MarketName":null,"MarketOpenTime":null,"MarketCloseTime":null,"ModeName":"","Balance":270,"createdAt":"2023-08-02T11:53:12.599Z"},{"id":"48","UserId":2,"ProcessedBy":"subadmin1","BidType":null,"BidNo":null,"TransactionType":"DebitToCredit","Debit":230,"Credit":null,"PreviousAmount":1270,"Remarks":"230 transferred to null","MarketName":null,"MarketOpenTime":null,"MarketCloseTime":null,"ModeName":"","Balance":1270,"createdAt":"2023-08-02T09:55:06.061Z"}]

class Data3 {
  Data3({
    num? count,
    List<Rows>? rows,
  }) {
    _count = count;
    _rows = rows;
  }

  Data3.fromJson(dynamic json) {
    _count = json['count'];
    if (json['rows'] != null) {
      _rows = [];
      json['rows'].forEach((v) {
        _rows?.add(Rows.fromJson(v));
      });
    }
  }
  num? _count;
  List<Rows>? _rows;
  Data3 copyWith({
    num? count,
    List<Rows>? rows,
  }) =>
      Data3(
        count: count ?? _count,
        rows: rows ?? _rows,
      );
  num? get count => _count;
  List<Rows>? get rows => _rows;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = _count;
    if (_rows != null) {
      map['rows'] = _rows?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "59"
/// UserId : 2
/// ProcessedBy : "admin"
/// BidType : null
/// BidNo : null
/// TransactionType : "Debit"
/// Debit : 25
/// Credit : null
/// PreviousAmount : 140
/// Remarks : "Amount debited"
/// MarketName : null
/// MarketOpenTime : null
/// MarketCloseTime : null
/// ModeName : ""
/// Balance : 115
/// createdAt : "2023-08-08T09:30:42.622Z"

class Rows {
  Rows({
    String? id,
    num? userId,
    String? processedBy,
    dynamic bidType,
    dynamic bidNo,
    String? transactionType,
    num? debit,
    dynamic credit,
    num? previousAmount,
    String? remarks,
    dynamic marketName,
    dynamic marketOpenTime,
    dynamic marketCloseTime,
    String? modeName,
    num? balance,
    String? createdAt,
    String? marketTime,
  }) {
    _id = id;
    _userId = userId;
    _processedBy = processedBy;
    _bidType = bidType;
    _bidNo = bidNo;
    _transactionType = transactionType;
    _debit = debit;
    _credit = credit;
    _previousAmount = previousAmount;
    _remarks = remarks;
    _marketName = marketName;
    _marketOpenTime = marketOpenTime;
    _marketCloseTime = marketCloseTime;
    _modeName = modeName;
    _balance = balance;
    _createdAt = createdAt;
    _marketTime = marketTime;
  }

  Rows.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['UserId'];
    _processedBy = json['ProcessedBy'];
    _bidType = json['BidType'];
    _bidNo = json['BidNo'];
    _transactionType = json['TransactionType'];
    _debit = json['Debit'];
    _credit = json['Credit'];
    _previousAmount = json['PreviousAmount'];
    _remarks = json['Remarks'];
    _marketName = json['MarketName'];
    _marketOpenTime = json['MarketOpenTime'];
    _marketCloseTime = json['MarketCloseTime'];
    _modeName = json['ModeName'];
    _balance = json['Balance'];
    _createdAt = json['createdAt'];
    _marketTime = json['MarketTime'];
  }
  String? _id;
  num? _userId;
  String? _processedBy;
  dynamic _bidType;
  dynamic _bidNo;
  String? _transactionType;
  num? _debit;
  dynamic _credit;
  num? _previousAmount;
  String? _remarks;
  dynamic _marketName;
  dynamic _marketOpenTime;
  dynamic _marketCloseTime;
  String? _modeName;
  num? _balance;
  String? _createdAt;
  String? _marketTime;
  Rows copyWith({
    String? id,
    num? userId,
    String? processedBy,
    dynamic bidType,
    dynamic bidNo,
    String? transactionType,
    num? debit,
    dynamic credit,
    num? previousAmount,
    String? remarks,
    dynamic marketName,
    dynamic marketOpenTime,
    dynamic marketCloseTime,
    String? modeName,
    num? balance,
    String? createdAt,
    String? marketTime,
  }) =>
      Rows(
        id: id ?? _id,
        userId: userId ?? _userId,
        processedBy: processedBy ?? _processedBy,
        bidType: bidType ?? _bidType,
        bidNo: bidNo ?? _bidNo,
        transactionType: transactionType ?? _transactionType,
        debit: debit ?? _debit,
        credit: credit ?? _credit,
        previousAmount: previousAmount ?? _previousAmount,
        remarks: remarks ?? _remarks,
        marketName: marketName ?? _marketName,
        marketOpenTime: marketOpenTime ?? _marketOpenTime,
        marketCloseTime: marketCloseTime ?? _marketCloseTime,
        modeName: modeName ?? _modeName,
        balance: balance ?? _balance,
        createdAt: createdAt ?? _createdAt,
        marketTime: marketTime ?? _marketTime,
      );
  String? get id => _id;
  num? get userId => _userId;
  String? get processedBy => _processedBy;
  dynamic get bidType => _bidType;
  dynamic get bidNo => _bidNo;
  String? get transactionType => _transactionType;
  num? get debit => _debit;
  dynamic get credit => _credit;
  num? get previousAmount => _previousAmount;
  String? get remarks => _remarks;
  dynamic get marketName => _marketName;
  dynamic get marketOpenTime => _marketOpenTime;
  dynamic get marketCloseTime => _marketCloseTime;
  String? get modeName => _modeName;
  num? get balance => _balance;
  String? get createdAt => _createdAt;
  String? get marketTime => _marketTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['UserId'] = _userId;
    map['ProcessedBy'] = _processedBy;
    map['BidType'] = _bidType;
    map['BidNo'] = _bidNo;
    map['TransactionType'] = _transactionType;
    map['Debit'] = _debit;
    map['Credit'] = _credit;
    map['PreviousAmount'] = _previousAmount;
    map['Remarks'] = _remarks;
    map['MarketName'] = _marketName;
    map['MarketOpenTime'] = _marketOpenTime;
    map['MarketCloseTime'] = _marketCloseTime;
    map['ModeName'] = _modeName;
    map['Balance'] = _balance;
    map['createdAt'] = _createdAt;
    map['MarketTime'] = _marketTime;
    return map;
  }
}
