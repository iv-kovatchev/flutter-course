import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/filter.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/meals_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  List<Filter> _selectedFilters = filters;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toggleMedalFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      setState(() => _favoriteMeals.remove(meal));
      _showInfoMessage('Meal is no longer existing!');
    } else {
      setState(() => _favoriteMeals.add(meal));
      _showInfoMessage('Marked as favorite!');
    }
  }

  void _selectPage(int index) {
    setState(
      () {
        _selectedPageIndex = index;
      },
    );
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();

    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<List<Filter>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
      
      setState(() {
        _selectedFilters = result ?? filters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Meal> meals = ref.watch(mealsProvider);

    final availableMeals = meals.where((meal) {
      if(_selectedFilters[0].isChecked && !meal.isGlutenFree) {
        return false;
      }

      if(_selectedFilters[1].isChecked && !meal.isLactoseFree) {
        return false;
      }

      if(_selectedFilters[2].isChecked && !meal.isVegetarian) {
        return false;
      }

      if(_selectedFilters[3].isChecked && !meal.isVegan) {
        return false;
      }

      return true;
    }).toList();

    Widget activePage = CategoriesScreen(_toggleMedalFavoriteStatus, availableMeals);
    String activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMedalFavoriteStatus,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(_setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
