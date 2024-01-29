import 'dart:convert';

import 'package:heatronn/models/activate_response.dart';
import 'package:heatronn/models/create_location_response.dart';
import 'package:heatronn/models/device_details_response.dart';
import 'package:heatronn/models/error_list.dart';
import 'package:heatronn/models/get_device_list_response.dart';
import 'package:heatronn/models/get_locations_response.dart';
import 'package:heatronn/models/pair_device_response.dart';
import 'package:heatronn/models/request_info_response.dart';
import 'package:heatronn/models/request_pair_device_response.dart';
import 'package:heatronn/models/sensor_detail_response.dart';
import 'package:heatronn/models/signup_response.dart';
import 'package:heatronn/models/update_device_response.dart';
import 'package:http/http.dart' as http;

class APICalls{
  Map<String,String> headers = {'Authorization': 'Bearer 2D6XeO1qSCcQhmyq2dVLH3N0M0BFiGmThfT7QkPnhZCkRjrZ1qtDByk8zYPj5SK9GHZC0CNUmukv0vDzgCjdziPJ7D1HL3h2MLs9uOVIXGWSilXWDXpzaUT'};
  String serverUrl = 'api.sbx';
  Future<SignUpResponse> postSignUp({required String firstName, required String lastName, required String email})
  async {
    String url = 'https://$serverUrl.heatronn.com/user/v1/signup';
    Uri uri = Uri.parse(url);
    Map<String,String> body = {
      "fistname": firstName,
      "lastname": lastName,
      "email": email
    };

    http.Response response =  await http.post(uri,body: jsonEncode(body),headers: headers);
    print('signupresponse ${response.body}');
    SignUpResponse signUpResponse = SignUpResponse.fromJson(jsonDecode(response.body));
    return signUpResponse;
  }

  Future<ActivateResponse> postActivate({required String activationToken, required String activationCode}) async {
    String url = 'https://$serverUrl.heatronn.com/user/v1/activate';
    Uri uri = Uri.parse(url);
    Map<String,String> body = {
      "activation_token": activationToken,
      "activation_code": activationCode
    };
    http.Response response = await http.post(uri,body:jsonEncode(body),headers: headers);
    print('response ${response.body}');
    ActivateResponse activateResponse = ActivateResponse.fromJson(jsonDecode(response.body));
    return activateResponse;
  }

  Future<SignUpResponse> postRequestAccess({required String email}) async {
    String url = 'https://$serverUrl.heatronn.com/user/v1/requestAccess';
    Uri uri = Uri.parse(url);
    Map<String,String> body = {
      "email": email
    };
    http.Response response = await http.post(uri,body:jsonEncode(body),headers: headers);
    SignUpResponse signUpResponse = SignUpResponse.fromJson(jsonDecode(response.body));
    return signUpResponse;
  }

