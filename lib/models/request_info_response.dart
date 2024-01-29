import 'error.dart';

class RequestInfoResponse {
  RequestInfoResponse({
    required this.status,
    this.result,
    this.error
  });
  late final String status;
  late final Result? result;
  late final Error? error;

  RequestInfoResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    result = json['result']!=null?Result.fromJson(json['result']):null;
    error = json['error']!=null?Error.fromJson(json['error']):null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['result'] = result?.toJson();
    return _data;
  }
}

class Result {
  Result({
    required this.name,
    required this.mac,
  });
  late final String name;
  late final String mac;

  Result.fromJson(Map<String, dynamic> json){
    name = json['name'];
    mac = json['mac'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['mac'] = mac;
    return _data;
  }
}