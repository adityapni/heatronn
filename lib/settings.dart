import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heatronn/models/device_details_response.dart';
import 'package:heatronn/repo/repo.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({
    super.key,
    required this.hardware,
    required this.deviceName,
    required this.deviceId
  });
  final Hardware hardware;
  final String deviceName;
  final String deviceId;
  // final TextEditingController nameController = TextEditingController();
  // final TextEditingController connectedController = TextEditingController();
  // Map<String,TextEditingController> nameControllers = {};
  Map<String, TextEditingController> connectedControllers = {};
  final Controller controller = Get.find<Controller>();
  Map<String,String> selectedDeviceIds = {};

  List<Widget> getSettings({required width}){
    List<Widget> settings = [];
    // int connectionSettingIndex = 0;
    List<UserSettings> userSettings = controller.deviceDetailsResponse.value!.result!.userSettings;
    List<UserSettings> connectionSettings = userSettings.where((element)=>element.name == "connections").toList();
    List<String> deviceIds = connectionSettings.map((e) => e.value!.first).toList();
    print('deviceIds $deviceIds');
    List<Elements> requireConnections = hardware.elements.where((element) => element.requirtConnection.availbleConnections!=null).toList();
    for (var (index,element) in requireConnections.indexed) {
      connectedControllers[element.name] = TextEditingController();
      List<Widget> newItems = [
        const SizedBox(height: 20,),
        const Text('Connected Temperature Sensor',style: TextStyle(fontSize: 18),),
        DropdownMenu(
        dropdownMenuEntries: element.requirtConnection.availbleConnections!.first.availableInLocation.map((e) => DropdownMenuEntry(value: e.idDevice, label: e.name)).toList(),
        controller: connectedControllers[element.name],
        onSelected: (value){
          selectedDeviceIds[element.name] = value!;
        },
        initialSelection: deviceIds[index],
        width: width*0.9,
        ),
      ];
      settings.addAll(newItems);
    }
    return settings;

  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('images/logo.png'),
        title: Obx(()=> Text(controller.deviceDetailsResponse.value?.result?.name??deviceName)),
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
            child: Obx(
              ()=> Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Name',style: TextStyle(fontSize: 18),),
                  TextField(controller: controller.nameController,),
                  ...getSettings(width: width),
                  const Spacer(),
                  SizedBox(
                    width: width,
                    child: ElevatedButton(onPressed: (){
                      List<Map<String,dynamic>> updates = [];
                      selectedDeviceIds.forEach((key, value) {
                        updates.add({
                          "element": key,
                          "name": "connections",
                          "value": [
                            value
                          ]
                        });
                      });
                      updates.add({
                        "element": "settings",
                        "name": "name",
                        "value": controller.nameController.text
                      });
                      print('update $updates');
                      controller.updateConnected(body:updates, deviceId: deviceId).then((userFriendlyMessage){
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
      ),
    );
  }
}
