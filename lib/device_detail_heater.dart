

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heatronn/models/device_details_response.dart';
import 'package:heatronn/repo/repo.dart';
import 'package:heatronn/settings.dart';

class DeviceDetailHeater extends StatelessWidget {
  DeviceDetailHeater({
    super.key,
    required this.deviceId,
    required this.deviceName
  });

  final Controller controller = Get.find<Controller>();
  final String deviceId;
  final String deviceName;
  List<Widget> getHeaters(){
    return controller.deviceDetailsResponse.value!.result!.hardware.elements.map((e) {
      final data = controller.deviceDetailsResponse.value!.result!.liveData.data;
      if(e.name =='heater_1'){
        return DeviceTypeAndTemperature(
          temperature: data.heater_1!.temperature.toString(),color: data.heater_1!.on?Colors.red:null,purpose: e.purpose,);
      }
      if(e.name =='heater_2'){
        return DeviceTypeAndTemperature(
          temperature: data.heater_2!.temperature.toString(),color: data.heater_2!.on?Colors.red:null,purpose: e.purpose,);
      }
      if(e.name =='heater_3'){
        return DeviceTypeAndTemperature(
          temperature: data.heater_3!.temperature.toString(),color: data.heater_3!.on?Colors.red:null,purpose: e.purpose,);
      }
      return DeviceTypeAndTemperature(
        temperature: data.heater_4!.temperature.toString(),color: data.heater_4!.on?Colors.red:null,purpose: e.purpose,);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    controller.getDeviceDetails(deviceId: deviceId);
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
      body: Obx(
          ()=> !controller.isDeviceDetailsLoading.value?
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: controller.deviceDetailsResponse.value?.result!=null?
              [
                IconButton(
                  icon:const Icon(Icons.settings),
                  onPressed: (){
                    controller.updateNameSettings(deviceName: controller.deviceDetailsResponse.value?.result?.name??deviceName);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        SettingsScreen(hardware: controller.deviceDetailsResponse.value!.result!.hardware,
                            deviceName: deviceName, deviceId: deviceId)
                    )
                    );
                  },
                ),
                ...getHeaters(),
                const SizedBox(height:20),
                const Center(child: Text('Activities',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                Center(child: ActivitiesChart(activities: controller.deviceDetailsResponse.value!.result!.stats.activities)),
                const SizedBox(height:20),
                const Center(child: Text('Daily Usage',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                Center(child: UsageChart(usageDailyKwh: controller.deviceDetailsResponse.value!.result!.stats.usageDailyKwh))
              ]:[const Text('No data')],
                    ),
          ):const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class ActivitiesChart extends StatelessWidget {
  const ActivitiesChart({
    super.key,
    required this.activities
  });
  final List<Activities> activities;
  List<BarChartGroupData> _chartGroups() {
    return activities.asMap().entries.map((entry) =>
        BarChartGroupData(
            x: entry.key,
            barRods: [
              BarChartRodData(
                  toY: entry.value.value.toDouble()
              )
            ]
        )

    ).toList();
  }

  SideTitles get _bottomTitles => SideTitles(
    showTitles: true,
    getTitlesWidget: (value, meta) {
      List<String> dates = activities.map((e) => e.statsDate).toList();
      String text = '';
      text = dates[value.toInt()];

      return Text(text);
    },
  );


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: width * 0.8,
      width: width * 0.8,
      child: BarChart(
        BarChartData(
          barGroups: _chartGroups(),
          borderData: FlBorderData(
              border: const Border(bottom: BorderSide(), left: BorderSide())),
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(sideTitles: _bottomTitles),
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
        )
      ),
    );
  }
}

class UsageChart extends StatelessWidget {
  const UsageChart({
    super.key,
    required this.usageDailyKwh
  });
  final List<UsageDailyKwh> usageDailyKwh;
  List<BarChartGroupData> _chartGroups() {
    return usageDailyKwh.asMap().entries.map((entry) =>
        BarChartGroupData(
            x: entry.key,
            barRods: [
              BarChartRodData(
                  toY: entry.value.value.toDouble()
              )
            ]
        )

    ).toList();
  }

  SideTitles get _bottomTitles => SideTitles(
    showTitles: true,
    getTitlesWidget: (value, meta) {
      List<String> dates = usageDailyKwh.map((e) => e.statsDate).toList();
      String text = '';
      text = dates[value.toInt()];

      return Text(text);
    },
  );


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: width * 0.8,
      width: width * 0.8,
      child: BarChart(
          BarChartData(
            barGroups: _chartGroups(),
            borderData: FlBorderData(
                border: const Border(bottom: BorderSide(), left: BorderSide())),
            gridData: const FlGridData(show: false),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(sideTitles: _bottomTitles),
              leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
          )
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$temperatureᶜ',style: const TextStyle(fontSize: 60,fontWeight: FontWeight.bold),),
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
    );
  }
}

