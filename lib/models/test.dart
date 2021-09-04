import 'package:flutter/material.dart';

class Test {
  double testId;
  String testType;
  String title;
  String correctAnswer;
  List<String> correctAnswers;
  List<String> answerOptions;
  List<String> chooseFromOptions;

  Test({
    @required this.testId,
    @required this.testType,
    @required this.answerOptions,
    this.title,
    this.correctAnswer,
    this.correctAnswers,
    this.chooseFromOptions,
  });
}
