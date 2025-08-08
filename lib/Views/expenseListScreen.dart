import 'package:flutter/material.dart';
import 'package:week_3_blp_1/theme/customThemes/contextThemeExtensions.dart';
import '../Widget/CategoriesTileButton.dart';

class ExpenseListScreen extends StatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  @override
  Widget build(BuildContext context) {
    final tiles = [
      {'label': 'Add Expense', 'icon': Icons.add, 'onPressed': () {}},
      {'label': 'View Stats', 'icon': Icons.bar_chart, 'onPressed': () {}},
      {'label': 'Reports', 'icon': Icons.receipt, 'onPressed': () {}},
      {'label': 'Settings', 'icon': Icons.settings, 'onPressed': () {}},
    ];
    return Scaffold(
      backgroundColor: context.appColors.primaryBackground,
      appBar: AppBar(
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
          Container(
            child: const Column(
              children: [
                Text('Total Balance'),
                Text('4500 pkr')
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: tiles.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,crossAxisSpacing: 10,mainAxisExtent: 60,mainAxisSpacing: 10
                ),
                itemBuilder: (context,index){
                  final tile = tiles[index];
                  return CategoryTileButton(
                    onPressed: () {  },
                    icon: tile['icon'] as IconData,
                    DescirptionTxt: 'here is the desciption lovely isnt itjjjf?',
                    TitleTxt: tile['label']as String,
                  );
                }

            ),
          )
        ],
      ),
    );
  }
}
