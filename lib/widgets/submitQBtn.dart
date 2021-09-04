import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suji_project/models/style.dart';

class SubmitQBtn extends StatefulWidget {
  const SubmitQBtn({
    Key key,
    @required this.onTap,
  }) : super(key: key);
  final Function() onTap;

  @override
  _SubmitQBtnState createState() => _SubmitQBtnState();
}

class _SubmitQBtnState extends State<SubmitQBtn> {
  bool _buttonPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      onTapDown: (TapDownDetails details) {
        setState(() {
          _buttonPressed = true;
        });
      },
      onTapCancel: () {
        setState(() {
          _buttonPressed = false;
        });
      },
      onTapUp: (TapUpDetails details) {
        setState(() {
          _buttonPressed = false;
        });
      },
      child: Container(
        height: 40,
        width: 160,
        decoration: BoxDecoration(
          color: _buttonPressed
              ? Theme.of(context).accentColor
              : Colors.transparent,
          border: Border.all(width: 1, color: Theme.of(context).accentColor),
          borderRadius: const BorderRadius.all(
            Radius.circular(100),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.hand_draw_fill,
              color:
                  _buttonPressed ? Colors.white : Theme.of(context).accentColor,
              size: 20,
            ),
            const SizedBox(width: 6),
            Text(
              'Abgeben',
              style: TextStyle(
                color: _buttonPressed
                    ? Colors.white
                    : Theme.of(context).accentColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
