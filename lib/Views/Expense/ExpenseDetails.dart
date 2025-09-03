import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week_3_blp_1/theme/customThemes/contextThemeExtensions.dart';
import '../../Models/expense.dart';
import '../../Widget/IconButton.dart';
import '../../main.dart';
import '../../presentation/cubit/expense_cubit.dart';
import 'EditExpense.dart';

class ExpenseDetailsScreen extends StatefulWidget {
  final Expense expense;
  final Function(Expense) onEdit;
  final Function() onDelete;

  const ExpenseDetailsScreen({super.key, 
    required this.expense,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  _ExpenseDetailsScreenState createState() => _ExpenseDetailsScreenState();
}

class _ExpenseDetailsScreenState extends State<ExpenseDetailsScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:Container(
        margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                  margin: EdgeInsets.only(),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: context.appColors.primarySurfaceHighlighted,
                      borderRadius: BorderRadius.only(topLeft:Radius.circular(20) ,bottomLeft: Radius.circular(20))
                  ),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>
                              EditExpenseScreen(expense: widget.expense,onEdit: (editedExpense)
                              {
                                context.read<ExpenseCubit>().editExpense(editedExpense);
                              }))
                      );
                    },
                    child: Text(
                      textAlign: TextAlign.center,
                      'Edit',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: context.appColors.primaryBackground,
                      borderRadius: BorderRadius.only(topRight:Radius.circular(20) ,bottomRight: Radius.circular(20))
                  ),
                  child: InkWell(
                    onTap: (){
                      context.read<ExpenseCubit>().deleteExpense(widget.expense.id);
                      widget.onDelete(); // Notify parent
                      Navigator.pop(context);
                    },
                    child: Text(
                      textAlign: TextAlign.center,
                      'Delete',
                      style: TextStyle(color: Colors.black),
                    ),
                  )
              ),
            ),
          ],
        ),
      ),
      backgroundColor: context.appColors.primarySurface,
      appBar: AppBar(
          backgroundColor: context.appColors.primarySurface,
        title: Text('Expense Details', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: CustomIconButton(
            color: Colors.white,
            icon: CupertinoIcons.arrow_left,
            onPressed: (){Navigator.pop(context);},
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: tileColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: widget.expense.imageUrl.isEmpty
                      ? Image.asset(
                    'assets/images/placeholder.png',
                    fit: BoxFit.fill,
                  )
                      : Image.file(
                    File(widget.expense.imageUrl),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.expense.title,
                    style: TextStyle(color: Colors.black,fontSize: 22),),
                  Text("\$"+'${widget.expense.amount}',
                    style: TextStyle(color: Colors.red,fontSize: 16),),
                ],
              ),
              SizedBox(height: 10,),
              Text(widget.expense.description,
                style: TextStyle(color: Colors.black,fontSize: 16),),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Category: '+widget.expense.category,
                    style: TextStyle(color: Colors.black45,fontSize: 14),),
                  Text(
                    DateFormat('yyyy-MM-dd').format(widget.expense.date),
                    style: const TextStyle(color: Colors.black45, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
