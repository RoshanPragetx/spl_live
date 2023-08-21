class MarketRatesApiResponseModel {
  String? message;
  bool? status;
  List<Data>? data;

  MarketRatesApiResponseModel({this.message, this.status, this.data});

  MarketRatesApiResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  dynamic baseRate;
  dynamic rate;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.name,
      this.baseRate,
      this.rate,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    baseRate = json['BaseRate'];
    rate = json['Rate'];
    isActive = json['IsActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['Name'] = name;
    data['BaseRate'] = baseRate;
    data['Rate'] = rate;
    data['IsActive'] = isActive;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
