class GameModesApiResponseModel {
  String? message;
  bool? status;
  GameModesData? data;

  GameModesApiResponseModel({this.message, this.status, this.data});

  GameModesApiResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? GameModesData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class GameModesData {
  bool? isBidOpenForOpen;
  bool? isBidOpenForClose;
  List<GameMode>? gameMode;

  GameModesData({this.isBidOpenForOpen, this.isBidOpenForClose, this.gameMode});

  GameModesData.fromJson(Map<String, dynamic> json) {
    isBidOpenForOpen = json['IsBidOpenForOpen'];
    isBidOpenForClose = json['IsBidOpenForClose'];
    if (json['GameMode'] != null) {
      gameMode = <GameMode>[];
      json['GameMode'].forEach((v) {
        gameMode!.add(GameMode.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['IsBidOpenForOpen'] = isBidOpenForOpen;
    data['IsBidOpenForClose'] = isBidOpenForClose;
    if (gameMode != null) {
      data['GameMode'] = gameMode!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GameMode {
  int? id;
  String? name;
  String? image;
  bool? isActive;

  GameMode({this.id, this.name, this.isActive, this.image});

  GameMode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    image = json['Image'] ??
        "http://43.205.145.101:9867/public/images/games/single-ank.png";
    isActive = json['IsActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['Name'] = name;
    data['Image'] = image;
    data['IsActive'] = isActive;
    return data;
  }
}
