import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final ShapeBorder shape;
  final double size;
  final EdgeInsets padding;
  final VoidCallback onPressed;
  const CustomIconButton(
      {
        super.key,
        required this.icon,
        required this.shape,
        required this.size,
        required this.padding,
        required this.onPressed
      });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
       onTap: onPressed,
       customBorder: shape,
       child: Padding(padding: padding,
         child: Icon(icon,
             size: size,
             color:Colors.black,),),
      ),
    );
  }
}
