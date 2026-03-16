import 'package:flutter/material.dart';

class ExpenseCategory {
  const ExpenseCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.accent,
    required this.softAccent,
    required this.monthlyBudget,
  });

  final String id;
  final String name;
  final IconData icon;
  final Color accent;
  final Color softAccent;
  final double monthlyBudget;
}

class InsightData {
  const InsightData({
    required this.icon,
    required this.title,
    required this.foreground,
    required this.background,
  });

  final IconData icon;
  final String title;
  final Color foreground;
  final Color background;
}

class QuickActionData {
  const QuickActionData({
    required this.eyebrow,
    required this.title,
    required this.icon,
    required this.gradient,
    required this.tabIndex,
  });

  final String eyebrow;
  final String title;
  final IconData icon;
  final List<Color> gradient;
  final int tabIndex;
}

class SubscriptionPreset {
  const SubscriptionPreset({
    required this.name,
    required this.price,
    required this.brandLabel,
    required this.color,
  });

  final String name;
  final double price;
  final String brandLabel;
  final Color color;
}

enum StatsRange { thisWeek, thisMonth, lastMonth }