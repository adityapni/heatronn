class SignUpResponse {
  SignUpResponse({
    required this.status,
    this.result,
    this.error
  });
  late final String status;
  late final Result? result;
  late final String? error;

  SignUpResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    error = json['error'];
    result = Result.fromJson(json['result']);
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