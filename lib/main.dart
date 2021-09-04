import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suji_project/models/themeData.dart';
import 'package:suji_project/provider/darkThemeProvider.dart';
import 'package:suji_project/screens/homeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            return themeChangeProvider;
          },
        ),
      ],
      child: Consumer<DarkThemeProvider>(
          builder: (BuildContext context, value, Widget child) {
        return MaterialApp(
          theme: Styles.themeData(themeChangeProvider.darkTheme, context),
          debugShowCheckedModeBanner: false,
          title: 'Suji',
          home: HomeScreen(),
        );
      }),
    );
  }
}
