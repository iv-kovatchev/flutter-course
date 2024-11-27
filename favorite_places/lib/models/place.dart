import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Place {
  final String id;
  final String title;

  Place(this.title) : id = uuid.v4();
}