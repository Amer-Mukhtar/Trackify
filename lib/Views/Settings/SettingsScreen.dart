import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:week_3_blp_1/theme/customThemes/contextThemeExtensions.dart';

import '../../Widget/IconButton.dart';

class SettingsScreen extends StatefulWidget {

  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final List<Map<String, String>> settingsOptions =[
    {'title':'About'},{'title':'Version'},{'title':'App Appearance'},{'title':'Logout'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.primarySurface,
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
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                backgroundColor: context.appColors.primaryBackground,
                radius: 85,
              ),
            ),
            SizedBox(height: 10,),
            Text('Ahmed Khan',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
            SizedBox(height: 50,),
            Expanded(
              child: ListView.builder(
                itemCount: settingsOptions.length,
                itemBuilder: (context, index) {
                  final settings = settingsOptions[index];
                  return Container(
                    decoration: BoxDecoration(
                        color: context.appColors.primaryBackground,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 2),
                    child: ListTile(
                      title: Text(settings['title']!, style: TextStyle(color: Colors.black)),
                      onTap: ()  {

                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
