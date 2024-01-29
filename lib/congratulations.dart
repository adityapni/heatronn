import 'package:flutter/material.dart';

class Congratulations extends StatelessWidget {
  const Congratulations({super.key,
    required this.message,
    required this.title
  });
  final String message;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('images/logo.png'),
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(message),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text('Go to Home Screen'),
              ),
            )
          ],
        ),
      ),

    );
  }
}
