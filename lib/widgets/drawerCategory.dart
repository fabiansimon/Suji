import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suji_project/models/style.dart';

class DrawerCategory extends StatefulWidget {
  DrawerCategory({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final Function() onTap;
  @override
  _DrawerCategoryState createState() => _DrawerCategoryState();
}

class _DrawerCategoryState extends State<DrawerCategory> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: GestureDetector(
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
          color: Colors.transparent,
          child: Row(
            children: [
              Icon(
                widget.icon,
                size: 15.0,
                color: _isTapped
                    ? Theme.of(context).hintColor.withOpacity(.6)
                    : Theme.of(context).hintColor,
              ),
              const SizedBox(width: 6),
              Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: _isTapped
                      ? Theme.of(context).hintColor.withOpacity(.6)
                      : Theme.of(context).hintColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
