import 'error.dart';

class PairDeviceResponse {
  PairDeviceResponse({
    required this.status,
    this.result,
   this.error,
  });
  late final String status;
  late final String? result;
  late final Error? error;

  PairDeviceResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    result = json['result'];
    error = json['error']!=null ? Error.fromJson(json['error']):null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['result'] = result;
    _data['error'] = error?.toJson();
    return _data;
  }
}