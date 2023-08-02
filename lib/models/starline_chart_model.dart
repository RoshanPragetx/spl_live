class StarlineChartModel {
  StarlineChartModel({
    String? message,
    bool? status,
    List<Data2>? data,
  }) {
    _message = message;
    _status = status;
    _data = data;
  }

  StarlineChartModel.fromJson(dynamic json) {
    _message = json['message'];
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data2.fromJson(v));
      });
    }
  }
  String? _message;
  bool? _status;
  List<Data2>? _data;
  StarlineChartModel copyWith({
    String? message,
    bool? status,
    List<Data2>? data,
  }) =>
      StarlineChartModel(
        message: message ?? _message,
        status: status ?? _status,
        data: data ?? _data,
      );
  String? get message => _message;
  bool? get status => _status;
  List<Data2>? get data => _data;

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

/// Date : "2023-06-20"
/// Time : [{"Name":"10:00 AM","Result":null},{"Name":"11:00 AM","Result":null},{"Name":"12:00 PM","Result":null},{"Name":"01:00 PM","Result":null},{"Name":"02:00 PM","Result":null},{"Name":"03:00 PM","Result":null},{"Name":"04:00 PM","Result":null},{"Name":"05:00 PM","Result":null},{"Name":"06:00 PM","Result":null},{"Name":"07:00 PM","Result":null},{"Name":"08:00 PM","Result":null},{"Name":"09:00 PM","Result":null},{"Name":"10:00 PM","Result":null}]

class Data2 {
  Data2({
    String? date,
    List<Time>? time,
  }) {
    _date = date;
    _time = time;
  }

  Data2.fromJson(dynamic json) {
    _date = json['Date'];
    if (json['Time'] != null) {
      _time = [];
      json['Time'].forEach((v) {
        _time?.add(Time.fromJson(v));
      });
    }
  }
  String? _date;
  List<Time>? _time;
  Data2 copyWith({
    String? date,
    List<Time>? time,
  }) =>
      Data2(
        date: date ?? _date,
        time: time ?? _time,
      );
  String? get date => _date;
  List<Time>? get time => _time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Date'] = _date;
    if (_time != null) {
      map['Time'] = _time?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// Name : "10:00 AM"
/// Result : null

class Time {
  Time({
    String? name,
    dynamic result,
  }) {
    _name = name;
    _result = result;
  }

  Time.fromJson(dynamic json) {
    _name = json['Name'];
    _result = json['Result'];
  }
  String? _name;
  dynamic _result;
  Time copyWith({
    String? name,
    dynamic result,
  }) =>
      Time(
        name: name ?? _name,
        result: result ?? _result,
      );
  String? get name => _name;
  dynamic get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Name'] = _name;
    map['Result'] = _result;
    return map;
  }
}
