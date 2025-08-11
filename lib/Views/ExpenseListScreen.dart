import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../presentation/cubit/expense_cubit.dart';
import '../presentation/cubit/expense_state.dart';
import 'expenseDetails.dart';
import '../main.dart';

class ExpenseListScreen extends StatefulWidget {
  @override
  _ExpenseListScreenState createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  String _selectedCategoryFilter = 'All';
  final List<String> _categories = ['All', 'Grocery', 'School', 'Entertainment', 'Bills', 'Others'];


  void _showCategoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text('Select a category', style: TextStyle(color: textWhite)),
          content: SingleChildScrollView(
            child: Theme(
              data: ThemeData.dark(),
              child: ListBody(
                children: _categories.map((category) {
                  return ListTile(
                    title: Text(category),
                    onTap: () {
                      setState(() {
                        _selectedCategoryFilter = category;
                      });
                      Navigator.of(context).pop();
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  void _clearExpenses() {
    context.read<ExpenseCubit>().clearAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.white),
            onPressed: _showCategoryDialog,
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.white),
            onPressed: _clearExpenses,
          ),
        ],
        backgroundColor: Colors.black,
        title: Text(
          'Expense Tracker',
          style: TextStyle(
            color: textWhite,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<ExpenseCubit, ExpenseState>(
          builder: (context, state) {
            if (state is ExpenseLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ExpenseError) {
              return Center(child: Text(state.message, style: TextStyle(color: Colors.white)));
            } else if (state is ExpenseLoaded) {
              final expenses = _selectedCategoryFilter == 'All'
                  ? state.expenses
                  : state.expenses.where((e) => e.category == _selectedCategoryFilter).toList();

              final totalAmount = expenses.fold(0.0, (sum, item) => sum + item.amount);

              if (expenses.isEmpty) {
                return Center(child: Text('No expenses found.', style: TextStyle(color: Colors.white)));
              }

              return Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    'PKR ${totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 25),
                      decoration: const BoxDecoration(
                        color: tileColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: ListView.builder(
                        itemCount: expenses.length,
                        itemBuilder: (context, index) {
                          final expense = expenses[index];
                          return ListTile(
                            leading: Icon(CupertinoIcons.dot_square_fill, color: Colors.red),
                            title: Text(expense.title, style: TextStyle(color: textWhite, fontWeight: FontWeight.bold)),
                            subtitle: Text('PKR ${expense.amount.toStringAsFixed(2)}', style: TextStyle(color: Colors.red[200])),
                            trailing: Text(
                              '${expense.category}\n${DateFormat('dd MMM yyyy').format(expense.date)}',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.right,
                            ),
                            onTap: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ExpenseDetailsScreen(
                                    expense: expense,
                                    onEdit: (editedExpense) {
                                      context.read<ExpenseCubit>().editExpense(editedExpense);
                                    },
                                    onDelete: () {
                                      context.read<ExpenseCubit>().deleteExpense(expense.id);
                                    },
                                  ),
                                ),
                              );
                              if (result == 'delete') {
                                context.read<ExpenseCubit>().loadExpenses();
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: Text('Unexpected state', style: TextStyle(color: Colors.white)));
            }
          },
        ),
      ),
    );
  }
}