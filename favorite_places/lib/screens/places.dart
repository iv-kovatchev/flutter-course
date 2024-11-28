import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/screens/add_place.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({ super.key });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPlaces = ref.watch(userPlacesProvider);

    void navigateToAddPlace() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const AddPlaceScreen(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Places',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
        actions: [
          IconButton(
            color: Theme.of(context).colorScheme.onPrimary,
            onPressed: navigateToAddPlace,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: PlacesList(
        userPlaces,
      ),
    );
  }
}
