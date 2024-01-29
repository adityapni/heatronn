import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heatronn/repo/repo.dart';

class CreateLocationScreen extends StatelessWidget {
  CreateLocationScreen({super.key});

  final TextEditingController locationNameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Controller controller = Get.find<Controller>();

    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('images/logo.png'),
        title: const Text('Create Location'),
        actions: [
          IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Icons.close))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Location name...'
              ),
              controller: locationNameController,
            ),
            const SizedBox(height: 20,),
            DropdownMenu(
              width: width * 0.9,
              controller: typeController,
              requestFocusOnTap: false,
              label: const Text('Location type'),
              onSelected: (value){
                typeController.text = value!;
              },
              dropdownMenuEntries: const [
                DropdownMenuEntry(value: 'home', label: 'Home'),
                DropdownMenuEntry(value: 'office', label: 'Office'),
                DropdownMenuEntry(value: 'others', label: 'Others'),
              ]
            ),
            const SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                  controller.createLocation(name: locationNameController.text, type: typeController.text).then((userFriendlyMessage){
                    if(userFriendlyMessage!=null){
                      SnackBar snackBar = SnackBar(content: Text(userFriendlyMessage));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    if(controller.createLocationResponse.value?.result != null){
                      Navigator.pop(context);
                    }
                  });

                },
                child: const Text('Next')
              ),
            )
          ],
        ),
      ),
    );
  }
}


