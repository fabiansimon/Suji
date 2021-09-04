import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suji_project/models/style.dart';

class TitleText extends StatefulWidget {
  const TitleText({
    Key key,
    @required this.title,
  }) : super(key: key);
  final String title;

  @override
  _TitleTextState createState() => _TitleTextState();
}

class _TitleTextState extends State<TitleText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.title,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        letterSpacing: -.3,
        color: Theme.of(context).hintColor,
        fontSize: 20,
      ),
    );
  }
}
