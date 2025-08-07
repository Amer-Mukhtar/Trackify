import 'package:flutter/material.dart';

import 'darkTheme.dart';
import 'lightTheme.dart';

abstract class AppTheme {
  ThemeData get theme;

  static final lightTheme = LightTheme();
  static final darkTheme = DarkTheme();
}