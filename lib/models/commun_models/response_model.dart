class ResponseModel {
  ResponseModel({
    String? message,
    bool? status,
    dynamic? data,
  }) {
    _message = message;
    _status = status;
    _data = data;
  }

  ResponseModel.fromJson(dynamic json) {
    _message = json['message'];
    _status = json['status'];
    _data = json['data'];
  }
  String? _message;
  bool? _status;
  dynamic? _data;
  ResponseModel copyWith({
    String? message,
    bool? status,
    dynamic? data,
  }) =>
      ResponseModel(
        message: message ?? _message,
        status: status ?? _status,
        data: data ?? _data,
      );
  String? get message => _message;
  bool? get status => _status;
  dynamic? get data => _data;

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
