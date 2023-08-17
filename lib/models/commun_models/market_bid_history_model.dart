class MarkethistoryModel {
  String? message;
  bool? status;
  List<MarketData2>? data;

  MarkethistoryModel({this.message, this.status, this.data});

  MarkethistoryModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <MarketData2>[];
      json['data'].forEach((v) {
        data!.add(MarketData2.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MarketData2 {
  int? id;
  int? totalBidAmount;
  int? totalWonAmount;
  String? marketName;
  Null? openResult;
  Null? closeResult;
  String? openTime;
  String? closeTime;

  MarketData2(
      {this.id,
      this.totalBidAmount,
      this.totalWonAmount,
      this.marketName,
      this.openResult,
      this.closeResult,
      this.openTime,
      this.closeTime});

  MarketData2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalBidAmount = json['totalBidAmount'];
    totalWonAmount = json['totalWonAmount'];
    marketName = json['marketName'];
    openResult = json['openResult'];
    closeResult = json['closeResult'];
    openTime = json['openTime'];
    closeTime = json['closeTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['totalBidAmount'] = this.totalBidAmount;
    data['totalWonAmount'] = this.totalWonAmount;
    data['marketName'] = this.marketName;
    data['openResult'] = this.openResult;
    data['closeResult'] = this.closeResult;
    data['openTime'] = this.openTime;
    data['closeTime'] = this.closeTime;
    return data;
  }
}
