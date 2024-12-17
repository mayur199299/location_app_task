import 'package:flutter/material.dart';
import 'package:location_app/model/place_model.dart';

class PlaceCard extends StatelessWidget {
  final PlaceModel place;

  const PlaceCard({required this.place});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.place, color: Colors.blue),
      title: Text(place.name),
      subtitle: Text('${place.type} - ${place.distance}'),
    );
  }
}
