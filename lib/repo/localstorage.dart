import 'package:get_storage/get_storage.dart';

class LocalStorage{
  final box = GetStorage();
  saveActivationToken({required String activationToken}){
    box.write('activation_token', activationToken);
  }
  String loadActivationToken(){
    return box.read('activation_token');
  }
  saveAccessToken({required String accessToken}){
    box.write('access_token', accessToken);
  }

  String loadAccessToken(){
    return box.read('access_token');
  }

  savePassword({required String password}){
    box.write('password', password);
  }

  String? readPassword(){
    return box.read('password');
  }

  savePairToken({required String pairToken}){
    box.write('pair_token',pairToken);
  }

  String loadPairToken(){
    return box.read('pair_token');
  }

  saveLocalCredential({required String ssid, required String key}){
    box.write('local_ssid',ssid);
    box.write('local_key', key);
  }

  String? loadLocalSsid(){
    return box.read('local_ssid');
  }

  String? loadLocalKey(){
    return box.read('local_key');
  }
}