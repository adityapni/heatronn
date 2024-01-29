import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heatronn/repo/repo.dart';
import 'package:heatronn/verification.dart';


class RequestAccessCodeScreen extends StatelessWidget {
  RequestAccessCodeScreen({super.key});
  final Controller controller = Get.find<Controller>();

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('images/logo.png'),
        title: const Text('Request Access'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Request Access Code',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            const SizedBox(height: 20,),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email...'
              ),
              controller: emailController,
            ),
            const SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                  controller.requestActivation(email: emailController.text)
                  .then((userFriendlyMessage){
                    if(controller.requestActivationResponse.value != null){
                      if(controller.requestActivationResponse.value!.error !=null){
                        SnackBar snackBar = SnackBar(content: Text(userFriendlyMessage??'Something is wrong'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>VerificationScreen()));
                      }
                    }
                  });
                },
                child: const Text('Next'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
