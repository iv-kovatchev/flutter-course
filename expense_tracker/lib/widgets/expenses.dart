import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({ super.key });

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense('Flutter Course', 19.99, DateTime.now(), Category.food,),
    Expense('Cinema', 15.69, DateTime.now(), Category.leisure,)
  ];

  @override
  Widget build(BuildContext context) {
    return (
      Scaffold(
        body: Column(
          children: [
            const Text('The chart'),
            Expanded(
              child: ExpensesList(_registeredExpenses),
            ),
          ],
        )
      )
    );
  }
}