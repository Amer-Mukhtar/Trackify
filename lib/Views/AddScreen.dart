import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../Models/expense.dart';
import '../presentation/cubit/expense_cubit.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = 'School';

  String generateSimpleUniqueId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = Random().nextInt(100000);
    return '$timestamp$random';
  }

  void _submitExpense() {
    final enteredName = _nameController.text;
    final enteredAmount = double.tryParse(_amountController.text);

    if (enteredName.isEmpty || enteredAmount == null || enteredAmount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter valid name and amount")),
      );
      return;
    }

    final newExpense = Expense(
      title: enteredName,
      amount: enteredAmount,
      date: _selectedDate,
      category: _selectedCategory,
      id: generateSimpleUniqueId(),
    );

    context.read<ExpenseCubit>().addExpense(newExpense);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        title: const Text(
          'Add Expense',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              style: const TextStyle(color: Colors.white),
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Task/Activity',
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            TextField(
              style: const TextStyle(color: Colors.white),
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Cost',
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Picked Date: ${DateFormat('dd MMM yyyy').format(_selectedDate)}',
                    style: const TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
                  ),
                ),
                TextButton(
                  onPressed: _presentDatePicker,
                  child: const Text('Choose Date', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            Row(
              children: [
                Theme(
                  data: ThemeData.dark(),
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    dropdownColor: Colors.black,
                    items: ['Grocery', 'School', 'Entertainment', 'Bills', 'Others']
                        .map((label) => DropdownMenuItem(
                      value: label,
                      child: Text(label, style: const TextStyle(color: Colors.white)),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value!;
                      });
                    },
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: _submitExpense,
                  child: const Text('Add', style: TextStyle(color: Colors.white)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
