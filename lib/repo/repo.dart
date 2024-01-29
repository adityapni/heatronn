

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
import 'package:heatronn/repo/apicalls.dart';
import 'package:heatronn/repo/localstorage.dart';

class Controller extends GetxController{

  APICalls apiCalls = APICalls();
  Rxn<SignUpResponse> signUpResponse = Rxn<SignUpResponse>();
  Rxn<ActivateResponse> activateResponse = Rxn<ActivateResponse>();
  Rxn<SignUpResponse> requestActivationResponse = Rxn<SignUpResponse>();
  Rxn<ErrorList> errorListResponse = Rxn<ErrorList>();
  LocalStorage localStorage = LocalStorage();
  RxString password = ''.obs;
  Rxn<RequestPairDeviceResponse> requestPairDeviceResponse = Rxn<RequestPairDeviceResponse>();
  Rx<DeviceConnectionStatus> connectionToDeviceStatus = DeviceConnectionStatus.scanningQR.obs;
  RxBool loggedIn = false.obs;
  Rxn<RequestInfoResponse> requestInfoResponse = Rxn<RequestInfoResponse>();
  Rxn<PairDeviceResponse> pairDeviceResponse = Rxn<PairDeviceResponse>();
  Rxn<GetDeviceListResponse> getDeviceListResponse = Rxn<GetDeviceListResponse>();
  RxBool isDeviceListLoading = false.obs;
  Rxn<CreateLocationResponse> createLocationResponse = Rxn<CreateLocationResponse>();
  Rxn<GetLocationsResponse> getLocationsResponse = Rxn<GetLocationsResponse>();
  RxBool isLocationsLoading = false.obs;
  Rxn<DeviceDetailsResponse> deviceDetailsResponse = Rxn<DeviceDetailsResponse>();
  RxBool isDeviceDetailsLoading = false.obs;
  Rxn<SensorDetailResponse> sensorDetailResponse = Rxn<SensorDetailResponse>();
  RxBool isSensorDetailLoading = false.obs;
  RxInt tempTimerCount = 4.obs;
  RxInt temperature = 0.obs;
  Rxn<UpdateDeviceResponse> updateDeviceResponse = Rxn<UpdateDeviceResponse>();
  TextEditingController nameController = TextEditingController();

  @override
  onInit() async {
    super.onInit();
    await getErrorList();
    password.value = readPassword();
    print('password ${password.value}');
  }

  Future<String?> signUp({
    required String email,
    required String firstName,
    required String lastName
  }) async {
    signUpResponse.value = await apiCalls.postSignUp(firstName: firstName, lastName: lastName, email: email);
    if (signUpResponse.value?.result?.activationToken!= null){
      String activationToken = signUpResponse.value!.result!.activationToken;
      localStorage.saveActivationToken(activationToken: activationToken);
    }
    if(signUpResponse.value!.error != null){
      String errorCode = signUpResponse.value!.error!.code.toString();
      String userFriendlyMessage = errorListResponse.value!.result.signup
          .firstWhere((element) => element.code == errorCode).userfriendlyMessage.en;
      return userFriendlyMessage;
    }
    return null;
  }

  Future<String?> activate({
    required String activationCode
  }) async {
    String activationToken = localStorage.loadActivationToken();
    activateResponse.value = await apiCalls.postActivate(activationToken: activationToken, activationCode: activationCode);
    if (activateResponse.value?.result?.accessToken!=null){
      String accessToken = activateResponse.value!.result!.accessToken;
      localStorage.saveAccessToken(accessToken: accessToken);
    }
    if (activateResponse.value?.error != null){
      String errorCode = activateResponse.value!.error!.code.toString();
      String userFriendlyMessage = errorListResponse.value!.result.activate
          .firstWhere((element) => element.code == errorCode).userfriendlyMessage.en;
      return userFriendlyMessage;
    }
    return null;
  }

  savePassword({required String password}){
    localStorage.savePassword(password: password);
    this.password.value = password;
  }

  Future<String?> requestActivation({required String email}) async {
    requestActivationResponse.value = await apiCalls.postRequestAccess(email: email);
    if (requestActivationResponse.value?.result?.activationToken!= null){
      String activationToken = requestActivationResponse.value!.result!.activationToken;
      localStorage.saveActivationToken(activationToken: activationToken);
    }
    if(requestActivationResponse.value!.error != null){
      String errorCode = requestActivationResponse.value!.error!.code.toString();
      String userFriendlyMessage = errorListResponse.value!.result.requestAccess
          .firstWhere((element) => element.code == errorCode).userfriendlyMessage.en;
      return userFriendlyMessage;
    }
    return null;
  }

  String readPassword(){
    return localStorage.readPassword()??'';
  }

  getErrorList() async {
    errorListResponse.value = await apiCalls.getErrorList();
  }

  Future<String?> getDevicesList() async {
    isDeviceListLoading.value = true;
    String accessToken = localStorage.loadAccessToken();
    getDeviceListResponse.value = await apiCalls.getDevicesList(accessToken: accessToken);
    if(getDeviceListResponse.value?.error !=null){
      String errorCode = requestPairDeviceResponse.value!.error!.code.toString();
      String userFriendlyMessage = errorListResponse.value!.result.getDeviceList
          .firstWhere((element) => element.code == errorCode).userfriendlyMessage.en;
      isDeviceListLoading.value = false;
      return userFriendlyMessage;
    }
    isDeviceListLoading.value = false;
    return null;
  }

