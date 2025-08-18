import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:week_3_blp_1/theme/customThemes/contextThemeExtensions.dart';
import '../../Widget/IconButton.dart';
import '../../main.dart';
import '../../presentation/cubit/expense_cubit.dart';
import '../../presentation/cubit/expense_state.dart';
import 'ExpenseDetails.dart';

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
      backgroundColor: context.appColors.primarySurface,
      appBar: AppBar(
        leadingWidth: 50,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: CustomIconButton(
            color: Colors.white,
            icon: CupertinoIcons.arrow_left,
            onPressed: (){Navigator.pop(context);},
          ),
        ),
          backgroundColor: context.appColors.primarySurface,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(50)),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.filter_list, color: Colors.black),
                  onPressed: _showCategoryDialog,
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.black),
                  onPressed: _clearExpenses,
                ),
              ],
            ),
          )
        ],

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
                    '\$ ${NumberFormat('#,##0.00').format(totalAmount)}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  Expanded(
                    child: ListView.builder(
                      itemCount: expenses.length,
                      itemBuilder: (context, index) {
                        final expense = expenses[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: context.appColors.primaryBackground,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 2),
                          child: ListTile(
                            leading: Container(
                             decoration: BoxDecoration(
                               shape: BoxShape.circle,
                             ),
                              child: Image.asset(
                                'assets/images/placeholder.png',
                                fit: BoxFit.cover,
                              ),
                            ),

                            title: Text(expense.title, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                            subtitle: Text('PKR ${expense.amount.toStringAsFixed(2)}', style: TextStyle(color: Colors.red[200])),
                            trailing: Text(
                              '${expense.category}\n${DateFormat('dd MMM yyyy').format(expense.date)}',
                              style: TextStyle(color: Colors.black),
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
                          ),
                        );
                      },
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