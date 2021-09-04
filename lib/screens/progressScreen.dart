import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:suji_project/data/category_data.dart';
import 'package:suji_project/models/catergory.dart';
import 'package:suji_project/models/style.dart';
import 'package:suji_project/widgets/chapterTile.dart';
import 'package:suji_project/widgets/dividerWhite.dart';
import 'package:suji_project/widgets/shareProgressBtn.dart';
import 'package:suji_project/widgets/statsRow.dart';
import 'package:suji_project/widgets/titleText.dart';

class ProgressScreen extends StatefulWidget {
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  bool _doneAnimating = false;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      height: screenSize.height,
      width: screenSize.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
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
          title: Text(
            'Dein Fortschritt',
            style: mainTextStyle,
          ),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              width: screenSize.width,
              height: screenSize.height * .9,
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[mainBoxshadow],
                color: Theme.of(context).backgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(22),
                  topRight: Radius.circular(22),
                ),
              ),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 18.0),
                    SizedBox(
                      width: screenSize.width,
                      child: Column(
                        children: <Widget>[
                          const TitleText(title: 'Allgemeiner Fortschritt'),
                          const SizedBox(height: 24),
                          CircularPercentIndicator(
                            radius: 100.0,
                            lineWidth: 12.0,
                            animation: true,
                            percent: 0.75,
                            onAnimationEnd: () {
                              setState(() {
                                _doneAnimating = true;
                              });
                            },
                            center: _doneAnimating
                                ? Text(
                                    '70%',
                                    style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20.0,
                                    ),
                                  )
                                : null,
                            circularStrokeCap: CircularStrokeCap.round,
                            linearGradient: LinearGradient(
                              colors: <Color>[
                                Theme.of(context).accentColor,
                                Theme.of(context).indicatorColor,
                              ],
                            ),
                            backgroundColor: Theme.of(context).highlightColor,
                          ),
                        ],
                      ),
                    ),
                    DividerWhite(height: 50),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TitleText(title: 'Statistik'),
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const <Widget>[
                          StatsRow(
                            description: 'Ø minuten am Tag konsumiert',
                            stat: '12:23 Minuten',
                          ),
                          SizedBox(height: 8),
                          StatsRow(
                            description: 'Konsumierte Stunden gesamt',
                            stat: '02:23 Stunden',
                          ),
                          SizedBox(height: 8),
                          StatsRow(
                            description: 'Gelernte Kapitel',
                            stat: '9 Kapitel',
                          ),
                          SizedBox(height: 8),
                          StatsRow(
                            description: 'Fehlende Kapitel',
                            stat: '3 Kapitel',
                          ),
                          SizedBox(height: 8),
                          StatsRow(
                            description: 'Vollendete Videos',
                            stat: '75 Videos',
                          ),
                          SizedBox(height: 8),
                          StatsRow(
                            description: 'Unvollendete Videos',
                            stat: '25 Videos',
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                    DividerWhite(height: 40),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TitleText(title: 'Details über'),
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      height: 140,
                      child: ListView.builder(
                        clipBehavior: Clip.none,
                        padding: const EdgeInsets.only(left: 20),
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ChapterTile(
                              category: categories[index],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 100.0),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ShareProgressBtn(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
