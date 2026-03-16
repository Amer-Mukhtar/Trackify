import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/expense_entry.dart';

class LocalDatabaseService {
  Database? _database;

  Future<LocalDatabaseService> init() async {
    final databaseDirectory = await getDatabasesPath();
    final databasePath = join(databaseDirectory, 'trackify.db');
    _database = await openDatabase(
      databasePath,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE expenses(
            id TEXT PRIMARY KEY,
            title TEXT NOT NULL,
            note TEXT,
            amount REAL NOT NULL,
            date TEXT NOT NULL,
            category_id TEXT NOT NULL,
            type TEXT NOT NULL
          )
        ''');
      },
    );
    await _seedIfEmpty();
    return this;
  }

  Database get database {
    final instance = _database;
    if (instance == null) {
      throw StateError('Database not initialized');
    }
    return instance;
  }

  Future<List<ExpenseEntry>> fetchExpenses() async {
    final result = await database.query(
      'expenses',
      orderBy: 'date DESC',
    );
    return result.map(ExpenseEntry.fromMap).toList();
  }

  Future<void> insertExpense(ExpenseEntry expense) async {
    await database.insert(
      'expenses',
      expense.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteExpense(String id) async {
    await database.delete(
      'expenses',
      where: 'id = ?',
      whereArgs: <Object?>[id],
    );
  }

  Future<void> _seedIfEmpty() async {
    final count = Sqflite.firstIntValue(
      await database.rawQuery('SELECT COUNT(*) FROM expenses'),
    );
    if ((count ?? 0) > 0) {
      return;
    }

    final now = DateTime.now();
    final seedExpenses = <ExpenseEntry>[
      ExpenseEntry(
        id: 'seed-food-1',
        title: 'Food',
        note: 'Lunch at cafe',
        amount: 45.5,
        date: now.subtract(const Duration(hours: 2)),
        categoryId: 'food',
        type: ExpenseType.oneTime,
      ),
      ExpenseEntry(
        id: 'seed-transport-1',
        title: 'Transport',
        note: 'Uber ride',
        amount: 12,
        date: now.subtract(const Duration(hours: 6)),
        categoryId: 'transport',
        type: ExpenseType.oneTime,
      ),
      ExpenseEntry(
        id: 'seed-shopping-1',
        title: 'Shopping',
        note: 'New shoes',
        amount: 120,
        date: now.subtract(const Duration(days: 1, hours: 4)),
        categoryId: 'shopping',
        type: ExpenseType.oneTime,
      ),
      ExpenseEntry(
        id: 'seed-food-2',
        title: 'Food',
        note: 'Family dinner',
        amount: 299.5,
        date: DateTime(now.year, now.month, 10, 20, 15),
        categoryId: 'food',
        type: ExpenseType.oneTime,
      ),
      ExpenseEntry(
        id: 'seed-food-3',
        title: 'Food',
        note: 'Weekly groceries',
        amount: 67,
        date: DateTime(now.year, now.month, 8, 17, 45),
        categoryId: 'food',
        type: ExpenseType.oneTime,
      ),
      ExpenseEntry(
        id: 'seed-food-4',
        title: 'Food',
        note: 'Coffee run',
        amount: 38,
        date: DateTime(now.year, now.month, 5, 8, 10),
        categoryId: 'food',
        type: ExpenseType.oneTime,
      ),
      ExpenseEntry(
        id: 'seed-transport-2',
        title: 'Transport',
        note: 'Fuel refill',
        amount: 63,
        date: DateTime(now.year, now.month, 12, 14, 20),
        categoryId: 'transport',
        type: ExpenseType.oneTime,
      ),
      ExpenseEntry(
        id: 'seed-transport-3',
        title: 'Transport',
        note: 'Metro pass',
        amount: 27,
        date: DateTime(now.year, now.month, 9, 7, 30),
        categoryId: 'transport',
        type: ExpenseType.recurring,
      ),
      ExpenseEntry(
        id: 'seed-transport-4',
        title: 'Transport',
        note: 'Ride share',
        amount: 18,
        date: DateTime(now.year, now.month, 3, 11, 45),
        categoryId: 'transport',
        type: ExpenseType.oneTime,
      ),
      ExpenseEntry(
        id: 'seed-shopping-2',
        title: 'Shopping',
        note: 'Home essentials',
        amount: 85,
        date: DateTime(now.year, now.month, 7, 18, 20),
        categoryId: 'shopping',
        type: ExpenseType.oneTime,
      ),
      ExpenseEntry(
        id: 'seed-shopping-3',
        title: 'Shopping',
        note: 'Gift order',
        amount: 75,
        date: DateTime(now.year, now.month, 2, 13, 50),
        categoryId: 'shopping',
        type: ExpenseType.oneTime,
      ),
      ExpenseEntry(
        id: 'seed-entertainment-1',
        title: 'Entertainment',
        note: 'Movie night',
        amount: 18,
        date: DateTime(now.year, now.month, 11, 21, 10),
        categoryId: 'entertainment',
        type: ExpenseType.oneTime,
      ),
      ExpenseEntry(
        id: 'seed-entertainment-2',
        title: 'Entertainment',
        note: 'Streaming subscription',
        amount: 27,
        date: DateTime(now.year, now.month, 4, 10, 0),
        categoryId: 'entertainment',
        type: ExpenseType.recurring,
      ),
      ExpenseEntry(
        id: 'seed-last-month-food',
        title: 'Food',
        note: 'Archived cafe bill',
        amount: 510,
        date: DateTime(now.year, now.month - 1, 18, 13, 0),
        categoryId: 'food',
        type: ExpenseType.oneTime,
      ),
      ExpenseEntry(
        id: 'seed-last-month-shopping',
        title: 'Shopping',
        note: 'Wardrobe refresh',
        amount: 190,
        date: DateTime(now.year, now.month - 1, 8, 15, 10),
        categoryId: 'shopping',
        type: ExpenseType.oneTime,
      ),
      ExpenseEntry(
        id: 'seed-last-month-transport',
        title: 'Transport',
        note: 'Monthly commute',
        amount: 135,
        date: DateTime(now.year, now.month - 1, 5, 8, 30),
        categoryId: 'transport',
        type: ExpenseType.recurring,
      ),
    ];

    final batch = database.batch();
    for (final expense in seedExpenses) {
      batch.insert('expenses', expense.toMap());
    }
    await batch.commit(noResult: true);
  }
}