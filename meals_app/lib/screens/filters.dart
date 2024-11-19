import 'package:flutter/material.dart';
import 'package:meals_app/models/filter.dart';

enum FilterEnum {
  glutenFree,
  lactoseFree,
  vegeterian,
  vegan,
}

List<Filter> filters = [
  Filter(
      title: 'Gluten-free',
      description: 'Only include gluten-free meals.',
      isChecked: false),
  Filter(
      title: 'Lactose-free',
      description: 'Only include lactose-free meals.',
      isChecked: false),
  Filter(
      title: 'Vegeterian',
      description: 'Only include vegeterian meals.',
      isChecked: false),
  Filter(
      title: 'Vegan',
      description: 'Only include vegan meals.',
      isChecked: false),
];

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: PopScope<List<Filter>>(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          if (didPop) return;

          Navigator.of(context).pop(filters);
        },
        child: Column(
          children: filters.map(
            (filter) {
              return SwitchListTile(
                value: filter.isChecked,
                onChanged: (isChecked) {
                  setState(() {
                    filter.isChecked = isChecked;
                  });
                },
                title: Text(
                  filter.title,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                subtitle: Text(
                  filter.description,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(left: 34, right: 22),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
