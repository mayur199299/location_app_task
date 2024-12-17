import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location_app/Routes/app_routes.dart';
import '../controllers/location_controller.dart';
import 'list_view_screen.dart';
import 'map_view_screen.dart';

class HomeScreen extends StatelessWidget {
  final LocationController controller = Get.put(LocationController());
  RxBool isMapView = false.obs; // Track whether we are in MapView or ListView

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Fetch Location'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              if (controller.isLoading.value) {
                return const CircularProgressIndicator();
              }

              if (controller.currentPosition.value != null) {
                return Column(
                  children: [
                    const Text(
                      "Location:",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "${controller.currentPosition.value!.latitude}, ${controller.currentPosition.value!.longitude}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        isMapView.value = !isMapView.value;
                        if (isMapView.value) {
                          Get.to(AppRoutes.map);
                        } else {
                          Get.to(AppRoutes.list);
                        }
                      },
                      child: Text(isMapView.value ? "View List" : "View Map"),
                    ),
                  ],
                );
              }

              return const Text("Fetching location...");
            }),
          ],
        ),
      ),
    );
  }
}
