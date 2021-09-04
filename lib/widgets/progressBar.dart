import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:suji_project/data/video_data.dart';
import 'package:suji_project/models/style.dart';
import 'package:suji_project/models/video.dart';

class ProgressBar extends StatefulWidget {
  Function() onTap;

  ProgressBar({
    this.onTap,
  });

  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  bool _isTapped = false;

  double _getCurrentProgress() {
    return videos
            .where((element) => element.isWatched == true)
            .toList()
            .length /
        videos.length;
  }

  @override
  void initState() {
    super.initState();
    _getCurrentProgress();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("DO");
        widget.onTap();
      },
      onTapDown: (details) {
        setState(() {
          _isTapped = true;
        });
      },
      onTapCancel: () {
        setState(() {
          _isTapped = false;
        });
      },
      onTapUp: (details) {
        setState(() {
          _isTapped = false;
        });
      },
      child: Container(
        clipBehavior: Clip.none,
        height: 45,
        decoration: BoxDecoration(
          color: _isTapped
              ? Theme.of(context).backgroundColor.withOpacity(.9)
              : Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          boxShadow: [mainBoxshadow],
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            LinearPercentIndicator(
              backgroundColor: Colors.transparent,
              linearGradient: LinearGradient(
                colors: [
                  Theme.of(context).accentColor,
                  Theme.of(context).indicatorColor,
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 23),
              lineHeight: 40.0,
              percent: _getCurrentProgress(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "9/12 Kapitel",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Text(
                    (_getCurrentProgress() * 100).toInt().toString() + "%",
                    style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
