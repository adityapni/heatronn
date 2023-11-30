import 'package:get/get.dart';
import 'package:heatronn/models/activate_response.dart';
import 'package:heatronn/models/signup_response.dart';
import 'package:heatronn/repo/apicalls.dart';
import 'package:heatronn/repo/localstorage.dart';

class Controller extends GetxController{

  APICalls apiCalls = APICalls();
  Rxn<SignUpResponse> signUpResponse = Rxn<SignUpResponse>();
  Rxn<ActivateResponse> activateResponse = Rxn<ActivateResponse>();
  LocalStorage localStorage = LocalStorage();

  signUp({
    required String email,
    required String firstName,
    required String lastName
  }) async {
    signUpResponse.value = await apiCalls.postSignUp(firstName: firstName, lastName: lastName, email: email);
    if (signUpResponse.value?.result?.activationToken!= null){
      String activationToken = signUpResponse.value!.result!.activationToken;
      localStorage.saveActivationToken(activationToken: activationToken);
    }
  }

  activate({
    required String activationCode
  }) async {
    String activationToken = localStorage.loadActivationToken();
    activateResponse.value = await apiCalls.postActivate(activationToken: activationToken, activationCode: activationCode);
    if (activateResponse.value?.result?.accessToken!=null){
      String accessToken = activateResponse.value!.result!.accessToken;
      localStorage.saveAccessToken(accessToken: accessToken);
    }
  }

  savePassword({required String password}){
    localStorage.savePassword(password: password);
  }
}