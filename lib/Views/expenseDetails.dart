import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:week_3_blp_1/Views/expenseListScreen.dart';
import '../Models/expense.dart';
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
      appBar: AppBar(title: Text('Expense Details',style: TextStyle(color: textWhite,fontWeight: FontWeight.bold),),
      backgroundColor: Colors.black,
        leading: BackButton(color: Colors.white,),
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
                  
                  borderRadius: BorderRadius.circular(30)
              ),
              child: Column(
                children: [
                  Row(children: [
                    Icon(Icons.task_alt,color: Colors.white,),Text(' Task: ',style: TextStyle(color: textWhite,fontSize: 20)),Text('${widget.expense.title}',style: TextStyle(color: Colors.red,fontSize: 20))
                  ],),
                  Row(children: [
                    Icon(Icons.money,color: Colors.white,),Text(' Cost: ',style: TextStyle(color: textWhite,fontSize: 20)),Text('${widget.expense.amount}',style: TextStyle(color: Colors.red,fontSize: 20))
                  ],),
                  Row(children: [
                    Icon(Icons.calendar_month,color: Colors.white,),Text(' Date: ',style: TextStyle(color: textWhite,fontSize: 20)),Text('${DateFormat('dd MMM yyyy').format(_selectedDate)}',style: TextStyle(color: Colors.red,fontSize: 20))
                  ],),
                  Row(children: [
                    Icon(Icons.category,color: Colors.white,),Text(' Category: ',style: TextStyle(color: textWhite,fontSize: 20)),Text('${widget.expense.category}',style: TextStyle(color: Colors.red,fontSize: 20))
                  ],),

                ],
              ),
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red
                  ),
                  onPressed: () {
                    _showEditDialog(context);
                  },
                  child: Text('Edit',style: TextStyle(color: textWhite)),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    widget.onDelete();
                    Navigator.pop(context);
                  },
                  child: Text('Delete',style: TextStyle(color: textBlack),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text('Edit',style: TextStyle(color: textWhite)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                style: TextStyle(color: Colors.white),
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Task',labelStyle:TextStyle(color: textWhite)),
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Cost',labelStyle:TextStyle(color: textWhite)),
                keyboardType: TextInputType.number,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text('Date: ${_selectedDate.toLocal()}'.split(' ')[0],style: TextStyle(color: textWhite)),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2005),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null && picked != _selectedDate) {
                        setState(() {
                          _selectedDate = picked;
                        });
                      }
                    },
                    child: Text('Select date',style: TextStyle(color: textBlack)),
                  ),
                ],
              ),
              Theme(data: ThemeData.dark(),
                child: DropdownButton<String>(
                  value: _selectedCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue!;
                    });
                  },
                  items: <String>['Grocery', 'School', 'Entertainment', 'Bills', 'Others']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style: TextStyle(color: textWhite)),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel',style: TextStyle(color: textWhite)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red
              ),
              onPressed: () {
                if (_nameController.text.isNotEmpty && _amountController.text.isNotEmpty) {
                  widget.onEdit(Expense(
                    title: _nameController.text,
                    amount: double.parse(_amountController.text),
                    date: _selectedDate,
                    category: _selectedCategory, id:widget.expense.id ,
                  ));
                  Navigator.of(context)..pop()..pop();
                }
              },
              child: Text('Save',style: TextStyle(color: textWhite)),
            ),
          ],
        );
      },
    );
  }
}
