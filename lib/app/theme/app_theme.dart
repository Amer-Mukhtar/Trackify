import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData get light {
    final baseTextTheme = GoogleFonts.plusJakartaSansTextTheme();
    final colorScheme = ColorScheme.fromSeed(
      seedColor: TrackifyColors.light.accent,
      brightness: Brightness.light,
      primary: TrackifyColors.light.accent,
      secondary: TrackifyColors.light.accentMint,
      surface: TrackifyColors.light.surface,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: TrackifyColors.light.background,
      textTheme: baseTextTheme.apply(
        bodyColor: TrackifyColors.light.textPrimary,
        displayColor: TrackifyColors.light.textPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      cardColor: TrackifyColors.light.surface,
      dividerColor: TrackifyColors.light.border,
      iconTheme: const IconThemeData(color: TrackifyColors.light.textPrimary),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
        showDragHandle: false,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: TrackifyColors.light.surfaceMuted,
        hintStyle: baseTextTheme.bodyLarge?.copyWith(
          color: TrackifyColors.light.textSecondary,
          fontWeight: FontWeight.w600,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: TrackifyColors.light.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: TrackifyColors.light.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: TrackifyColors.light.accent.withValues(alpha: 0.5)),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),
      extensions: const <ThemeExtension<dynamic>>[
        TrackifyColors.light,
      ],
    );
  }

  static ThemeData get dark {
    final baseTextTheme = GoogleFonts.plusJakartaSansTextTheme();
    final colorScheme = ColorScheme.fromSeed(
      seedColor: TrackifyColors.dark.accent,
      brightness: Brightness.dark,
      primary: TrackifyColors.dark.accent,
      secondary: TrackifyColors.dark.accentMint,
      surface: TrackifyColors.dark.surface,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: TrackifyColors.dark.background,
      textTheme: baseTextTheme.apply(
        bodyColor: TrackifyColors.dark.textPrimary,
        displayColor: TrackifyColors.dark.textPrimary,
      ),
      extensions: const <ThemeExtension<dynamic>>[
        TrackifyColors.dark,
      ],
    );
  }
}