import 'package:flutter/material.dart';
import '../Models/expense.dart';
import '../main.dart';



class ExpenseItem extends StatelessWidget {
  final Expense expense;

  const ExpenseItem(this.expense, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(expense.title,style: TextStyle(color: textWhite),),
      subtitle: Text('${expense.amount} - ${expense.category}',style: TextStyle(color: textWhite)),
      trailing: Text(expense.date.toLocal().toString(),style: TextStyle(color: textWhite)),
      onTap: () {
      },
    );
  }
}
