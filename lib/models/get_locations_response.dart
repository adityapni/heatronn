import 'error.dart';

class GetLocationsResponse {
  GetLocationsResponse({
    required this.status,
    this.result,
    this.error
  });
  late final String status;
  late final List<Result>? result;
  late final Error? error;

  GetLocationsResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    result = json['result']!=null?List.from(json['result']).map((e)=>Result.fromJson(e)).toList():null;
    error =  json['error']!=null?Error.fromJson(json['error']):null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['result'] = result?.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Result {
  Result({
    required this.idLocation,
    required this.name,
  });
  late final String idLocation;
  late final String name;

  Result.fromJson(Map<String, dynamic> json){
    idLocation = json['id_location'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id_location'] = idLocation;
    _data['name'] = name;
    return _data;
  }
}