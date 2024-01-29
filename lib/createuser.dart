import 'package:flutter/material.dart';
import 'package:heatronn/congratulations.dart';
import 'package:heatronn/repo/repo.dart';
import 'package:get/get.dart';

class CreateUserScreen extends StatelessWidget {
  CreateUserScreen({super.key});

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPassController = TextEditingController();
  final Controller controller = Get.find<Controller>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('images/logo.png'),
        title: const Text('Signup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Secure app with Login',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Password...',
              ),
              controller: passwordController,
            ),
            const SizedBox(height: 20,),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Repeat Password...',
              ),
              controller: repeatPassController,
            ),
            const SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: (){
                if(passwordController.text == repeatPassController.text){
                  controller.savePassword(password: passwordController.text);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const Congratulations(
                    title: 'Signup',
                    message: 'Congratulations, registration was successful',
                  )));
                } else {
                  SnackBar snackBar = const SnackBar(content: Text('Wrong password. Please re enter your password'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              }, child: const Text('Next')),
            )
          ],
        ),
      ),
    );
  }
}
