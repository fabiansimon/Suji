import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:suji_project/data/category_data.dart';
import 'package:suji_project/data/video_data.dart';
import 'package:suji_project/models/catergory.dart';

import 'package:suji_project/models/style.dart';
import 'package:suji_project/models/userData.dart';
import 'package:suji_project/models/video.dart';
import 'package:suji_project/screens/chapterScreen.dart';
import 'package:suji_project/screens/progressScreen.dart';
import 'package:suji_project/widgets/codeBtn.dart';
import 'package:suji_project/widgets/drawerContainer.dart';
import 'package:suji_project/widgets/searchSheet.dart';
import 'package:suji_project/widgets/videoTile.dart';
import 'package:suji_project/widgets/chapterTile.dart';
import 'package:suji_project/widgets/dividerWhite.dart';
import 'package:suji_project/widgets/lastSeenVideoTile.dart';
import 'package:suji_project/widgets/progressBar.dart';
import 'package:suji_project/widgets/titleText.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  final RefreshController _refreshController = RefreshController();

  final GlobalKey<State<StatefulWidget>> tooltipKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isCheckingCode = false;
  bool _showSuggestion = false;
  bool _codeInput = false;
  bool _isLoading = false;
  final int _animationSpeed = 200;

  String videoIdSuggestion;

  // Function to checkcode and find specific Video
  void _checkCode(String value) {
    if (value.length == 4) {
      // _isCheckingCode = true;
      FocusScope.of(context).requestFocus(FocusNode());
      print('searching...');
      _filterVideo(value);
    } else {
      print('missing letters');
      setState(() {
        _isCheckingCode = false;
        _showSuggestion = false;
      });
    }
  }

  // Function to filter Video
  void _filterVideo(String value) {
    for (int i = 0; i < videos.length; i++) {
      if (videos[i].vidCode == value.trim().toUpperCase()) {
        setState(() {
          _isCheckingCode = true;
          _showSuggestion = true;
          videoIdSuggestion = videos[i].id;
        });
      }
    }
  }

  // Exit the codeCheck with animation
  void _exitCodeCheck() {
    setState(() {
      _codeInput = false;
      _showSuggestion = false;
      _isCheckingCode = false;
      _controller.clear();
    });
  }

  // ModalSheet which pops up from the bottom of the screen
  Future<void> _searchModalSheet() async {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return SearchSheet();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    // ignore: always_specify_types
    Future.delayed(const Duration(seconds: 3)).then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    setState(() {
      _isCheckingCode = false;
      _showSuggestion = false;
      _codeInput = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    if (_isLoading) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).focusColor
            ],
          ),
        ),
        child: Center(
          child: Lottie.asset(
            'assets/animation.json',
            width: screenSize.width * .5,
          ),
        ),
      );
    } else {
      final toolTip =
          "Diesen Code bekommt ihr \nauf unserem Yotube Kanal \num interaktiv mitzuarbeiten!";
      return Container(
        height: screenSize.height,
        width: screenSize.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Theme.of(context).primaryColor,
              Theme.of(context).focusColor,
            ],
          ),
        ),
        child: Stack(
          children: <Widget>[
            Scaffold(
              key: _scaffoldKey,
              resizeToAvoidBottomInset: false,
              drawer: DrawerContainer(),
              onDrawerChanged: (bool isOpened) {
                setState(() {
                  _isCheckingCode = false;
                  _showSuggestion = false;
                  _codeInput = false;
                });
              },
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                leading: IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: const Icon(Icons.menu),
                  onPressed: () => _scaffoldKey.currentState.openDrawer(),
                ),
                brightness: Brightness.dark,
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        DateFormat('d. MMMM').format(DateTime.now()).toString(),
                        style: mainTextStyle,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Noch ' +
                            DateTime.now()
                                .difference(
                                  DateTime.utc(DateTime.now().year, 5, 21),
                                )
                                .inDays
                                .abs()
                                .toString() +
                            ' Tage bis zur Matura',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0, left: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        _searchModalSheet();
                      },
                      child: const Icon(
                        CupertinoIcons.search,
                      ),
                    ),
                  )
                ],
              ),
              body: Stack(
                children: [
                  SizedBox(
                    height: screenSize.height,
                    width: screenSize.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: ProgressBar(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<BuildContext>(
                                  builder: (BuildContext context) =>
                                      ProgressScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 14),
                        Expanded(
                          child: Container(
                            width: screenSize.width,
                            decoration: BoxDecoration(
                              boxShadow: <BoxShadow>[mainBoxshadow],
                              // color: mainBackgroundColor,
                              color: Theme.of(context).backgroundColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(22),
                                topRight: Radius.circular(22),
                              ),
                            ),
                            child: SmartRefresher(
                              controller: _refreshController,
                              onRefresh: () {
                                Future.delayed(const Duration(seconds: 1))
                                    .then((_) {
                                  _refreshController.refreshCompleted();
                                });
                              },
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const SizedBox(height: 18.0),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18.0),
                                      child: LastSeenVideoTile(
                                        videoId:
                                            videos[currentUser.lastVideo].id,
                                      ),
                                    ),
                                    const SizedBox(height: 17.5),
                                    DividerWhite(height: 40),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 24.0),
                                      child: TitleText(title: 'Kapitel'),
                                    ),
                                    const SizedBox(height: 16.0),
                                    SizedBox(
                                      height: 140,
                                      child: ListView.builder(
                                        clipBehavior: Clip.none,
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: categories.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: ChapterTile(
                                              category: categories[index],
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute<
                                                      BuildContext>(
                                                    builder: (BuildContext
                                                            context) =>
                                                        ChapterScreen(
                                                      category:
                                                          categories[index],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 17.5),
                                    DividerWhite(height: 30),
                                    const Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24.0),
                                      child: TitleText(title: 'Videos'),
                                    ),
                                    const SizedBox(height: 16.0),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        clipBehavior: Clip.none,
                                        shrinkWrap: true,
                                        itemCount: videos.length -
                                            currentUser.lastVideo,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: VideoTile(
                                                id: (index +
                                                        currentUser.lastVideo)
                                                    .toString()),
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    right: 20,
                    bottom: 30,
                    child: CodeBtn(
                      onTap: () {
                        setState(() {
                          _codeInput = true;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            AnimatedOpacity(
              opacity: _codeInput ? 1 : 0,
              duration: Duration(milliseconds: _animationSpeed + 100),
              curve: Curves.easeIn,
              child: _codeInput
                  ? Material(
                      color: Colors.transparent,
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            color: Colors.black.withOpacity(.3),
                            width: screenSize.width,
                            height: screenSize.height,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Stack(
                                    children: [
                                      AnimatedContainer(
                                        curve: Curves.easeInCubic,
                                        duration: Duration(
                                            milliseconds:
                                                _animationSpeed + 100),
                                        onEnd: () {
                                          setState(() {
                                            _isCheckingCode
                                                ? _showSuggestion = true
                                                : _showSuggestion = false;
                                          });
                                        },
                                        height: _isCheckingCode ? 240 : 164,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          color:
                                              Theme.of(context).backgroundColor,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              height: 55,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Theme.of(context)
                                                        .primaryColor,
                                                    Theme.of(context)
                                                        .focusColor,
                                                  ],
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 14.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          _codeInput = false;
                                                        });
                                                        _exitCodeCheck();
                                                      },
                                                      child: Container(
                                                        color:
                                                            Colors.transparent,
                                                        child: const Icon(
                                                          CupertinoIcons.xmark,
                                                          color: Colors.white,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ),
                                                    const Text(
                                                      'Video Suche',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        letterSpacing: -.5,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Tooltip(
                                                      key: tooltipKey,
                                                      preferBelow: false,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12),
                                                      message: toolTip,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          final dynamic
                                                              tooltip =
                                                              tooltipKey
                                                                  .currentState;
                                                          tooltip
                                                              .ensureTooltipVisible();
                                                        },
                                                        child: const Icon(
                                                          CupertinoIcons
                                                              .question_circle_fill,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 12.0,
                                                  ),
                                                  child: Container(
                                                    height: 50,
                                                    width: 200,
                                                    decoration: BoxDecoration(
                                                      boxShadow: [
                                                        mainBoxshadow
                                                      ],
                                                      color: Theme.of(context)
                                                          .cardColor,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(5),
                                                      ),
                                                    ),
                                                    child: TextField(
                                                      maxLength: 4,
                                                      style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .hintColor),
                                                      enableSuggestions: false,
                                                      autocorrect: false,
                                                      cursorColor:
                                                          Theme.of(context)
                                                              .hintColor,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: 'zB AB02',
                                                        hintStyle: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .hintColor
                                                              .withOpacity(.6),
                                                        ),
                                                        border:
                                                            InputBorder.none,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        enabledBorder:
                                                            InputBorder.none,
                                                        errorBorder:
                                                            InputBorder.none,
                                                        disabledBorder:
                                                            InputBorder.none,
                                                        counterText: '',
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                      controller: _controller,
                                                      onChanged:
                                                          (String value) {
                                                        _checkCode(value);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  'Gib den 4-stelligen Code ein',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Theme.of(context)
                                                        .highlightColor,
                                                  ),
                                                ),
                                                if (_isCheckingCode &&
                                                    _showSuggestion)
                                                  DividerWhite(height: 20)
                                                else
                                                  const SizedBox(),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      AnimatedPositioned(
                                        curve: Curves.bounceIn,
                                        duration: Duration(
                                            milliseconds: _animationSpeed),
                                        bottom: 10,
                                        left: _showSuggestion
                                            ? screenSize.width * .022
                                            : -500,
                                        child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxWidth: screenSize.width * .85,
                                          ),
                                          child: videoIdSuggestion != null
                                              ? VideoTile(
                                                  id: videoIdSuggestion,
                                                )
                                              : const SizedBox(),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            )
          ],
        ),
      );
    }
  }
}
