import 'package:flutter/material.dart';

class CategoryTileButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String DescirptionTxt;
  final String TitleTxt;
  const CategoryTileButton(
      {
        super.key,
        required this.onPressed,
        required this.icon,
        required this.DescirptionTxt,
        required this.TitleTxt
      });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        color: Colors.grey,
        height: 50,
        width: 50,
        child: Column(
          children: [
            Row(
              children: [
                Text(DescirptionTxt),
                Icon(icon)
              ],
            ),
            Text(TitleTxt)
          ],
        ),
      ),
    );
  }
}