  Future<ErrorList> getErrorList() async {
    String url = 'https://$serverUrl.heatronn.com/user/v1/getErrorList';
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri,headers: headers);
    ErrorList errorList = ErrorList.fromJson(jsonDecode(response.body));
    return errorList;
  }

  Future<GetDeviceListResponse> getDevicesList({required String accessToken}) async {
    String url = 'https://$serverUrl.heatronn.com/user/v1/getDeviceList';
    Map<String,String> activationHeader = {'Authorization': 'Bearer $accessToken'};
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri,headers: activationHeader);
    print('response ${response.body}');
    GetDeviceListResponse getDeviceListResponse = GetDeviceListResponse.fromJson(jsonDecode(response.body));
    return getDeviceListResponse;
  }

  Future<RequestPairDeviceResponse> postRequestPairDevice({required String name, required String location, required String accessToken}) async {
    String url = 'https://$serverUrl.heatronn.com/user/v1/requestPairDevice';
    Uri uri  = Uri.parse(url);
    Map<String,String> body = {
      "name":name,
      "id_location": location
    };
    print('request $body');
    Map<String,String> activationHeader = {'Authorization': 'Bearer $accessToken'};
    http.Response response = await http.post(uri,body: jsonEncode(body),headers: activationHeader);
    print('response ${response.body}');
    RequestPairDeviceResponse requestPairDeviceResponse = RequestPairDeviceResponse.fromJson(jsonDecode(response.body));
    return requestPairDeviceResponse;
  }

  Future<RequestInfoResponse> postRequestInfo() async {
    String url  = 'http://192.168.4.1:8877';
    Uri uri = Uri.parse(url);
    Map<String,String> body = {
      "ask":"info"
    };
    http.Response response = await http.post(uri,body: jsonEncode(body));
    print('response ${response.body}');
    RequestInfoResponse requestInfoResponse = RequestInfoResponse.fromJson(jsonDecode(response.body));
    return requestInfoResponse;
  }

  Future<PairDeviceResponse> postPairDevice({required String ssid, required String key, required String pairToken}) async {
    String url  = 'http://192.168.4.1:8877';
    Uri uri = Uri.parse(url);
    Map<String,dynamic> body = {
      "pair": {
        "PAIR_TOKEN": pairToken,
        "WIFI_SSID": ssid,
        "WIFI_KEY": key
      }
    };
    http.Response response = await http.post(uri,body: jsonEncode(body));
    print('response ${response.body}');
    PairDeviceResponse pairDeviceResponse = PairDeviceResponse.fromJson(jsonDecode(response.body));
    return pairDeviceResponse;
  }

  Future<CreateLocationResponse> createLocation({required String name, required String type, required String accessToken}) async {
    String url = 'https://$serverUrl.heatronn.com/user/v1/createLocation';
    Uri uri = Uri.parse(url);
    Map <String,String> body = {
      "name": name,
      "type": type
    };
    Map<String,String> activationHeader = {'Authorization': 'Bearer $accessToken'};
    http.Response response = await http.post(uri,headers: activationHeader,body: jsonEncode(body));
    print('response ${response.body}');
    CreateLocationResponse createLocationResponse = CreateLocationResponse.fromJson(jsonDecode(response.body));
    return createLocationResponse;
  }

  Future<GetLocationsResponse> getLocations({required String accessToken}) async {
    String url = 'https://$serverUrl.heatronn.com/user/v1/getLocations';
    Uri uri = Uri.parse(url);
    Map<String,String> activationHeader = {'Authorization': 'Bearer $accessToken'};
    http.Response response = await http.get(uri,headers: activationHeader);
    print('response ${response.body}');
    GetLocationsResponse getLocationsResponse = GetLocationsResponse.fromJson(jsonDecode(response.body));
    return getLocationsResponse;
  }

  Future<DeviceDetailsResponse> getDeviceDetails({required String deviceId, required String accessToken}) async {
    String url = 'https://$serverUrl.heatronn.com/user/v1/getDeviceDetails/$deviceId';
    Uri uri = Uri.parse(url);
    Map<String,String> activationHeader = {'Authorization': 'Bearer $accessToken'};
    http.Response response = await http.get(uri,headers: activationHeader);
    print('response ${response.body}');
    DeviceDetailsResponse deviceDetailsResponse = DeviceDetailsResponse.fromJson(jsonDecode(response.body));
    return deviceDetailsResponse;
  }

  Future<SensorDetailResponse> getSensorDetails({required String deviceId, required String accessToken}) async {
    String url = 'https://$serverUrl.heatronn.com/user/v1/getDeviceDetails/$deviceId';
    Uri uri = Uri.parse(url);
    Map<String,String> activationHeader = {'Authorization': 'Bearer $accessToken'};
    http.Response response = await http.get(uri,headers: activationHeader);
    print('response ${response.body}');
    SensorDetailResponse sensorDetailResponse = SensorDetailResponse.fromJson(jsonDecode(response.body));
    return sensorDetailResponse;
  }

  Future<UpdateDeviceResponse> updateDevice({required String deviceId, required String accessToken,
  required List<Map<String,dynamic>> body}) async {
    String url = 'https://$serverUrl.heatronn.com/user/v1/updateDevice/$deviceId';
    Uri uri = Uri.parse(url);
    Map<String,String> activationHeader = {'Authorization': 'Bearer $accessToken'};
    http.Response response = await http.put(uri,headers: activationHeader,body: jsonEncode(body));
    print('response ${response.body}');
    UpdateDeviceResponse updateDeviceResponse = UpdateDeviceResponse.fromJson(jsonDecode(response.body));
    return updateDeviceResponse;
  }
}

