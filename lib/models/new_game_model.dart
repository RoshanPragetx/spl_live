class Model2 {
  final String? message;
  final bool? status;
  final int? length;
  late final List<dynamic>? data;

  Model2({
    this.message,
    this.status,
    this.length,
    this.data,
  });

  Model2.fromJson(Map<String, dynamic> json)
      : message = json['message'] as String?,
        status = json['status'] as bool?,
        length = json['length'] as int?,
        data =
            (json['data'] as List?)?.map((dynamic e) => e as dynamic).toList();

  Map<String, dynamic> toJson() =>
      {'message': message, 'status': status, 'length': length, 'data': data};
}
