import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:week_3_blp_1/theme/customThemes/contextThemeExtensions.dart';
import '../Widget/CategoriesTileButton.dart';
import '../Widget/LineGraph.dart';
import '../Widget/TextButton.dart';

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
      bottomNavigationBar: HorizontalTextButton( text: 'Add New Expense',
      onpressed: () {  },

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
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            height: 180,width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
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
                const Text('\$4,500.98 ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 32),)
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
                    onPressed: () {  },
                    icon: tile['icon'] as IconData,
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
