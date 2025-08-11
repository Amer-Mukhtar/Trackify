
import 'package:flutter/material.dart';
import 'package:week_3_blp_1/theme/theme.dart';

import 'customThemes/backgroundTheme.dart';

class DarkTheme extends AppTheme{
  @override
  // TODO: implement theme
  ThemeData get theme =>ThemeData(
    extensions: const [
      CustomAppColors(
          primaryBackground: Colors.black ,
          primarySurface: Color(0xFFDEDFE2),
          primarySurfaceHighlighted: Colors.black,
          onPrimary: Color(0xFFFF7664)
      ),

    ],
  );
}