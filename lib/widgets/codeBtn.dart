import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suji_project/models/style.dart';

class CodeBtn extends StatefulWidget {
  CodeBtn({
    Key key,
    @required this.onTap,
  });
  final Function() onTap;

  @override
  _CodeBtnState createState() => _CodeBtnState();
}

class _CodeBtnState extends State<CodeBtn> {
  bool _isTapped = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      onTapDown: (TapDownDetails details) {
        setState(() {
          _isTapped = true;
        });
      },
      onTapCancel: () {
        setState(() {
          _isTapped = false;
        });
      },
      onTapUp: (TapUpDetails details) {
        setState(() {
          _isTapped = false;
        });
      },
      child: Container(
        width: 100,
        height: 45,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[accentBoxshadow],
          color: _isTapped
              ? Theme.of(context).accentColor.withOpacity(.8)
              : Theme.of(context).accentColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(100),
          ),
        ),
        child: const Center(
          child: Text(
            '[ABCD]',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
