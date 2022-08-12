import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme() => ThemeData(
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: Colors.grey[100],
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.grey[100],
        statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.grey[100],
    elevation: 0,
    titleSpacing: 0,
    iconTheme: IconThemeData(
    color: Colors.grey.withOpacity(.5),
  ),
  ),
  textTheme: TextTheme(
    headline1: TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontFamily: 'Glory',
      fontWeight: FontWeight.w900,
    ),
    bodyText1: TextStyle(
      fontFamily: 'Glory',
      fontSize: 20,
      color: Colors.black,
    ),
  ),
);

ThemeData darkTheme() => ThemeData(
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: Colors.grey[900],
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.grey[900],
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: Colors.grey[900],
    elevation: 0,
    titleSpacing: 0,
    iconTheme: IconThemeData(
      color: Colors.grey,
    ),
  ),
  textTheme: TextTheme(
    headline1: TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontFamily: 'Glory',
      fontWeight: FontWeight.w700,
    ),
    bodyText1: TextStyle(
      fontFamily: 'Glory',
      fontSize: 20,
      color: Colors.white,
    ),
  ),
);