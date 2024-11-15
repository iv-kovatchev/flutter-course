import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category {
  food,
  travel,
  leisure,
  work
}

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Expense(
    this.title,
    this.amount,
    this.date,
    this.category
  ) : id = uuid.v4();
}
