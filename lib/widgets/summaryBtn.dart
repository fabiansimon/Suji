import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suji_project/models/style.dart';

class SummaryBtn extends StatefulWidget {
  @override
  _SummaryBtnState createState() => _SummaryBtnState();
}

class _SummaryBtnState extends State<SummaryBtn> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('tapped');
      },
      onTapDown: (_) {
        setState(() {
          _isTapped = true;
        });
      },
      onTapCancel: () {
        setState(() {
          _isTapped = false;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isTapped = false;
        });
      },
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width * .9,
        decoration: BoxDecoration(
          color: _isTapped
              ? Theme.of(context).cardColor.withOpacity(.8)
              : Theme.of(context).cardColor,
          border: Border.all(
            color: Theme.of(context).hintColor.withOpacity(.2),
          ),
          boxShadow: <BoxShadow>[mainBoxshadow],
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              CupertinoIcons.book,
              size: 18,
              color: Theme.of(context).hintColor,
            ),
            const SizedBox(width: 6),
            Text(
              'Zusammenfassung',
              style: TextStyle(
                color: Theme.of(context).hintColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
