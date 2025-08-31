import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:week_3_blp_1/theme/customThemes/contextThemeExtensions.dart';
import '../../Models/expense.dart';
import '../../Widget/IconButton.dart';
import '../../Widget/TextButton.dart';
import '../../Widget/image.dart';
import '../../presentation/cubit/expense_cubit.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _desciptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = 'School';
  String url ='';

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
      id: generateSimpleUniqueId(), description: _desciptionController.text, imageUrl: '',
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
      backgroundColor: context.appColors.primarySurface,
      bottomNavigationBar: HorizontalTextButton( text: 'Add Expense',
        onpressed: () {
          _submitExpense();
        }),
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
        title: const Text(
          'Add Expense',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: context.appColors.primarySurface,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      //color: context.appColors.primaryBackground,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    child:Image.asset('assets/images/placeholder.png'),
                  ),
                  Positioned(
                    top: 220,left: 295,
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.appColors.onPrimary,
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        onTap: ()
                        {imageSheet(context,);},
                        child: Icon(CupertinoIcons.plus,
                          size: 25,
                          color:Colors.white,),
                      ),
                    )
                  )
                ],
              ),
              SizedBox(height: 20,),
              TextField(
                style: const TextStyle(color: Colors.black),
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              SizedBox(height: 20,),
               TextField(
                style: TextStyle(color: Colors.black),
                controller: _desciptionController,
                maxLines: null,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
              ),
        
              SizedBox(height: 20,),
              TextField(
                style: const TextStyle(color: Colors.black),
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Cost',
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Picked Date: ${DateFormat('dd MMM yyyy').format(_selectedDate)}',
                      style: const TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
                    ),
                  ),
                  TextButton(
                    onPressed: _presentDatePicker,
                    child: const Text('Choose Date', style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
              Row(
                children: [
                  Theme(
                    data: ThemeData.dark(),
                    child: DropdownButton<String>(
                      value: _selectedCategory,
                      dropdownColor: Colors.white,
                      items: ['Grocery', 'School', 'Entertainment', 'Bills', 'Others']
                          .map((label) => DropdownMenuItem(
                        value: label,
                        child: Text(label, style: const TextStyle(color: Colors.black)),
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                    ),
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
