import 'package:flutter/material.dart';

String color="Brown";
bool mail=true;
bool down=true;
bool isNight=false;
String email="setemail";


ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.deepOrange,
  primarySwatch: Colors.deepOrange,
  accentColor: Colors.deepOrange,
  cursorColor: Colors.deepOrange
);
 ThemeData light = new ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.brown,
  accentColor: Colors.black,
  cursorColor: Colors.brown,
  buttonTheme: ButtonThemeData(
           buttonColor: Color(0xFF764423),
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
           textTheme:ButtonTextTheme.accent
           ,
  ),
);


 ThemeData red = new ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.red,
  primarySwatch: Colors.red,
  accentColor: Colors.black,
  cursorColor: Colors.red,
  buttonTheme: ButtonThemeData(
           buttonColor: Color(0xFFfc1808),
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
           textTheme:ButtonTextTheme.accent
           ,
  ),

);

 ThemeData pink = new ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.pink,
  primarySwatch: Colors.pink,
  accentColor: Colors.black,
  cursorColor: Colors.pink,
  buttonTheme: ButtonThemeData(
           buttonColor: Color(0xFFee0f94),
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
           textTheme:ButtonTextTheme.accent
           ,
  ),
);

 ThemeData purple = new ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.deepPurple,
  primarySwatch: Colors.deepPurple,
  accentColor: Colors.black,
  cursorColor: Colors.deepPurple,
  buttonTheme: ButtonThemeData(
           buttonColor: Color(0xFF9100e5),
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
           textTheme:ButtonTextTheme.accent
           ,
  ),
);

final ThemeData orange = new ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.orange,
  accentColor: Colors.black,
  cursorColor: Colors.orange,
  buttonTheme: ButtonThemeData(
           buttonColor: Color(0xFFffa300),
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
           textTheme:ButtonTextTheme.accent
           ,
  ),
);

ThemeData themeChoser(String color) {
  if (isNight)
    return dark;
  else {
    if (color=="Purple")
      return purple;
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

Color cardColor(){
  if (isNight)
    return Colors.orange;
  else {
    if (color=="Purple")
      return Color(0xFF9100e5);
    else if (color=="Red")
      return Color(0xFFfc1808);
    else if (color=="Pink")
      return Color(0xFFee0f94);
    else if (color=="Orange")
      return Color(0xFFffa300);
    else
      return Color(0xFF764423);
  }
}

Color listColor(){
  if (isNight)
    return Colors.orange;
  else {
    if (color=="Purple")
      return Color(0xFFab60b6);
    else if (color=="Red")
      return Color(0xFFfc1808);
    else if (color=="Pink")
      return Color(0xFFfc44ae);
    else if (color=="Orange")
      return Color(0xFFffc40b);
    else
      return Color(0xFF996644);
  }
}

