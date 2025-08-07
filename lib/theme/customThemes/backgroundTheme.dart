import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color primaryBackground;
  final Color primarySurface;
  final Color primarySurfaceHighlighted;
  final Color onPrimary;

  const AppColors({
    required this.primaryBackground,
    required this.primarySurface,
    required this.primarySurfaceHighlighted,
    required this.onPrimary,
  });

  @override
  AppColors copyWith({
    Color? primaryBackground,
    Color? primarySurface,
    Color? primarySurfaceHighlighted,
    Color? onPrimary,
  }) {
    return AppColors(
      primaryBackground: primaryBackground ?? this.primaryBackground,
      primarySurface: primarySurface ?? this.primarySurface,
      primarySurfaceHighlighted: primarySurfaceHighlighted ?? this.primarySurfaceHighlighted,
      onPrimary: onPrimary ?? this.onPrimary,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primaryBackground: Color.lerp(primaryBackground, other.primaryBackground, t)!,
      primarySurface: Color.lerp(primarySurface, other.primarySurface, t)!,
      primarySurfaceHighlighted: Color.lerp(primarySurfaceHighlighted, other.primarySurfaceHighlighted, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
    );
  }
}
