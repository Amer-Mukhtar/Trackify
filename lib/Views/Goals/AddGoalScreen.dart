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
  final TitleController = TextEditingController();
  final DescripController = TextEditingController();
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
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Column(
          children: [
            TextField(
              style: const TextStyle(color: Colors.black),
              controller: TitleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              maxLines: null,
              style: const TextStyle(color: Colors.black),
              controller: DescripController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
