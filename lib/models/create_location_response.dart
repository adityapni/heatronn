import 'error.dart';

class CreateLocationResponse {
  CreateLocationResponse({
    required this.status,
    this.result,
    this.error
  });
  late final String status;
  late final Result? result;
  late final Error? error;

  CreateLocationResponse.fromJson(Map<String, dynamic> json){
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
    required this.idLocation,
  });
  late final String idLocation;

  Result.fromJson(Map<String, dynamic> json){
    idLocation = json['id_location'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id_location'] = idLocation;
    return _data;
  }
}