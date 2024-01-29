import 'error.dart';
class RequestPairDeviceResponse {
  RequestPairDeviceResponse({
    required this.status,
    this.result,
    this.error
  });
  late final String status;
  late final Result? result;
  late final Error? error;

  RequestPairDeviceResponse.fromJson(Map<String, dynamic> json){
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
    required this.pairToken,
  });
  late final String pairToken;

  Result.fromJson(Map<String, dynamic> json){
    pairToken = json['pair_token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['pair_token'] = pairToken;
    return _data;
  }
}