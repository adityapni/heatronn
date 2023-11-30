import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heatronn/repo/repo.dart';
import 'package:heatronn/verification.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final Controller controller = Get.find<Controller>();

  @override
  Widget build(BuildContext context) {
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('images/logo.png'),
        title: const Text('Signup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              'Name and Address',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(
                labelText: 'First Name...'
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(
                  labelText: 'Last Name...'
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                  labelText: 'Email...'
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: (){
                controller.signUp(email: emailController.text, firstName: firstNameController.text, lastName: lastNameController.text);
                if(controller.signUpResponse.value?.error !=null){
                  SnackBar snackBar = SnackBar(content: Text(controller.signUpResponse.value!.error!));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>VerificationScreen()));
                }
              }, child: const Text('Next'))
            )
          ],
        ),
      ),
    );
  }
}
