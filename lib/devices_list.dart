import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heatronn/add_device.dart';
import 'package:heatronn/create_location.dart';
import 'package:heatronn/device_detail_heater.dart';
import 'package:heatronn/device_detail_sensor.dart';
import 'package:heatronn/repo/repo.dart';

class DevicesListScreen extends StatelessWidget {
  DevicesListScreen({super.key});
  final Controller controller = Get.find<Controller>();
  
  Uint8List decodeImage(String imageString){
    String data = imageString.substring(imageString.indexOf(',')+1);
    Uint8List decoded = base64Decode(data);
    return decoded;
  }

  @override
  Widget build(BuildContext context) {
    controller.getDevicesList().then((userFriendlyMessage) {
      if(controller.getDeviceListResponse.value?.error != null){
        SnackBar snackBar = SnackBar(content: Text(userFriendlyMessage??'Connection Error'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('images/logo.png'),
        title: const Text('Devices'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PopupMenuButton(
              child: const Icon(Icons.add),
              onSelected: (value){
                if(value == 'create location'){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateLocationScreen()));
                }
                if(value == 'add device'){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddDeviceScreen()));
                }
              },
              itemBuilder: (context)=>[
                const PopupMenuItem(
                  value: 'create location',
                  child: Text('Create Location'),
                ),
                const PopupMenuItem(
                  value: 'add device',
                  child: Text('Add Device'),
                )
              ]
            ),
          )
        ],
      ),
      body: Obx(
          () {
            if(controller.getDeviceListResponse.value?.result != null && !controller.isDeviceListLoading.value){
              if(controller.getDeviceListResponse.value!.result!.isEmpty){
                return const Center(
                  child: Text('No device yet. Please create new location, then add new device'),
                );
              }
              return RefreshIndicator(
                onRefresh: () async {
                  controller.getDevicesList();
                },
                child: ListView.builder(
                    itemCount: controller.getDeviceListResponse.value!.result!
                        .length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(controller.getDeviceListResponse.value!.result![index].name),
                        subtitle: Text(controller.getDeviceListResponse.value!.result![index].nameLocation),
                        leading: Image.memory(decodeImage(controller.getDeviceListResponse.value!.result![index].imageLarge)),
                        onTap: (){
                          String idDevice = controller.getDeviceListResponse.value!.result![index].idDevice;
                          String deviceName = controller.getDeviceListResponse.value!.result![index].name;
                          print(' hardware ${controller.getDeviceListResponse.value!.result![index].hardware!.type}');
                          if(controller.getDeviceListResponse.value!.result![index].hardware!.type == 'heater'){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=>DeviceDetailHeater(deviceId: idDevice,deviceName: deviceName,)));
                          } else {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=>DeviceDetailSensor(deviceId: idDevice,deviceName: deviceName,)));
                          }
                        },
                      );
                    }
                ),
              );
            }
            if((controller.getDeviceListResponse.value?.result == null ) && !controller.isDeviceListLoading.value){
              return const Center(
                child: Text('No device yet. Please add new device'),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }
      )
    );
  }
}
