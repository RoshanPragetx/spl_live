class UserDetailsModel {
  int? id;
  String? userName;
  String? fullName;
  String? phoneNumber;
  String? countryCode;
  String? deviceId;
  String? token;

  UserDetailsModel(
      {this.id,
      this.userName,
      this.fullName,
      this.phoneNumber,
      this.countryCode,
      this.deviceId,
      this.token});

  UserDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    userName = json['UserName'];
    fullName = json['FullName'];
    phoneNumber = json['PhoneNumber'];
    countryCode = json['CountryCode'];
    deviceId = json['DeviceId'];
    token = json['Token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['UserName'] = userName;
    data['FullName'] = fullName;
    data['PhoneNumber'] = phoneNumber;
    data['CountryCode'] = countryCode;
    data['DeviceId'] = deviceId;
    data['Token'] = token;
    return data;
  }
}
