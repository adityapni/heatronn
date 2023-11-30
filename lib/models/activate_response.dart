class ActivateResponse {
  ActivateResponse({
    required this.status,
    this.error,
    this.result,
  });
  late final String status;
  late final String? error;
  late final Result? result;

  ActivateResponse.fromJson(Map<String, dynamic> json){
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