import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:week_3_blp_1/Views/Goals/GoalsScreen.dart';
import 'package:week_3_blp_1/Views/Statistics/StatsScreen.dart';
import 'package:week_3_blp_1/theme/customThemes/contextThemeExtensions.dart';
import '../ViewModel/dbHandler.dart';
import '../Widget/CategoriesTileButton.dart';
import '../Widget/LineGraph.dart';
import '../Widget/TextButton.dart';
import '../presentation/cubit/expense_cubit.dart';
import 'Expense/AddScreen.dart';
import 'Expense/ExpenseListScreen.dart';
import 'Settings/SettingsScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double totalExpense = 0.0;
  @override
  @override
  void initState() {
    super.initState();
    _loadTotalExpense();
  }
  Future<void> _loadTotalExpense() async {
    final db = myDb();
    double total = await db.getTotalExpenseAmount();
    setState(() {
      totalExpense = total;
    });
  }
  Widget build(BuildContext context) {
    final tiles = [
      {'label': 'See All Expenses',  'onPressed': () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => ExpenseListScreen()),
        ).then((result) {
          if (result != null) {
            context.read<ExpenseCubit>().loadExpenses();
          }
        });
      }},
      {'label': 'View Stats',  'onPressed': () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>StatsScreen()));
      }},
      {'label': 'Goals',  'onPressed': () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>GoalsScreen()));
      }},
      {'label': 'Settings',  'onPressed': () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsScreen()));
      }},
    ];
    return Scaffold(
      bottomNavigationBar: HorizontalTextButton( text: 'Add New Expense',
      onpressed: () {  Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => AddExpenseScreen()),
      ).then((result) {
        if (result != null) {
          context.read<ExpenseCubit>().loadExpenses();
        }
      });
        },
      ),
      backgroundColor: context.appColors.primarySurface,
      appBar: AppBar(
        backgroundColor: context.appColors.primarySurface,
        title: const Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey,
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Good Morning', style: TextStyle(fontSize: 14)),
                Text('Ahmed Khan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
        body: Column(
        children: [
          SizedBox(height: 10,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            height: 180,width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Balance'),
                Container(
                  constraints: BoxConstraints(maxHeight: 80),
                  child: LineGraph(
                    data: const [5, 12, 9, 14, 7, 20, 15],
                    lineColor: context.appColors.onPrimary,
                    lineWidth: 3,
                    height: 250,
                  ),
                ),
                Text('\$ ${NumberFormat('#,##0.00').format(totalExpense)}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 32),)
              ],
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
            child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              itemCount: tiles.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisExtent: 170,
                    mainAxisSpacing: 5
                ),
                itemBuilder: (context,index){
                  final tile = tiles[index];
                  return CategoryTileButton(
                    onPressed: tile['onPressed'] as VoidCallback,
                    descriptionTxt: 'here is the desciption lovely isnt itjjjf?',
                    titleTxt: tile['label']as String,
                  );
                }

            ),
          ),
        ],
      ),
    );
  }
}
