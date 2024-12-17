import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_app/model/place_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';  // Added geocoding package for reverse geocoding

class LocationController extends GetxController {
  Rx<Position?> currentPosition = Rx<Position?>(null);
  RxList<PlaceModel> places = <PlaceModel>[].obs;
  RxBool isLoading = false.obs;
  RxList<Marker> mapMarkers = <Marker>[].obs; // Store map markers

  @override
  void onInit() {
    super.onInit();
    fetchUserLocation();
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
      await loadMockPlaces(); // Load places based on the current location
      addMarkers(); // Add markers once the user's location is fetched
    } catch (e) {
      Get.snackbar("Error", "Failed to get location: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Load Mock Data for Nearby Places based on User's Location
  Future<void> loadMockPlaces() async {
    if (currentPosition.value != null) {
      List<Placemark> placemarks = await GeocodingPlatform.instance!.placemarkFromCoordinates(currentPosition.value!.latitude, currentPosition.value!.longitude);

      String city = placemarks[0].locality ?? "";

      // Check the city and load relevant places
      if (city.toLowerCase().contains('ahmedabad')) {
        _loadAhmedabadPlaces();
      } else if (city.toLowerCase().contains('baroda')) {
        _loadBarodaPlaces();
      } else if (city.toLowerCase().contains('australia')) {
        _loadAustraliaPlaces();
      } else {
        _loadDefaultPlaces();
      }
    }
  }

  // Load Ahmedabad places
  void _loadAhmedabadPlaces() {
    places.addAll([
      PlaceModel(
        name: "Sabarmati Riverfront",
        type: "Park",
        distance: "2.0 km",
        latitude: 23.0225,
        longitude: 72.5714,
        thumbnailUrl: "https://picsum.photos/seed/ahmedabad/200/300",
      ),
      PlaceModel(
        name: "Manek Chowk",
        type: "Market",
        distance: "1.0 km",
        latitude: 23.0226,
        longitude: 72.5712,
        thumbnailUrl: "https://picsum.photos/seed/manek/200/300",
      ),
    ]);
  }

  // Load Baroda places
  void _loadBarodaPlaces() {
    places.addAll([
      PlaceModel(
        name: "Laxmi Vilas Palace",
        type: "Historical Place",
        distance: "5.0 km",
        latitude: 22.3039,
        longitude: 73.1920,
        thumbnailUrl: "https://picsum.photos/seed/baroda/200/300",
      ),
      PlaceModel(
        name: "Sayaji Garden",
        type: "Park",
        distance: "3.0 km",
        latitude: 22.3061,
        longitude: 73.1852,
        thumbnailUrl: "https://picsum.photos/seed/sayaji/200/300",
      ),
    ]);
  }

  // Load Australia places
  void _loadAustraliaPlaces() {
    places.addAll([
      PlaceModel(
        name: "Adelaide",
        type: "City",
        distance: "Unknown",
        latitude: -34.9285,
        longitude: 138.6007,
        thumbnailUrl: "https://picsum.photos/seed/sydney/200/300",
      ),
    ]);
  }

  // Load default places
  void _loadDefaultPlaces() {
    places.addAll([
      PlaceModel(
        name: "Central Park",
        type: "Park",
        distance: "1.2 km",
        latitude: 40.785091,
        longitude: -73.968285,
        thumbnailUrl: "https://picsum.photos/seed/picsum/200/300",
      ),
      PlaceModel(
        name: "Joe's Pizza",
        type: "Restaurant",
        distance: "0.8 km",
        latitude: 40.730610,
        longitude: -73.935242,
        thumbnailUrl: "https://picsum.photos/seed/picsum/200/300",
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
    update(); // If you're using GetX, call update() to notify listeners.
  }

  // Add Markers for Places and User Location on Map
  void addMarkers() {
    mapMarkers.clear();
    if (currentPosition.value != null) {
      // Add user's location as a marker
      mapMarkers.add(Marker(
        markerId: const MarkerId('user_location'),
        position: LatLng(currentPosition.value!.latitude, currentPosition.value!.longitude),
        infoWindow: const InfoWindow(title: 'Your Location'),
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
