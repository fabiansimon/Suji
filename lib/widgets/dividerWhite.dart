import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

class DividerWhite extends StatefulWidget {
  DividerWhite({
    Key key,
    @required this.height,
  }) : super(key: key);

  final double height;

  @override
  _DividerWhiteState createState() => _DividerWhiteState();
}

class _DividerWhiteState extends State<DividerWhite> {
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Theme.of(context).cardColor,
      thickness: 2,
      height: widget.height,
      endIndent: 30,
      indent: 30,
    );
  }
}
