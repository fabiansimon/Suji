import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suji_project/data/video_data.dart';
import 'package:suji_project/models/style.dart';
import 'package:suji_project/models/video.dart';
import 'package:suji_project/widgets/interactiveTest.dart';
import 'package:suji_project/widgets/submitQBtn.dart';
import 'package:suji_project/widgets/summaryBtn.dart';
import 'package:suji_project/widgets/titleText.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LectureScreen extends StatefulWidget {
  const LectureScreen({
    Key key,
    @required this.id,
  }) : super(key: key);
  final String id;

  @override
  _LectureScreenState createState() => _LectureScreenState();
}

class _LectureScreenState extends State<LectureScreen> {
  bool _isLiked = false;
  Video video;
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    // get current Video with id
    setState(() {
      video = videos.firstWhere((Video element) => element.id == widget.id);
    });

    // Setup YoutubePlayer
    _controller = YoutubePlayerController(
      initialVideoId:
          videos.firstWhere((Video element) => element.id == widget.id).url,
      flags: const YoutubePlayerFlags(autoPlay: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    // return Scaffold(
    //   body: SingleChildScrollView(
    //     child: Container(
    //       color: Colors.red,
    //       height: screenSize.height,
    //       width: screenSize.width,
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.stretch,
    //         children: <Widget>[
    //           YoutubePlayerBuilder(
    //             player: YoutubePlayer(
    //               controller: _controller,
    //               // aspectRatio: 16 / 9,
    //               showVideoProgressIndicator: true,
    //             ),
    //             builder: (BuildContext context, Widget player) {
    //               return Column(
    //                 children: <Widget>[player],
    //               );
    //             },
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    return Container(
      width: screenSize.width,
      height: screenSize.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Theme.of(context).primaryColor,
            Theme.of(context).focusColor
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          brightness: Brightness.dark,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Image.asset(
            'assets/logoTemp.png',
            height: 30,
            width: screenSize.width * .6,
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              clipBehavior: Clip.hardEdge,
              width: screenSize.width,
              height: screenSize.height,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                boxShadow: <BoxShadow>[mainBoxshadow],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(22),
                  topRight: Radius.circular(22),
                ),
              ),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TitleText(title: video.title),
                          const SizedBox(height: 6.0),
                          Text(
                            video.description,
                            style: TextStyle(
                              color: Theme.of(context).hintColor,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        YoutubePlayerBuilder(
                          player: YoutubePlayer(
                            controller: _controller,
                            // aspectRatio: 16 / 9,
                            showVideoProgressIndicator: true,
                          ),
                          builder: (BuildContext context, Widget player) {
                            return Column(
                              children: <Widget>[player],
                            );
                          },
                        ),
                        _buildLikeButton(context),
                      ],
                    ),
                    const SizedBox(height: 22.0),
                    InteractiveTest(id: video.id),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 20,
              bottom: 40,
              child: SummaryBtn(),
            ),
          ],
        ),
      ),
    );
  }

  Positioned _buildLikeButton(BuildContext context) {
    return Positioned(
      right: 10,
      top: -20,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isLiked = !_isLiked;
            print(_isLiked);
          });
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[mainBoxshadow],
            shape: BoxShape.circle,
            color: Theme.of(context).cardColor,
          ),
          child: Center(
            child: _isLiked
                ? Icon(
                    CupertinoIcons.heart_fill,
                    size: 20,
                    color: Theme.of(context).accentColor,
                  )
                : Icon(
                    CupertinoIcons.heart,
                    size: 20,
                    color: Theme.of(context).accentColor,
                  ),
          ),
        ),
      ),
    );
  }
}
