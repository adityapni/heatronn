import 'error.dart';

class UpdateDeviceResponse {
  UpdateDeviceResponse({
    required this.status,
    this.result,
    this.error
  });
  late final String status;
  late final Result? result;
  late final Error? error;

  UpdateDeviceResponse.fromJson(Map<String, dynamic> json){
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
    required this.idDevice,
    required this.userSettings,
  });
  late final String idDevice;
  late final List<UserSettings> userSettings;

  Result.fromJson(Map<String, dynamic> json){
    idDevice = json['id_device'];
    userSettings = List.from(json['user_settings']).map((e)=>UserSettings.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id_device'] = idDevice;
    _data['user_settings'] = userSettings.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class UserSettings {
  UserSettings({
    required this.element,
    required this.name,
    required this.value,
    required this.creationDate,
  });
  late final String element;
  late final String name;
  late final dynamic value;
  late final String creationDate;

  UserSettings.fromJson(Map<String, dynamic> json){
    element = json['element'];
    name = json['name'];
    value = json['value'];
    creationDate = json['creation_date'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['element'] = element;
    _data['name'] = name;
    _data['value'] = value;
    _data['creation_date'] = creationDate;
    return _data;
  }
}