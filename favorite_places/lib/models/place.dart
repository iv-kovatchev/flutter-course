import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Place {
  final String id;
  final String title;
  final File image;

  Place(this.title, this.image) : id = uuid.v4();
}