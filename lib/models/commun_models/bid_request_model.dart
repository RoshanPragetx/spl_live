class BidRequestModel {
  int? userId;
  int? dailyMarketId;
  String? bidType;
  List<Bids>? bids;

  BidRequestModel({this.userId, this.dailyMarketId, this.bidType, this.bids});

  BidRequestModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    dailyMarketId = json['dailyMarketId'];
    bidType = json['bidType'];
    if (json['bids'] != null) {
      bids = <Bids>[];
      json['bids'].forEach((v) {
        bids!.add(Bids.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['dailyMarketId'] = dailyMarketId;
    data['bidType'] = bidType;
    if (bids != null) {
      data['bids'] = bids!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bids {
  int? gameId;
  int? subGameId;
  String? bidNo;
  int? coins;
  String? remarks;
  String? gameModeName;

  Bids({
    this.gameId,
    this.bidNo,
    this.coins,
    this.remarks,
    this.gameModeName,
    this.subGameId,
  });

  Bids.fromJson(Map<String, dynamic> json) {
    gameId = json['gameId'];
    subGameId = json['subGameId'];
    bidNo = json['bidNo'];
    coins = json['coins'];
    remarks = json['remarks'];
    gameModeName = json['gameModeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gameId'] = gameId;
    data['subGameId'] = subGameId;
    data['bidNo'] = bidNo;
    data['coins'] = coins;
    data['remarks'] = remarks;
    data['gameModeName'] = gameModeName;
    return data;
  }
}

// //
// let test = [1123,123,123,123,123,123,123,122,332]

// let obj = {
//   gameId = 1;
//     subGameId = null;
//     bidNo = test[i];
//     coins = 1;
//     remarks = "test remakred";
//     gameModeName = "Single Ank";
        
// }

