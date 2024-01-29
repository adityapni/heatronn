import 'error.dart';

class SensorDetailResponse {
  final String? status;
  final Result? result;
  final Error? error;

  SensorDetailResponse({
    this.status,
    this.result,
    this.error
  });

  SensorDetailResponse.fromJson(Map<String, dynamic> json)
      : status = json['status'] as String?,
        error = json['error']!=null?Error.fromJson(json['error']):null,
        result = (json['result'] as Map<String,dynamic>?) != null ? Result.fromJson(json['result'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'status' : status,
    'result' : result?.toJson()
  };
}

class Result {
  final String? idDevice;
  final String? name;
  final List<UserSettings?>? userSettings;
  final String? nameLocation;
  final String? idLocation;
  final String? idType;
  final String? nameType;
  final Hardware? hardware;
  final Stats? stats;
  final LiveData? liveData;

  Result({
    this.idDevice,
    this.name,
    this.userSettings,
    this.nameLocation,
    this.idLocation,
    this.idType,
    this.nameType,
    this.hardware,
    this.stats,
    this.liveData,
  });

  Result.fromJson(Map<String, dynamic> json)
      : idDevice = json['id_device'] as String?,
        name = json['name'] as String?,
        userSettings = (json['user_settings'] as List?)?.map((dynamic e) => UserSettings.fromJson(e as Map<String,dynamic>)).toList(),
        nameLocation = json['name_location'] as String?,
        idLocation = json['id_location'] as String?,
        idType = json['id_type'] as String?,
        nameType = json['name_type'] as String?,
        hardware = (json['hardware'] as Map<String,dynamic>?) != null ? Hardware.fromJson(json['hardware'] as Map<String,dynamic>) : null,
        stats = (json['stats'] as Map<String,dynamic>?) != null ? Stats.fromJson(json['stats'] as Map<String,dynamic>) : null,
        liveData = (json['live_data'] as Map<String,dynamic>?) != null ? LiveData.fromJson(json['live_data'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'id_device' : idDevice,
    'name' : name,
    'user_settings' : userSettings?.map((e) => e?.toJson()).toList(),
    'name_location' : nameLocation,
    'id_location' : idLocation,
    'id_type' : idType,
    'name_type' : nameType,
    'hardware' : hardware?.toJson(),
    'stats' : stats?.toJson(),
    'live_data' : liveData?.toJson()
  };
}

class UserSettings {
  final String? element;
  final String? name;
  final String? value;
  final String? creationDate;

  UserSettings({
    this.element,
    this.name,
    this.value,
    this.creationDate,
  });

  UserSettings.fromJson(Map<String, dynamic> json)
      : element = json['element'] as String?,
        name = json['name'] as String?,
        value = json['value'].runtimeType == int?json['value'].toString():json['value'] as String?,
        creationDate = json['creation_date'] as String?;

  Map<String, dynamic> toJson() => {
    'element' : element,
    'name' : name,
    'value' : value,
    'creation_date' : creationDate
  };
}

class Hardware {
  final String? type;
  final List<Elements>? elements;

  Hardware({
    this.type,
    this.elements,
  });

  Hardware.fromJson(Map<String, dynamic> json)
      : type = json['type'] as String?,
        elements = (json['elements'] as List?)?.map((dynamic e) => Elements.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'type' : type,
    'elements' : elements?.map((e) => e.toJson()).toList()
  };
}

class Elements {
  final String? name;
  final String? type;
  final String? purpose;
  final List<UserSettingsElement>? userSettings;
  final RequirtConnection? requirtConnection;

  Elements({
    this.name,
    this.type,
    this.purpose,
    this.userSettings,
    this.requirtConnection,
  });

  Elements.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        type = json['type'] as String?,
        purpose = json['purpose'] as String?,
        userSettings = (json['user_settings'] as List?)?.map((dynamic e) => UserSettingsElement.fromJson(e as Map<String,dynamic>)).toList(),
        requirtConnection = (json['requirt_connection'] as Map<String,dynamic>?) != null ? RequirtConnection.fromJson(json['requirt_connection'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'name' : name,
    'type' : type,
    'purpose' : purpose,
    'user_settings' : userSettings?.map((e) => e.toJson()).toList(),
    'requirt_connection' : requirtConnection?.toJson()
  };
}

class UserSettingsElement {
  final String? name;
  final Type? type;
  final bool? mandatory;

  UserSettingsElement({
    this.name,
    this.type,
    this.mandatory,
  });

