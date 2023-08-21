class WithdrawalRequestResponseModel {
  String? message;
  bool? status;
  List<WithdrawalRequestList>? data;

  WithdrawalRequestResponseModel({this.message, this.status, this.data});

  WithdrawalRequestResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <WithdrawalRequestList>[];
      json['data'].forEach((v) {
        data!.add(new WithdrawalRequestList.fromJson(v));
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

class WithdrawalRequestList {
  int? id;
  int? requestedAmount;
  String? remarks;
  String? requestId;
  String? status;
  String? requestProcessedAt;
  String? requestTime;

  WithdrawalRequestList(
      {this.id,
      this.requestedAmount,
      this.remarks,
      this.requestId,
      this.status,
      this.requestProcessedAt,
      this.requestTime});

  WithdrawalRequestList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestedAmount = json['RequestedAmount'];
    remarks = json['Remarks'];
    requestId = json['RequestId'];
    status = json['Status'];
    requestProcessedAt = json['RequestProcessedAt'];
    requestTime = json['RequestTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['RequestedAmount'] = this.requestedAmount;
    data['Remarks'] = this.remarks;
    data['RequestId'] = this.requestId;
    data['Status'] = this.status;
    data['RequestProcessedAt'] = this.requestProcessedAt;
    data['RequestTime'] = this.requestTime;
    return data;
  }
}
