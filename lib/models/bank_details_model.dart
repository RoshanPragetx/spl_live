class BankDetailsResponseModel {
  String? message;
  BankData? data;
  bool? status;

  BankDetailsResponseModel({this.message, this.data, this.status});

  BankDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? BankData.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = status;
    return data;
  }
}

class BankData {
  int? id;
  int? userId;
  String? bankName;
  String? accountHolderName;
  String? accountNumber;
  String? iFSCCode;
  String? gpayNumber;
  String? paytmNumber;
  String? bhimUPI;
  bool? isEditPermission;
  String? createdAt;
  String? updatedAt;

  BankData(
      {this.id,
      this.userId,
      this.bankName,
      this.accountHolderName,
      this.accountNumber,
      this.iFSCCode,
      this.gpayNumber,
      this.paytmNumber,
      this.bhimUPI,
      this.isEditPermission,
      this.createdAt,
      this.updatedAt});

  BankData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['UserId'];
    bankName = json['BankName'];
    accountHolderName = json['AccountHolderName'];
    accountNumber = json['AccountNumber'];
    iFSCCode = json['IFSCCode'];
    gpayNumber = json['GpayNumber'];
    paytmNumber = json['PaytmNumber'];
    bhimUPI = json['BhimUPI'];
    isEditPermission = json['IsEditPermission'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['UserId'] = userId;
    data['BankName'] = bankName;
    data['AccountHolderName'] = accountHolderName;
    data['AccountNumber'] = accountNumber;
    data['IFSCCode'] = iFSCCode;
    data['GpayNumber'] = gpayNumber;
    data['PaytmNumber'] = paytmNumber;
    data['BhimUPI'] = bhimUPI;
    data['IsEditPermission'] = isEditPermission;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
