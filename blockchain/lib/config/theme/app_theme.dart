import 'package:flutter/material.dart';

class AppTheme {
  final bool isDark;
  final Color seedColor;

  AppTheme({this.isDark = false, this.seedColor = const Color(0XFFEC87C0)});

  ThemeData get theme => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: isDark ? Brightness.dark : Brightness.light,
          seedColor: seedColor,
        ),
      );
}
