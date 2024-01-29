import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heatronn/devices_list.dart';
import 'package:heatronn/repo/repo.dart';

class RegisteredUserLogin extends StatelessWidget {
  RegisteredUserLogin({super.key});
  final Controller controller = Get.find<Controller>();

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    return Obx(
      ()=> !controller.loggedIn.value? Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('images/logoWithName.png'),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Password...'
                  ),
                  controller: passwordController,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (){
                      String password =  controller.readPassword();
                      if(passwordController.text == password){
                        controller.loggedIn.value = true;
                      }
                    },
                    child: const Text('Login'),
                  ),
                )
              ],
            ),
          ),
        ),
      ):DevicesListScreen(),
    );
  }
}
