import 'dart:io';
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

class EditExpenseScreen extends StatefulWidget
{
  final Expense expense;  final Function(Expense) onEdit;

  const EditExpenseScreen({super.key, required this.expense, required this.onEdit});

  @override
  _EditExpenseScreenState createState() => _EditExpenseScreenState();
}

class _EditExpenseScreenState extends State<EditExpenseScreen> {
  late var TitleController = TextEditingController();
  late var AmountController = TextEditingController();
  late var DesciptionController = TextEditingController();
  DateTime SelectedDate = DateTime.now();
  String SelectedCategory = 'School';
  String url ='';
  String generateSimpleUniqueId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = Random().nextInt(100000);
    return '$timestamp$random';
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: SelectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          SelectedDate = pickedDate;
        });
      }
    });
  }
  @override
  void initState() {
    super.initState();
    SelectedDate=widget.expense.date;
    url=widget.expense.imageUrl;
    TitleController = TextEditingController(text: widget.expense.title);
    AmountController = TextEditingController(
        text: widget.expense.amount.toString());
    DesciptionController = TextEditingController(
        text: widget.expense.description);
    SelectedDate = widget.expense.date;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.primarySurface,
      bottomNavigationBar: HorizontalTextButton( text: 'Edit Expense',
          onpressed: () {
            final enteredName = TitleController.text;
            final enteredAmount = double.tryParse(AmountController.text);
            final newExpense = Expense(
              title: enteredName,
              amount: enteredAmount!,
              date: SelectedDate,
              category: SelectedCategory,
              id: generateSimpleUniqueId(), description: DesciptionController.text, imageUrl: url,
            );
            context.read<ExpenseCubit>().editExpense(newExpense);
            widget.onEdit(newExpense); // Notify parent
            setState(() {

            });
            Navigator.of(context).pop();
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
          'Edit Expense',
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
                    child:url.isEmpty
                        ? Image.asset(
                      'assets/images/placeholder.png',
                      fit: BoxFit.cover,
                    )
                        : Image.file(
                      File(url),
                      fit: BoxFit.cover,
                    ),
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
                          async {url =(await imageSheet(context))!;
                          setState(() {

                          });},
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
                controller: TitleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                style: TextStyle(color: Colors.black),
                controller: DesciptionController,
                maxLines: null,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
              ),

              SizedBox(height: 20,),
              TextField(
                style: const TextStyle(color: Colors.black),
                controller: AmountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Cost',
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Picked Date: ${DateFormat('dd MMM yyyy').format(SelectedDate)}',
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
                      value: SelectedCategory,
                      dropdownColor: Colors.white,
                      items: ['Grocery', 'School', 'Entertainment', 'Bills', 'Others']
                          .map((label) => DropdownMenuItem(
                        value: label,
                        child: Text(label, style: const TextStyle(color: Colors.black)),
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          SelectedCategory = value!;
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
