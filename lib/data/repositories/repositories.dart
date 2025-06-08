import '../../Models/expense.dart';
import '../../ViewModel/dbHandler.dart';

class ExpenseRepository {
  final myDb db;

  ExpenseRepository(this.db);

  Future<List<Expense>> fetchAllExpenses() => db.getExpenses();

  Future<void> addExpense(Expense expense) => db.insertRecord(expense);

  Future<void> deleteExpense(String id) => db.deleteRecord(id);

  Future<void> editExpense(Expense expense) => db.editRecord(expense);

  Future<void> clearExpenses() => db.clearAllExpenses();
}
