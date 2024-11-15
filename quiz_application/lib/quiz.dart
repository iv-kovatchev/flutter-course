import 'package:flutter/material.dart';
import 'package:quiz_application/data/questions.dart';
import 'package:quiz_application/questions_screen.dart';
import 'package:quiz_application/results_screen.dart';

import 'package:quiz_application/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  var _activeScreen = 'start-screen';

  void switchScreen() {
    setState(() {
      _activeScreen = 'questions-screen';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if(selectedAnswers.length == questions.length) {
      setState(() {
        _activeScreen = 'results-screen';
      });
    }
  }

  void restartQuiz() {
    setState(() {
      selectedAnswers  = [];
      _activeScreen = 'questions-screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = StartScreen(switchScreen);

    if(_activeScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(chooseAnswer);
    }

    if(_activeScreen == 'results-screen') {
      screenWidget = ResultsScreen(restartQuiz, selectedAnswers);
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 78, 13, 151),
                Color.fromARGB(255, 107, 15, 168),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
