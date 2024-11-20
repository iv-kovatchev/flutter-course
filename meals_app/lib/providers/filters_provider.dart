import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/filter.dart';

class FiltersNotifier extends StateNotifier<List<Filter>> {
  FiltersNotifier() : super(filters);

  void setFilter(Filter filter) {
    state = [...filters, filter];
  }

  void setFilters(List<Filter> filters) {
    state = filters;
  }
}

final filtersProvider = StateNotifierProvider<FiltersNotifier, List<Filter>>(
  (ref) => FiltersNotifier(),
);
