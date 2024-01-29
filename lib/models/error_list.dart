class ErrorList {
  ErrorList({
    required this.status,
    required this.result,
  });
  late final String status;
  late final Result result;

  ErrorList.fromJson(Map<String, dynamic> json){
    status = json['status'];
    result = Result.fromJson(json['result']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['result'] = result.toJson();
    return _data;
  }
}

class Result {
  Result({
  required this.all,
  required this.getLanguages,
  required this.getErrorList,
  required this.signup,
  required this.requestAccess,
  required this.activate,
  required this.requestPairDevice,
  required this.completePairDevice,
  required this.getDeviceList,
  required this.getDeviceDetails,
});
late final List<All> all;
late final List<GetLanguages> getLanguages;
late final List<GetErrorList> getErrorList;
late final List<Signup> signup;
late final List<RequestAccess> requestAccess;
late final List<Activate> activate;
late final List<RequestPairDevice> requestPairDevice;
late final List<CompletePairDevice> completePairDevice;
late final List<GetDeviceList> getDeviceList;
late final List<GetDeviceDetails> getDeviceDetails;

Result.fromJson(Map<String, dynamic> json){
all = List.from(json['*']).map((e)=>All.fromJson(e)).toList();
getLanguages = List.from(json['getLanguages']).map((e)=>GetLanguages.fromJson(e)).toList();
getErrorList = List.from(json['getErrorList']).map((e)=>GetErrorList.fromJson(e)).toList();
signup = List.from(json['signup']).map((e)=>Signup.fromJson(e)).toList();
requestAccess = List.from(json['requestAccess']).map((e)=>RequestAccess.fromJson(e)).toList();
activate = List.from(json['activate']).map((e)=>Activate.fromJson(e)).toList();
requestPairDevice = List.from(json['requestPairDevice']).map((e)=>RequestPairDevice.fromJson(e)).toList();
completePairDevice = List.from(json['completePairDevice']).map((e)=>CompletePairDevice.fromJson(e)).toList();
getDeviceList = List.from(json['getDeviceList']).map((e)=>GetDeviceList.fromJson(e)).toList();
getDeviceDetails = List.from(json['getDeviceDetails']).map((e)=>GetDeviceDetails.fromJson(e)).toList();
}

Map<String, dynamic> toJson() {
final _data = <String, dynamic>{};
_data['*'] = all.map((e)=>e.toJson()).toList();
_data['getLanguages'] = getLanguages.map((e)=>e.toJson()).toList();
_data['getErrorList'] = getErrorList.map((e)=>e.toJson()).toList();
_data['signup'] = signup.map((e)=>e.toJson()).toList();
_data['requestAccess'] = requestAccess.map((e)=>e.toJson()).toList();
_data['activate'] = activate.map((e)=>e.toJson()).toList();
_data['requestPairDevice'] = requestPairDevice.map((e)=>e.toJson()).toList();
_data['completePairDevice'] = completePairDevice.map((e)=>e.toJson()).toList();
_data['getDeviceList'] = getDeviceList.map((e)=>e.toJson()).toList();
_data['getDeviceDetails'] = getDeviceDetails.map((e)=>e.toJson()).toList();
return _data;
}
}

class All {
All({
required this.code,
required this.description,
required this.responseMessage,
required this.userfriendlyMessage,
});
late final String code;
late final String description;
late final String responseMessage;
late final UserfriendlyMessage userfriendlyMessage;

All.fromJson(Map<String, dynamic> json){
code = json['code'];
description = json['description'];
responseMessage = json['response_message'];
userfriendlyMessage = UserfriendlyMessage.fromJson(json['userfriendly_message']);
}

Map<String, dynamic> toJson() {
final _data = <String, dynamic>{};
_data['code'] = code;
_data['description'] = description;
_data['response_message'] = responseMessage;
_data['userfriendly_message'] = userfriendlyMessage.toJson();
return _data;
}
}

class UserfriendlyMessage {
UserfriendlyMessage({
required this.en,
});
late final String en;

UserfriendlyMessage.fromJson(Map<String, dynamic> json){
en = json['en'];
}

Map<String, dynamic> toJson() {
final _data = <String, dynamic>{};
_data['en'] = en;
return _data;
}
}

class GetLanguages {
GetLanguages({
required this.code,
required this.description,
required this.responseMessage,
required this.userfriendlyMessage,
});
late final String code;
late final String description;
late final String responseMessage;
late final UserfriendlyMessage userfriendlyMessage;

GetLanguages.fromJson(Map<String, dynamic> json){
code = json['code'];
description = json['description'];
responseMessage = json['response_message'];
userfriendlyMessage = UserfriendlyMessage.fromJson(json['userfriendly_message']);
}

Map<String, dynamic> toJson() {
final _data = <String, dynamic>{};
_data['code'] = code;
_data['description'] = description;
_data['response_message'] = responseMessage;
_data['userfriendly_message'] = userfriendlyMessage.toJson();
return _data;
}
}

class GetErrorList {
GetErrorList({
required this.code,
required this.description,
required this.responseMessage,
required this.userfriendlyMessage,
});
late final String code;
late final String description;
late final String responseMessage;
late final UserfriendlyMessage userfriendlyMessage;

GetErrorList.fromJson(Map<String, dynamic> json){
code = json['code'];
description = json['description'];
responseMessage = json['response_message'];
userfriendlyMessage = UserfriendlyMessage.fromJson(json['userfriendly_message']);
}

Map<String, dynamic> toJson() {
final _data = <String, dynamic>{};
_data['code'] = code;
_data['description'] = description;
_data['response_message'] = responseMessage;
_data['userfriendly_message'] = userfriendlyMessage.toJson();
return _data;
}
}

class Signup {
Signup({
required this.code,
required this.description,
required this.responseMessage,
required this.userfriendlyMessage,
});
late final String code;
late final String description;
late final String responseMessage;
late final UserfriendlyMessage userfriendlyMessage;

Signup.fromJson(Map<String, dynamic> json){
code = json['code'];
description = json['description'];
responseMessage = json['response_message'];
userfriendlyMessage = UserfriendlyMessage.fromJson(json['userfriendly_message']);
}

Map<String, dynamic> toJson() {
final _data = <String, dynamic>{};
_data['code'] = code;
_data['description'] = description;
_data['response_message'] = responseMessage;
_data['userfriendly_message'] = userfriendlyMessage.toJson();
return _data;
}
}

class RequestAccess {
RequestAccess({
required this.code,
required this.description,
required this.responseMessage,
required this.userfriendlyMessage,
});
late final String code;
late final String description;
late final String responseMessage;
late final UserfriendlyMessage userfriendlyMessage;

RequestAccess.fromJson(Map<String, dynamic> json){
code = json['code'];
description = json['description'];
responseMessage = json['response_message'];
userfriendlyMessage = UserfriendlyMessage.fromJson(json['userfriendly_message']);
}

Map<String, dynamic> toJson() {
final _data = <String, dynamic>{};
_data['code'] = code;
_data['description'] = description;
_data['response_message'] = responseMessage;
_data['userfriendly_message'] = userfriendlyMessage.toJson();
return _data;
}
}

class Activate {
Activate({
required this.code,
required this.description,
required this.responseMessage,
required this.userfriendlyMessage,
});
late final String code;
late final String description;
late final String responseMessage;
late final UserfriendlyMessage userfriendlyMessage;

Activate.fromJson(Map<String, dynamic> json){
code = json['code'];
description = json['description'];
responseMessage = json['response_message'];
userfriendlyMessage = UserfriendlyMessage.fromJson(json['userfriendly_message']);
}

Map<String, dynamic> toJson() {
final _data = <String, dynamic>{};
_data['code'] = code;
_data['description'] = description;
_data['response_message'] = responseMessage;
_data['userfriendly_message'] = userfriendlyMessage.toJson();
return _data;
}
}

class RequestPairDevice {
RequestPairDevice({
required this.code,
required this.description,
required this.responseMessage,
required this.userfriendlyMessage,
});
late final String code;
late final String description;
late final String responseMessage;
late final UserfriendlyMessage userfriendlyMessage;

RequestPairDevice.fromJson(Map<String, dynamic> json){
code = json['code'];
description = json['description'];
responseMessage = json['response_message'];
userfriendlyMessage = UserfriendlyMessage.fromJson(json['userfriendly_message']);
}

Map<String, dynamic> toJson() {
final _data = <String, dynamic>{};
_data['code'] = code;
_data['description'] = description;
_data['response_message'] = responseMessage;
_data['userfriendly_message'] = userfriendlyMessage.toJson();
return _data;
}
}

class CompletePairDevice {
CompletePairDevice({
required this.code,
required this.description,
required this.responseMessage,
required this.userfriendlyMessage,
});
late final String code;
late final String description;
late final String responseMessage;
late final UserfriendlyMessage userfriendlyMessage;

CompletePairDevice.fromJson(Map<String, dynamic> json){
code = json['code'];
description = json['description'];
responseMessage = json['response_message'];
userfriendlyMessage = UserfriendlyMessage.fromJson(json['userfriendly_message']);
}

Map<String, dynamic> toJson() {
final _data = <String, dynamic>{};
_data['code'] = code;
_data['description'] = description;
_data['response_message'] = responseMessage;
_data['userfriendly_message'] = userfriendlyMessage.toJson();
return _data;
}
}

class GetDeviceList {
GetDeviceList({
required this.code,
required this.description,
required this.responseMessage,
required this.userfriendlyMessage,
});
late final String code;
late final String description;
late final String responseMessage;
late final UserfriendlyMessage userfriendlyMessage;

GetDeviceList.fromJson(Map<String, dynamic> json){
code = json['code'];
description = json['description'];
responseMessage = json['response_message'];
userfriendlyMessage = UserfriendlyMessage.fromJson(json['userfriendly_message']);
}

Map<String, dynamic> toJson() {
final _data = <String, dynamic>{};
_data['code'] = code;
_data['description'] = description;
_data['response_message'] = responseMessage;
_data['userfriendly_message'] = userfriendlyMessage.toJson();
return _data;
}
}

class GetDeviceDetails {
  GetDeviceDetails({
    required this.code,
    required this.description,
    required this.responseMessage,
    required this.userfriendlyMessage,
  });
  late final String code;
  late final String description;
  late final String responseMessage;
  late final UserfriendlyMessage userfriendlyMessage;

  GetDeviceDetails.fromJson(Map<String, dynamic> json){
    code = json['code'];
    description = json['description'];
    responseMessage = json['response_message'];
    userfriendlyMessage = UserfriendlyMessage.fromJson(json['userfriendly_message']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['description'] = description;
    _data['response_message'] = responseMessage;
    _data['userfriendly_message'] = userfriendlyMessage.toJson();
    return _data;
  }
}