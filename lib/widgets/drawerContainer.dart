import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suji_project/models/style.dart';
import 'package:suji_project/provider/darkThemeProvider.dart';
import 'package:suji_project/screens/progressScreen.dart';
import 'package:suji_project/widgets/dividerWhite.dart';
import 'package:suji_project/widgets/drawerCategory.dart';

class DrawerContainer extends StatefulWidget {
  @override
  _DrawerContainerState createState() => _DrawerContainerState();
}

class _DrawerContainerState extends State<DrawerContainer> {
  void _navigateTo(Widget screen, BuildContext ctxt) {
    Navigator.pop(ctxt);
    Navigator.push(
      context,
      MaterialPageRoute<Widget>(
        builder: (BuildContext ctxt) => screen,
      ),
    );
  }

  bool _isDark = false;

  bool changeColorMode() {
    return _isDark = !_isDark;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    // ignore: lines_longer_than_80_chars
    final DarkThemeProvider themeChange =
        Provider.of<DarkThemeProvider>(context);
    return Container(
      width: screenSize.width * .7,
      height: screenSize.height,
      color: Theme.of(context).backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).focusColor
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: screenSize.height * .05),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.white),
                      color: Theme.of(context).backgroundColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Transform.rotate(
                            angle: 6.1,
                            child: Text(
                              'A+',
                              style: TextStyle(
                                fontSize: 44,
                                color: Theme.of(context).hintColor,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'PREMIUM',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                  fontSize: 16,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '• 100 neue Videos',
                                style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                '• 50 neue Beispiele',
                                style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                '• und vieles mehr ...',
                                style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Hol dir die Premium-Mitgliedschaft um die Matura im Handumdrehen zu bestehen!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DrawerCategory(
                  icon: CupertinoIcons.lightbulb_fill,
                  title: 'Dein Fortschritt',
                  onTap: () {
                    _navigateTo(ProgressScreen(), context);
                  },
                ),
                DrawerCategory(
                  icon: CupertinoIcons.book_fill,
                  title: 'Zusammenfassungen',
                  onTap: () {},
                ),
                DrawerCategory(
                  icon: CupertinoIcons.heart_fill,
                  title: 'Gespeicherte Videos',
                  onTap: () {},
                ),
                DrawerCategory(
                    icon: CupertinoIcons.gear_solid,
                    title: 'Einstellungen',
                    onTap: () {}),
                DrawerCategory(
                  icon: CupertinoIcons.phone_fill,
                  title: 'Kontakt',
                  onTap: () {},
                ),
                DrawerCategory(
                  icon: CupertinoIcons.person_fill,
                  title: 'Deine Mitgliedschaft',
                  onTap: () => print("tapped"),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).hintColor.withOpacity(.2),
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(100),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Icon(
                                CupertinoIcons.moon_fill,
                                size: 18,
                                color: Theme.of(context).hintColor,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Dark Mode',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch.adaptive(
                          activeColor: Theme.of(context).accentColor,
                          value: themeChange.darkTheme,
                          onChanged: (bool value) {
                            themeChange.darkTheme = value;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
