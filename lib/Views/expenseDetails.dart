import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Models/expense.dart';
import '../presentation/cubit/expense_cubit.dart';
import '../main.dart';

class ExpenseDetailsScreen extends StatefulWidget {
  final Expense expense;
  final Function(Expense) onEdit;
  final Function() onDelete;

  ExpenseDetailsScreen({
    required this.expense,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  _ExpenseDetailsScreenState createState() => _ExpenseDetailsScreenState();
}

class _ExpenseDetailsScreenState extends State<ExpenseDetailsScreen> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = '';

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.expense.title;
    _amountController.text = widget.expense.amount.toString();
    _selectedDate = widget.expense.date;
    _selectedCategory = widget.expense.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Expense Details', style: TextStyle(color: textWhite, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        leading: BackButton(color: Colors.white),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: tileColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  _buildRow(Icons.task_alt, 'Task', widget.expense.title),
                  _buildRow(Icons.money, 'Cost', widget.expense.amount.toString()),
                  _buildRow(Icons.calendar_month, 'Date', DateFormat('dd MMM yyyy').format(_selectedDate)),
                  _buildRow(Icons.category, 'Category', widget.expense.category),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () => _showEditDialog(context),
                  child: Text('Edit', style: TextStyle(color: textWhite)),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    context.read<ExpenseCubit>().deleteExpense(widget.expense.id);
                    widget.onDelete(); // Notify parent
                    Navigator.pop(context);
                  },
                  child: Text('Delete', style: TextStyle(color: textBlack)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.white),
        Text(' $label: ', style: TextStyle(color: textWhite, fontSize: 20)),
        Text(value, style: TextStyle(color: Colors.red, fontSize: 20)),
      ],
    );
  }

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text('Edit', style: TextStyle(color: textWhite)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                style: TextStyle(color: Colors.white),
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Task',
                  labelStyle: TextStyle(color: textWhite),
                ),
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Cost',
                  labelStyle: TextStyle(color: textWhite),
                ),
                keyboardType: TextInputType.number,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Date: ${DateFormat('dd MMM yyyy').format(_selectedDate)}',
                      style: TextStyle(color: textWhite),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2005),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null) {
                        setState(() {
                          _selectedDate = picked;
                        });
                      }
                    },
                    child: Text('Select date', style: TextStyle(color: textBlack)),
                  ),
                ],
              ),
              Theme(
                data: ThemeData.dark(),
                child: DropdownButton<String>(
                  value: _selectedCategory,
                  dropdownColor: Colors.black,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue!;
                    });
                  },
                  items: <String>['Grocery', 'School', 'Entertainment', 'Bills', 'Others']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(color: textWhite)),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: textWhite)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                if (_nameController.text.isNotEmpty && _amountController.text.isNotEmpty) {
                  final updatedExpense = Expense(
                    id: widget.expense.id,
                    title: _nameController.text,
                    amount: double.parse(_amountController.text),
                    date: _selectedDate,
                    category: _selectedCategory,
                  );

                  context.read<ExpenseCubit>().editExpense(updatedExpense);
                  widget.onEdit(updatedExpense); // Notify parent
                  Navigator.pop(context); // Close dialog
                }
              },
              child: Text('Save', style: TextStyle(color: textWhite)),
            ),
          ],
        );
      },
    );
  }
}
