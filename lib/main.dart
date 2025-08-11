import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:week_3_blp_1/presentation/cubit/expense_cubit.dart';
import 'package:week_3_blp_1/theme/theme.dart';
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
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 915),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context,child){
        return MaterialApp(
          theme: AppTheme.lightTheme.theme,
          darkTheme: AppTheme.darkTheme.theme,
          themeMode:ThemeMode.system,
          debugShowCheckedModeBanner: false,
          title: 'Expense Tracker',
          home: const ExpenseListScreen(),
        );
      },
    );
  }
}
