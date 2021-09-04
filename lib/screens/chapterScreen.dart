import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suji_project/data/video_data.dart';
import 'package:suji_project/models/catergory.dart';
import 'package:suji_project/models/style.dart';
import 'package:suji_project/models/video.dart';
import 'package:suji_project/widgets/VideoTile.dart';
import 'package:suji_project/widgets/summaryBtn.dart';
import 'package:suji_project/widgets/titleText.dart';

class ChapterScreen extends StatefulWidget {
  const ChapterScreen({
    Key key,
    @required this.category,
  }) : super(key: key);
  final Category category;

  @override
  _ChapterScreenState createState() => _ChapterScreenState();
}

// ignore: constant_identifier_names
enum SortState { WissenState, BeispieleState }

class _ChapterScreenState extends State<ChapterScreen> {
  SortState _sortState = SortState.WissenState;

  @override
  Widget build(BuildContext context) {
    final List<Video> videosToShow = videos
        .where((Video element) => element.category == widget.category.title)
        .toList();
    final Size screenSize = MediaQuery.of(context).size;

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
          alignment: Alignment.bottomCenter,
          children: [
            Container(
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
                  children: <Widget>[
                    const SizedBox(height: 22.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: TitleText(title: widget.category.title),
                    ),
                    const SizedBox(height: 22.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        height: 30,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).accentColor,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _sortState = SortState.WissenState;
                                  });
                                },
                                child: Container(
                                  width: double.infinity,
                                  color: _sortState == SortState.WissenState
                                      ? Theme.of(context).accentColor
                                      : Colors.transparent,
                                  child: Center(
                                    child: Text(
                                      'Wissen',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color:
                                            _sortState == SortState.WissenState
                                                ? Theme.of(context).cardColor
                                                : Theme.of(context).accentColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _sortState = SortState.BeispieleState;
                                  });
                                },
                                child: Container(
                                  width: double.infinity,
                                  color: _sortState == SortState.BeispieleState
                                      ? Theme.of(context).accentColor
                                      : Colors.transparent,
                                  child: Center(
                                    child: Text(
                                      'Beispiele',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: _sortState ==
                                                SortState.BeispieleState
                                            ? Theme.of(context).cardColor
                                            : Theme.of(context).accentColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 22.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        clipBehavior: Clip.none,
                        shrinkWrap: true,
                        itemCount:
                            // _sortState == SortState.BeispieleState ? 4 : 20,

                            videosToShow.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: VideoTile(
                              id: videosToShow[index].id,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: SummaryBtn(),
            ),
          ],
        ),
      ),
    );
  }
}
