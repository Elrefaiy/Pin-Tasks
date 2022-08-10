import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme() => ThemeData(
  primaryColor: Colors.amber[700],
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0,
    titleSpacing: 0,
    iconTheme: IconThemeData(
      color: Colors.amber[700],
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
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.white,
    elevation: 4,
    highlightElevation: 0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    unselectedItemColor: Colors.grey,
    selectedItemColor: Colors.amber[700],
    elevation: 30,
  ),
);

ThemeData darkTheme() => ThemeData(
  primaryColor: Colors.amber[700],
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
      color: Colors.amber[700],
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
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.grey[800],
    elevation: 4,
    highlightElevation: 0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.grey[850],
    unselectedItemColor: Colors.grey,
    selectedItemColor: Colors.amber[700],
    elevation: 30,
  ),

);