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
        centerTitle: true,
        title: const Text('Nearby Places'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                controller.sortPlacesByDistance();
              },
              child: const Text('Sort by Distance'),
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
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10.0),
                      leading: Image.network(
                        place.thumbnailUrl,  // Use thumbnailUrl from PlaceModel
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(place.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(place.type),
                          Text('Distance: ${place.distance}'),
                        ],
                      ),
                    ),
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
