import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  final List<Place> places;

  const PlacesList(this.places, {super.key});

  @override
  Widget build(BuildContext context) {
    return places.isEmpty
        ? const Center(child: Text('No places added yet'))
        : ListView.builder(
            itemCount: places.length,
            itemBuilder: (ctx, index) => ListTile(
              title: Text(
                places[index].title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
          );
  }
}
