import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../main.dart';
import 'AddScreen.dart';
import 'expenseDetails.dart';
import 'package:week_3_blp_1/Models/expense.dart';


class ExpenseListScreen extends StatefulWidget {
  @override
  _ExpenseListScreenState createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  final List<Expense> _userExpenses = [];
  String _selectedCategoryFilter = 'All';

  void _addNewExpense(Expense expense) {
    setState(() {
      _userExpenses.add(expense);
    });
  }

  void _startAddNewExpense(BuildContext ctx) {
    Navigator.of(ctx)
        .push(
      MaterialPageRoute(
        builder: (_) {
          return AddExpenseScreen();
        },
      ),
    )
        .then((result) {
      if (result != null) {
        _addNewExpense(result);
      }
    });
  }

  void _editExpense(int index, Expense editedExpense) {
    setState(() {
      _userExpenses[index] = editedExpense;
    });
  }

  void _deleteExpense(int index) {
    setState(() {
      _userExpenses.removeAt(index);
    });
  }

  final List<String> _categories = ['All', 'Grocery', 'School', 'Entertainment', 'Bills', 'Others'];

  void _showCategoryDialog() {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text('Select a category',style: TextStyle(color: textWhite),),
          content: SingleChildScrollView(
            child: Theme(data: ThemeData.dark(),
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
    List<Expense> _filteredExpenses = _selectedCategoryFilter == 'All'
        ? _userExpenses
        : _userExpenses.where((expense) => expense.category == _selectedCategoryFilter).toList();

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
            onPressed: () {
              _startAddNewExpense(context);
            },
            icon: const Icon(
              CupertinoIcons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list,color: Colors.white,),
            onPressed: _showCategoryDialog,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Text(
                  'PKR ${_userExpenses.fold(0.0, (sum, item) => item.amount + sum)}',
                  style: TextStyle(color: Colors.red, fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ],
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
                  itemCount: _filteredExpenses.length,
                  itemBuilder: (context, index) {
                    final expense = _filteredExpenses[index];
                    return ListTile(
                      leading: Icon(CupertinoIcons.dot_square_fill, color: Colors.red),
                      title: Text(expense.name, style: TextStyle(color: textWhite, fontWeight: FontWeight.bold)),
                      subtitle: Text('PKR ${expense.amount}', style: TextStyle(color: Colors.red[200])),
                      trailing: Text('${expense.category}\n${DateFormat('dd MMM yyyy').format(expense.date)}'),
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExpenseDetailsScreen(
                              expense: expense,
                              onEdit: (editedExpense) {
                                _editExpense(index, editedExpense);
                              },
                              onDelete: () {
                                _deleteExpense(index);
                              },
                            ),
                          ),
                        );
                        if (result == 'delete') {
                          _deleteExpense(index);
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
