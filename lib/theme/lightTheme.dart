import 'package:flutter/material.dart';
import 'package:week_3_blp_1/theme/theme.dart';

import 'customThemes/backgroundTheme.dart';

class LightTheme extends AppTheme{
  @override

  ThemeData get theme => ThemeData(
    inputDecorationTheme: const InputDecorationTheme(
      alignLabelWithHint: true,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      labelStyle: TextStyle(color: Colors.black),
    ),

    extensions: const [
      CustomAppColors(
        primaryBackground: Colors.white ,
        primarySurface: Color(0xFFDEDFE2),
        primarySurfaceHighlighted: Colors.black,
        onPrimary: Color(0xFFFF7664)
      ),

    ],
      );
}