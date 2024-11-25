import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';
import 'package:http/http.dart' as http;

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() {
    return _GroceryListState();
  }
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https('abc.flutter-prop-c90b1-default-rtdb.firebaseio.com',
        '/shopping-list.json');

    try {
      final response = await http.get(url);
      print(response.statusCode);

      if (response.statusCode >= 400) {
        throw Error();
      } else {
        final Map<String, dynamic> listData = json.decode(response.body);

        List<GroceryItem> loadedItems = [];

        for (final item in listData.entries) {
          final category = categories.entries
              .firstWhere((el) => el.value.title == item.value['category'])
              .value;
          loadedItems.add(
            GroceryItem(
              item.key,
              item.value['name'],
              item.value['quantity'],
              category,
            ),
          );
        }

        setState(() {
          _groceryItems = loadedItems;
          _isLoading = false;
        });
      }
    } catch (err) {
      setState(() {
        _error = 'Failed to fetch data. Please try again later!';
      });

      return;
    }
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );

    if (newItem == null) {
      return;
    }

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) {
    setState(
      () {
        _groceryItems.remove(item);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (context, index) => Dismissible(
          onDismissed: (direction) => _removeItem(_groceryItems[index]),
          key: ValueKey(_groceryItems[index].id),
          child: ListTile(
            title: Text(
              _groceryItems[index].title,
            ),
            leading: Container(
              width: 24,
              height: 24,
              color: _groceryItems[index].category.color,
            ),
            trailing: Text(
              _groceryItems[index].quantity.toString(),
            ),
          ),
        ),
      );
    }

    if (_error != null) {
      content = Center(
        child: Text(_error!),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Your Groceries',
          ),
          actions: [
            IconButton(
              onPressed: _addItem,
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: content);
  }
}
