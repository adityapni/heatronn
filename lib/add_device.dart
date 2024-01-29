import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heatronn/qrscan.dart';
import 'package:heatronn/repo/repo.dart';
import 'package:wifi_iot/wifi_iot.dart';

class AddDeviceScreen extends StatelessWidget {
  AddDeviceScreen({super.key});
  final Controller controller = Get.find<Controller>();
  final TextEditingController deviceNameController = TextEditingController();
  final TextEditingController deviceLocationController = TextEditingController();

  Future<bool> disconnectFromHeatronnDevice() async {
    String? ssid = await WiFiForIoTPlugin.getSSID();
    bool isConnectedToHeatronnDeviceWifi = ssid?.contains('HEATRONN')??false;
    if(isConnectedToHeatronnDeviceWifi){
      await WiFiForIoTPlugin.disconnect();
      return await WiFiForIoTPlugin.forceWifiUsage(false);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
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
      body: GetX<Controller>(
        initState: (state){
          controller.getLocation();
        },
        builder:(controller) {
          if(controller.isLocationsLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                        labelText: 'Device name...'
                    ),
                    controller: deviceNameController,
                  ),
                  const SizedBox(height: 20,),
                  controller.getLocationsResponse.value?.result!=null?
                  DropdownMenu(
                    controller: deviceLocationController,
                    dropdownMenuEntries: controller.getLocationsResponse.value!.result!
                      .map((e) => DropdownMenuEntry(value: e.idLocation, label: e.name)).toList(),
                    label: const Text('Select location'),
                    requestFocusOnTap: false,
                    width: width * 0.9,
                    onSelected: (value){
                      deviceLocationController.text = value!;
                    },
                  ):
                  const Text('No Location Available. Please create location first'),
                  const SizedBox(height: 20,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        disconnectFromHeatronnDevice().then((value) {
                          controller.connectionToDeviceStatus.value =
                              DeviceConnectionStatus.scanningQR;
                          controller.requestPairDevice(
                              name: deviceNameController.text,
                              location: deviceLocationController.text)
                              .then((userFriendlyMessage) {
                            if (controller.requestPairDeviceResponse.value
                                ?.error != null) {
                              SnackBar snackBar = SnackBar(content: Text(
                                  userFriendlyMessage ?? 'Something is wrong'));
                              ScaffoldMessenger.of(context).showSnackBar(
                                  snackBar);
                            }
                            if (controller.requestPairDeviceResponse.value
                                ?.result != null) {
                              WiFiForIoTPlugin.isEnabled().then((isEnabled) {
                                if (isEnabled) {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => QRScanScreen()));
                                } else {
                                  showDialog(
                                      context: context, builder: (context) =>
                                      AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: const Text('Wifi not available'),
                                        content: const Text(
                                            'Please turn wifi on'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text('Close'),
                                          ),
                                        ],
                                      ));
                                }
                              });
                            }
                          });
                        });
                      },
                      child: const Text('Finish'),
                    ),
                  )
                ],
              ),
            );
          }
        }
      ),
    );
  }
}
