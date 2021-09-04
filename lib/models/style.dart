import 'package:flutter/material.dart';

Color mainColor = Color(0xFF45B4ED);
Color mainColorAccent = Color(0xFF45C7ED);

Color accentColor = Color(0xFFEF4B6B);
Color accentColorAccent = Color(0xFFEA5471);

Color mainBackgroundColor = Color(0xFFF6F6F6);
Color mainTileColor = Color(0xFFFFFFFF);

Color textBlack = Color(0xFF131415);
Color subtleTextColor = Color(0xFF878787);

TextStyle mainTextStyle = TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: 18,
);

LinearGradient mainColorGradient = LinearGradient(
  colors: [mainColor, mainColorAccent],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

LinearGradient accentColorGradient = LinearGradient(
  colors: [accentColor, accentColorAccent],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

BoxShadow mainBoxshadow = BoxShadow(
  color: Color(0xFF000000).withOpacity(.08),
  blurRadius: 10,
);

BoxShadow mainColorBoxShadow = BoxShadow(
  color: mainColor.withOpacity(.03),
  blurRadius: 10,
);
BoxShadow accentBoxshadow = BoxShadow(
  color: accentColor.withOpacity(.03),
  blurRadius: 10,
);
