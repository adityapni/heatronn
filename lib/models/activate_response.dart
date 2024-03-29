import 'error.dart';
class ActivateResponse {
  ActivateResponse({
    required this.status,
    this.error,
    this.result,
  });
  late final String status;
  late final Error? error;
  late final Result? result;

  ActivateResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    error = json['error']!=null?Error.fromJson(json['error']):null;
    result = json['result']!=null?Result.fromJson(json['result']):null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['error'] = error;
    _data['result'] = result?.toJson();
    return _data;
  }
}

class Result {
  Result({
    required this.accessToken,
    required this.account,
  });
  late final String accessToken;
  late final String account;

  Result.fromJson(Map<String, dynamic> json){
    accessToken = json['access_token'];
    account = json['account'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['access_token'] = accessToken;
    _data['account'] = account;
    return _data;
  }
}