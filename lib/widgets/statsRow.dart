import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatsRow extends StatefulWidget {
  const StatsRow({
    Key key,
    @required this.description,
    @required this.stat,
  }) : super(key: key);

  final String description;
  final String stat;

  @override
  _StatsRowState createState() => _StatsRowState();
}

class _StatsRowState extends State<StatsRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          widget.description,
          style: TextStyle(
            color: Theme.of(context).hintColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          widget.stat,
          style: TextStyle(
            color: Theme.of(context).hintColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
