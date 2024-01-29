import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heatronn/repo/repo.dart';
import 'package:heatronn/settings_sensor.dart';

class DeviceDetailSensor extends StatelessWidget {
  DeviceDetailSensor({
    super.key,
    required this.deviceId,
    required this.deviceName
  });

  final Controller controller = Get.find<Controller>();
  final String deviceId;
  final String deviceName;

  List<Widget> getSensors(){
    final liveData = controller.sensorDetailResponse.value!.result!.liveData;
    if(liveData!=null){
      return [DeviceTypeAndTemperature(temperature: '${liveData.data!.temperature!.current}ᶜ', purpose: 'temperature')];
    } else {
      return const [DeviceTypeAndTemperature(temperature: '0ᶜ', purpose: 'temperature')];
    }
  }

  List<Widget> getTemperatureController({required double width}){
    if(controller.sensorDetailResponse.value!.result!.userSettings !=null){
      final data = controller.sensorDetailResponse.value!.result!.userSettings!.first;
      return [
        const SizedBox(height: 20,),
        SizedBox(
          width: width*0.25,
          child: FittedBox(
            fit: BoxFit.cover,
            child: IconButton(
              icon: const Icon(CupertinoIcons.arrowtriangle_up_square_fill,color: Colors.lightBlue,),
              onPressed: (){
                controller.temperature.value++;
                controller.tempTimerCount.value = 4;
                Timer.periodic(const Duration(seconds: 1), (timer) {
                  controller.tempTimerCount.value--;
                  if(controller.tempTimerCount.value==0){
                    controller.updateTemperature(temperature: controller.temperature.value.toString(),
                        deviceId: controller.sensorDetailResponse.value!.result!.idDevice!,
                        element: controller.sensorDetailResponse.value!.result!.hardware!.elements!.first.name!,
                        name: 'temperature');
                  }
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 20,),
        Text('${controller.temperature.value}ᶜ',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 60),),
        const SizedBox(height: 20,),
        SizedBox(
          width: width*0.25,
          child: FittedBox(
            fit: BoxFit.cover,
            child: IconButton(
              icon: const Icon(CupertinoIcons.arrowtriangle_down_square_fill,color: Colors.lightBlue),
              onPressed: (){
                controller.temperature.value--;
                controller.tempTimerCount.value = 4;
                Timer.periodic(const Duration(seconds: 1), (timer) {
                  controller.tempTimerCount.value--;
                  if(controller.tempTimerCount.value==0){
                    controller.updateTemperature(temperature: controller.temperature.value.toString(),
                        deviceId: controller.sensorDetailResponse.value!.result!.idDevice!,
                        element: controller.sensorDetailResponse.value!.result!.hardware!.elements!.first.name!,
                        name: 'temperature');
                  }
                });
              },
            ),
          ),
        ),
      ];
    } else {
      return [
        Container(),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    controller.getSensorDetails(deviceId: deviceId);
    double width = MediaQuery.of(context).size.width;
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
      body: Obx(
            ()=> !controller.isSensorDetailLoading.value?
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: controller.sensorDetailResponse.value?.result!=null?
                <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon:const Icon(Icons.settings),
                      onPressed: (){
                        controller.updateNameSettings(deviceName: controller.sensorDetailResponse.value?.result?.name??deviceName);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>SensorSettingsScreen(
                                hardware: controller.sensorDetailResponse.value!.result!.hardware!,
                                deviceName: deviceName, deviceId: deviceId)));
                      },
                    ),
                  ),
                  ...getSensors(),
                  ...getTemperatureController(width: width)
                ]:[const Text('No data')],
              ),
            ):const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class DeviceTypeAndTemperature extends StatelessWidget {
  const DeviceTypeAndTemperature({
    super.key,
    required this.temperature,
    required this.purpose,
    this.color
  });

  final String temperature;
  final String purpose;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(temperature,style: const TextStyle(fontSize: 60,fontWeight: FontWeight.bold),),
          const SizedBox(width: 20,),
          Column(
            children: [
              SizedBox(
                width: width*0.25,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Icon(Icons.fireplace,color: color,),
                ),
              ),
              Text(purpose)
            ],
          )
        ],
      ),
    );
  }
}


