import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:week_3_blp_1/theme/customThemes/contextThemeExtensions.dart';
import '../../Widget/IconButton.dart';
import '../../Widget/TextButton.dart';
import 'AddGoalScreen.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.primarySurface,
      bottomNavigationBar: HorizontalTextButton( text: 'Add New Goal',
        onpressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddGoalScreen()));
        },
      ),
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
        backgroundColor: context.appColors.primarySurface,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            padding: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
            height: 180,width: double.infinity,
            decoration: BoxDecoration(
                color: context.appColors.onPrimary,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Title Goal'),
                Container(

                  constraints: BoxConstraints(maxHeight: 80),
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(40),
                    value: 0.5,
                    minHeight: 6,
                    backgroundColor: context.appColors.primarySurface,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                //Text('\$ ${NumberFormat('#,##0.00').format(totalExpense)}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 32),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
