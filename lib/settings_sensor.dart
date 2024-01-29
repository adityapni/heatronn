import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heatronn/models/sensor_detail_response.dart';
import 'package:heatronn/repo/repo.dart';

class SensorSettingsScreen extends StatelessWidget {
  SensorSettingsScreen({
    super.key,
    required this.hardware,
    required this.deviceName,
    required this.deviceId
  });
  final Hardware hardware;
  final String deviceName;
  final String deviceId;
  final TextEditingController typeController = TextEditingController(text: 'Celcius');
  // final TextEditingController connectedController = TextEditingController();
  // Map<String,TextEditingController> nameControllers = {};
  final Controller controller = Get.find<Controller>();
  Map<String,String> selectedDeviceIds = {};


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('images/logo.png'),
        title: Obx(()=> Text(controller.sensorDetailResponse.value?.result?.name??deviceName)),
        actions: [
          IconButton(
              onPressed: (){Navigator.pop(context);},
              icon: const Icon(Icons.close)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: SizedBox(
            height: height * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Name',style: TextStyle(fontSize: 18),),
                TextField(controller: controller.nameController,),
                const SizedBox(height: 20,),
                const Text('Display type',style: TextStyle(fontSize: 18),),
                DropdownMenu(
                  dropdownMenuEntries: const [
                    DropdownMenuEntry(value: 'Celcius', label: 'Celcius'),
                    DropdownMenuEntry(value: 'Fahrenheit', label: 'Fahrenheit')
                  ],
                  onSelected: (value){
                    typeController.text = value!;
                  },
                  controller: typeController,
                  initialSelection: 'Celcius',
                  width: width *0.9,
                ),
                const Spacer(),
                SizedBox(
                  width: width,
                  child: ElevatedButton(onPressed: (){
                    List<Map<String,dynamic>> updates = [];
                    updates.add({
                      "element": hardware.elements!.first.name,
                      "name": "display_type",
                      "value": typeController.text
                    });
                    updates.add({
                      "element": "settings",
                      "name": "name",
                      "value": controller.nameController.text
                    });
                    print('update $updates');
                    controller.updateConnectedSensor(body:updates, deviceId: deviceId).then((userFriendlyMessage){
                      if(userFriendlyMessage!=null){
                        SnackBar snackBar = SnackBar(content: Text(userFriendlyMessage));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      Navigator.pop(context);
                    });
                    }, child: const Text('Update')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