  Future<String?> requestPairDevice({required String name, required String location}) async{
    String accessToken = localStorage.loadAccessToken();
    requestPairDeviceResponse.value = await apiCalls.postRequestPairDevice(name: name, location: location, accessToken: accessToken);
    if(requestPairDeviceResponse.value?.result?.pairToken!=null){
      localStorage.savePairToken(pairToken: requestPairDeviceResponse.value!.result!.pairToken);
    }
    if(requestPairDeviceResponse.value?.error != null){
      String errorCode = requestPairDeviceResponse.value!.error!.code.toString();
      String userFriendlyMessage = errorListResponse.value!.result.requestAccess
          .firstWhere((element) => element.code == errorCode).userfriendlyMessage.en;
      return userFriendlyMessage;
    }
    return null;
  }

  Future<String?> requestInfo() async {
    requestInfoResponse.value = await apiCalls.postRequestInfo();
    // for testing
    // Map<String,dynamic> response = {
    //   "status": "success",
    //   "result": {
    //     "name": "Smart Home V3",
    //     "mac": "76:jhj:87:98"
    //   }
    // };
    // requestInfoResponse.value = RequestInfoResponse.fromJson(jsonDecode(jsonEncode(response)));
    if(requestInfoResponse.value?.error != null){
      // String errorCode = requestInfoResponse.value!.error!.code.toString();
      return requestInfoResponse.value!.error!.message;
    }
    return null;
  }

  Future<String?> pairDevice({required String ssid, required String key }) async {
    String pairToken = localStorage.loadPairToken();
    pairDeviceResponse.value =  await apiCalls.postPairDevice(ssid: ssid, key: key, pairToken: pairToken);
    if(pairDeviceResponse.value?.error != null){
      return pairDeviceResponse.value!.error!.message;
    }
    if(pairDeviceResponse.value?.result!=null){
      localStorage.saveLocalCredential(ssid: ssid, key: key);
    }
    return null;
  }

  String? loadLocalSsid(){
    return localStorage.loadLocalSsid();
  }

  String? loadLocalKey(){
    return localStorage.loadLocalKey();
  }

  Future<String?> createLocation({required String name, required String type}) async {
    String accessToken = localStorage.loadAccessToken();
    createLocationResponse.value = await apiCalls.createLocation(name: name, type: type,accessToken: accessToken);
    if(createLocationResponse.value?.error !=null){
      return createLocationResponse.value!.error!.message;
    }
    return null;
  }

  Future<String?> getLocation() async {
    isLocationsLoading.value = true;
    String accessToken = localStorage.loadAccessToken();
    getLocationsResponse.value = await apiCalls.getLocations(accessToken: accessToken);
    isLocationsLoading.value = false;
    if(getLocationsResponse.value?.error != null){
      return getLocationsResponse.value!.error!.message;
    }
    return null;
  }

  Future<String?> getDeviceDetails({required String deviceId}) async {
    String accessToken = localStorage.loadAccessToken();
    isDeviceDetailsLoading.value = true;
    deviceDetailsResponse.value = await apiCalls.getDeviceDetails(deviceId: deviceId, accessToken: accessToken);
    isDeviceDetailsLoading.value = false;
    if(deviceDetailsResponse.value?.error !=null){
      String errorCode = deviceDetailsResponse.value!.error!.code.toString();
      String userFriendlyMessage = errorListResponse.value!.result.getDeviceDetails
          .firstWhere((element) => element.code == errorCode).userfriendlyMessage.en;
      return userFriendlyMessage;
    }
    return null;
  }

  Future<String?> getSensorDetails({required String deviceId}) async {
    String accessToken = localStorage.loadAccessToken();
    isSensorDetailLoading.value = true;
    sensorDetailResponse.value = await apiCalls.getSensorDetails(deviceId: deviceId, accessToken: accessToken);
    isSensorDetailLoading.value = false;
    if(sensorDetailResponse.value?.error !=null){
      String errorCode = sensorDetailResponse.value!.error!.code.toString();
      String userFriendlyMessage = errorListResponse.value!.result.getDeviceDetails
          .firstWhere((element) => element.code == errorCode).userfriendlyMessage.en;
      return userFriendlyMessage;
    }
    temperature.value = int.parse(sensorDetailResponse.value!.result!.userSettings!.first!.value!.toString());
    return null;
  }

  Future<String?> updateTemperature({required String temperature,required String deviceId,
    required String element, required String name}) async {
    String accessToken = localStorage.loadAccessToken();
    List<Map<String,String>> body = [{
      "element": element,
      "name": name,
      "value": temperature
    }];
    updateDeviceResponse.value = await apiCalls.updateDevice(deviceId: deviceId, accessToken: accessToken, body: body);
    if(updateDeviceResponse.value?.error != null){
      return updateDeviceResponse.value!.error!.message;
    }
    getSensorDetails(deviceId: deviceId);
    return null;
  }

  Future<String?> updateConnected({required List<Map<String,dynamic>> body, required String deviceId}) async {
    String accessToken = localStorage.loadAccessToken();
    updateDeviceResponse.value = await apiCalls.updateDevice(deviceId: deviceId, accessToken: accessToken, body: body);
    if(updateDeviceResponse.value?.error != null){
      return updateDeviceResponse.value!.error!.message;
    }
    await getDeviceDetails(deviceId: deviceId);
    return null;
  }

  Future<String?> updateConnectedSensor({required List<Map<String,dynamic>> body, required String deviceId}) async {
    String accessToken = localStorage.loadAccessToken();
    updateDeviceResponse.value = await apiCalls.updateDevice(deviceId: deviceId, accessToken: accessToken, body: body);
    if(updateDeviceResponse.value?.error != null){
      return updateDeviceResponse.value!.error!.message;
    }
    await getSensorDetails(deviceId: deviceId);
    return null;
  }

  updateNameSettings({required String deviceName}){
    nameController.text = deviceName;
  }
}


enum DeviceConnectionStatus{
  scanningQR, connecting, connected
}