import 'package:flutter/material.dart';

@immutable
class TrackifyColors extends ThemeExtension<TrackifyColors> {
  const TrackifyColors({
    required this.background,
    required this.surface,
    required this.surfaceMuted,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.accent,
    required this.accentWarm,
    required this.accentMint,
    required this.accentViolet,
    required this.accentAmber,
    required this.danger,
    required this.success,
    required this.info,
    required this.shadow,
  });

  final Color background;
  final Color surface;
  final Color surfaceMuted;
  final Color border;
  final Color textPrimary;
  final Color textSecondary;
  final Color accent;
  final Color accentWarm;
  final Color accentMint;
  final Color accentViolet;
  final Color accentAmber;
  final Color danger;
  final Color success;
  final Color info;
  final Color shadow;

  static const light = TrackifyColors(
    background: Color(0xFFF6F7FB),
    surface: Colors.white,
    surfaceMuted: Color(0xFFF0F3F8),
    border: Color(0xFFE8ECF4),
    textPrimary: Color(0xFF162039),
    textSecondary: Color(0xFF75819A),
    accent: Color(0xFFFF6A6A),
    accentWarm: Color(0xFFFF8B4E),
    accentMint: Color(0xFF4EC9C1),
    accentViolet: Color(0xFFA06AE8),
    accentAmber: Color(0xFFFFC95C),
    danger: Color(0xFFE71C24),
    success: Color(0xFF10B051),
    info: Color(0xFF2F65F5),
    shadow: Color(0x160F172A),
  );

  static const dark = TrackifyColors(
    background: Color(0xFF101522),
    surface: Color(0xFF182032),
    surfaceMuted: Color(0xFF202A3F),
    border: Color(0xFF2C3650),
    textPrimary: Color(0xFFF7F8FB),
    textSecondary: Color(0xFFB3BDD4),
    accent: Color(0xFFFF7B74),
    accentWarm: Color(0xFFFF9D64),
    accentMint: Color(0xFF55D1C2),
    accentViolet: Color(0xFFAB81EC),
    accentAmber: Color(0xFFFFCE6D),
    danger: Color(0xFFFF5757),
    success: Color(0xFF30C767),
    info: Color(0xFF5B8AFF),
    shadow: Color(0x33000000),
  );

  @override
  TrackifyColors copyWith({
    Color? background,
    Color? surface,
    Color? surfaceMuted,
    Color? border,
    Color? textPrimary,
    Color? textSecondary,
    Color? accent,
    Color? accentWarm,
    Color? accentMint,
    Color? accentViolet,
    Color? accentAmber,
    Color? danger,
    Color? success,
    Color? info,
    Color? shadow,
  }) {
    return TrackifyColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceMuted: surfaceMuted ?? this.surfaceMuted,
      border: border ?? this.border,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      accent: accent ?? this.accent,
      accentWarm: accentWarm ?? this.accentWarm,
      accentMint: accentMint ?? this.accentMint,
      accentViolet: accentViolet ?? this.accentViolet,
      accentAmber: accentAmber ?? this.accentAmber,
      danger: danger ?? this.danger,
      success: success ?? this.success,
      info: info ?? this.info,
      shadow: shadow ?? this.shadow,
    );
  }

  @override
  ThemeExtension<TrackifyColors> lerp(
    covariant ThemeExtension<TrackifyColors>? other,
    double t,
  ) {
    if (other is! TrackifyColors) {
      return this;
    }
    return TrackifyColors(
      background: Color.lerp(background, other.background, t) ?? background,
      surface: Color.lerp(surface, other.surface, t) ?? surface,
      surfaceMuted: Color.lerp(surfaceMuted, other.surfaceMuted, t) ?? surfaceMuted,
      border: Color.lerp(border, other.border, t) ?? border,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t) ?? textPrimary,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t) ?? textSecondary,
      accent: Color.lerp(accent, other.accent, t) ?? accent,
      accentWarm: Color.lerp(accentWarm, other.accentWarm, t) ?? accentWarm,
      accentMint: Color.lerp(accentMint, other.accentMint, t) ?? accentMint,
      accentViolet: Color.lerp(accentViolet, other.accentViolet, t) ?? accentViolet,
      accentAmber: Color.lerp(accentAmber, other.accentAmber, t) ?? accentAmber,
      danger: Color.lerp(danger, other.danger, t) ?? danger,
      success: Color.lerp(success, other.success, t) ?? success,
      info: Color.lerp(info, other.info, t) ?? info,
      shadow: Color.lerp(shadow, other.shadow, t) ?? shadow,
    );
  }
}