/// message : ""
/// status : true
/// data : {"count":1,"rows":[{"id":"448","BidType":"Close","BidNo":"1","Coins":3,"Remarks":"You invested At MILAN MORNING on 1 (Single Ank)","Balance":155,"WinAmount":0,"IsWin":false,"BidTime":"2023-08-10T04:50:35.090Z","Game":{"Name":"Single Ank"}}]}

class NewBidhistorypageModel {
  NewBidhistorypageModel({
    String? message,
    bool? status,
    Data2? data,
  }) {
    _message = message;
    _status = status;
    _data = data;
  }

  NewBidhistorypageModel.fromJson(dynamic json) {
    _message = json['message'];
    _status = json['status'];
    if (json['data'] != null) {
      _data = Data2.fromJson(json['data']);
    }
  }
  String? _message;
  bool? _status;
  Data2? _data;
  NewBidhistorypageModel copyWith({
    String? message,
    bool? status,
    Data2? data,
  }) =>
      NewBidhistorypageModel(
        message: message ?? _message,
        status: status ?? _status,
        data: data ?? _data,
      );
  String? get message => _message;
  bool? get status => _status;
  Data2? get data => _data;

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

class Data2 {
  Data2({
    dynamic count,
    List<Rows>? rows,
  }) {
    _count = count;
    _rows = rows;
  }

  Data2.fromJson(dynamic json) {
    _count = json['count'];
    if (json['rows'] != null) {
      _rows = [];
      json['rows'].forEach((v) {
        _rows?.add(Rows.fromJson(v));
      });
    }
  }
  dynamic _count;
  List<Rows>? _rows;
  Data2 copyWith({
    dynamic count,
    List<Rows>? rows,
  }) =>
      Data2(
        count: count ?? _count,
        rows: rows ?? _rows,
      );
  dynamic get count => _count;
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

/// id : "448"
/// BidType : "Close"
/// BidNo : "1"
/// Coins : 3
/// Remarks : "You invested At MILAN MORNING on 1 (Single Ank)"
/// Balance : 155
/// WinAmount : 0
/// IsWin : false
/// BidTime : "2023-08-10T04:50:35.090Z"
/// Game : {"Name":"Single Ank"}

class Rows {
  Rows({
    String? id,
    String? bidType,
    String? bidNo,
    num? coins,
    String? remarks,
    num? balance,
    num? winAmount,
    bool? isWin,
    String? bidTime,
    Game? game,
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
    _game = game;
  }

  Rows.fromJson(dynamic json) {
    _id = json['id'];
    _bidType = json['BidType'];
    _bidNo = json['BidNo'];
    _coins = json['Coins'];
    _remarks = json['Remarks'];
    _balance = json['Balance'];
    _winAmount = json['WinAmount'];
    _isWin = json['IsWin'];
    _bidTime = json['BidTime'];
    _game = json['Game'] != null ? Game.fromJson(json['Game']) : null;
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
  Game? _game;
  Rows copyWith({
    String? id,
    String? bidType,
    String? bidNo,
    num? coins,
    String? remarks,
    num? balance,
    num? winAmount,
    bool? isWin,
    String? bidTime,
    Game? game,
  }) =>
      Rows(
        id: id ?? _id,
        bidType: bidType ?? _bidType,
        bidNo: bidNo ?? _bidNo,
        coins: coins ?? _coins,
        remarks: remarks ?? _remarks,
        balance: balance ?? _balance,
        winAmount: winAmount ?? _winAmount,
        isWin: isWin ?? _isWin,
        bidTime: bidTime ?? _bidTime,
        game: game ?? _game,
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
  Game? get game => _game;

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
    if (_game != null) {
      map['Game'] = _game?.toJson();
    }
    return map;
  }
}

/// Name : "Single Ank"

class Game {
  Game({
    String? name,
  }) {
    _name = name;
  }

  Game.fromJson(dynamic json) {
    _name = json['Name'];
  }
  String? _name;
  Game copyWith({
    String? name,
  }) =>
      Game(
        name: name ?? _name,
      );
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Name'] = _name;
    return map;
  }
}
