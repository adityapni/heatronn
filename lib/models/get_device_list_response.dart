import 'error.dart';

class GetDeviceListResponse {
  GetDeviceListResponse({
    required this.status,
    this.result,
    this.error
  });
  late final String status;
  late final List<Result>? result;
  late final Error? error;

  GetDeviceListResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    result = json['result']!=null?List.from(json['result']).map((e)=>Result.fromJson(e)).toList():null;
    error = json['error']!=null?Error.fromJson(json['error']):null;
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
    required this.idDevice,
    required this.name,
    required this.nameLocation,
    required this.idLocation,
    required this.idType,
    required this.nameType,
    this.hardware
  });
  late final String idDevice;
  late final String name;
  late final String nameLocation;
  late final String idLocation;
  late final String idType;
  late final String nameType;
  late final String imageLarge;
  late final Hardware? hardware;

  Result.fromJson(Map<String, dynamic> json){
    idDevice = json['id_device'];
    name = json['name'];
    nameLocation = json['name_location'];
    idLocation = json['id_location'];
    idType = json['id_type'];
    nameType = json['name_type'];
    imageLarge = json['image_large'];
    hardware = json['hardware']!=null?Hardware.fromJson(json['hardware']):null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id_device'] = idDevice;
    _data['name'] = name;
    _data['name_location'] = nameLocation;
    _data['id_location'] = idLocation;
    _data['id_type'] = idType;
    _data['name_type'] = nameType;
    return _data;
  }
}

class Hardware {
  final String? type;
  // final List<Elements>? elements;

  Hardware({
    this.type,
    // this.elements,
  });

  Hardware.fromJson(Map<String, dynamic> json)
      : type = json['type'] as String?;
        // elements = (json['elements'] as List?)?.map((dynamic e) => Elements.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'type' : type,
    // 'elements' : elements?.map((e) => e.toJson()).toList()
  };
}


class Requirt {
  Requirt({
    required this.idType,
    required this.nameType,
    required this.availableInLocation,
    required this.connectedDevices,
  });
  late final String idType;
  late final String nameType;
  late final List<AvailableInLocation> availableInLocation;
  late final List<dynamic> connectedDevices;

  Requirt.fromJson(Map<String, dynamic> json){
    idType = json['id_type'];
    nameType = json['name_type'];
    availableInLocation = List.from(json['available_in_location']).map((e)=>AvailableInLocation.fromJson(e)).toList();
    connectedDevices = List.castFrom<dynamic, dynamic>(json['connected_devices']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id_type'] = idType;
    _data['name_type'] = nameType;
    _data['available_in_location'] = availableInLocation.map((e)=>e.toJson()).toList();
    _data['connected_devices'] = connectedDevices;
    return _data;
  }
}

class AvailableInLocation {
  AvailableInLocation({
    required this.idDevice,
    required this.name,
  });
  late final String idDevice;
  late final String name;

  AvailableInLocation.fromJson(Map<String, dynamic> json){
    idDevice = json['id_device'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id_device'] = idDevice;
    _data['name'] = name;
    return _data;
  }
}

class Stats {
  Stats({
    required this.activities,
    required this.reboot,
  });
  late final List<dynamic> activities;
  late final List<dynamic> reboot;

  Stats.fromJson(Map<String, dynamic> json){
    activities = List.castFrom<dynamic, dynamic>(json['activities']);
    reboot = List.castFrom<dynamic, dynamic>(json['reboot']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['activities'] = activities;
    _data['reboot'] = reboot;
    return _data;
  }
}