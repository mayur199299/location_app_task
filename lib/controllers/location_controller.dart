import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_app/model/place_model.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationController extends GetxController {
  Rx<Position?> currentPosition = Rx<Position?>(null);
  RxList<PlaceModel> places = <PlaceModel>[].obs;
  RxBool isLoading = false.obs;
  RxList<Marker> mapMarkers = <Marker>[].obs; // Store map markers

  @override
  void onInit() {
    super.onInit();
    fetchUserLocation();
    loadMockPlaces();
  }

  // Fetch User Geolocation
  Future<void> fetchUserLocation() async {
    try {
      isLoading.value = true;

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar("Error", "Location services are disabled.");
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar("Error", "Location permissions are denied.");
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Get.snackbar("Error", "Location permissions are permanently denied.");
        openAppSettings(); // Redirect to app settings
        return;
      }

      currentPosition.value = await Geolocator.getCurrentPosition();
      addMarkers(); // Add markers once the user's location is fetched
    } catch (e) {
      Get.snackbar("Error", "Failed to get location: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Load Mock Data for Nearby Places
  void loadMockPlaces() {
    places.addAll([
      PlaceModel(
        name: "Central Park",
        type: "Park",
        distance: "1.2 km",
        latitude: 40.785091,
        longitude: -73.968285,
      ),
      PlaceModel(
        name: "Joe's Pizza",
        type: "Restaurant",
        distance: "0.8 km",
        latitude: 40.730610,
        longitude: -73.935242,
      ),
      PlaceModel(
        name: "City Mall",
        type: "Store",
        distance: "2.5 km",
        latitude: 40.712776,
        longitude: -74.005974,
      ),
    ]);
  }

  void sortPlacesByDistance() {
    // Sort the places by the numeric value of distance (remove the 'km' part)
    places.sort((a, b) {
      double distanceA = double.parse(a.distance.split(" ")[0]);
      double distanceB = double.parse(b.distance.split(" ")[0]);
      return distanceA.compareTo(distanceB);
    });
  }

  // Add Markers for Places and User Location on Map
  void addMarkers() {
    mapMarkers.clear();
    if (currentPosition.value != null) {
      // Add user's location as a marker
      mapMarkers.add(Marker(
        markerId: MarkerId('user_location'),
        position: LatLng(currentPosition.value!.latitude, currentPosition.value!.longitude),
        infoWindow: InfoWindow(title: 'Your Location'),
      ));
    }

    // Add markers for nearby places
    for (var place in places) {
      mapMarkers.add(Marker(
        markerId: MarkerId(place.name),
        position: LatLng(place.latitude, place.longitude),
        infoWindow: InfoWindow(title: place.name, snippet: place.type),
      ));
    }
  }
}