import 'dart:convert';

import 'package:heatronn/models/activate_response.dart';
import 'package:heatronn/models/signup_response.dart';
import 'package:http/http.dart' as http;

class APICalls{
  Map<String,String> headers = {'Heatronn-App-Token': '2D6XeO1qSCcQhmyq2dVLH3N0M0BFiGmThfT7QkPnhZCkRjrZ1qtDByk8zYPj5SK9GHZC0CNUmukv0vDzgCjdziPJ7D1HL3h2MLs9uOVIXGWSilXWDXpzaUT'};
  Future<SignUpResponse> postSignUp({required String firstName, required String lastName, required String email})
  async {
    String url = 'https://api.sbx.heatronn.com/user/v1/signup';
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
    String url = 'https://api.sbx.heatronn.com/user/v1/activate';
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
}

