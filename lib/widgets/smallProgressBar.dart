import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:suji_project/models/style.dart';

class SmallProgressBar extends StatefulWidget {
  const SmallProgressBar({
    Key key,
    @required this.percentage,
    @required this.backgroundColor,
  });
  final double percentage;
  final Color backgroundColor;

  @override
  _SmallProgressBarState createState() => _SmallProgressBarState();
}

class _SmallProgressBarState extends State<SmallProgressBar> {
  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      progressColor: Theme.of(context).accentColor,
      backgroundColor: widget.backgroundColor,
      percent: widget.percentage,
    );
  }
}
