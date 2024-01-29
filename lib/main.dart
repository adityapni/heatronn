import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heatronn/registered_user_login.dart';
import 'package:heatronn/repo/repo.dart';
import 'package:heatronn/request_access_code.dart';
import 'package:heatronn/signup.dart';
import 'package:get_storage/get_storage.dart';

void main() async  {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlue, // background (button) color
            foregroundColor: Colors.white, // foreground (text) color
          ),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Heatron'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {

    return Obx(
        ()=> controller.password.value.isEmpty?Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset('images/logoWithName.png'),
                const Text(
                  'There is no account available. Use the signup button to first create an account',
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                  }, child: const Text('New User/ Sign Up'))
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>RequestAccessCodeScreen()));
                  }, child: const Text('Already User/ Request Access'))
                )
              ],
            ),
          ),
        ),
      ):RegisteredUserLogin(),
    );
  }
}
