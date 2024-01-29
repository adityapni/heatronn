import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heatronn/congratulations.dart';
import 'package:heatronn/repo/repo.dart';
import 'package:wifi_iot/wifi_iot.dart';

class ConnectToLocalWifiScreen extends StatelessWidget {
  ConnectToLocalWifiScreen({super.key});
  final Controller controller = Get.find<Controller>();

  @override
  Widget build(BuildContext context) {
    TextEditingController ssidController = TextEditingController(text: controller.loadLocalSsid());
    TextEditingController keyController = TextEditingController(text: controller.loadLocalKey());
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('images/logo.png'),
        title: const Text('Add Device'),
        actions: [
          IconButton(
              onPressed: (){Navigator.popUntil(context, (route) => route.isFirst);},
              icon: const Icon(Icons.close)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text('Connect device to local wifi'),
              const SizedBox(height: 20,),
              TextField(
                decoration: const InputDecoration(
                    labelText: 'SSID...'
                ),
                controller: ssidController,
              ),
              const SizedBox(height: 20,),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: 'Key...'
                ),
                controller: keyController,
              ),
              const SizedBox(height: 20,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){
                    controller.pairDevice(ssid: ssidController.text, key: keyController.text).then((userFriendlyMessage) {
                      if (controller.pairDeviceResponse.value?.error != null) {
                        SnackBar snackBar = SnackBar(content: Text(
                            userFriendlyMessage!));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      if (controller.pairDeviceResponse.value?.result != null) {
                        WiFiForIoTPlugin.forceWifiUsage(false).then((value){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const Congratulations(
                              message: 'Congratulations,device has been added successfully',
                              title: 'Add Devices'))).then((value) => controller.getDevicesList());
                        });
                      }
                    });
                  },
                  child: const Text('Next'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
