import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/filter.dart';
import 'package:meals_app/providers/meals_provider.dart';

class FiltersNotifier extends StateNotifier<List<Filter>> {
  FiltersNotifier() : super(filters);

  void setFilter(Filter filter) {
    state = state.map((el) {
      if(el.id == filter.id) {
        return filter;
      }
      
      return el;
    }).toList();
  }

  void setFilters(List<Filter> filters) {
    state = filters;
  }
}

final filtersProvider = StateNotifierProvider<FiltersNotifier, List<Filter>>(
  (ref) => FiltersNotifier(),
);

final filteredMealsProvider = Provider((ref) {
    final meals = ref.watch(mealsProvider);
    final filters = ref.watch(filtersProvider);

    return meals.where((meal) {
      if(filters[0].isChecked && !meal.isGlutenFree) {
        return false;
      }

      if(filters[1].isChecked && !meal.isLactoseFree) {
        return false;
      }

      if(filters[2].isChecked && !meal.isVegetarian) {
        return false;
      }

      if(filters[3].isChecked && !meal.isVegan) {
        return false;
      }

      return true;
    }).toList();
});