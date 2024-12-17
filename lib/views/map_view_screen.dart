import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_app/views/list_view_screen.dart';
import '../controllers/location_controller.dart';

class MapViewScreen extends StatelessWidget {
  final LocationController controller = Get.find<LocationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Map View'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Get.to(() => ListViewScreen()); // Navigate to ListViewScreen
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.currentPosition.value == null) {
          return const Center(child: Text("Fetching location..."));
        }

        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(controller.currentPosition.value!.latitude, controller.currentPosition.value!.longitude),
            zoom: 14.0,
          ),
          markers: Set<Marker>.of(controller.mapMarkers), // Display the markers
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
        );
      }),
    );
  }
}
