import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:suji_project/models/style.dart';

class ShareProgressBtn extends StatefulWidget {
  @override
  _ShareProgressBtnState createState() => _ShareProgressBtnState();
}

class _ShareProgressBtnState extends State<ShareProgressBtn> {
  bool _isTapped = false;
  final String _shareText =
      'Durch Suji - Die Mathe App, habe ich schon 70% Fortschritt gemacht, in nur 12 Tagen!';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("DO");
        Share.share(_shareText);
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
        height: 45,
        width: MediaQuery.of(context).size.width * .9,
        decoration: BoxDecoration(
          color: _isTapped
              ? Theme.of(context).accentColor.withOpacity(.8)
              : Theme.of(context).accentColor,
          boxShadow: <BoxShadow>[accentBoxshadow],
          borderRadius: const BorderRadius.all(
            Radius.circular(100),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(CupertinoIcons.share, color: Colors.white),
            SizedBox(width: 6),
            Text(
              'Teile deinen Fortschritt',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
