import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suji_project/data/video_data.dart';
import 'package:suji_project/models/catergory.dart';
import 'package:suji_project/models/style.dart';
import 'package:suji_project/models/video.dart';
import 'package:suji_project/widgets/SmallProgressBar.dart';

class ChapterTile extends StatefulWidget {
  ChapterTile({
    Key key,
    this.onTap,
    @required this.category,
  });
  final Category category;
  final Function() onTap;

  @override
  _ChapterTileState createState() => _ChapterTileState();
}

class _ChapterTileState extends State<ChapterTile> {
  // Get Percentage of  Chapter
  double _getPercentage() {
    List<Video> categoryVids = <Video>[];
    List<Video> finishedVids = <Video>[];

    categoryVids = videos
        .where((Video element) => element.category == widget.category.title)
        .toList();

    if (categoryVids.isEmpty) {
      return 0;
    } else {
      finishedVids =
          // ignore: lines_longer_than_80_chars
          categoryVids
              .where((Video element) => element.isWatched == true)
              .toList();

      return (finishedVids.length / categoryVids.length) * 100;
    }
  }

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
        height: 140,
        width: 110,
        decoration: BoxDecoration(
          color: _isTapped
              ? Theme.of(context).cardColor.withOpacity(.8)
              : Theme.of(context).cardColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          boxShadow: [mainBoxshadow],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 6,
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Image.asset(
                  'assets/' + widget.category.imageIcon,
                  height: 25,
                  color: Theme.of(context).hintColor,
                ),
              )),
            ),
            Flexible(
              flex: 4,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      widget.category.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SmallProgressBar(
                    percentage: _getPercentage() / 100,
                    backgroundColor: Theme.of(context).highlightColor,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _getPercentage().toInt().toString() + '%',
                    style: TextStyle(
                      fontSize: 11,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
