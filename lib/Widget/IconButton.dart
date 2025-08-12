import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;
  const CustomIconButton(
      {
        super.key,
        required this.icon,
        required this.onPressed, required this.color
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color,
        shape: BoxShape.circle,
      ),
      child: InkWell(
        onTap: onPressed,
        child: Icon(icon,
            size: 20,
            color:Colors.black,),
      ),
    );
  }
}
