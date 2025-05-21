import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../ViewModel/dbHandler.dart';
import '../main.dart';
import 'AddScreen.dart';
import 'expenseDetails.dart';
import 'package:week_3_blp_1/Models/expense.dart';

class ExpenseListScreen extends StatefulWidget {
  @override
  _ExpenseListScreenState createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  final myDb db = myDb();
  String _selectedCategoryFilter = 'All';
  final List<String> _categories = ['All', 'Grocery', 'School', 'Entertainment', 'Bills', 'Others'];

  void _startAddNewExpense(BuildContext ctx) {
    Navigator.of(ctx)
        .push(MaterialPageRoute(builder: (_) => AddExpenseScreen()))
        .then((result) {
      if (result != null) {
        setState(() {});
      }
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        height: 50,
        width: 80,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: IconButton(
            onPressed: () => _startAddNewExpense(context),
            icon: const Icon(CupertinoIcons.add, color: Colors.white),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.white),
            onPressed: _showCategoryDialog,
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.white),
            onPressed: (){db.clearAllExpenses();
              print('object');},
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
        child: Column(
          children: [
            SizedBox(height: 10),
            FutureBuilder<List<Expense>>(
              future: db.getExpenses(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No expenses found.', style: TextStyle(color: Colors.white)));
                }
                final expenses = snapshot.data!;
                final filteredExpenses = _selectedCategoryFilter == 'All'
                    ? expenses
                    : expenses.where((e) => e.category == _selectedCategoryFilter).toList();

                final totalAmount = filteredExpenses.fold(0.0, (sum, item) => sum + item.amount);

                return Expanded(
                  child: Column(
                    children: [
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
                            itemCount: filteredExpenses.length,
                            itemBuilder: (context, index) {
                              final expense = filteredExpenses[index];
                              return ListTile(
                                leading: Icon(CupertinoIcons.dot_square_fill, color: Colors.red),
                                title: Text(
                                  expense.title,
                                  style: TextStyle(
                                    color: textWhite,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  'PKR ${expense.amount.toStringAsFixed(2)}',
                                  style: TextStyle(color: Colors.red[200]),
                                ),
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
                                          setState(() {});
                                        },
                                        onDelete: () {
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  );
                                  if (result == 'delete') {
                                    setState(() {});
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
