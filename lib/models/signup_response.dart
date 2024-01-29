import 'error.dart';
class SignUpResponse {
  SignUpResponse({
    required this.status,
    this.result,
    this.error
  });
  late final String status;
  late final Result? result;
  late final Error? error;

  SignUpResponse.fromJson(Map<String, dynamic> json){
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
    required this.activationToken,
  });
  late final String activationToken;

  Result.fromJson(Map<String, dynamic> json){
    activationToken = json['activation_token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['activation_token'] = activationToken;
    return _data;
  }
}