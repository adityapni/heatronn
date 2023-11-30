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

  savePassword({required String password}){
    box.write('password', password);
  }
}