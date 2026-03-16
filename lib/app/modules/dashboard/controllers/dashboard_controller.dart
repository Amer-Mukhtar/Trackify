import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/models/expense_entry.dart';
import '../../../data/repositories/expense_repository.dart';
import '../models/dashboard_models.dart';

class DashboardController extends GetxController {
  DashboardController(this._repository);

  final ExpenseRepository _repository;

  final RxBool isLoading = false.obs;
  final RxInt selectedTabIndex = 0.obs;
  final RxString selectedExpenseFilter = 'All'.obs;
  final RxString searchQuery = ''.obs;
  final Rx<StatsRange> selectedRange = StatsRange.thisMonth.obs;
  final Rx<ExpenseType> addExpenseType = ExpenseType.oneTime.obs;
  final RxString selectedCategoryId = 'food'.obs;
  final RxnString selectedSubscription = RxnString();
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final RxBool notificationsEnabled = true.obs;
  final RxList<ExpenseEntry> expenses = <ExpenseEntry>[].obs;

  final TextEditingController amountController = TextEditingController(text: '0.00');
  final TextEditingController noteController = TextEditingController();

  final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'en_US',
    symbol: r'$',
    decimalDigits: 2,
  );

  static const double monthlyIncome = 2142.5;

  final List<ExpenseCategory> categories = const <ExpenseCategory>[
    ExpenseCategory(
      id: 'food',
      name: 'Food',
      icon: Icons.restaurant_rounded,
      accent: Color(0xFFFF6A6A),
      softAccent: Color(0xFFFDE8E8),
      monthlyBudget: 600,
    ),
    ExpenseCategory(
      id: 'transport',
      name: 'Transport',
      icon: Icons.commute_rounded,
      accent: Color(0xFF4EC9C1),
      softAccent: Color(0xFFE2F7F5),
      monthlyBudget: 200,
    ),
    ExpenseCategory(
      id: 'shopping',
      name: 'Shopping',
      icon: Icons.shopping_bag_rounded,
      accent: Color(0xFFA06AE8),
      softAccent: Color(0xFFF0E8FF),
      monthlyBudget: 300,
    ),
    ExpenseCategory(
      id: 'groceries',
      name: 'Groceries',
      icon: Icons.local_grocery_store_rounded,
      accent: Color(0xFF55B9A5),
      softAccent: Color(0xFFE5F4EF),
      monthlyBudget: 180,
    ),
    ExpenseCategory(
      id: 'bills',
      name: 'Bills',
      icon: Icons.receipt_long_rounded,
      accent: Color(0xFFFFB14F),
      softAccent: Color(0xFFFFF1E0),
      monthlyBudget: 150,
    ),
    ExpenseCategory(
      id: 'entertainment',
      name: 'Entertainment',
      icon: Icons.live_tv_rounded,
      accent: Color(0xFFFF8A4C),
      softAccent: Color(0xFFFFEBDD),
      monthlyBudget: 150,
    ),
    ExpenseCategory(
      id: 'health',
      name: 'Health',
      icon: Icons.favorite_border_rounded,
      accent: Color(0xFFF48FB1),
      softAccent: Color(0xFFFFECF3),
      monthlyBudget: 120,
    ),
    ExpenseCategory(
      id: 'other',
      name: 'Other',
      icon: Icons.more_horiz_rounded,
      accent: Color(0xFF9DA8BC),
      softAccent: Color(0xFFF2F4F8),
      monthlyBudget: 100,
    ),
  ];

  final List<SubscriptionPreset> subscriptionPresets = const <SubscriptionPreset>[
    SubscriptionPreset(name: 'Netflix', price: 15.99, brandLabel: 'N', color: Color(0xFFE50914)),
    SubscriptionPreset(name: 'Spotify', price: 10.99, brandLabel: '♪', color: Color(0xFF1DB954)),
    SubscriptionPreset(name: 'YouTube Premium', price: 11.99, brandLabel: '▶', color: Color(0xFFFF0000)),
    SubscriptionPreset(name: 'Amazon Prime', price: 14.99, brandLabel: 'a', color: Color(0xFFFF9900)),
    SubscriptionPreset(name: 'HBO Max', price: 15.99, brandLabel: 'H', color: Color(0xFF7A4DFF)),
    SubscriptionPreset(name: 'Disney+', price: 10.99, brandLabel: 'D+', color: Color(0xFF2246D5)),
  ];

  List<QuickActionData> get quickActions => const <QuickActionData>[
        QuickActionData(
          eyebrow: 'View transaction history',
          title: 'All Expenses',
          icon: Icons.arrow_outward_rounded,
          gradient: <Color>[Color(0xFFFF6C6B), Color(0xFFFF8F4F)],
          tabIndex: 1,
        ),
        QuickActionData(
          eyebrow: 'Analyze spending',
          title: 'View Stats',
          icon: Icons.arrow_outward_rounded,
          gradient: <Color>[Color(0xFF54D0C5), Color(0xFF43AD98)],
          tabIndex: 3,
        ),
        QuickActionData(
          eyebrow: 'Track budgets',
          title: 'Set Goals',
          icon: Icons.arrow_outward_rounded,
          gradient: <Color>[Color(0xFF9F69E7), Color(0xFFB986ED)],
          tabIndex: 2,
        ),
        QuickActionData(
          eyebrow: 'Manage preferences',
          title: 'Settings',
          icon: Icons.arrow_outward_rounded,
          gradient: <Color>[Color(0xFFFFB14F), Color(0xFFFFD65B)],
          tabIndex: 4,
        ),
      ];

  @override
  void onInit() {
    super.onInit();
    loadExpenses();
  }

  @override
  void onClose() {
    amountController.dispose();
    noteController.dispose();
    super.onClose();
  }

  Future<void> loadExpenses() async {
    isLoading.value = true;
    try {
      final items = await _repository.fetchExpenses();
      expenses.assignAll(items);
    } finally {
      isLoading.value = false;
    }
  }

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  void jumpToTab(int index) {
    selectedTabIndex.value = index;
  }

  void toggleNotifications(bool value) {
    notificationsEnabled.value = value;
  }

  List<String> get expenseFilters {
    return <String>['All', ...categories.take(6).map((category) => category.name)];
  }

  ExpenseCategory categoryById(String categoryId) {
    return categories.firstWhere(
      (category) => category.id == categoryId,
      orElse: () => categories.last,
    );
  }

  ExpenseCategory categoryByName(String categoryName) {
    return categories.firstWhere(
      (category) => category.name == categoryName,
      orElse: () => categories.first,
    );
  }

  List<ExpenseEntry> get currentMonthExpenses {
    final now = DateTime.now();
    return expenses.where((expense) {
      return expense.date.year == now.year && expense.date.month == now.month;
    }).toList();
  }

  List<ExpenseEntry> get lastMonthExpenses {
    final now = DateTime.now();
    final month = now.month == 1 ? 12 : now.month - 1;
    final year = now.month == 1 ? now.year - 1 : now.year;
    return expenses.where((expense) {
      return expense.date.year == year && expense.date.month == month;
    }).toList();
  }

  List<ExpenseEntry> get currentWeekExpenses {
    final now = DateTime.now();
    final startOfWeek = DateTime(now.year, now.month, now.day).subtract(Duration(days: now.weekday - 1));
    return expenses.where((expense) {
      return !expense.date.isBefore(startOfWeek);
    }).toList();
  }

  List<ExpenseEntry> get previousWeekExpenses {
    final now = DateTime.now();
    final startOfWeek = DateTime(now.year, now.month, now.day).subtract(Duration(days: now.weekday - 1));
    final previousWeekStart = startOfWeek.subtract(const Duration(days: 7));
    return expenses.where((expense) {
      return expense.date.isAfter(previousWeekStart) && expense.date.isBefore(startOfWeek);
    }).toList();
  }

  double sumExpenses(Iterable<ExpenseEntry> items) {
    return items.fold<double>(0, (sum, expense) => sum + expense.amount);
  }

  double get currentMonthTotal => sumExpenses(currentMonthExpenses);
  double get lastMonthTotal => sumExpenses(lastMonthExpenses);
  double get currentWeekTotal => sumExpenses(currentWeekExpenses);
  double get totalBudget => categories
      .where((category) => <String>{'food', 'transport', 'shopping', 'entertainment'}.contains(category.id))
      .fold<double>(0, (sum, category) => sum + category.monthlyBudget);
  double get remainingBudget => max(totalBudget - currentMonthTotal, 0);
  double get availableBalance => monthlyIncome - currentMonthTotal;

  ExpenseCategory get topCategory {
    final totals = categoryTotals(currentMonthExpenses);
    String winnerId = 'food';
    double winnerTotal = -1;
    totals.forEach((key, value) {
      if (value > winnerTotal) {
        winnerId = key;
        winnerTotal = value;
      }
    });
    return categoryById(winnerId);
  }

  double get topCategoryAmount => categoryTotals(currentMonthExpenses)[topCategory.id] ?? 0;
  double get topCategoryShare => currentMonthTotal == 0 ? 0 : topCategoryAmount / currentMonthTotal;

  Map<String, double> categoryTotals(List<ExpenseEntry> source) {
    final totals = <String, double>{};
    for (final expense in source) {
      totals.update(expense.categoryId, (value) => value + expense.amount, ifAbsent: () => expense.amount);
    }
    return totals;
  }

  List<ExpenseEntry> get filteredExpenses {
    final query = searchQuery.value.trim().toLowerCase();
    final activeFilter = selectedExpenseFilter.value;
    return currentMonthExpenses.where((expense) {
      final category = categoryById(expense.categoryId);
      final matchesFilter = activeFilter == 'All' || category.name == activeFilter;
      final matchesQuery = query.isEmpty ||
          expense.title.toLowerCase().contains(query) ||
          expense.note.toLowerCase().contains(query) ||
          category.name.toLowerCase().contains(query);
      return matchesFilter && matchesQuery;
    }).toList();
  }

  List<double> get weeklyTrend {
    final now = DateTime.now();
    return List<double>.generate(4, (index) {
      final startDay = 1 + (index * 7);
      final endDay = min(startDay + 6, DateUtils.getDaysInMonth(now.year, now.month));
      return currentMonthExpenses.where((expense) {
        return expense.date.day >= startDay && expense.date.day <= endDay;
      }).fold<double>(0, (sum, expense) => sum + expense.amount);
    });
  }

  List<ExpenseEntry> expensesForRange(StatsRange range) {
    switch (range) {
      case StatsRange.thisWeek:
        return currentWeekExpenses;
      case StatsRange.thisMonth:
        return currentMonthExpenses;
      case StatsRange.lastMonth:
        return lastMonthExpenses;
    }
  }

  String labelForRange(StatsRange range) {
    switch (range) {
      case StatsRange.thisWeek:
        return 'This Week';
      case StatsRange.thisMonth:
        return 'This Month';
      case StatsRange.lastMonth:
        return 'Last Month';
    }
  }

  List<InsightData> get insights {
    final currentFood = currentWeekExpenses
        .where((expense) => expense.categoryId == 'food')
        .fold<double>(0, (sum, expense) => sum + expense.amount);
    final previousFood = previousWeekExpenses
        .where((expense) => expense.categoryId == 'food')
        .fold<double>(0, (sum, expense) => sum + expense.amount);
    final foodChange = previousFood == 0 ? 0 : ((currentFood - previousFood) / previousFood) * 100;

    final currentTransport = currentMonthExpenses
        .where((expense) => expense.categoryId == 'transport')
        .fold<double>(0, (sum, expense) => sum + expense.amount);
    final previousTransport = lastMonthExpenses
        .where((expense) => expense.categoryId == 'transport')
        .fold<double>(0, (sum, expense) => sum + expense.amount);
    final transportChange = previousTransport == 0 ? 0 : ((previousTransport - currentTransport) / previousTransport) * 100;

    return <InsightData>[
      InsightData(
        icon: Icons.trending_up_rounded,
        title: 'You spent ${foodChange.abs().round()}% more on food this week',
        foreground: const Color(0xFFE71C24),
        background: const Color(0xFFFFF1F3),
      ),
      InsightData(
        icon: Icons.trending_down_rounded,
        title: 'Transport spending decreased by ${transportChange.abs().round()}%',
        foreground: const Color(0xFF10B051),
        background: const Color(0xFFEAFBF0),
      ),
      InsightData(
        icon: Icons.error_outline_rounded,
        title: '${topCategory.name} is your largest spending category',
        foreground: const Color(0xFFFF5C00),
        background: const Color(0xFFFFF4E8),
      ),
    ];
  }

  String formatCurrency(double amount, {bool compact = false}) {
    if (compact) {
      return NumberFormat.compactSimpleCurrency(locale: 'en_US').format(amount);
    }
    return currencyFormatter.format(amount);
  }

  void updateSearch(String value) {
    searchQuery.value = value;
  }

  void updateExpenseFilter(String value) {
    selectedExpenseFilter.value = value;
  }

  void updateStatsRange(StatsRange range) {
    selectedRange.value = range;
  }

  void resetAddExpenseForm() {
    addExpenseType.value = ExpenseType.oneTime;
    selectedCategoryId.value = 'food';
    selectedSubscription.value = null;
    selectedDate.value = DateTime.now();
    amountController.text = '0.00';
    noteController.clear();
  }

  void setExpenseType(ExpenseType type) {
    addExpenseType.value = type;
    if (type == ExpenseType.oneTime) {
      selectedSubscription.value = null;
    }
  }

  void selectCategory(String categoryId) {
    selectedCategoryId.value = categoryId;
  }

  void selectSubscription(SubscriptionPreset preset) {
    selectedSubscription.value = preset.name;
    amountController.text = preset.price.toStringAsFixed(2);
    if (selectedCategoryId.value == 'food') {
      selectedCategoryId.value = 'entertainment';
    }
  }

  Future<void> pickExpenseDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null) {
      selectedDate.value = picked;
    }
  }

  Future<void> submitExpense() async {
    final amount = double.tryParse(amountController.text.trim());
    if (amount == null || amount <= 0) {
      Get.snackbar('Invalid amount', 'Enter a valid expense amount.');
      return;
    }

    final category = categoryById(selectedCategoryId.value);
    final title = selectedSubscription.value ?? category.name;
    final note = noteController.text.trim().isEmpty
        ? addExpenseType.value == ExpenseType.recurring
            ? 'Billed monthly'
            : 'Tracked with Trackify'
        : noteController.text.trim();

    final expense = ExpenseEntry(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      note: note,
      amount: amount,
      date: selectedDate.value,
      categoryId: category.id,
      type: addExpenseType.value,
    );

    await _repository.addExpense(expense);
    await loadExpenses();
    if (Get.isBottomSheetOpen ?? false) {
      Get.back<void>();
    }
    Get.snackbar('Expense added', '${formatCurrency(amount)} added to ${category.name}.');
  }
}