import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:week_3_blp_1/theme/customThemes/contextThemeExtensions.dart';

import '../../Widget/IconButton.dart';
import '../../Widget/TextButton.dart';

class AddGoalScreen extends StatefulWidget {
  const AddGoalScreen({super.key});

  @override
  State<AddGoalScreen> createState() => _AddGoalScreenState();
}

class _AddGoalScreenState extends State<AddGoalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.primarySurface,
      bottomNavigationBar: HorizontalTextButton( text: 'Add',
        onpressed: () {

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

        ],
      ),
    );
  }
}
