import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week_3_blp_1/presentation/cubit/expense_cubit.dart';
import './Views/expenseListScreen.dart';
import 'ViewModel/dbHandler.dart';
import 'data/repositories/repositories.dart';
Color textWhite=Colors.white;
Color textBlack=Colors.black;
const Color tileColor = Color(0xFF211a23);

void main() {
  final db = myDb();
  final repository = ExpenseRepository(db);
  runApp(BlocProvider(create: (_)=>ExpenseCubit(repository)..loadExpenses(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      home: ExpenseListScreen(),
    );
  }
}
