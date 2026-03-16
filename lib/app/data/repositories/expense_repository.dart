import '../models/expense_entry.dart';
import '../services/local_database_service.dart';

class ExpenseRepository {
  ExpenseRepository(this._databaseService);

  final LocalDatabaseService _databaseService;

  Future<List<ExpenseEntry>> fetchExpenses() {
    return _databaseService.fetchExpenses();
  }

  Future<void> addExpense(ExpenseEntry expense) {
    return _databaseService.insertExpense(expense);
  }

  Future<void> deleteExpense(String id) {
    return _databaseService.deleteExpense(id);
  }
}