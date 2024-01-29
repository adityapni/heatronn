import 'package:flutter/material.dart';
import 'package:heatronn/createuser.dart';
import 'package:heatronn/repo/repo.dart';
import 'package:get/get.dart';

class VerificationScreen extends StatelessWidget {
  VerificationScreen({super.key});

  final Controller controller = Get.find<Controller>();

  @override
  Widget build(BuildContext context) {
    TextEditingController activationCodeController = TextEditingController();
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
            const Text('Verification for Sign Up',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Access Code...',
              ),
              controller: activationCodeController,
            ),
            const SizedBox(height: 20,),
            const Text('You will receive an email with an access code to your specified email address'),
            const SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: (){
                controller.activate( activationCode: activationCodeController.text)
                .then((value){
                  if(controller.activateResponse.value != null){
                    if(controller.activateResponse.value!.error !=null){
                      SnackBar snackBar = SnackBar(content: Text(controller.activateResponse.value!.error!.message));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CreateUserScreen()));
                    }
                  }
                });
              }, child: const Text('Next')),
            )
          ],
        ),
      ),
    );
  }
}
