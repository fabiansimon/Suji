import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suji_project/data/video_data.dart';
import 'package:suji_project/models/style.dart';
import 'package:suji_project/models/video.dart';
import 'package:suji_project/widgets/videoTile.dart';

class SearchSheet extends StatefulWidget {
  @override
  _SearchSheetState createState() => _SearchSheetState();
}

class _SearchSheetState extends State<SearchSheet> {
  final TextEditingController _controller = TextEditingController();

  bool _isNotEmpty = false;
  List<Video> _filteredVideos = <Video>[];

  // Filter and show specific Videos
  void _searchVideos(String value) {
    if (value.isEmpty) {
      setState(() {
        _filteredVideos = <Video>[];
      });
    } else {
      setState(() {
        _filteredVideos = videos
            .where((Video element) =>
                element.title.toLowerCase().contains(value.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height * 0.2,
          ),
        ),
        Container(
          clipBehavior: Clip.hardEdge,
          height: screenSize.height * .8,
          width: screenSize.width,
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[mainBoxshadow],
            color: Theme.of(context).backgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(22),
              topRight: Radius.circular(22),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Theme.of(context).primaryColor,
                      Theme.of(context).focusColor,
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          CupertinoIcons.xmark,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      const Text(
                        'Suche',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: screenSize.height - screenSize.height * .265,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 18),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            boxShadow: [mainBoxshadow],
                            color: Theme.of(context).cardColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(17),
                            ),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 14.0),
                            child: Row(
                              children: [
                                Icon(
                                  CupertinoIcons.search,
                                  size: 20,
                                  color: Theme.of(context).highlightColor,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: TextField(
                                    controller: _controller,
                                    onChanged: (String value) {
                                      _searchVideos(value);

                                      if (_controller.text.isNotEmpty) {
                                        setState(() {
                                          _isNotEmpty = true;
                                        });
                                      } else {
                                        setState(() {
                                          _isNotEmpty = false;
                                        });
                                      }
                                    },
                                    style: TextStyle(
                                        color: Theme.of(context).hintColor),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText:
                                          "'Funktionen und Stammfunktion'",
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).highlightColor,
                                      ),
                                    ),
                                  ),
                                ),
                                if (_isNotEmpty)
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _controller.clear();
                                        _filteredVideos = <Video>[];
                                        _isNotEmpty = false;
                                      });
                                    },
                                    child: Icon(
                                      CupertinoIcons.xmark_circle_fill,
                                      size: 20,
                                      color: Theme.of(context).highlightColor,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Suchergebnisse',
                          style: TextStyle(
                            fontSize: 13,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _filteredVideos.isEmpty
                              ? 1
                              : _filteredVideos.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: _filteredVideos.isEmpty
                                  ? Center(
                                      child: Column(
                                        children: <Widget>[
                                          const SizedBox(height: 14),
                                          Text(
                                            'Keine derzeitigen Suchergebnisse',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Theme.of(context)
                                                  .highlightColor,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Icon(
                                            Icons
                                                .sentiment_dissatisfied_rounded,
                                            color: Theme.of(context)
                                                .highlightColor,
                                          )
                                        ],
                                      ),
                                    )
                                  : VideoTile(id: _filteredVideos[index].id),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
