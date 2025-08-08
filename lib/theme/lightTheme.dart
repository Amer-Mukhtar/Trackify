import 'package:flutter/material.dart';
import 'package:week_3_blp_1/theme/theme.dart';

import 'customThemes/backgroundTheme.dart';

class LightTheme extends AppTheme{
  @override

  ThemeData get theme => ThemeData(
    extensions: const [
      CustomAppColors(
        primaryBackground: Colors.white ,
        primarySurface: Colors.grey,
        primarySurfaceHighlighted: Colors.black,
        onPrimary: Colors.redAccent
      ),

    ],
      );
}