  UserSettingsElement.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        type = (json['type'] as Map<String,dynamic>?) != null ? Type.fromJson(json['type'] as Map<String,dynamic>) : null,
        mandatory = json['mandatory'] as bool?;

  Map<String, dynamic> toJson() => {
    'name' : name,
    'type' : type?.toJson(),
    'mandatory' : mandatory
  };
}

class Type {
  final String? name;
  final int? min;
  final int? max;
  final List<String>? variant;
  final String? defaultVariant;

  Type({
    this.name,
    this.min,
    this.max,
    this.variant,
    this.defaultVariant,
  });

  Type.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        min = json['min'] as int?,
        max = json['max'] as int?,
        variant = (json['variant'] as List?)?.map((dynamic e) => e as String).toList(),
        defaultVariant = json['default_variant'] as String?;

  Map<String, dynamic> toJson() => {
    'name' : name,
    'min' : min,
    'max' : max,
    'variant' : variant,
    'default_variant' : defaultVariant
  };
}

class RequirtConnection {
  final List<dynamic>? type;
  final bool? mandatory;

  RequirtConnection({
    this.type,
    this.mandatory,
  });

  RequirtConnection.fromJson(Map<String, dynamic> json)
      : type = json['type'] as List?,
        mandatory = json['mandatory'] as bool?;

  Map<String, dynamic> toJson() => {
    'type' : type,
    'mandatory' : mandatory
  };
}

class Stats {
  final List<UsageDailyKwh>? usageDailyKwh;
  final List<Activities>? activities;
  final List<Reboot>? reboot;

  Stats({
    this.usageDailyKwh,
    this.activities,
    this.reboot,
  });

  Stats.fromJson(Map<String, dynamic> json)
      : usageDailyKwh = (json['usage_daily_kwh'] as List?)?.map((dynamic e) => UsageDailyKwh.fromJson(e as Map<String,dynamic>)).toList(),
        activities = (json['activities'] as List?)?.map((dynamic e) => Activities.fromJson(e as Map<String,dynamic>)).toList(),
        reboot = (json['reboot'] as List?)?.map((dynamic e) => Reboot.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'usage_daily_kwh' : usageDailyKwh?.map((e) => e.toJson()).toList(),
    'activities' : activities?.map((e) => e.toJson()).toList(),
    'reboot' : reboot?.map((e) => e.toJson()).toList()
  };
}

class UsageDailyKwh {
  final String? statsDate;
  final int? value;

  UsageDailyKwh({
    this.statsDate,
    this.value,
  });

  UsageDailyKwh.fromJson(Map<String, dynamic> json)
      : statsDate = json['stats_date'] as String?,
        value = json['value'] as int?;

  Map<String, dynamic> toJson() => {
    'stats_date' : statsDate,
    'value' : value
  };
}

class Activities {
  final String? statsDate;
  final int? value;

  Activities({
    this.statsDate,
    this.value,
  });

  Activities.fromJson(Map<String, dynamic> json)
      : statsDate = json['stats_date'] as String?,
        value = json['value'] as int?;

  Map<String, dynamic> toJson() => {
    'stats_date' : statsDate,
    'value' : value
  };
}

class Reboot {
  final String? statsDate;
  final int? value;

  Reboot({
    this.statsDate,
    this.value,
  });

  Reboot.fromJson(Map<String, dynamic> json)
      : statsDate = json['stats_date'] as String?,
        value = json['value'] as int?;

  Map<String, dynamic> toJson() => {
    'stats_date' : statsDate,
    'value' : value
  };
}

class LiveData {
  final String? type;
  final Data? data;

  LiveData({
    this.type,
    this.data,
  });

  LiveData.fromJson(Map<String, dynamic> json)
      : type = json['type'] as String?,
        data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'type' : type,
    'data' : data?.toJson()
  };
}

class Data {
  final Temperature? temperature;

  Data({
    this.temperature,
  });

  Data.fromJson(Map<String, dynamic> json)
      : temperature = (json['temperature'] as Map<String,dynamic>?) != null ? Temperature.fromJson(json['temperature'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'temperature' : temperature?.toJson()
  };
}

class Temperature {
  final int? current;
  final int? set;

  Temperature({
    this.current,
    this.set,
  });

  Temperature.fromJson(Map<String, dynamic> json)
      : current = json['current'] as int?,
        set = json['set'] as int?;

  Map<String, dynamic> toJson() => {
    'current' : current,
    'set' : set
  };
}