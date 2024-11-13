import 'package:first_app/dice_roller.dart';
import 'package:flutter/material.dart';

const startAlignment = Alignment.topLeft;
const endAlignment = Alignment.bottomRight;

class GradientContainer extends StatelessWidget {
  final List<Color> colors;

  const GradientContainer(this.colors, {super.key});

  const GradientContainer.purple({super.key}): colors = const [Colors.deepPurple, Colors.indigo];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: colors, begin: startAlignment, end: endAlignment)),
      child: const Center(
        child: DiceRoller() 
      ),
    );
  }
}
