import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suji_project/data/video_data.dart';
import 'package:suji_project/models/style.dart';
import 'package:suji_project/models/userData.dart';
import 'package:suji_project/models/video.dart';
import 'package:suji_project/screens/lectureScreen.dart';

class VideoTile extends StatefulWidget {
  const VideoTile({
    Key key,
    @required this.id,
  }) : super(key: key);
  final String id;

  @override
  _VideoTileState createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> {
  Video video;

  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    video = videos.firstWhere((Video element) => element.id == widget.id);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<Widget>(
            builder: (BuildContext context) => LectureScreen(
              id: widget.id,
            ),
          ),
        );
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
      child: Dismissible(
        onDismissed: (DismissDirection direction) {},
        key: GlobalKey(),
        background: Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Icon(
              CupertinoIcons.heart_fill,
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: 65,
          decoration: BoxDecoration(
            color: _isTapped
                ? Theme.of(context).cardColor.withOpacity(.7)
                : Theme.of(context).cardColor,
            boxShadow: <BoxShadow>[mainBoxshadow],
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Row(
            children: <Widget>[
              if (video.isWatched)
                Container(
                  width: 5,
                  height: 65,
                  color: Theme.of(context).accentColor,
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: Icon(
                    CupertinoIcons.play_arrow_solid,
                    size: 22,
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.title,
                      maxLines: 1,
                      style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      video.category,
                      style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontSize: 11.0,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 20,
                  height: 20,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color:
                        video.isWatched ? Theme.of(context).accentColor : null,
                    border: Border.all(
                      color: const Color(0xFFE6E6E6),
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(3),
                    ),
                  ),
                  child: video.isWatched
                      ? const Center(
                          child: Icon(
                            CupertinoIcons.check_mark,
                            size: 13,
                            color: Colors.white,
                          ),
                        )
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
