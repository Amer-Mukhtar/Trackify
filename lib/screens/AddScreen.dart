import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Models/expense.dart';
import '../main.dart';



class AddExpenseScreen extends StatefulWidget {
  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = 'School';

  void _submitExpense() {
    final enteredName = _nameController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredName.isEmpty || enteredAmount <= 0) {
      return;
    }

    final newExpense = Expense(
      name: enteredName,
      amount: enteredAmount,
      date: _selectedDate,
      category: _selectedCategory,
    );

    Navigator.of(context).pop(newExpense);
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: BackButton(color: Colors.white,),
        title: Text(
          'Add Expense',
          style: TextStyle(color: textWhite,fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              style: TextStyle(color: textWhite),
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Task/Activity',
                labelStyle: TextStyle(color: textWhite),
              ),
            ),
            TextField(
              style: TextStyle(color: textWhite),
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Cost',
                labelStyle: TextStyle(color: textWhite),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No Date Chosen!'
                        : 'Picked Date: ${DateFormat('dd MMM yyyy').format(_selectedDate)}',
                    style: TextStyle(color: textWhite,fontStyle: FontStyle.italic),
                  ),
                ),
                TextButton(
                  onPressed: _presentDatePicker,
                  child: Text(
                    'Choose Date',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Theme(data: ThemeData.dark(),
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    items: ['Grocery', 'School', 'Entertainment', 'Bills', 'Others']
                        .map((label) => DropdownMenuItem(
                      child: Text(label, style: TextStyle(color: textWhite)),
                      value: label,
                    )
                    )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 155,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: _submitExpense,
                  child: Text('Add', style: TextStyle(color: textWhite)),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}

