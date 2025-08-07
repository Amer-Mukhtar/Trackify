import 'package:flutter/material.dart';
import 'backgroundTheme.dart';


extension ThemeContextExtensions on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textStyles => Theme.of(this).textTheme;
}