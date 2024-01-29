

import 'error.dart';

class DeviceDetailsResponse {
  DeviceDetailsResponse({
    required this.status,
    this.result,
    this.error
  });
  late final String status;
  late final Result? result;
  late final Error? error;

  DeviceDetailsResponse.fromJson(Map<String, dynamic> json){
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
    required this.name,
    required this.nameLocation,
    required this.idLocation,
    required this.idType,
    required this.nameType,
    this.requirt,
    required this.hardware,
    required this.liveData,
    required this.userSettings,
    required this.stats,
  });
  late final String idDevice;
  late final String name;
  late final String nameLocation;
  late final String idLocation;
  late final String idType;
  late final String nameType;
  late final List<Requirt>? requirt;
  late final Hardware hardware;
  late final LiveData liveData;
  late final List<UserSettings> userSettings;
  late final Stats stats;

  Result.fromJson(Map<String, dynamic> json){
    idDevice = json['id_device'];
    name = json['name'];
    nameLocation = json['name_location'];
    idLocation = json['id_location'];
    idType = json['id_type'];
    nameType = json['name_type'];
    requirt = json['requirt']!=null?List.from(json['requirt']).map((e)=>Requirt.fromJson(e)).toList():null;
    hardware = Hardware.fromJson(json['hardware']);
    liveData = LiveData.fromJson(json['live_data']);
    userSettings = json['user_settings'].toString()!='[]'?List.from(json['user_settings']).map((e)=>UserSettings.fromJson(e)).toList():[];
    stats = Stats.fromJson(json['stats']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id_device'] = idDevice;
    _data['name'] = name;
    _data['name_location'] = nameLocation;
    _data['id_location'] = idLocation;
    _data['id_type'] = idType;
    _data['name_type'] = nameType;
    _data['requirt'] = requirt?.map((e)=>e.toJson()).toList();
    _data['hardware'] = hardware.toJson();
    _data['live_data'] = liveData.toJson();
    _data['stats'] = stats.toJson();
    return _data;
  }
}

class UserSettings {
  UserSettings({
    this.element,
    required this.name,
    this.value,
    this.creationDate,
  });
  late final String? element;
  late final String name;
  late final List<String>? value;
  late final String? creationDate;

