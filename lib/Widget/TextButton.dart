import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:week_3_blp_1/theme/customThemes/contextThemeExtensions.dart';

class HorizontalTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onpressed;

  const HorizontalTextButton({super.key, required this.text, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: context.appColors.primarySurfaceHighlighted,
        borderRadius: BorderRadius.circular(20)
      ),
        child: InkWell(
          onTap: onpressed,
          child: Text(
            textAlign: TextAlign.center,
            text,
            style: TextStyle(color: Colors.white),
          ),
        )
    );
  }
}
