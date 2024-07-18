import 'package:flutter/material.dart';
import './screens/expenseListScreen.dart';
Color textWhite=Colors.white;
Color textBlack=Colors.black;
const Color tileColor = Color(0xFF211a23);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      home: ExpenseListScreen(),
    );
  }
}
