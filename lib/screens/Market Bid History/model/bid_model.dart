class BidModel {
  String? message;
  bool? status;
  Data? data;

  BidModel({this.message, this.status, this.data});

  BidModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? count;
  List<Rows>? rows;

  Data({this.count, this.rows});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <Rows>[];
      json['rows'].forEach((v) {
        rows!.add(new Rows.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.rows != null) {
      data['rows'] = this.rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rows {
  String? id;
  String? bidType;
  String? bidNo;
  int? coins;
  String? remarks;
  int? balance;
  int? winAmount;
  bool? isWin;
  String? bidTime;
  Game? game;

  Rows(
      {this.id,
      this.bidType,
      this.bidNo,
      this.coins,
      this.remarks,
      this.balance,
      this.winAmount,
      this.isWin,
      this.bidTime,
      this.game});

  Rows.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bidType = json['BidType'];
    bidNo = json['BidNo'];
    coins = json['Coins'];
    remarks = json['Remarks'];
    balance = json['Balance'];
    winAmount = json['WinAmount'];
    isWin = json['IsWin'];
    bidTime = json['BidTime'];
    game = json['Game'] != null ? new Game.fromJson(json['Game']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['BidType'] = this.bidType;
    data['BidNo'] = this.bidNo;
    data['Coins'] = this.coins;
    data['Remarks'] = this.remarks;
    data['Balance'] = this.balance;
    data['WinAmount'] = this.winAmount;
    data['IsWin'] = this.isWin;
    data['BidTime'] = this.bidTime;
    if (this.game != null) {
      data['Game'] = this.game!.toJson();
    }
    return data;
  }
}

class Game {
  String? name;

  Game({this.name});

  Game.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    return data;
  }
}
