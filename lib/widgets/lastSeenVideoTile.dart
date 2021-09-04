import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suji_project/data/category_data.dart';
import 'package:suji_project/data/video_data.dart';
import 'package:suji_project/models/catergory.dart';
import 'package:suji_project/models/style.dart';
import 'package:suji_project/models/video.dart';
import 'package:suji_project/widgets/SmallProgressBar.dart';

class LastSeenVideoTile extends StatefulWidget {
  const LastSeenVideoTile({
    Key key,
    @required this.videoId,
  }) : super(key: key);
  final String videoId;

  @override
  _LastSeenVideoTileState createState() => _LastSeenVideoTileState();
}

class _LastSeenVideoTileState extends State<LastSeenVideoTile> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    // ignore: lines_longer_than_80_chars
    final Video video =
        videos.firstWhere((Video element) => element.id == widget.videoId);

    return GestureDetector(
      onTap: () {},
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
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Theme.of(context).primaryColor.withOpacity(.35),
                  blurRadius: 20,
                ),
              ],
              color: _isTapped
                  ? Theme.of(context).primaryColor.withOpacity(.8)
                  : Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(22),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 22.0),
              child: Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 28.0, right: 12.0, top: 30, bottom: 30),
                        child: Image.asset(
                          'assets/' +
                              categories
                                  .firstWhere((Category element) =>
                                      element.title == video.category)
                                  .imageIcon,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        const SizedBox(height: 24),
                        Text(
                          video.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          video.description,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 14),
                        const SmallProgressBar(
                          percentage: .4,
                          backgroundColor: Colors.white,
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          '10:23/23:55',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -17.5,
            child: Container(
              width: 100,
              height: 35,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(17.5),
                ),
              ),
              child: const Center(
                child: Icon(
                  CupertinoIcons.play_arrow_solid,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
