import 'package:flutter/material.dart';

@immutable
class CustomAppColors extends ThemeExtension<CustomAppColors> {
  final Color primaryBackground;
  final Color primarySurface;
  final Color primarySurfaceHighlighted;
  final Color onPrimary;

  const CustomAppColors({
    required this.primaryBackground,
    required this.primarySurface,
    required this.primarySurfaceHighlighted,
    required this.onPrimary,
  });

  @override
  CustomAppColors copyWith({
    Color? primaryBackground,
    Color? primarySurface,
    Color? primarySurfaceHighlighted,
    Color? onPrimary,
  }) {
    return CustomAppColors(
      primaryBackground: primaryBackground ?? this.primaryBackground,
      primarySurface: primarySurface ?? this.primarySurface,
      primarySurfaceHighlighted: primarySurfaceHighlighted ?? this.primarySurfaceHighlighted,
      onPrimary: onPrimary ?? this.onPrimary,
    );
  }

  @override
  CustomAppColors lerp(ThemeExtension<CustomAppColors>? other, double t) {
    if (other is! CustomAppColors) return this;
    return CustomAppColors(
      primaryBackground: Color.lerp(primaryBackground, other.primaryBackground, t)!,
      primarySurface: Color.lerp(primarySurface, other.primarySurface, t)!,
      primarySurfaceHighlighted: Color.lerp(primarySurfaceHighlighted, other.primarySurfaceHighlighted, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
    );
  }
}