  UserSettings.fromJson(Map<String, dynamic> json){
    element = json['element'];
    name = json['name'];
    value = json['value']!=null?List.castFrom<dynamic, String>(json['value']):null;
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

class Hardware {
  Hardware({
    required this.type,
    required this.elements,
  });
  late final String type;
  late final List<Elements> elements;

  Hardware.fromJson(Map<String, dynamic> json){
    type = json['type'];
    elements = List.from(json['elements']).map((e)=>Elements.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['elements'] = elements.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Elements {
  Elements({
    required this.name,
    required this.type,
    required this.purpose,
    required this.userSettings,
    required this.requirtConnection,
  });
  late final String name;
  late final String type;
  late final String purpose;
  late final List<UserSettings> userSettings;
  late final RequirtConnection requirtConnection;

  Elements.fromJson(Map<String, dynamic> json){
    name = json['name'];
    type = json['type'];
    purpose = json['purpose'];
    userSettings = json['user_settings'].toString()!='[]'?List.from(json['user_settings']).map((e)=>UserSettings.fromJson(e)).toList():[];
    requirtConnection = RequirtConnection.fromJson(json['requirt_connection']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['type'] = type;
    _data['purpose'] = purpose;
    _data['user_settings'] = userSettings.map((e)=>e.toJson()).toList();
    _data['requirt_connection'] = requirtConnection.toJson();
    return _data;
  }
}

class RequirtConnection {
  RequirtConnection({
    required this.type,
    required this.mandatory,
    this.availbleConnections
  });
  late final List<String> type;
  late final bool mandatory;
  late final List<AvailbleConnections>? availbleConnections;

  RequirtConnection.fromJson(Map<String, dynamic> json){
    type = List.castFrom<dynamic, String>(json['type']);
    mandatory = json['mandatory'];
    availbleConnections = json['availble_connections']!=null?List.from(json['availble_connections']).map((e)=>AvailbleConnections.fromJson(e)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['mandatory'] = mandatory;
    return _data;
  }
}
class AvailbleConnections {
  AvailbleConnections({
    required this.idType,
    required this.nameType,
    required this.availableInLocation,
  });
  late final String idType;
  late final String nameType;
  late final List<AvailableInLocation> availableInLocation;

  AvailbleConnections.fromJson(Map<String, dynamic> json){
    idType = json['id_type'];
    nameType = json['name_type'];
    availableInLocation = List.from(json['available_in_location']).map((e)=>AvailableInLocation.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id_type'] = idType;
    _data['name_type'] = nameType;
    _data['available_in_location'] = availableInLocation.map((e)=>e.toJson()).toList();
    return _data;
  }
}



class Settings {
  Settings({
    required this.heaterElements,
  });
  late final List<HeaterElements> heaterElements;

  Settings.fromJson(Map<String, dynamic> json){
    heaterElements = List.from(json['heater_elements']).map((e)=>HeaterElements.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['heater_elements'] = heaterElements.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class HeaterElements {
  HeaterElements({
    required this.name,
    required this.type,
    required this.purpose,
  });
  late final String name;
  late final String type;
  late final String purpose;

  HeaterElements.fromJson(Map<String, dynamic> json){
    name = json['name'];
    type = json['type'];
    purpose = json['purpose'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['type'] = type;
    _data['purpose'] = purpose;
    return _data;
  }
}

class LiveData {
  LiveData({
    required this.type,
    required this.data,
  });
  late final String type;
  late final Data data;

  LiveData.fromJson(Map<String, dynamic> json){
    type = json['type'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Stats {
  Stats({
    required this.usageDailyKwh,
    required this.activities,
    required this.reboot,
  });
  late final List<UsageDailyKwh> usageDailyKwh;
  late final List<Activities> activities;
  late final List<Reboot> reboot;

  Stats.fromJson(Map<String, dynamic> json){
    usageDailyKwh = List.from(json['usage_daily_kwh']).map((e)=>UsageDailyKwh.fromJson(e)).toList();
    activities = List.from(json['activities']).map((e)=>Activities.fromJson(e)).toList();
    reboot = List.from(json['reboot']).map((e)=>Reboot.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['usage_daily_kwh'] = usageDailyKwh.map((e)=>e.toJson()).toList();
    _data['activities'] = activities.map((e)=>e.toJson()).toList();
    _data['reboot'] = reboot.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class UsageDailyKwh {
  UsageDailyKwh({
    required this.statsDate,
    required this.value,
  });
  late final String statsDate;
  late final int value;

  UsageDailyKwh.fromJson(Map<String, dynamic> json){
    statsDate = json['stats_date'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['stats_date'] = statsDate;
    _data['value'] = value;
    return _data;
  }
}


class Activities {
  Activities({
    required this.statsDate,
    required this.value,
  });
  late final String statsDate;
  late final int value;

  Activities.fromJson(Map<String, dynamic> json){
    statsDate = json['stats_date'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['stats_date'] = statsDate;
    _data['value'] = value;
    return _data;
  }
}

class Reboot {
  Reboot({
    required this.statsDate,
    required this.value,
  });
  late final String statsDate;
  late final int value;

  Reboot.fromJson(Map<String, dynamic> json){
    statsDate = json['stats_date'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['stats_date'] = statsDate;
    _data['value'] = value;
    return _data;
  }
}

class Data {
  Data({
    this.heater_1,
    this.heater_2,
    this.heater_3,
    this.heater_4,
    this.temperature
  });
  late final Heater_1? heater_1;
  late final Heater_2? heater_2;
  late final Heater_3? heater_3;
  late final Heater_4? heater_4;
  late final Temperature? temperature;

  Data.fromJson(Map<String, dynamic> json){
    heater_1 = json['heater_1']!=null?Heater_1.fromJson(json['heater_1']):null;
    heater_2 = json['heater_2']!=null?Heater_2.fromJson(json['heater_2']):null;
    heater_3 = json['heater_3']!=null?Heater_3.fromJson(json['heater_3']):null;
    heater_4 = json['heater_4']!=null?Heater_4.fromJson(json['heater_4']):null;
    temperature = json['temperature']!=null?Temperature.fromJson(json['temperature']):null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['heater_1'] = heater_1?.toJson();
    _data['heater_2'] = heater_2?.toJson();
    _data['heater_3'] = heater_3?.toJson();
    _data['heater_4'] = heater_4?.toJson();
    return _data;
  }
}

class Temperature {
  Temperature({
    required this.current,
    required this.set,
  });
  late final int current;
  late final int set;

  Temperature.fromJson(Map<String, dynamic> json){
    current = json['current'];
    set = json['set'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['current'] = current;
    _data['set'] = set;
    return _data;
  }
}

class Heater_1 {
  Heater_1({
    required this.on,
    required this.temperature,
  });
  late final bool on;
  late final int temperature;

  Heater_1.fromJson(Map<String, dynamic> json){
    on = json['on'];
    temperature = json['temperature'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['on'] = on;
    _data['temperature'] = temperature;
    return _data;
  }
}

class Heater_2 {
  Heater_2({
    required this.on,
    required this.temperature,
  });
  late final bool on;
  late final int temperature;

  Heater_2.fromJson(Map<String, dynamic> json){
    on = json['on'];
    temperature = json['temperature'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['on'] = on;
    _data['temperature'] = temperature;
    return _data;
  }
}

class Heater_3 {
  Heater_3({
    required this.on,
    required this.temperature,
  });
  late final bool on;
  late final int temperature;

  Heater_3.fromJson(Map<String, dynamic> json){
    on = json['on'];
    temperature = json['temperature'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['on'] = on;
    _data['temperature'] = temperature;
    return _data;
  }
}

class Heater_4 {
  Heater_4({
    required this.on,
    required this.temperature,
  });
  late final bool on;
  late final int temperature;

  Heater_4.fromJson(Map<String, dynamic> json){
    on = json['on'];
    temperature = json['temperature'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['on'] = on;
    _data['temperature'] = temperature;
    return _data;
  }
}