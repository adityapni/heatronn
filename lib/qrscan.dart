import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heatronn/connect_to_local.dart';
import 'package:heatronn/repo/repo.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:wifi_iot/wifi_iot.dart';

class QRScanScreen extends StatelessWidget {
  QRScanScreen({super.key});
  final Controller controller = Get.find<Controller>();

  Future<String?> getPreviousWifiSsid() async {
    bool isConnected = await WiFiForIoTPlugin.isConnected();
    if (isConnected){
      return await WiFiForIoTPlugin.getSSID();
    }
    return null;
  }

  Future<String?> connectAndRequestInfo({required String ssid, required String pass}) async {
    controller.connectionToDeviceStatus.value = DeviceConnectionStatus.connecting;
    bool connected = await WiFiForIoTPlugin.connect(ssid,password: pass,security: NetworkSecurity.WPA);
    if(connected){
      try{
        // await Future.delayed(const Duration(seconds: 4));
        await WiFiForIoTPlugin.forceWifiUsage(true);
        controller.requestInfo().then((userFriendlyMessage){
          if(controller.requestInfoResponse.value?.error != null){
            return userFriendlyMessage??'Connection Error';
          }
          if(controller.requestInfoResponse.value?.result != null){
            controller.connectionToDeviceStatus.value = DeviceConnectionStatus.connected;
          }
        });
      } catch(e){
        return '$e';
      }

    } else {
      return 'Error connecting to $ssid';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(
            (){
              switch (controller.connectionToDeviceStatus.value){
              case DeviceConnectionStatus.scanningQR:
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Add Devices',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 20,),
                      const Text('Please scan QRCode on device',style: TextStyle(fontSize: 20),),
                      const SizedBox(height: 20,),
                      SizedBox(
                        height: height *0.7,
                        child: MobileScanner(
                          // fit: BoxFit.contain,
                          onDetect: (capture) {
                            final List<Barcode> barcodes = capture.barcodes;
                            // final Uint8List? image = capture.image;
                            final String? qrCodeParsed = barcodes[0].rawValue;
                            if(qrCodeParsed != null){
                              String ssid = qrCodeParsed.substring(qrCodeParsed.indexOf('S:')+2,qrCodeParsed.indexOf(';P'));
                              String pass  = qrCodeParsed.substring(qrCodeParsed.indexOf('P:')+2,qrCodeParsed.indexOf(';H'));
                              getPreviousWifiSsid().then((previousSSID){
                                if(ssid != previousSSID && previousSSID!=null){
                                  WiFiForIoTPlugin.isConnected().then((isConnected){
                                    if(isConnected){
                                      WiFiForIoTPlugin.disconnect().then((value){
                                        controller.connectionToDeviceStatus.value = DeviceConnectionStatus.connecting;
                                        connectAndRequestInfo(ssid: ssid, pass: pass).then((error){
                                          if(error!=null){
                                            SnackBar snackBar = SnackBar(content: Text(error));
                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                          }
                                        });
                                      });
                                    } else {
                                      controller.connectionToDeviceStatus.value = DeviceConnectionStatus.connecting;
                                      connectAndRequestInfo(ssid: ssid, pass: pass).then((error){
                                        if(error!=null){
                                          SnackBar snackBar = SnackBar(content: Text(error));
                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                        }
                                      });
                                    }
                                  });
                                }
                                if(ssid == previousSSID){
                                  WiFiForIoTPlugin.forceWifiUsage(true).then((value){
                                    // ssid is same as before, skip connecting
                                    controller.requestInfo().then((userFriendlyMessage){
                                      if(controller.requestInfoResponse.value?.error != null){
                                        SnackBar snackBar = SnackBar(content: Text(userFriendlyMessage??'Connection Error'));
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      }
                                    });
                                  });
                                }
                                if(previousSSID == null){
                                  connectAndRequestInfo(ssid: ssid, pass: pass).then((error){
                                    if(error!=null){
                                      SnackBar snackBar = SnackBar(content: Text(error));
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    }
                                    if(controller.requestInfoResponse.value?.result != null){
                                      controller.connectionToDeviceStatus.value = DeviceConnectionStatus.connected;
                                    }
                                  });
                                }
                              });
                              // for testing
                              // controller.requestInfo().then((value){
                              //   controller.connectionToDeviceStatus.value = DeviceConnectionStatus.connected;
                              // });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                );

              case DeviceConnectionStatus.connecting:
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Add Devices',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 20,),
                      const Text('Please scan QRCode on device',style: TextStyle(fontSize: 20),),
                      const SizedBox(height: 20,),
                      Center(
                        child: SizedBox(
                          width: width * 0.5,
                          child: const FittedBox(child: Icon(Icons.wifi,color: Colors.lightBlue,)
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Center(
                        child: Countdown(
                          seconds: 60,
                          build: (BuildContext context, double time) => Text(time.round().toString()),
                          onFinished: (){
                            if(controller.connectionToDeviceStatus.value == DeviceConnectionStatus.connected){
                              // do nothing
                            }
                            if(controller.connectionToDeviceStatus.value == DeviceConnectionStatus.connecting){
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 20,),
                    ],
                  ),
                );
              default: return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(controller.requestInfoResponse.value?.result?.name??'Unknown Device',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 20,),
                  const Text('Connected',style: TextStyle(fontSize: 20),),
                  const SizedBox(height: 20,),
                  Center(
                    child: SizedBox(
                      height: height * 0.5,
                      width: double.infinity,
                      child: const FittedBox(child: Icon(Icons.check_circle,color: Colors.green,)
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ConnectToLocalWifiScreen()));
                      },
                      child: const Text('Next'),
                    ),
                  )
                ],
              );
            }
        }),
      ),
    );
  }
}
