import 'package:flutter/material.dart';

class RequestAccessCodeScreen extends StatelessWidget {
  const RequestAccessCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
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
              controller: controller,
            ),
            const SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){},
                child: const Text('Next'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
