import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suji_project/data/test_data.dart';
import 'package:suji_project/models/style.dart';
import 'package:suji_project/models/test.dart';
import 'package:suji_project/models/video.dart';
import 'package:suji_project/widgets/submitQBtn.dart';
import 'package:suji_project/widgets/titleText.dart';

class InteractiveTest extends StatefulWidget {
  const InteractiveTest({
    Key key,
    @required this.id,
  }) : super(key: key);
  final String id;

  @override
  _InteractiveTestState createState() => _InteractiveTestState();
}

class _InteractiveTestState extends State<InteractiveTest> {
  Video video;
  final List<TextEditingController> _controllers = <TextEditingController>[];
  int _choosenAnswer;
  final List<int> _choosenAnswers = <int>[];
  final String _alphabet = 'abcdefghijklmnopqrstuvwxyz';
  double _testId;

  // Temporary function to get a random Test
  double _getRandomTest(int category) {
    final List<Test> usableTests = availableTests
        .where((Test element) =>
            element.testId >= category && element.testId < category + 1)
        .toList();

    return usableTests[Random().nextInt(usableTests.length)].testId;
  }

  // display ShowSnackbar
  void _showSnackBar(bool isCorrect) {
    final SnackBar snackBar = SnackBar(
      content: Text(
        isCorrect
            ? 'Gratulation! Das ist richtig!'
            : 'Ups, das ist leider nicht Korrekt!',
        textAlign: TextAlign.center,
      ),
      backgroundColor: isCorrect
          ? Theme.of(context).accentColor
          : Theme.of(context).primaryColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Temporary Function to check various tests
  void _checkTest({double testId}) {
    final Test test =
        availableTests.firstWhere((Test element) => element.testId == testId);

    switch (test.testType) {
      case 'Multiple_Choice':
        if (test.answerOptions[_choosenAnswer] == test.correctAnswer) {
          _showSnackBar(true);
        } else {
          _showSnackBar(false);
        }
        break;
      case 'One_To_One':
        for (int i = 0; i < test.correctAnswers.length; i++) {
          if (_controllers[i].text.isNotEmpty &&
              test.correctAnswers[i] == _controllers[i].text) {
          } else {
            _showSnackBar(false);
            return;
          }
        }
        _showSnackBar(true);
        break;
      case 'Mulitple_Answers':
        for (int i = 0; i < _choosenAnswers.length; i++) {
          if (test.correctAnswers
              .contains(test.answerOptions[_choosenAnswers[i]])) {
          } else {
            _showSnackBar(false);
            return;
          }
        }
        _showSnackBar(true);
        break;
      default:
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _testId = _getRandomTest(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [mainColorBoxShadow],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const TitleText(title: 'Interaktives Quiz'),
            const SizedBox(height: 12),
            _testWidget(testId: _testId),
            const SizedBox(height: 12),
            Center(
              child: SubmitQBtn(
                onTap: () {
                  _checkTest(testId: _testId);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to dispay the needed test
  Widget _testWidget({double testId}) {
    final String testType = availableTests
        .firstWhere((Test element) => element.testId == testId)
        .testType;

    if (testType == 'Multiple_Choice') return _multipleChoice(testId: testId);
    if (testType == 'One_To_One') return _oneToOneQuiz(testId: testId);
    return _multipleAnswers(testId: testId);
  }

  // Multiple Choice Widget
  Widget _multipleChoice({double testId}) {
    final Test test =
        availableTests.firstWhere((Test element) => element.testId == testId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          test.title,
          style: TextStyle(color: Theme.of(context).hintColor),
        ),
        const SizedBox(height: 18),
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).accentColor,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: 40,
                width: double.infinity,
                color: Theme.of(context).accentColor,
                child: const Center(
                  child: Text(
                    'Wähle eine Option aus',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Column(
                children: List<Widget>.generate(test.answerOptions.length,
                    (int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _choosenAnswer = index;
                      });
                    },
                    child: Container(
                      constraints: const BoxConstraints(minHeight: 50),
                      decoration: BoxDecoration(
                        border: index != test.answerOptions.length - 1
                            ? Border(
                                bottom: BorderSide(
                                  color: Theme.of(context).accentColor,
                                ),
                              )
                            : null,
                        color: Colors.transparent,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 3,
                              child: Text(
                                test.answerOptions[index],
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Flexible(
                              child: Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _choosenAnswer == index
                                      ? Theme.of(context).accentColor
                                      : null,
                                  border: Border.all(
                                    width: 2,
                                    color: _choosenAnswer == index
                                        ? Theme.of(context).accentColor
                                        : Theme.of(context).hintColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Multiple Answers Widget
  Widget _multipleAnswers({double testId}) {
    final Test test =
        availableTests.firstWhere((Test element) => element.testId == testId);
    final int lengthAO = test.answerOptions.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          test.title,
          style: TextStyle(color: Theme.of(context).hintColor),
        ),
        const SizedBox(height: 18),
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).accentColor),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: 40,
                width: double.infinity,
                color: Theme.of(context).accentColor,
                child: const Center(
                  child: Text(
                    'Wähle deine Optionen aus',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Column(
                children: List<Widget>.generate(lengthAO, (int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        !_choosenAnswers.contains(index)
                            ? _choosenAnswers.add(index)
                            : _choosenAnswers.remove(index);
                      });
                    },
                    child: Container(
                      constraints: const BoxConstraints(minHeight: 50),
                      decoration: BoxDecoration(
                        border: index != test.answerOptions.length - 1
                            ? Border(
                                bottom: BorderSide(
                                    color: Theme.of(context).accentColor),
                              )
                            : null,
                        color: Colors.transparent,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 3,
                              child: Text(
                                test.answerOptions[index],
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Flexible(
                              child: Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(3),
                                  ),
                                  color: _choosenAnswers.contains(index)
                                      ? Theme.of(context).accentColor
                                      : null,
                                  border: Border.all(
                                    width: 2,
                                    color: _choosenAnswers.contains(index)
                                        ? Theme.of(context).accentColor
                                        : Theme.of(context).hintColor,
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    CupertinoIcons.xmark,
                                    color: _choosenAnswers.contains(index)
                                        ? Colors.white
                                        : Colors.transparent,
                                    size: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // OneToOneQuiz Widget
  Widget _oneToOneQuiz({double testId}) {
    final Test test =
        availableTests.firstWhere((Test element) => element.testId == testId);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Ordnen Sie den vier Funktionsgleichungen jeweils die zugehörige Liste (aus A bis F) zu:',
          style: TextStyle(color: Theme.of(context).hintColor),
        ),
        const SizedBox(height: 18),
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Theme.of(context).accentColor),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Column(
            children: List<Widget>.generate(
              test.answerOptions.length,
              (int index) {
                _controllers.add(TextEditingController());
                return IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                          constraints: const BoxConstraints(minHeight: 50),
                          decoration: index != test.answerOptions.length - 1
                              ? BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                )
                              : null,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                test.answerOptions[index],
                                style: TextStyle(
                                    color: Theme.of(context).hintColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          constraints: const BoxConstraints(minHeight: 50),
                          decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            border: index != test.answerOptions.length - 1
                                ? Border(
                                    bottom: BorderSide(
                                      color: Theme.of(context).cardColor,
                                    ),
                                  )
                                : null,
                          ),
                          child: TextField(
                            controller: _controllers[index],
                            cursorColor: Colors.white,
                            textAlign: TextAlign.center,
                            textCapitalization: TextCapitalization.characters,
                            maxLength: 1,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              counterText: '',
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: const EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).accentColor,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Column(
            children: List<Widget>.generate(
              test.chooseFromOptions.length,
              (int index) {
                return IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: index != test.chooseFromOptions.length - 1
                                ? Border(
                                    bottom: BorderSide(
                                      color: Theme.of(context).cardColor,
                                    ),
                                  )
                                : null,
                            color: Theme.of(context).accentColor,
                          ),
                          child: Center(
                            child: Text(
                              _alphabet[index].toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: index != test.chooseFromOptions.length - 1
                              ? BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                )
                              : null,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              test.chooseFromOptions[index],
                              style: TextStyle(
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  // Widget _fillGapQuiz() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //           "Ergänzen Sie die Textlücken im nachstehenden Satz durch Ankreuzen des jeweils zutreffenden Satzteils so, dass eine richtige Aussage entsteht"),
  //       SizedBox(height: 24.0),
  //       Text("Jede Polynomfunktion _________  hat ________ ."),
  //       SizedBox(height: 20.0),
  //       Container(
  //         clipBehavior: Clip.hardEdge,
  //         decoration: BoxDecoration(
  //           border: Border.all(width: 1, color: Theme.of(context).accentColor),
  //           borderRadius: BorderRadius.all(Radius.circular(10)),
  //         ),
  //         child: Column(
  //           children: [
  //             Container(
  //               height: 40,
  //               width: double.infinity,
  //               color: Theme.of(context).accentColor,
  //               child: Center(
  //                 child: Text(
  //                   "Wähle eine Option aus",
  //                   style: TextStyle(
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Column(
  //               children: List.generate(
  //                   quizzes[timeStamp]["answer_options"].length, (index) {
  //                 return GestureDetector(
  //                   onTap: () {
  //                     setState(() {
  //                       choosenAnswer = index;
  //                     });
  //                   },
  //                   child: Container(
  //                     constraints: BoxConstraints(minHeight: 50),
  //                     decoration: BoxDecoration(
  //                       border: index !=
  //                               quizzes[timeStamp]["answer_options"].length - 1
  //                           ? Border(
  //                               bottom:
  //                                   BorderSide(width: 1, color: Theme.of(context).accentColor),
  //                             )
  //                           : null,
  //                       color: Colors.transparent,
  //                     ),
  //                     child: Padding(
  //                       padding: const EdgeInsets.symmetric(
  //                         horizontal: 12.0,
  //                         vertical: 4.0,
  //                       ),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Flexible(
  //                             flex: 3,
  //                             child: Text(
  //                               quizzes[timeStamp]["answer_options"][index],
  //                               style: TextStyle(
  //                                 fontSize: 15,
  //                                 color: Theme.of(context).hintColor,
  //                               ),
  //                             ),
  //                           ),
  //                           SizedBox(width: 14),
  //                           Flexible(
  //                             flex: 1,
  //                             child: Container(
  //                               width: 15,
  //                               height: 15,
  //                               decoration: BoxDecoration(
  //                                 shape: BoxShape.circle,
  //                                 color: choosenAnswer == index
  //                                     ? Theme.of(context).accentColor
  //                                     : null,
  //                                 border: Border.all(
  //                                   width: 2,
  //                                   color: choosenAnswer == index
  //                                       ? Theme.of(context).accentColor
  //                                       : Theme.of(context).hintColor,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 );
  //               }),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
