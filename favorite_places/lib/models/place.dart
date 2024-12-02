import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  PlaceLocation(this.latitude, this.longitude, this.address);
}

class Place {
  final String id;
  final String title;
  final File image;
  final PlaceLocation location;


  Place(this.title, this.image, this.location) : id = uuid.v4();
}