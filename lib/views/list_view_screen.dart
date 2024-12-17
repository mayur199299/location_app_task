import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/location_controller.dart';
import 'package:location_app/model/place_model.dart';

class ListViewScreen extends StatelessWidget {
  final LocationController controller = Get.find<LocationController>();

  @override
  Widget build(BuildContext context) {
    // Sort places by distance initially or when the button is clicked
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Places'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                controller.sortPlacesByDistance(); // Sort the places by distance
              },
              child: const Text('Sort by Distance (Ascending)'),
            ),
          ),
          Obx(() {
            // Check if the places list is empty
            return controller.places.isEmpty
                ? const Center(child: Text("No places available"))
                : Expanded(
              child: ListView.builder(
                itemCount: controller.places.length,
                itemBuilder: (context, index) {
                  PlaceModel place = controller.places[index];
                  return ListTile(
                    title: Text(place.name),
                    subtitle: Text(place.type),
                    trailing: Text(place.distance),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
