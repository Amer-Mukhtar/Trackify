import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Models/expense.dart';
import '../../data/repositories/repositories.dart';
import 'expense_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  final ExpenseRepository repository;

  ExpenseCubit(this.repository) : super(ExpenseInitial());

  Future<void> loadExpenses() async {
    try {
      emit(ExpenseLoading());
      final expenses = await repository.fetchAllExpenses();
      emit(ExpenseLoaded(expenses));
    } catch (e) {
      emit(ExpenseError('Failed to load expenses'));
    }
  }

  Future<void> addExpense(Expense expense) async {
    await repository.addExpense(expense);
    await loadExpenses();
  }

  Future<void> deleteExpense(String id) async {
    await repository.deleteExpense(id);
    await loadExpenses();
  }

  Future<void> editExpense(Expense expense) async {
    await repository.editExpense(expense);
    await loadExpenses();
  }

  Future<void> clearAll() async {
    await repository.clearExpenses();
    await loadExpenses();
  }
}
