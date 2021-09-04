import 'package:suji_project/models/test.dart';

List<Test> availableTests = <Test>[
  Test(
    testId: 1.01,
    testType: 'One_To_One',
    answerOptions: <String>[
      'f(x) = a*bx',
      'f(x) = a*bx',
      'f(x) = a*bx',
      'f(x) = a*bx',
    ],
    chooseFromOptions: <String>[
      '– kein Monotoniewechsel \n– konstante Steigung\n– kein Krümmungswechsel',
      '– kein Monotoniewechsel \n– konstante Steigung\n– kein Krümmungswechsel',
      '– kein Monotoniewechsel \n– konstante Steigung\n– kein Krümmungswechsel',
      '– kein Monotoniewechsel \n– konstante Steigung\n– kein Krümmungswechsel',
      '– kein Monotoniewechsel \n– konstante Steigung\n– kein Krümmungswechsel',
      '– kein Monotoniewechsel \n– konstante Steigung\n– kein Krümmungswechsel',
      '– kein Monotoniewechsel \n– konstante Steigung\n– kein Krümmungswechsel',
    ],
    correctAnswers: <String>['A', 'B', 'C'],
  ),
  Test(
    testId: 1.02,
    testType: 'Multiple_Choice',
    title: 'Wie nennet man die längste Seite eines Dreiecks?',
    answerOptions: <String>[
      'Katheder',
      'Hypotenuse',
      'Kathedrale',
      'Lange Seite'
    ],
    correctAnswer: 'Hypotenuse',
  ),
  Test(
    testId: 1.03,
    testType: 'Mulitple_Answers',
    title: 'Wie kann man Fabian nennen?',
    answerOptions: <String>['Fabian', 'Fabs', 'Fabus', 'Kenig'],
    correctAnswers: <String>['Fabian', 'Kenig'],
  ),
  Test(
    testId: 2.01,
    testType: 'One_To_One',
    answerOptions: <String>[
      'f(x) = a*bx2',
      'f(x) = a*bx2',
      'f(x) = a*bx2',
    ],
    chooseFromOptions: <String>[
      '– konstante Steigung\n– kein Krümmungswechsel',
      '– kein Monotoniewechsel \n– konstante Steigung',
      '–  kein Krümmungswechsel',
      ' kein Krümmungswechsel',
      'dd',
      '– kein Monotoniewechsel \n– konstante Steigung\n– kein Krümmungswechsel',
    ],
    correctAnswers: <String>['A', 'B', 'D'],
  ),
  Test(
    testId: 2.02,
    testType: 'Multiple_Choice',
    title: 'Wie nennet man die längste Seite eines Vierrecks?',
    answerOptions: <String>['Hat', 'Keine', 'Bruder', 'bzw 2'],
    correctAnswer: 'bzw 2',
  ),
];
