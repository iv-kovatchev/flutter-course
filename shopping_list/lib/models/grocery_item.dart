import 'package:shopping_list/models/category.dart';

class GroceryItem {
  final String id;
  final String title;
  final int quantity;
  final Category category;

  const GroceryItem(
    this.id,
    this.title,
    this.quantity,
    this.category,
  );
}
