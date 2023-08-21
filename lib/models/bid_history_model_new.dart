/// message : ""
/// status : true
/// data : [{"id":50,"totalBidAmount":420,"totalWonAmount":0,"marketName":"SRIDEVI NIGHT","openResult":null,"closeResult":null,"openTime":"19:15:00","closeTime":"20:15:00"},{"id":200,"totalBidAmount":84,"totalWonAmount":0,"marketName":"MILAN DAY","openResult":null,"closeResult":null,"openTime":"15:10:00","closeTime":"17:15:00"},{"id":198,"totalBidAmount":83,"totalWonAmount":0,"marketName":"RAJDHANI DAY","openResult":null,"closeResult":null,"openTime":"15:10:00","closeTime":"17:10:00"},{"id":204,"totalBidAmount":81,"totalWonAmount":0,"marketName":"SUPREME NIGHT ","openResult":null,"closeResult":null,"openTime":"20:45:00","closeTime":"22:45:00"},{"id":171,"totalBidAmount":80,"totalWonAmount":0,"marketName":"SUPREME DAY","openResult":null,"closeResult":null,"openTime":"15:30:00","closeTime":"17:30:00"},{"id":170,"totalBidAmount":71,"totalWonAmount":0,"marketName":"MADHUR DAY","openResult":null,"closeResult":null,"openTime":"13:40:00","closeTime":"14:40:00"},{"id":143,"totalBidAmount":23,"totalWonAmount":0,"marketName":"MADHUR NIGHT ","openResult":null,"closeResult":null,"openTime":"20:40:00","closeTime":"22:40:00"},{"id":223,"totalBidAmount":10,"totalWonAmount":0,"marketName":"MILAN MORNING","openResult":null,"closeResult":null,"openTime":"10:20:00","closeTime":"11:20:00"}]

class Bidhistorymodel {
  Bidhistorymodel({
    String? message,
    bool? status,
    List<BidHistoryNew>? data,
  }) {
    _message = message;
    _status = status;
    _data = data;
  }

  Bidhistorymodel.fromJson(dynamic json) {
    _message = json['message'];
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(BidHistoryNew.fromJson(v));
      });
    }
  }
  String? _message;
  bool? _status;
  List<BidHistoryNew>? _data;
  Bidhistorymodel copyWith({
    String? message,
    bool? status,
    List<BidHistoryNew>? data,
  }) =>
      Bidhistorymodel(
        message: message ?? _message,
        status: status ?? _status,
        data: data ?? _data,
      );
  String? get message => _message;
  bool? get status => _status;
  List<BidHistoryNew>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 50
/// totalBidAmount : 420
/// totalWonAmount : 0
/// marketName : "SRIDEVI NIGHT"
/// openResult : null
/// closeResult : null
/// openTime : "19:15:00"
/// closeTime : "20:15:00"

class BidHistoryNew {
  BidHistoryNew({
    num? id,
    num? totalBidAmount,
    num? totalWonAmount,
    String? marketName,
    dynamic openResult,
    dynamic closeResult,
    String? openTime,
    String? closeTime,
    String? result,
  }) {
    _id = id;
    _totalBidAmount = totalBidAmount;
    _totalWonAmount = totalWonAmount;
    _marketName = marketName;
    _openResult = openResult;
    _closeResult = closeResult;
    _openTime = openTime;
    _closeTime = closeTime;
    _result = result;
  }

  BidHistoryNew.fromJson(dynamic json) {
    _id = json['id'];
    _totalBidAmount = json['totalBidAmount'];
    _totalWonAmount = json['totalWonAmount'];
    _marketName = json['marketName'];
    _openResult = json['openResult'];
    _closeResult = json['closeResult'];
    _openTime = json['openTime'];
    _closeTime = json['closeTime'];
    _result = json['result'];
  }
  num? _id;
  num? _totalBidAmount;
  num? _totalWonAmount;
  String? _marketName;
  dynamic _openResult;
  dynamic _closeResult;
  String? _openTime;
  String? _closeTime;
  String? _result;
  BidHistoryNew copyWith({
    num? id,
    num? totalBidAmount,
    num? totalWonAmount,
    String? marketName,
    dynamic openResult,
    dynamic closeResult,
    String? openTime,
    String? closeTime,
    String? result,
  }) =>
      BidHistoryNew(
        id: id ?? _id,
        totalBidAmount: totalBidAmount ?? _totalBidAmount,
        totalWonAmount: totalWonAmount ?? _totalWonAmount,
        marketName: marketName ?? _marketName,
        openResult: openResult ?? _openResult,
        closeResult: closeResult ?? _closeResult,
        openTime: openTime ?? _openTime,
        closeTime: closeTime ?? _closeTime,
        result: result ?? _result,
      );
  num? get id => _id;
  num? get totalBidAmount => _totalBidAmount;
  num? get totalWonAmount => _totalWonAmount;
  String? get marketName => _marketName;
  dynamic get openResult => _openResult;
  dynamic get closeResult => _closeResult;
  String? get openTime => _openTime;
  String? get closeTime => _closeTime;
  String? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['totalBidAmount'] = _totalBidAmount;
    map['totalWonAmount'] = _totalWonAmount;
    map['marketName'] = _marketName;
    map['openResult'] = _openResult;
    map['closeResult'] = _closeResult;
    map['openTime'] = _openTime;
    map['closeTime'] = _closeTime;
    map['result'] = _result;
    return map;
  }
}
