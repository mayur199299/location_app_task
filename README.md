# location_app

This Flutter project displays nearby places, allows sorting by distance, and provides detailed information about each place, including their name, type, and distance. The app uses various packages to manage location and UI interactions efficiently.

## Features Implemented

Display Nearby Places: Lists nearby places retrieved from a controller, showing their name, type, and distance.

Sort Places by Distance: Allows users to sort the places by distance with a button click.

Dynamic UI with Obx: Uses GetX for state management to handle the UI updates when the list of places changes.

Error Handling: Displays a message when no places are available.

Image Handling: Displays images (thumbnails) for each place using Image.network to show the place's thumbnail.

## Steps to Run the Project

1. Clone the Repository : git clone <repository-url>
2. Install Dependencies: flutter pub get
3. Run the Application: flutter run
4. Set Up Location Permissions: 
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>

## Tools/Packages Used

1. Flutter: The framework used to build the app.
2. GetX: Used for state management, to reactively update the UI when the list of places changes.
3. Location: A package for handling location services and obtaining the current location of the user.
4. Geolocator: Provides functions for calculating distances and retrieving the device’s current position.
5. Image Network: Used to fetch and display images from URLs.


