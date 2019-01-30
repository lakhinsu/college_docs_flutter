import 'package:flutter/material.dart';

String color="Brown";
bool isNight=false;


ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.orange,
);
 ThemeData light = new ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.brown,
  accentColor: Colors.brown,
  cursorColor: Colors.brown,
);


 ThemeData red = new ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.red,
  accentColor: Colors.red,
  cursorColor: Colors.red,
);

 ThemeData pink = new ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.pink,
  accentColor: Colors.pink,
  cursorColor: Colors.pink,
);

 ThemeData yellow = new ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.yellow,
  accentColor: Colors.yellow,
  cursorColor: Colors.yellow,
);

final ThemeData orange = new ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.orange,
  accentColor: Colors.orange,
  cursorColor: Colors.orange,
);

ThemeData themeChoser(String color) {
  if (isNight)
    return dark;
  else {
    if (color=="Yellow")
      return yellow;
    else if (color=="Red")
      return red;
    else if (color=="Pink")
      return pink;
    else if (color=="Orange")
      return orange;
    else
      return light;
  }
}

