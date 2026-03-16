import 'package:flutter/material.dart';

import 'app_colors.dart';

extension ThemeContext on BuildContext {
  ThemeData get appTheme => Theme.of(this);
  TextTheme get textTheme => appTheme.textTheme;
  ColorScheme get colorScheme => appTheme.colorScheme;
  TrackifyColors get palette => appTheme.extension<TrackifyColors>()!;
}